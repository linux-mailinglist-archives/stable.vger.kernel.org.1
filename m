Return-Path: <stable+bounces-161484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2241AFF105
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB2D1C810B5
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2E23ABA3;
	Wed,  9 Jul 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PP9fz4hu"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878D23507E;
	Wed,  9 Jul 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086675; cv=none; b=SEwTf9ulRWsbxZ4i2orJ1ecDxFhdcaNVY2CQurAfALq3Cwe8i71bU1JTF3IcatmdU7zozfL/ID/gz9Ria2gsdLTSzxF49b71VBinTrd5xRC7kntRKFQjH4YA/rBaBKZfZhBxpNoKvRGbLn8SYnfdt51tmvVpABPyJdJrUqBg4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086675; c=relaxed/simple;
	bh=LnSpViirecCt5hQ3qDHHxWMQrkVthi3qX9NY3MXKyqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqDj9pm+H8hxt05QN05aWzLjX8TIQXo4xbnKVXc4MxIKPtBR/yg56gQC4oFSeA5ckmYg9QBypA7MMPYqOMX7xS13avhNmKzWXu5Ig90ZoBH4idJPVkoUXM6N8Dryod+CR/4U4te4SqCNMpu18UPtVelIhGzEnbcpS1K82JY6JN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PP9fz4hu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E7028201A4A9;
	Wed,  9 Jul 2025 11:44:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7028201A4A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752086673;
	bh=G2dyhTNarlOLAveUVZiYAu+lzf15ztcoGNt03mbPme0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=PP9fz4hu1ioveQReVhuKlUAHtb9HH+nCfk2aboW5dHq5X3WKKZVE4nVVJWQKFS7+T
	 fiR4bMl0Yp/IkEarB6JDAl2K7uTXv89F04ZOwbNQQb7AoULfiGkxhmoXdXl//7Voia
	 CnY2mb9P8zlucmwoDrL+EObhYZejyi9wvZdxfRGE=
Date: Wed, 9 Jul 2025 11:44:32 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Jann Horn
 <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
 <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau
 Rezki <urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
 security@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250709114432.294425ff@DESKTOP-0403QTC.>
In-Reply-To: <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
	<20250709085158.0f050630@DESKTOP-0403QTC.>
	<20250709162724.GE1599700@nvidia.com>
	<20250709111527.5ba9bc31@DESKTOP-0403QTC.>
	<42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 9 Jul 2025 11:22:34 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 7/9/25 11:15, Jacob Pan wrote:
> >>> Is there a use case where a SVA user can access kernel memory in
> >>> the first place?   =20
> >> No. It should be fully blocked.
> >> =20
> > Then I don't understand what is the "vulnerability condition" being
> > addressed here. We are talking about KVA range here. =20
>=20
> SVA users can't access kernel memory, but they can compel walks of
> kernel page tables, which the IOMMU caches. The trouble starts if the
> kernel happens to free that page table page and the IOMMU is using the
> cache after the page is freed.
>=20
According to VT-d spec. 6.2.4 S1 IOTLB caching includes access
privilege.
"First-stage mappings:
=E2=80=94 Each of these is a mapping from a input page number in a request =
to the physical page frame
to which it translates (derived from first-stage translation), along with i=
nformation about
access privileges and memory typing (if applicable)."

So you are saying IOMMU can cache user DMA initiated walks and cache
with supervisor privilige? Since the SVA PASID is a user PASID, even if
IOMMU uses the cache later on, how could it get supervior privilege?



