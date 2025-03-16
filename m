Return-Path: <stable+bounces-124552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39533A637A0
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7669016A472
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B7199FD0;
	Sun, 16 Mar 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Of7IXzZt"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD517D346
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742162414; cv=none; b=gOSJrslNJ3OCTZDowsKb1KPCPg+8XZHI6lZJFHv/MpEqEK6q4qz9SKSH+GpwjYNXuDjv84YqUYypMztbnLG2wMetBFw12VlCeEnc4wcsVNXzS/4Ck3nAIT2LykFO15MqvWibDH5h4V4JqQNJ6mCSgx6bf4UZKUb4W4hxgUZHq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742162414; c=relaxed/simple;
	bh=LxbpImp9+fAa7a2gzuLuT0uenEc57/7pMm3uefW/RIc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VPJI3W2mMJcncOu2IXN5ij4mceprG1iufvifmFFUWJxzSp+D+ttT9ES1djbPJfS6z6Ymoty6YSmVd6sz8BmkBohzbmhtZO1LPvD9TyiJ9cXWdIw0YkZZDM+bhqVp53C5xpBXTm7w2b102sUVXoTo88jUSGT947+PCR9peobbcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Of7IXzZt; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfe1d14f-1488-4a6b-b864-2b9c23ae16df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742162409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDcwEC9Hm/pamSwL5uTliXHBCVufdMY1FDJGGf3nZSY=;
	b=Of7IXzZtO5BQC2KJ9e4nVhyLrQUpfemzpZDlzQH+WrJoQbXX9jRiqRTOA1MFQELQz9gOeC
	7/bVpxAswWilO+5UcH/VeoB/fKHnZfIkq1W7KgGOSngKszgKxb4jVINe3kuN7g/Lt8D1SA
	tgMCuJo2wMfRTubywMApni5OLUVGqxk=
Date: Sun, 16 Mar 2025 23:00:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [PATCH] fpga: fix potential null pointer deref in
 fpga_mgr_test_img_load_sgt()
To: Qasim Ijaz <qasdev00@gmail.com>, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com, trix@redhat.com, marpagan@redhat.com,
 russ.weight@linux.dev
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250311234509.15523-1-qasdev00@gmail.com>
Content-Language: en-US
In-Reply-To: <20250311234509.15523-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2025-03-12 00:45, Qasim Ijaz wrote:
> fpga_mgr_test_img_load_sgt() allocates memory for sgt using
> kunit_kzalloc() however it does not check if the allocation failed. 
> It then passes sgt to sg_alloc_table(), which passes it to
> __sg_alloc_table(). This function calls memset() on sgt in an attempt to
> zero it out. If the allocation fails then sgt will be NULL and the
> memset will trigger a NULL pointer dereference.
> 
> Fix this by checking the allocation with KUNIT_ASSERT_NOT_ERR_OR_NULL().
> 
> Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Marco Pagani <marco.pagani@linux.dev>

> ---
>  drivers/fpga/tests/fpga-mgr-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> index 9cb37aefbac4..1902ebf5a298 100644
> --- a/drivers/fpga/tests/fpga-mgr-test.c
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -263,6 +263,7 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
>  	img_buf = init_test_buffer(test, IMAGE_SIZE);
>  
>  	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>  	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);

Thanks,
Marco


