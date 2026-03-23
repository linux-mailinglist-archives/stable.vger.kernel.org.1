Return-Path: <stable+bounces-228562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNOEJkdUwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:55:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62C2F56CA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7731F3115EF2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688D381B03;
	Mon, 23 Mar 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vzbr2Xrb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46457175A80;
	Mon, 23 Mar 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275459; cv=none; b=N9gEOeQVIZyef9q8d5kN2DnGIB9k1t2uU1fh0Pg+tcr/zuZLz0hoUhsk3u9ncbbR/dTaw7Ti/UXZXvLTnrCLiWbJZoxkUksvWLoKqvZ8YsH6F5yDsUvobQZtQj1hges2vHKSgid+SaQNQh7SInI15minluFdGS0vDw1cMul1Gc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275459; c=relaxed/simple;
	bh=fI3gq+UKo+oSXXc66iKBhWnAb4cNGfxsn+LXNO3bwKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2VltHlrRaOIX10FVF3hNA8IXS4JwTQjEvdY8Nes8KwKF17RgyemiMdIyiwTbwU7g/KahrHagvXSnnBzopXTsGMPdQGAkSVzNM8sW2fUzn8bmW4XayT13i3nrbU2QEQEXzqGxguOMF5NenfZNK/drP55jZESQtqhBA9LRRmLOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vzbr2Xrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4CBC4CEF7;
	Mon, 23 Mar 2026 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275459;
	bh=fI3gq+UKo+oSXXc66iKBhWnAb4cNGfxsn+LXNO3bwKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vzbr2Xrb0THIE5QCm8xxJiDON1Ack5FJhADVMr1ry1E3664wYv5hjxIGLVbe8NtnI
	 Ke3aM93MSiJk8YdjW4PRU5/+Yzw+ms3LMl58pmvvgavUmgCPZqbimyGyke2Sf5yaou
	 hWZ0W1D+KW/fBZYRNofCywGhZfQ3cv6NsWd6MWBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	RD Babiera <rdbabiera@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.12 109/460] usb: typec: altmode/displayport: set displayport signaling rate in configure message
Date: Mon, 23 Mar 2026 14:41:45 +0100
Message-ID: <20260323134529.319475261@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228562-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E62C2F56CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: RD Babiera <rdbabiera@google.com>

commit e8557acfa079a54b59a21f447c82a31aec7717df upstream.

dp_altmode_configure sets the signaling rate to the current
configuration's rate and then shifts the value to the Select
Configuration bitfield. On the initial configuration, dp->data.conf
is 0 to begin with, so the signaling rate field is never set, which
leads to some DisplayPort Alt Mode partners sending NAK to the
Configure message.

Set the signaling rate to the capabilities supported by both the
port and the port partner. If the cable supports DisplayPort Alt Mode,
then include its capabilities as well.

Fixes: a17fae8fc38e ("usb: typec: Add Displayport Alternate Mode 2.1 Support")
Cc: stable <stable@kernel.org>
Signed-off-by: RD Babiera <rdbabiera@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260310204106.3939862-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/altmodes/displayport.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -93,9 +93,14 @@ static int dp_altmode_configure(struct d
 {
 	u8 pin_assign = 0;
 	u32 conf;
+	u32 signal;
 
 	/* DP Signalling */
-	conf = (dp->data.conf & DP_CONF_SIGNALLING_MASK) >> DP_CONF_SIGNALLING_SHIFT;
+	signal = DP_CAP_DP_SIGNALLING(dp->port->vdo) & DP_CAP_DP_SIGNALLING(dp->alt->vdo);
+	if (dp->plug_prime)
+		signal &= DP_CAP_DP_SIGNALLING(dp->plug_prime->vdo);
+
+	conf = signal << DP_CONF_SIGNALLING_SHIFT;
 
 	switch (con) {
 	case DP_STATUS_CON_DISABLED:



