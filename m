Return-Path: <stable+bounces-10486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206882AB30
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB8AB27330
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62FC11733;
	Thu, 11 Jan 2024 09:47:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960912E52;
	Thu, 11 Jan 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (unknown [95.90.244.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F1CF661E5FE06;
	Thu, 11 Jan 2024 10:46:34 +0100 (CET)
Message-ID: <bf74d533-c0ff-42c6-966f-b4b28c5e0f60@molgen.mpg.de>
Date: Thu, 11 Jan 2024 10:46:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix crash when btattach controller
 ROME
Content-Language: en-US
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, jiangzp@google.com,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
References: <1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zijun,


Thank you for your patch.

Am 11.01.24 um 09:16 schrieb Zijun Hu:
> A crash will happen when btattach controller ROME, and it is caused by

What does “btattach controller ROME” mean? Is ROME a platform? If so, 
should it be *on ROME* or similar?

> dereferring nullptr hu->serdev, fixed by null check before access.

dereferring → dereferencing

> 
> sudo btattach -B /dev/ttyUSB0 -P qca
> Bluetooth: hci1: QCA setup on UART is completed
> BUG: kernel NULL pointer dereference, address: 00000000000002f0
> ......
> Workqueue: hci1 hci_power_on [bluetooth]
> RIP: 0010:qca_setup+0x7c1/0xe30 [hci_uart]
> ......
> Call Trace:
>   <TASK>
>   ? show_regs+0x72/0x90
>   ? __die+0x25/0x80
>   ? page_fault_oops+0x154/0x4c0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? kmem_cache_alloc+0x16b/0x310
>   ? do_user_addr_fault+0x330/0x6e0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? exc_page_fault+0x84/0x1b0
>   ? asm_exc_page_fault+0x27/0x30
>   ? qca_setup+0x7c1/0xe30 [hci_uart]
>   hci_uart_setup+0x5c/0x1a0 [hci_uart]
>   hci_dev_open_sync+0xee/0xca0 [bluetooth]
>   hci_dev_do_open+0x2a/0x70 [bluetooth]
>   hci_power_on+0x46/0x210 [bluetooth]
>   process_one_work+0x17b/0x360
>   worker_thread+0x307/0x430
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xf7/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x46/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
> 
> Fixes: 03b0093f7b31 ("Bluetooth: hci_qca: get wakeup status from serdev device handle")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Zijun Hu <quic_zijuhu@quicinc.com>

On what device?

> ---
>   drivers/bluetooth/hci_qca.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 94b8c406f0c0..6fcfc1f7bb12 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1951,7 +1951,7 @@ static int qca_setup(struct hci_uart *hu)
>   		qca_debugfs_init(hdev);
>   		hu->hdev->hw_error = qca_hw_error;
>   		hu->hdev->cmd_timeout = qca_cmd_timeout;
> -		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
> +		if (hu->serdev && device_can_wakeup(hu->serdev->ctrl->dev.parent))
>   			hu->hdev->wakeup = qca_wakeup;

Why is `hu->serdev` not set on the device?

>   	} else if (ret == -ENOENT) {
>   		/* No patch/nvm-config found, run with original fw/config */


Kind regards,

Paul

