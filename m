Return-Path: <stable+bounces-183578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B16BC340C
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 05:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9C9C4E925E
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 03:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC22BDC2A;
	Wed,  8 Oct 2025 03:52:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DB23F422;
	Wed,  8 Oct 2025 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895529; cv=none; b=QXXOCiqR1EhuPnJvpXv7dXDFUXO9jCnj8NnWtbwcdJGf9SvWitOiTZ92JgqOO74zunVbAZzIGqY2Uw/UlX5GWsPnpx0BQkMpjhliumg6m+L70RBLynhdm2GfrJ6l5DCwJjTIfhjunxFdc4FhMTnOWKNucxA5wl/7yillK1MaRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895529; c=relaxed/simple;
	bh=vMnZxNvw3AeVnX0HFoTG1czseYUxgJCDXkCU9NJB/LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yhhe62b80KDEDVD2XFlf6MTJL2QwXkTgKUcl78UmJZLF6FfaN2ZE+ShrUVsMbEPukTMRliYl7qdGkqXw/VobTUBLTNPkGwjQ09cQ4wYrNarfpo3YAZ+tTcP2OyvNTYTEMDpoZd6H+/7GbHo5knhlEK0dMfBBCQbCiB8ZZx0HTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af0e2.dynamic.kabel-deutschland.de [95.90.240.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A2DD60288273;
	Wed, 08 Oct 2025 05:51:54 +0200 (CEST)
Message-ID: <77bde79f-2080-4e40-a013-52b480c0928c@molgen.mpg.de>
Date: Wed, 8 Oct 2025 05:51:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: bfusb: Fix buffer over-read in rx
 processing loop
To: Seungjin Bae <eeodqql09@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
References: <20251007232941.3742133-2-eeodqql09@gmail.com>
 <20251008015640.3745834-2-eeodqql09@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251008015640.3745834-2-eeodqql09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Seungjin,


Thank you for the patch.

Am 08.10.25 um 03:56 schrieb pip-izony:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The bfusb_rx_complete() function parses incoming URB data in while loop.

… in *a* while loop.

> The logic does not sufficiently validate the remaining buffer size(count)
> accross loop iterations, which can lead to a buffer over-read.

across

> For example, with 4-bytes remaining buffer, if the first iteration takes
> the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
> only 2-bytes remain, but the else branch is trying to access the third
> byte(buf[2]). This causes an out-of-bounds read and a potential kernel panic.

Please re-flow for 75 characters per line.

> This patch fixes the vulnerability by adding checks to ensure enough
> data remains in the buffer before it is accessed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>   v1 -> v2: Fixing the error function name
>   
>   drivers/bluetooth/bfusb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 8df310983bf6..45f4ec5b6860 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -360,6 +360,10 @@ static void bfusb_rx_complete(struct urb *urb)
>   			count -= 2;
>   			buf   += 2;
>   		} else {
> +            if (count < 3) {
> +                bt_dev_err(data->hdev, "block header is too short");

Please print count and 3.

> +                break;
> +            }

Please use tabs for alignment. `scripts/checkpatch.pl` should have 
warned about this.

>   			len = (buf[2] == 0) ? 256 : buf[2];
>   			count -= 3;
>   			buf   += 3;


Kind regards,

Paul

