Return-Path: <stable+bounces-226272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJEMMJqGuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:51:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE632AE89A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABB143061B65
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B663F20F8;
	Tue, 17 Mar 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2D6AgwEM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38253F1641;
	Tue, 17 Mar 2026 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765976; cv=none; b=LI0GzH2s3jPIYqGER7Pt8z4qpQnghCns4MlQ6hlh6ZP/UU6g5Wr1wQa89MddrqCWtADsd3BukpJComwx0W7nk2keIJH2otHI61C5OaXjB1amK2r14Iar8T7I33xUcVyMR1KdLl4yOQCsORzRIcZZI3JYAsWHGCna9Kb51SmbiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765976; c=relaxed/simple;
	bh=5Sry85VGNo85nKQDAX1pMT13C8XrgMM44wLfN3LcWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKGwtxd7+1mTdvNMeeqq3AD+10I9FOV8yZrTXLT+ybQIJ9Yn+AW5+uv7Sw9Ikpq2RmQDKpba55Ki4hLJVy/dCAsU8rcIEQxAz3eQ1iYrigTe3HfxptsTjnAQSp8KVaAvqrdRvUdTpK8oAL2Juo8RC3R32tUKkFjmfAP5OPgAyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2D6AgwEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E611C19424;
	Tue, 17 Mar 2026 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765976;
	bh=5Sry85VGNo85nKQDAX1pMT13C8XrgMM44wLfN3LcWdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2D6AgwEMGEpLYquSnnWoaI4Yt0JzqJI50Mm0QnL2IKITKsSz1wPb/QOHRSNbBfMhY
	 NYsA0mn1GSzjCf3nz0rsupkJub1vqA0BoQvKdQ1XUww7moHuKi4Cj7r7Gy0TRXdLU2
	 alxCbxQc0LZCGDXsIXEs+g797Pu0XRsS5wyBiBGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	A1RM4X <dev@a1rm4x.com>
Subject: [PATCH 6.19 142/378] USB: add QUIRK_NO_BOS for video capture several devices
Date: Tue, 17 Mar 2026 17:31:39 +0100
Message-ID: <20260317163012.236765192@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226272-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,a1rm4x.com:email]
X-Rspamd-Queue-Id: EDE632AE89A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: A1RM4X <dev@a1rm4x.com>

commit 93cd0d664661f58f7e7bed7373714ab2ace41734 upstream.

Several USB capture devices also need the USB_QUIRK_NO_BOS set for them
to work properly, odds are they are all the same chip inside, just
different vendor/product ids.

This fixes up:
  - ASUS TUF 4K PRO
  - Avermedia Live Gamer Ultra 2.1 (GC553G2)
  - UGREEN 35871
to now run at full speed (10 Gbps/4K 60 fps mode.)

Link: https://lore.kernel.org/r/CACy+XB-f-51xGpNQFCSm5pE_momTQLu=BaZggHYU1DiDmFX=ug@mail.gmail.com
Cc: stable <stable@kernel.org>
Signed-off-by: A1RM4X <dev@a1rm4x.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -377,6 +377,9 @@ static const struct usb_device_id usb_qu
 	/* SanDisk Extreme 55AE */
 	{ USB_DEVICE(0x0781, 0x55ae), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Avermedia Live Gamer Ultra 2.1 (GC553G2) - BOS descriptor fetch hangs at SuperSpeed Plus */
+	{ USB_DEVICE(0x07ca, 0x2553), .driver_info = USB_QUIRK_NO_BOS },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
@@ -437,6 +440,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* ASUS TUF 4K PRO - BOS descriptor fetch hangs at SuperSpeed Plus */
+	{ USB_DEVICE(0x0b05, 0x1ab9), .driver_info = USB_QUIRK_NO_BOS },
+
 	/* Realtek Semiconductor Corp. Mass Storage Device (Multicard Reader)*/
 	{ USB_DEVICE(0x0bda, 0x0151), .driver_info = USB_QUIRK_CONFIG_INTF_STRINGS },
 
@@ -565,6 +571,9 @@ static const struct usb_device_id usb_qu
 
 	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* UGREEN 35871 - BOS descriptor fetch hangs at SuperSpeed Plus */
+	{ USB_DEVICE(0x2b89, 0x5871), .driver_info = USB_QUIRK_NO_BOS },
+
 	/* APTIV AUTOMOTIVE HUB */
 	{ USB_DEVICE(0x2c48, 0x0132), .driver_info =
 			USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT },



