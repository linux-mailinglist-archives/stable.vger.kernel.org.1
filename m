Return-Path: <stable+bounces-176388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A6B36D67
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735F98E5D4C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40203227B9F;
	Tue, 26 Aug 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MkFRCod7"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494E2222AC;
	Tue, 26 Aug 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220180; cv=none; b=DEAztwwCPZQlTop3oLyAbpyZtH4rxPowZ1w4nerdPL52X9BqKWNv5V9n/dd/69tgu+tAaoKwMORHF73L7hoTwbzpvv+WSV4XwkqmsTR8VA8jqqCfQrp/ity2Ux5DIdNqFwLEenwwlr8majQh20jPq9xh3E7a7OAoUZk5n7jv3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220180; c=relaxed/simple;
	bh=LI1dCZa4FwieTJrb5lNo+wXzSQ7nbU3b0nB7rDBUhHM=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=dxnw46hR0mnxtHaNJpI2YEhAyRQVez+liHHBPkmo5B46zcIPCajdFMx/sMzzNOtxBDMt01fDk+csuKoJmLjyYSAdJjCvr1DT0DoFj4zlHMA9B1zXDzuXj1kosIKVbldHV/CzLqVKPh/U1UMb5fd0Scp5prM+GnnkC4BeEW9G6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MkFRCod7; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756220177; x=1787756177;
  h=mime-version:content-transfer-encoding:date:message-id:
   to:cc:subject:from:references:in-reply-to;
  bh=6W8m3tqW7TsBzc9bn3jq/EsbNWeFZzmBuJ+k3VQ45Yk=;
  b=MkFRCod77B5NtIFu9/GDHQxgWaEhs0N8JSTb1otA6TKqzb50FnqoVf1Q
   BOB5h8K0Ovxa4HMmOGfzQGLsfifPOlgIs0h6VobPz1uzmlc/zwAY3M1t+
   D8sqOU417nzNV1Hlm2aXiUSl4ucyIoBoFUSUxYzohA7tO3yZalj/czo8y
   jYzf4IBqhyUoTQBr7twAKJ89c9kaBxj6fcp9yxN4OGzYGAx6Z0rZc70kn
   O4HV8Ia4a3eJsJkELz/EAzXUtzsYctbdu/K3aApGT/ZCpSPN0DlnT0jCj
   2Ly8eCPrR0lklm1kfWHBI8oEsSlVreLSXauaDipW45q6GxZnIaKfsL7RG
   A==;
X-CSE-ConnectionGUID: asiGzhnzTiCdDQnaKZprlg==
X-CSE-MsgGUID: R4nyLwQwQJCy5oUT7xGABg==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1210282"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 14:56:07 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:1375]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.187:2525] with esmtp (Farcaster)
 id 2f6f29d2-1acf-4882-b0d8-cf461d27f0a6; Tue, 26 Aug 2025 14:56:07 +0000 (UTC)
X-Farcaster-Flow-ID: 2f6f29d2-1acf-4882-b0d8-cf461d27f0a6
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 26 Aug 2025 14:56:06 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 26 Aug 2025
 14:56:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Aug 2025 14:55:58 +0000
Message-ID: <DCCG3711VAN4.9QEOBBP433L2@amazon.com>
To: Eugene Koira <eugkoira@amazon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <longpeng2@huawei.com>,
	<graf@amazon.de>, <nsaenz@amazon.com>, <nh-open-source@amazon.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/intel: Fix __domain_mapping()'s usage of
 switch_to_super_page()
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <20250826143816.38686-1-eugkoira@amazon.com>
In-Reply-To: <20250826143816.38686-1-eugkoira@amazon.com>
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Tue Aug 26, 2025 at 2:38 PM UTC, Eugene Koira wrote:
> switch_to_super_page() assumes the memory range it's working on is aligne=
d
> to the target large page level. Unfortunately, __domain_mapping() doesn't
> take this into account when using it, and will pass unaligned ranges
> ultimately freeing a PTE range larger than expected.
>
> Take for example a mapping with the following iov_pfn range [0x3fe400,
> 0x4c0600], which should be backed by the following mappings:
>
>    iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
>    iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
>    iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages
>
> Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c05ff=
]
> to switch_to_super_page() at a 1 GiB granularity, which will in turn
> free PTEs all the way to iov_pfn 0x4fffff.
>
> Mitigate this by rounding down the iov_pfn range passed to
> switch_to_super_page() in __domain_mapping()
> to the target large page level.
>
> Additionally add range alignment checks to switch_to_super_page.
>
> Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domain_ma=
pping()")
> Signed-off-by: Eugene Koira <eugkoira@amazon.com>
> Cc: stable@vger.kernel.org
> ---

>  drivers/iommu/intel/iommu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9c3ab9d9f69a..dff2d895b8ab 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1575,6 +1575,10 @@ static void switch_to_super_page(struct dmar_domai=
n *domain,
>  	unsigned long lvl_pages =3D lvl_to_nr_pages(level);
>  	struct dma_pte *pte =3D NULL;
> =20
> +	if (WARN_ON(!IS_ALIGNED(start_pfn, lvl_pages) ||
> +		    !IS_ALIGNED(end_pfn + 1, lvl_pages)))

It might make sense to downgrade the warning to WARN_ON_ONCE().

Other than that:

	Reviewed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

Regards,
Nicolas

