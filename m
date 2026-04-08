Return-Path: <stable+bounces-235193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIzQA++r1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332983C2FB3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37DC03211D10
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93D35BDDB;
	Wed,  8 Apr 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EUC0JDia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75662857C1;
	Wed,  8 Apr 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674809; cv=none; b=uK23hU4m5T6z6DKtlkfaRdHff1nj0C81u0BSajjzgfq/lDs+jwK1/mFxOkEleOwT+Z7fPnLZmVDQoKBVz6mtoqpwe3FT9AqYmlyHwgHFNU6iH8lc+DDKiYbAdf8moWmUr/XDJO2grqWWdKO/DsrVP0EnVoVb8tzDLOhb9nLIdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674809; c=relaxed/simple;
	bh=8qQGmV5KgBHYEAyjHeiwNJiq1+yapxk7O8T9M35cuVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7nGRHHl7tQ8PmW/AmBA3404G4yF9ZyrRxpkkpHjy9t/4NkBQGM9T6VsDZ/rVpq0DWoM12pbepdlXL0jn5OlMP3qBgYJbjCd8G6bQk5qJzeiNmTtLBPwfDdxomgHWR+27yJuqZiqzxzxrmHRg9DyC7TPh9I4tkzDP18x3NqUwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EUC0JDia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3BCC19421;
	Wed,  8 Apr 2026 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674809;
	bh=8qQGmV5KgBHYEAyjHeiwNJiq1+yapxk7O8T9M35cuVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUC0JDiaI5U/9iVGowCVIIogbVN4MGV9xkL4s+0koX7ym9ueoS462AJt/bbM5PqDB
	 qKWRqUNUqWuTrs6BOPvNbVzcT9p4hFrfeubkf09Gx+evAVdZ5clpFg3L/R9XymluDr
	 +QiPXP9+JhBXYCG1+XCBVGESyBP9QINMOxY69ofo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: [PATCH 6.19 240/311] usb: misc: usbio: Fix URB memory leak on submit failure
Date: Wed,  8 Apr 2026 20:04:00 +0200
Message-ID: <20260408175948.355488248@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235193-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.com:email]
X-Rspamd-Queue-Id: 332983C2FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



