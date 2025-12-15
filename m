Return-Path: <stable+bounces-201042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E133CBE264
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F96E30341DD
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC602BE644;
	Mon, 15 Dec 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="wHZ/fFlJ"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819892F2613;
	Mon, 15 Dec 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806794; cv=none; b=Xn0cSCWtsEK3mB97xPb0nZni1b2vkb7Uy8mqXFDOT68gui0Szbg/4D7AaTGk14DGml58UioGOvSpRi2kiwCafRnuN5OhKwRZhMvFFScz3TSakxvL4vybl2DNtnR2ijMd4xwu4ZvtBuoPj2O5Jq7HNaB6xOmlR/asmwqjXBk3HHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806794; c=relaxed/simple;
	bh=YFS5o96Yz0eaybLLRmzVvwZiVwnKR0HlzbfCmYPtZv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FincsS0PzE4VYXheBQrKdTgoooVMs+tPks8+q91tABelyxu2zadrJ+jvGeql1mnClkWd+WBsGgAHD8eUShYtYVMjOE1Q+9sqezYJRU7tPTJT0H8VE13MXnDiuaf1W2CN1/XozPymI5jMY5IYMncsYakyI8g9ibukUheNqIJocZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=wHZ/fFlJ; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D85562022F;
	Mon, 15 Dec 2025 13:53:04 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 1425A3E8D1;
	Mon, 15 Dec 2025 13:52:57 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id D46CF40361;
	Mon, 15 Dec 2025 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1765806774; bh=YFS5o96Yz0eaybLLRmzVvwZiVwnKR0HlzbfCmYPtZv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wHZ/fFlJoF4x645taA9fnQ+d5Xy+E3jUeUR0q5rzd1NSOOPU9qw/X98QOKZEjwrmG
	 1ohU8pVp+5XMDZN4bHAEnT9vlY2V9fRxFdFHd6Sbvxz1J1sDOTOKLg4y2f6OhZEuPu
	 w6VHF60cMQYWxJCWyxGI49jfzn/vRbbwBN3hvy9s=
Received: from [192.168.5.7] (unknown [111.40.58.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id B8EBD409C4;
	Mon, 15 Dec 2025 13:52:50 +0000 (UTC)
Message-ID: <b20b5f10-eb69-423b-aa5c-9ed0d3d84cbe@aosc.io>
Date: Mon, 15 Dec 2025 21:52:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
To: linux-kernel@vger.kernel.org
Cc: Wu Haotian <rigoligo03@gmail.com>, Mingcong Bai <jeffbai@aosc.io>,
 Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <20251208132340.1317531-1-ilikara@aosc.io>
From: Ilikara Zheng <ilikara@aosc.io>
In-Reply-To: <20251208132340.1317531-1-ilikara@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D46CF40361
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-1.49 / 10.00];
	BAYES_HAM(-1.39)[90.83%];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[ilikara.aosc.io:server fail,stable.vger.kernel.org:server fail];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,aosc.io,vger.kernel.org,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi all,
Just a gentle ping on this patch.

On 12/8/2025 9:23 PM, Ilikara Zheng wrote:
> Secondary temperature thresholds (temp2_{min,max}) were not reported
> properly on this NVMe SSD. This resulted in an error while attempting to
> read these values with sensors(1):
>
>    ERROR: Can't get value of subfeature temp2_min: I/O error
>    ERROR: Can't get value of subfeature temp2_max: I/O error
>
> Add the device to the nvme_id_table with the
> NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
> composite temperature thresholds.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..31049f33f27d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3997,6 +3997,8 @@ static const struct pci_device_id nvme_id_table[] = {
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> +	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
> +		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
>   	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */

