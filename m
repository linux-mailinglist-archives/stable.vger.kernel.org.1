Return-Path: <stable+bounces-10366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3624828395
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9258C286F1A
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1B35EFC;
	Tue,  9 Jan 2024 09:58:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97431A7E;
	Tue,  9 Jan 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 21BC861E5FE01;
	Tue,  9 Jan 2024 10:58:42 +0100 (CET)
Message-ID: <a4ec8dd2-22aa-4337-b9f4-b35563aa404f@molgen.mpg.de>
Date: Tue, 9 Jan 2024 10:58:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_event: Fix wakeup BD_ADDR are
 wrongly recorded
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
References: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zijun,


Thank you very much for your patch. Should you resent, some nits for the 
commit message. For the summary, I suggest:

Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR

Am 09.01.24 um 09:37 schrieb Zijun Hu:
> hci_store_wake_reason() wrongly parses event HCI_Connection_Request
> as HCI_Connection_Complete and HCI_Connection_Complete as
> HCI_Connection_Request, so causes recording wakeup BD_ADDR error and
> stability issue, it is fixed by this change.

Maybe: … stability issue. Fix it by using the correct field.

How did you reproduce the stability issues?

As you sent it to stable@vger.kernel.org, could you please add a Fixes: tag?

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>   net/bluetooth/hci_event.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ef8c3bed7361..22b22c264c2a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7420,10 +7420,10 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
>   	 * keep track of the bdaddr of the connection event that woke us up.
>   	 */
>   	if (event == HCI_EV_CONN_REQUEST) {
> -		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
> +		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
>   		hdev->wake_addr_type = BDADDR_BREDR;
>   	} else if (event == HCI_EV_CONN_COMPLETE) {
> -		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
> +		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
>   		hdev->wake_addr_type = BDADDR_BREDR;
>   	} else if (event == HCI_EV_LE_META) {
>   		struct hci_ev_le_meta *le_ev = (void *)skb->data;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

