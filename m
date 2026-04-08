Return-Path: <stable+bounces-234390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDFbNjie1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE603C0C5C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1318930104AA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9553ACA41;
	Wed,  8 Apr 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZqr1qwN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90545B67E;
	Wed,  8 Apr 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672734; cv=none; b=b8eAAlc06RVDMg5c2rQs+hluj3SEGLsVEo7sRWxYqmk0E/EHoe8vCUXxmQXMyfvzKsZDQMpDOkUP7ZYlEFJkM906Slk6X4TBi/w9q9orh6II4utu6W3fo8gUYYkwsdgHT/I3j790iim4JgzVQ/bN2sAuJrzwtxc6brxZrpcXAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672734; c=relaxed/simple;
	bh=Bu7EEUr/mKmd5yFJRlmu/svDsoovbuc3AM/D8vC/MYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYuUY7QKm97K9GdMh7prKkznbbY83FV93IJVfu+AL1FZmrgo8vQWou3jkMvBZilFJ2Eibq/eYrdqefGY4W6Rajk3JpweSUy3T7sfaJOU9SfL9bk3iHo6cex5wLjtSykuoyt0JWefilolRPYBPJqObhkmov6KNQTW4DXV7UkG0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZqr1qwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B504C19421;
	Wed,  8 Apr 2026 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672734;
	bh=Bu7EEUr/mKmd5yFJRlmu/svDsoovbuc3AM/D8vC/MYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZqr1qwNaR9qudNDlXQ3jUycfdoTJVb2Xq6dMSgnYEJdR4FmtcvIr9znkRpFmqAcr
	 UgbEa450EUOu4xIwsiY2w4ITiZXH+foo/iqExJ49Jta5uI06gyEKdxSXUV3cwX49Oo
	 0cpcWzZdINbpuTg2bnj7EpW1NKXjnDqAaWy6qxHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.6 121/160] comedi: me4000: Fix potential overrun of firmware buffer
Date: Wed,  8 Apr 2026 20:03:28 +0200
Message-ID: <20260408175917.710895869@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234390-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev.co.uk:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9CE603C0C5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit 3fb43a7a5b44713f892c58ead2e5f3a1bc9f4ee7 upstream.

`me4000_xilinx_download()` loads the firmware that was requested by
`request_firmware()`.  It is possible for it to overrun the source
buffer because it blindly trusts the file format.  It reads a data
stream length from the first 4 bytes into variable `file_length` and
reads the data stream contents of length `file_length` from offset 16
onwards.

Add a test to ensure that the supplied firmware is long enough to
contain the header and the data stream.  On failure, log an error and
return `-EINVAL`.

Note: The firmware loading was totally broken before commit ac584af59945
("staging: comedi: me4000: fix firmware downloading"), but that is the
most sensible target for this fix.

Fixes: ac584af59945 ("staging: comedi: me4000: fix firmware downloading")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20260205133949.71722-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/me4000.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/comedi/drivers/me4000.c
+++ b/drivers/comedi/drivers/me4000.c
@@ -315,6 +315,18 @@ static int me4000_xilinx_download(struct
 	unsigned int val;
 	unsigned int i;
 
+	/* Get data stream length from header. */
+	if (size >= 4) {
+		file_length = (((unsigned int)data[0] & 0xff) << 24) +
+			      (((unsigned int)data[1] & 0xff) << 16) +
+			      (((unsigned int)data[2] & 0xff) << 8) +
+			      ((unsigned int)data[3] & 0xff);
+	}
+	if (size < 16 || file_length > size - 16) {
+		dev_err(dev->class_dev, "Firmware length inconsistency\n");
+		return -EINVAL;
+	}
+
 	if (!xilinx_iobase)
 		return -ENODEV;
 
@@ -346,10 +358,6 @@ static int me4000_xilinx_download(struct
 	outl(val, devpriv->plx_regbase + PLX9052_CNTRL);
 
 	/* Download Xilinx firmware */
-	file_length = (((unsigned int)data[0] & 0xff) << 24) +
-		      (((unsigned int)data[1] & 0xff) << 16) +
-		      (((unsigned int)data[2] & 0xff) << 8) +
-		      ((unsigned int)data[3] & 0xff);
 	usleep_range(10, 1000);
 
 	for (i = 0; i < file_length; i++) {



