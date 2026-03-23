Return-Path: <stable+bounces-229243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEFjJihvwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB92F8DEA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D668D3435179
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A033B0AE5;
	Mon, 23 Mar 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFwp9STj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F63B0AD1;
	Mon, 23 Mar 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278510; cv=none; b=LpUp6ATHXCFaxpItpuDY2vrML29nmEnNYB39Rm/WOMUcbgt2HJmjbo2vbCWPLn7n8q14vP1ZfUBJhFn3wwK7PJJrIcUR69gdYsyOvLt4nObtsAmKtVqmO5w104qGdb7WgQRQQcvqFDvaJuU7GP1SL/qr614uEjqUoRLK4SB+DoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278510; c=relaxed/simple;
	bh=YEKjh+tcJ8Qa70lCPEUDfxHpLXXqJCosg31cJjSUACE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP/zwlVFkcdubWVGxmB5lZ8oSUjKpqLxKYmqRNdkSJPy9+mMyCS4Y55JBzqIkmhtE8zZ1KW6AkHa0YmpBxt2qsyW+ih9jkCntEOSJbG9Zf8/ztozX6UZI/SZKXJBNHAGbqjTKeAR1dueW4Hxa/XDePeWdEt5NxKxuDxnhLeUfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFwp9STj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C44C4CEF7;
	Mon, 23 Mar 2026 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278509;
	bh=YEKjh+tcJ8Qa70lCPEUDfxHpLXXqJCosg31cJjSUACE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFwp9STjws/dzeEuGQga2YtxsSbucHOor5kR2fywmbVB+PDD7RqZUWK6o+sMV7rR+
	 4Pvs7Zm+rwI8Q7zseh9eS8FHvElcYTWHnDn+hzsMaBk580l8b0Gilb5H4AZWAFzjDO
	 IRI8gEtBZFTmvsJXE7s77Nw+B4peeS+4It7AaGvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 276/567] usb: misc: uss720: properly clean up reference in uss720_probe()
Date: Mon, 23 Mar 2026 14:43:16 +0100
Message-ID: <20260323134540.656587325@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229243-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2CFB92F8DEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 45dba8011efac11a2f360383221b541f5ea53ce5 upstream.

If get_1284_register() fails, the usb device reference count is
incorrect and needs to be properly dropped before returning.  That will
happen when the kref is dropped in the call to destroy_priv(), so jump
to that error path instead of returning directly.

Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Link: https://patch.msgid.link/2026022342-smokiness-stove-d792@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/uss720.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -733,7 +733,7 @@ static int uss720_probe(struct usb_inter
 	ret = get_1284_register(pp, 0, &reg, GFP_KERNEL);
 	dev_dbg(&intf->dev, "reg: %7ph\n", priv->reg);
 	if (ret < 0)
-		return ret;
+		goto probe_abort;
 
 	ret = usb_find_last_int_in_endpoint(interface, &epd);
 	if (!ret) {



