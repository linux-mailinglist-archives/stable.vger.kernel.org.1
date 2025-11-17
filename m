Return-Path: <stable+bounces-194973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FFC64F8C
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4434CA56
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624F296BC2;
	Mon, 17 Nov 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VLSU0QVn"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C028640C
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394580; cv=none; b=Q9nHXNujV+o1az04NASbRPFU8/9+NngvykF7hW+XtTUcEtDPgJQ79Jf1BAr/BIkMJL6ul3QMhwpK4svxOwoAxMa/j4/wg+VOe+SRZJNg46ss08ONzUbcUKFV/RpaG8C+NQFjR2OuEP3kHRqfglop41TvsrvOsshqGw4ciiSqS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394580; c=relaxed/simple;
	bh=PlKnzs8SRrr3GApGtBgUa6hyvvBeNebTDbAvtyt+NcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=t9k7anppCy2wMIktS+ulx60+rw5tKhLbsTfgXLu4NngybEW0yddPKEGL4u+gdiiyA+nBRf7HZhdIHq4MVQhSn8OGv6bkPcRpfsycpinS80E5pVqLcy3H2DC8p+0ssXzE2iAgk5m52IvcptdjoVlIjwKgG3zSYp7FpxO7oVIZaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VLSU0QVn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251117154935epoutp045f61257e35b300a7dda87e2ff005ca83~41gYR1FFx3025830258epoutp04K
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 15:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251117154935epoutp045f61257e35b300a7dda87e2ff005ca83~41gYR1FFx3025830258epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763394575;
	bh=0ICNx/oPdS9KbNlZq7PkBuiUJgqZn9KtQ9UINy+zh9U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VLSU0QVnBN9UO7+xKQ1c9VBx2F0glYlDjOA9/DCpzAhIWcfmLlr0+5qkVzwVHJISH
	 9Mpb4IlnHKIYD8vwE7PQAIIcFaro4+HhbFSQb7aC6oC17istp6ItZy21trTO9gfB05
	 02eLlMLwHKapjvqLH/+Yg2sqHncHiYPAeUKC1S0k=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251117154934epcas5p18fc0618ad4c8276cec2f8b146c9a944f~41gXpFHiZ1459814598epcas5p1I;
	Mon, 17 Nov 2025 15:49:34 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d9By628z4z3hhT8; Mon, 17 Nov
	2025 15:49:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251117154933epcas5p3f39fab451d236900a0f5f3acd745be41~41gWfV8mB1805018050epcas5p3S;
	Mon, 17 Nov 2025 15:49:33 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251117154928epsmtip226d28abe9b3711faec27e68b563d8011~41gRuoXu-0132701327epsmtip2L;
	Mon, 17 Nov 2025 15:49:27 +0000 (GMT)
Message-ID: <f4a65be6-f892-464f-a4c6-5032c1558666@samsung.com>
Date: Mon, 17 Nov 2025 21:19:23 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Prevent EPs resource conflict during
 StartTransfer
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20251117152812.622-1-selvarasu.g@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251117154933epcas5p3f39fab451d236900a0f5f3acd745be41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117152924epcas5p3463725d014582467d6f3c100fa21eb8c
References: <CGME20251117152924epcas5p3463725d014582467d6f3c100fa21eb8c@epcas5p3.samsung.com>
	<20251117152812.622-1-selvarasu.g@samsung.com>


On 11/17/2025 8:58 PM, Selvarasu Ganesan wrote:
> This commit fixes the below warning that occurs when a StartTransfer
> command is issued for bulk or interrupt endpoints in
> `dwc3_gadget_ep_enable` while a previous transfer on the same endpoint
> is still in progress. The gadget functions drivers can invoke
> usb_ep_enable (which triggers a new StartTransfer command) before the
> earlier transfer has completed. Because the previous StartTransfer is
> still active, `dwc3_gadget_ep_disable` can skip the required
> `EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to  the endpoint
> resources are busy for previous StartTransfer and warning ("No resource
> for ep") from gadget driver.
>
> To resolve this, a check is added to `dwc3_gadget_ep_enable` that
> checks the `DWC3_EP_TRANSFER_STARTED` flag before issuing a new
> StartTransfer. By preventing a second StartTransfer on an already busy
> endpoint, the resource conflict is eliminated, the warning disappears,
> and potential kernel panics caused by `panic_on_warn` are avoided.
>
> ------------[ cut here ]------------
> dwc3 13200000.dwc3: No resource for ep1out
> WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 dwc3_send_gadget_ep_cmd+0x2f8/0x76c
> Call trace:
>   dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>   __dwc3_gadget_ep_enable+0x490/0x7c0
>   dwc3_gadget_ep_enable+0x6c/0xe4
>   usb_ep_enable+0x5c/0x15c
>   mp_eth_stop+0xd4/0x11c
>   __dev_close_many+0x160/0x1c8
>   __dev_change_flags+0xfc/0x220
>   dev_change_flags+0x24/0x70
>   devinet_ioctl+0x434/0x524
>   inet_ioctl+0xa8/0x224
>   sock_do_ioctl+0x74/0x128
>   sock_ioctl+0x3bc/0x468
>   __arm64_sys_ioctl+0xa8/0xe4
>   invoke_syscall+0x58/0x10c
>   el0_svc_common+0xa8/0xdc
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x38/0x88
>   el0t_64_sync_handler+0x70/0xbc
>   el0t_64_sync+0x1a8/0x1ac
>
> Change-Id: Id292265a34448e566ef1ea882e313856423342dc
Required to remove change-id as mistakenly included, and going to post 
new version with remove change-id.
> Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for bulk EPs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>   drivers/usb/dwc3/gadget.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index f95d1369bbc6..23e5c111da7c 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -951,8 +951,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>   	 * Issue StartTransfer here with no-op TRB so we can always rely on No
>   	 * Response Update Transfer command.
>   	 */
> -	if (usb_endpoint_xfer_bulk(desc) ||
> -			usb_endpoint_xfer_int(desc)) {
> +	if ((usb_endpoint_xfer_bulk(desc) ||
> +			usb_endpoint_xfer_int(desc)) &&
> +			!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
>   		struct dwc3_gadget_ep_cmd_params params;
>   		struct dwc3_trb	*trb;
>   		dma_addr_t trb_dma;

