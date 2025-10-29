Return-Path: <stable+bounces-191584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CBC19531
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABF40568027
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50731E0E4;
	Wed, 29 Oct 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Qd9ah1dL"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8B21ABDC
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727821; cv=none; b=TPOvrJzFESnJl6uty1jWcR8OBV24s+47l7xzWagC7EIfAmoCXoXSmbCBKxY7clLEojd0QR+1HEVT6ojeWwTIbhIVvd6ZobkG5qaNeATbqG6G2Ph2dZGoPd9g5/GXmIwyjnlUvY4oMik5BZuZlL2bllIX7JFcV3PCPOhL0YgoKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727821; c=relaxed/simple;
	bh=n0euRFB7gWfEM4REy6W9bGSiZeq9pZRm2S2BPlJhkH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BZC2lR7mwq+D6K8LueqgudTf7VxqmnYuytSzqAeABI+rVvnCQRtES2xAVW9jLsRD27c5tEEAuuI5ARKCuEjANukteqgPdDZ+0c+iQZd25+BSnBJUl5O5n+sUtA5E0LhCqrBDADK4buTcLqgrjmNW8WYhTD3S+VRoy9sgxItiQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Qd9ah1dL; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251029085017euoutp02e3e279145d67dbe1fe5f349108473ef8~y6h2WA3dD0912909129euoutp02b
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251029085017euoutp02e3e279145d67dbe1fe5f349108473ef8~y6h2WA3dD0912909129euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761727817;
	bh=xwfkOFZVwI3gkfo6lbTR619jwqrwqG3gDKV0KKwf95s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Qd9ah1dLFECOzDeqpRRLAMGaMQZu+YEXJSZBFVOHF/+JOk/BIUJMpTAZc/7QKb5s8
	 9raZCPJkCj862Ohp+zXVlWmxp7Ts1tYEcuvqNEBoQXguUqhn56awoSRN8/pxDt9cOO
	 awusNs/42HINstr9V27RIV5GNl78NRWgHuUXWVA4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251029085016eucas1p2b6acb52ed4c2ac940db72dd0e95ef66d~y6h2FrF2Y1329313293eucas1p2Q;
	Wed, 29 Oct 2025 08:50:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251029085016eusmtip16e2fb817f49f299f9f43bedf2ccf86c1~y6h1kmZbu1417114171eusmtip16;
	Wed, 29 Oct 2025 08:50:16 +0000 (GMT)
Message-ID: <c1d459dd-df6c-4ba3-b193-06015918df06@samsung.com>
Date: Wed, 29 Oct 2025 09:50:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 1/2] dma-mapping: benchmark: Restore padding to
 ensure uABI remained consistent
To: Barry Song <21cnbao@gmail.com>, Qinxin Xia <xiaqinxin@huawei.com>
Cc: robin.murphy@arm.com, prime.zeng@huawei.com, fanghao11@huawei.com,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGsJ_4wy2B7=KwLfODySky+FADkLZYowWCNm28FBmri_Opv7ZQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251029085016eucas1p2b6acb52ed4c2ac940db72dd0e95ef66d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028195814eucas1p2a4fc5571fb2d272fc40dc4b0dcf60a42
X-EPHeader: CA
X-CMS-RootMailID: 20251028195814eucas1p2a4fc5571fb2d272fc40dc4b0dcf60a42
References: <20251028120900.2265511-1-xiaqinxin@huawei.com>
	<20251028120900.2265511-2-xiaqinxin@huawei.com>
	<CGME20251028195814eucas1p2a4fc5571fb2d272fc40dc4b0dcf60a42@eucas1p2.samsung.com>
	<CAGsJ_4wy2B7=KwLfODySky+FADkLZYowWCNm28FBmri_Opv7ZQ@mail.gmail.com>

On 28.10.2025 20:57, Barry Song wrote:
> On Tue, Oct 28, 2025 at 8:09 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> The padding field in the structure was previously reserved to
>> maintain a stable interface for potential new fields, ensuring
>> compatibility with user-space shared data structures.
>> However,it was accidentally removed by tiantao in a prior commit,
>> which may lead to incompatibility between user space and the kernel.
>>
>> This patch reinstates the padding to restore the original structure
>> layout and preserve compatibility.
>>
>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
> It would be preferable to include the following as well:
>
> Reported-by: Barry Song <baohua@kernel.org>
> Closes: https://lore.kernel.org/lkml/CAGsJ_4waiZ2+NBJG+SCnbNk+nQ_ZF13_Q5FHJqZyxyJTcEop2A@mail.gmail.com/
>
>> Cc: stable@vger.kernel.org
>> Acked-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> Thank you. We also need to include Jonathan’s tag[1]:
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> [1] https://lore.kernel.org/lkml/20250616105318.00001132@huawei.com/
>
> I assume Marek can assist with adding those tags when you apply the patch?

Thanks, applied to dma-mapping-fixes 
branch with all the above additional tags.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


