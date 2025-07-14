Return-Path: <stable+bounces-161824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66685B03AD2
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0323BAA2D
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A323C503;
	Mon, 14 Jul 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Bq/RqKlb"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF221C174;
	Mon, 14 Jul 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485433; cv=pass; b=Fq7TbYU7f/Qs/wGdUtjy3ZXwLWEkpQM6YTwyj11XOe1jDuEudQTdc7p7RT1Y+xmiYxZbMZVKuf9sxXmCEn6KUiGDiyo7SIjIbVwe4E4aiIlAdh939Vwhy9MmB0c5g+bd4tsmXkVZ9k1nVIEptOwOgQv7lYlid29NKS12m0j7M+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485433; c=relaxed/simple;
	bh=0viVw14qLa+IIUKZf23RNEgmHcGaOEDjZy5FdVzfuB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmR1pMNZ6G2n166AD9mlpbx8fB7bPg6i6NyNOCVjgJ89n5IEV8rqyZfhrfvzcgwVtEll1lAt2nIgGfbMjCv6Gkh1d1+chbu1kPnKNZhZMp+ycigI7aQP0qNmGxGpWlwkg1pPTo6bTbQDux4zDtSaHqreqYuhlFhlRRpULgczIp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Bq/RqKlb; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752485407; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lkjpl+d5f8l8xdYgnWp8IKWtj1jBrzxKAfy4mdX9qQ32hSRgThY4CKRFNDmzVXQpHBUnryctvmTV6oSoEmHDdaCqXjmk5WveUJLR3xCWhU+UuLQS2OWQtdIl8d8WPiCSoDjCYjc4f+pTphC8xNZDetaGsVNN7KFHm62nCM3NmIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752485407; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z22yQXuLYE/Mv13/zs5rlwmEVg1w4jHq5ZFpK/GGYnw=; 
	b=Y5xwRom7qOWSMuKWgwQm38JfM3ewbLobVsa3Zma0ZwARsqcbQFMnT2MZTrbe0UOy2dnQJjd+oAiIyQw2Uth1FNqZjsw8Woh1soi8M9aZ3v9vtzYQ9CVSC6oQspITAHozDbEd+EBpsNpSl3FPW+NSmOI0eulFL4X8iTW45IX7KYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752485406;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=z22yQXuLYE/Mv13/zs5rlwmEVg1w4jHq5ZFpK/GGYnw=;
	b=Bq/RqKlbo3w4Lzb6QIcJ5U0dMk/v9++6OEqk/j03Tff0bpZ1wl00gDpPjlTSu5sg
	V9HkiMfGc74BZS0AixWEPBtTSsIHDutkdATwgBvL1ltOJElGl9LowJBPj5vIrdnsIIM
	O1apupA6oI7E3VuyHQ0nPG63TXzzShg+1QvnHHrg=
Received: by mx.zohomail.com with SMTPS id 1752485403948754.1647085662507;
	Mon, 14 Jul 2025 02:30:03 -0700 (PDT)
Message-ID: <ada3b3d9-3e79-4f51-b0ea-baa11f1b2bbb@zohomail.com>
Date: Mon, 14 Jul 2025 17:29:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Balance device refcount when destroying
 devices
To: Ma Ke <make24@iscas.ac.cn>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
 zijun.hu@oss.qualcomm.com, fabio.m.de.francesco@linux.intel.com
References: <20250714091654.3206432-1-make24@iscas.ac.cn>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250714091654.3206432-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227cda918ae3a36950e7e4eba90000036761418356bc7ce59264f6f2c88af6ae760e84c7d35465815:zu080112271d08ad947e296a6c4f35997300006b313e96501b4b2d38f9fefdfec798f44da6d688199d67bd63:rf0801122de93c9513d46e2ad2d76d99d20000c38db3e85870edecaa6517ea6dd5f6b02422d9d4215971af6f0daae7e20ec4:ZohoMail
X-ZohoMailClient: External

On 7/14/2025 5:16 PM, Ma Ke wrote:
> Using device_find_child() to lookup the proper device to destroy
> causes an unbalance in device refcount, since device_find_child()
> calls an implicit get_device() to increment the device's reference
> count before returning the pointer. cxl_port_find_switch_decoder()
> directly converts this pointer to a cxl_decoder and returns it without
> releasing the reference properly. We should call put_device() to
> decrement reference count.
>
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: d6879d8cfb81 ("cxl/region: Add function to find a port's switch decoder by range")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/cxl/core/region.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..cae16d761261 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3234,6 +3234,9 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
>  	struct device *cxld_dev = device_find_child(&port->dev, hpa,
>  						    match_decoder_by_range);
>  
> +	/* Drop the refcnt bumped implicitly by device_find_child */
> +	put_device(cxld_dev);
> +
>  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
>  }
>  

It is not needed, because cxl_port_find_switch_decoder() is only invoked in cxl_find_root_decoder(), and cxl_find_root_decoder() is only called in cxl_add_to_region(), there is a __free(put_cxl_root_decoder) in cxl_add_to_region() for the device dereference.


Ming


