Return-Path: <stable+bounces-195366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B49C758E4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6DC034F8A0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22463371DF9;
	Thu, 20 Nov 2025 17:05:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4E33C1A8;
	Thu, 20 Nov 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658351; cv=none; b=guM4ZD3DaUYI3cHLmUQ4sZkuDjZ1YXODlpxYkFBir3xxV2CBpVHhsb/tH+gKmtaNMpOEEpgd8Zz20Lrr5cvGDrJ5s7xL/2LvMm/QHYd264lnpBXFTId7LEtPe1xAG4OR4E7ppJRZ0KqphlcUHchDdvu87FXfwjYZ5MHyQYkY0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658351; c=relaxed/simple;
	bh=zOzBlVRGWjXj/eLJL63dPaCE0EqtsPjRY+ol2qCqdbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaXckNd1gg+xAQixNHJFIW9e4pII/RDx4t2R3r9+DdabBx+ZIngcCTR9EdbmdnTrWKU6wEjJtfCtRuiSheisJbiQiWzG+R5F8LQNv64XbGkyEZMwc9qMW3PA5cnJdkSmkTNVMxjTN4QEQvIBUNdNdDVXsU69DAaLn7f7qhhWLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CF5FF61CC3FE1;
	Thu, 20 Nov 2025 18:04:36 +0100 (CET)
Message-ID: <be1cbae6-f868-4939-a1c1-fd66e2c6b23e@molgen.mpg.de>
Date: Thu, 20 Nov 2025 18:04:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid
 btusb_mtk_claim_iso_intf() NULL deref
To: Douglas Anderson <dianders@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 incogcyberpunk@proton.me, johan.hedberg@gmail.com, sean.wang@mediatek.com,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Douglas,


Thank you for your patch.

Am 20.11.25 um 17:12 schrieb Douglas Anderson:
> In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
>    usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)
> 
> That function can return NULL in some cases. Even when it returns
> NULL, though, we still go on to call btusb_mtk_claim_iso_intf().
> 
> As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
> usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
> when `btmtk_data->isopkt_intf` is NULL will cause a crash because
> we'll end up passing a bad pointer to device_lock(). Prior to that
> commit we'd pass the NULL pointer directly to
> usb_driver_claim_interface() which would detect it and return an
> error, which was handled.
> 
> Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
> at the start of the function. This makes the code handle a NULL
> `btmtk_data->isopkt_intf` the same way it did before the problematic
> commit (just with a slight change to the error message printed).
> 
> Reported-by: IncogCyberpunk <incogcyberpunk@proton.me>
> Closes: http://lore.kernel.org/r/a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info
> Fixes: e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()")
> Cc: stable@vger.kernel.org
> Tested-by: IncogCyberpunk <incogcyberpunk@proton.me>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - Added Cc to stable.
> - Added IncogCyberpunk Tested-by tag.
> - v2: https://patch.msgid.link/20251119092641.v2.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid
> 
> Changes in v2:
> - Rebase atop commit 529ac8e706c3 ("Bluetooth: ... mtk iso interface")
> - v1: https://patch.msgid.link/20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid
> 
>   drivers/bluetooth/btusb.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index fcc62e2fb641..683ac02e964b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2751,6 +2751,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
>   	if (!btmtk_data)
>   		return;
>   
> +	if (!btmtk_data->isopkt_intf) {
> +		bt_dev_err(data->hdev, "Can't claim NULL iso interface");

As an error is printed now, what should be done about? Do drivers need 
fixing? Is it broken hardware?

> +		return;
> +	}
> +
>   	/*
>   	 * The function usb_driver_claim_interface() is documented to need
>   	 * locks held if it's not called from a probe routine. The code here

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

