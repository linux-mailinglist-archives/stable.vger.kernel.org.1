Return-Path: <stable+bounces-234630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO4fHTek1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F493C1DED
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DFAF31AD85A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DA36166F;
	Wed,  8 Apr 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d6T1/LJO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD828C87C;
	Wed,  8 Apr 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673356; cv=none; b=giP05cbi86a1adm+7Na7CvglAAuXMtoxWRQABa82XdWULy0faNyYXpUyw3bu26SxTy/PjDvVNY2DLQpAz0BPyLRl+xKgYdDEEm3/ErZ8pBS/sgrQcI5kecxb4Fiwe5l864zTZ8HRC8p1u7rNHF+QCSpaYrMg1kJH/wKz7r3EFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673356; c=relaxed/simple;
	bh=clWuuON2LGTX25xvOJdt8eZdzE3jy5qNtBCHpA1l3X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K414dy+Pxw6pldxSOGzkkIdx0gry8fKxdy6G7HrimL0eMyn27paVgWJTPLnYywXIsa+tfC1ms4mHj2dfDNih6NW9HZw5mJHSIQeJOfQDVdD9AqU23+UVnm0czsRG10E+JsgKU8aZxH4McBSR+AArT3ECEyxlO0rY0opL02douTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d6T1/LJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2077DC19421;
	Wed,  8 Apr 2026 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673356;
	bh=clWuuON2LGTX25xvOJdt8eZdzE3jy5qNtBCHpA1l3X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6T1/LJOayUEOvGiA90GruHQj+jpOQKGbJ+oamrHUOBogoh/P3WiTqUaH/mWtVxwg
	 fjlbfrP2WLaXqHOANfTqunyiJR7WO/McTWkI1mGTITWalXR/Y95npRDpWFG2xHbdQT
	 /RGByNVMVFCWC/ORDvmz1Pwwb87OXjDD43w6dYBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: [PATCH 6.18 200/277] usb: misc: usbio: Fix URB memory leak on submit failure
Date: Wed,  8 Apr 2026 20:03:05 +0200
Message-ID: <20260408175941.331725544@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-234630-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,suse.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.com:email,qualcomm.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F493C1DED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 33cfe0709b6bf1a7f1a16d5e8d65d003a71b6a21 upstream.

When usb_submit_urb() fails in usbio_probe(), the previously allocated
URB is never freed, causing a memory leak.

Fix this by jumping to err_free_urb label to properly release the URB
on the error path.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260331-usbio-v2-1-d8c48dad9463@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/usbio.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -614,8 +614,10 @@ static int usbio_probe(struct usb_interf
 	usb_fill_bulk_urb(usbio->urb, udev, usbio->rx_pipe, usbio->rxbuf,
 			  usbio->rxbuf_len, usbio_bulk_recv, usbio);
 	ret = usb_submit_urb(usbio->urb, GFP_KERNEL);
-	if (ret)
-		return dev_err_probe(dev, ret, "Submitting usb urb\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "Submitting usb urb\n");
+		goto err_free_urb;
+	}
 
 	mutex_lock(&usbio->ctrl_mutex);
 
@@ -663,6 +665,7 @@ static int usbio_probe(struct usb_interf
 err_unlock:
 	mutex_unlock(&usbio->ctrl_mutex);
 	usb_kill_urb(usbio->urb);
+err_free_urb:
 	usb_free_urb(usbio->urb);
 
 	return ret;



