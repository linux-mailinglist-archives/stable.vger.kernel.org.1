Return-Path: <stable+bounces-138498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85510AA1849
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569CB1BC402A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C4A233735;
	Tue, 29 Apr 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tE4ZoFHH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6E215F6C;
	Tue, 29 Apr 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949443; cv=none; b=XWzIkAcMyQZXKtuA2PrH5E3He7sWwVdfU1olBZH38H+OfPbX/Hl8ex3ybQG4CYKYKtpdX1FFT94bmLJfkZBDTsLrvWR0JNxSieY1BbjbFyTyQ/sqTXTXg2eNs1vASQV2krOfzdfKEKipmvrk4qKmWV3CcStvdan67V58S5bEXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949443; c=relaxed/simple;
	bh=nhdkO3UmBydyvlCPvuTPNIROkDJPWJOmwNBqTq9vs+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU4r9awQyPo39O5e88JiUrxvLcHe+mMsHleHGgfEu90Ag+gjLEevahDYtC0rbrU/L7MVGDRtLTuK+sR5hazKXEsEoccuaLRlbA4jehxDGmdmf6LRcMVYEfSt+FbANyoocbTFlX9TfAGQxQAU85SiYOHdKLqi07ZvSYjd3gzGhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tE4ZoFHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F41CC4CEE3;
	Tue, 29 Apr 2025 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949442;
	bh=nhdkO3UmBydyvlCPvuTPNIROkDJPWJOmwNBqTq9vs+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tE4ZoFHHEQ7CunYf8vuDdPEaNuZxUB6LhDN/iFESfSYclac+KMYMwgcdBAxetHyhH
	 hpz5VciylrTkJszSmvY5BKtxsukTj76a/ADCp/V+SJTbw9umxi8FEF+zU5SVBDwaRl
	 bNSX5AiQ7I2RmsMzoSoicrYvERSoHINu2c1Y1Dw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 5.15 321/373] USB: wdm: wdm_wwan_port_tx_complete mutex in atomic context
Date: Tue, 29 Apr 2025 18:43:18 +0200
Message-ID: <20250429161136.327965656@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 1fdc4dca350c0b8ada0b8ebf212504e1ad55e511 upstream.

wdm_wwan_port_tx_complete is called from a completion
handler with irqs disabled and possible in IRQ context
usb_autopm_put_interface can take a mutex.
Hence usb_autopm_put_interface_async must be used.

Fixes: cac6fb015f71 ("usb: class: cdc-wdm: WWAN framework integration")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250401084749.175246-4-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-wdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -879,7 +879,7 @@ static void wdm_wwan_port_tx_complete(st
 	struct sk_buff *skb = urb->context;
 	struct wdm_device *desc = skb_shinfo(skb)->destructor_arg;
 
-	usb_autopm_put_interface(desc->intf);
+	usb_autopm_put_interface_async(desc->intf);
 	wwan_port_txon(desc->wwanp);
 	kfree_skb(skb);
 }



