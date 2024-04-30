Return-Path: <stable+bounces-41790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDF8B6916
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 05:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260C71F21D65
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 03:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFED10799;
	Tue, 30 Apr 2024 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4qI9tzF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595E1119A
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448408; cv=none; b=tk4HAzogh/rbnxYAm/k17f15NDnX5xD05RhvF0IcWCh6kS09lEVUPHxjlWLcoBQXuZIJXvdO/oeOV9tIzwyiO2qHffTEoXieWDXGN/cbrM38qbzNhrBSJAcnyuk2e/6F4Ms0M+yaW2ebrCNjGBc5ZWt+utt8U+JINzQBBjUCVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448408; c=relaxed/simple;
	bh=m/p/IgRYePojDeT7PwzlS+lqlu3d/yqc6YD7XQM6Sug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF8EfilZ5M19G3zm95ZsenUrwgjfuA4JE200I3dVAgKPy/MNAyIFtJbLvUHURmLeXZr+pbC9Mhzfu1HLDA8QaRyLK4N1zd8n6LDWTxe8kzrZX/xeOct/o9hfxsR6FQ1g/lU1F/TMDCbDDf/irHB09Y3uQ2XnugAFLotZuOC04eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4qI9tzF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714448405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8kTq/NFS4+YJ9jH3Ma0+wYkL5Q7oA3OoNJBEMfeUMg=;
	b=P4qI9tzFiLakr4mTLyDFblXcRI5bNVaSEfHWChE0DycNgAJ3SKMlRr8buV2Lhv6Dtsv5zn
	RnHr7QGFGVV/AYHLizr0dfhwxl27/HeWKyUdaI6geV9wYvtHWwNLNjAd9h+UtOIOx4GXbA
	AT8nD9f0T9xcyQ18NoRlRRnOuWg1Tpo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-sh7g9oh4NbyEqvdHixjlgg-1; Mon, 29 Apr 2024 23:39:54 -0400
X-MC-Unique: sh7g9oh4NbyEqvdHixjlgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB7FF18065B1;
	Tue, 30 Apr 2024 03:39:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 912AD1C060D0;
	Tue, 30 Apr 2024 03:39:52 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:39:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Chen Jiahao <chenjiahao16@huawei.com>
Subject: Re: [PATCH v2] Revert "riscv: kdump: fix crashkernel reserving
 problem on RISC-V"
Message-ID: <ZjBoBYwdPMyPDGhG@MiWiFi-R3L-srv>
References: <20240430032403.19562-1-xingmingzheng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430032403.19562-1-xingmingzheng@iscas.ac.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/30/24 at 11:24am, Mingzheng Xing wrote:
> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which was
> mistakenly added into v6.6.y and the commit corresponding to the 'Fixes:'
> tag is invalid. For more information, see link [1].
> 
> This will result in the loss of Crashkernel data in /proc/iomem, and kdump
> failed:
> 
> ```
> Memory for crashkernel is not reserved
> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> Then try to loading kdump kernel
> ```
> 
> After revert, kdump works fine. Tested on QEMU riscv.
> 
> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Chen Jiahao <chenjiahao16@huawei.com>
> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>

Ack. This is necessary for v6.6.y stable branch.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
> 
> v1 -> v2:
> 
> - Changed the commit message
> - Added Cc:
> 
> v1:
> https://lore.kernel.org/stable/20240416085647.14376-1-xingmingzheng@iscas.ac.cn
> 
>  arch/riscv/kernel/setup.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index aac853ae4eb74..e600aab116a40 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -173,6 +173,19 @@ static void __init init_resources(void)
>  	if (ret < 0)
>  		goto error;
>  
> +#ifdef CONFIG_KEXEC_CORE
> +	if (crashk_res.start != crashk_res.end) {
> +		ret = add_resource(&iomem_resource, &crashk_res);
> +		if (ret < 0)
> +			goto error;
> +	}
> +	if (crashk_low_res.start != crashk_low_res.end) {
> +		ret = add_resource(&iomem_resource, &crashk_low_res);
> +		if (ret < 0)
> +			goto error;
> +	}
> +#endif
> +
>  #ifdef CONFIG_CRASH_DUMP
>  	if (elfcorehdr_size > 0) {
>  		elfcorehdr_res.start = elfcorehdr_addr;
> -- 
> 2.34.1
> 


