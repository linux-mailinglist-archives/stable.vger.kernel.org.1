Return-Path: <stable+bounces-231011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNOUI+cXyml85AUAu9opvQ
	(envelope-from <stable+bounces-231011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:27:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD0355E78
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66F033003D30
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF33939BD;
	Mon, 30 Mar 2026 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GlOLUa6/"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8D14A60F;
	Mon, 30 Mar 2026 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852068; cv=none; b=S6R1HqBgEgpwprat9MykgJG717WkvNO0PUru0ZFMjXDANG8g9HXW5xcJcyXYqoj0sqHuAykJyQ9AqcFswPfaMxc5rQjtx4yfnr0ZKyS70QtfEntSbVQQPsNQlM+4W6DekqXhNOaDqlSpWzFeA1J3+xblZYarjQTjjRlrllW8zwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852068; c=relaxed/simple;
	bh=Knu8bUCMtcArQ12U1VZ1JTSL/k1AEL88cvEepH8L7+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgKg8K85UebnzqXuTIrHazQ52haO+RcgPwMtILlfsIxBpDxkMk2QpJe9Dwk7mihjc+gV0V8MyzxKCZExCG4jsWGFx/JZHZ3h9JRESTkYpKww5yje3vkHxoHq+Aa/cd+c9RJb0nIZ+NQoHSbKmDEPssMb933sb1KxLUoMnR4HbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GlOLUa6/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774852054; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hx0KUQkz2fhW9W+oV1gZB96ZGHDs6RQDYrnZbLoEL6I=;
	b=GlOLUa6/OwDzZ4OKCdnI6lCkOpD+pRqKNyFmx9x34E+SKp6zsvwM32Fjf+lyROzh7+PPTSkOMKD7kYerNKIdP0ANzvFGwtRMzBFQXG+gsnaPzhSWL23ViJYLpcBvKIFl+mnoRqEoAN6DomNewJ2kfxnRb6y6QI4oncVAqEqFHEo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.vDBIU_1774852052;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.vDBIU_1774852052 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 14:27:33 +0800
Message-ID: <9bd1cd45-df2d-45a3-ab9e-1668310e9ac4@linux.alibaba.com>
Date: Mon, 30 Mar 2026 14:27:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, stable@vger.kernel.org
References: <20260330030755.12856-1-zhenzhong.duan@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260330030755.12856-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231011-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueshuai@linux.alibaba.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 06BD0355E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/30/26 11:07 AM, Zhenzhong Duan wrote:
> copy_from_user() may return number of bytes failed to copy, we should
> not pass over this number to user space to cheat that write() succeed.
> Instead, -EFAULT should be returned.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/iommufd/eventq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
> index f1e686b3a265..710eef0b6004 100644
> --- a/drivers/iommu/iommufd/eventq.c
> +++ b/drivers/iommu/iommufd/eventq.c
> @@ -187,9 +187,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
>   
>   	mutex_lock(&fault->mutex);
>   	while (count > done) {
> -		rc = copy_from_user(&response, buf + done, response_size);
> -		if (rc)
> +		if (copy_from_user(&response, buf + done, response_size)) {
> +			rc = -EFAULT;
>   			break;
> +		}
>   
>   		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
>   			      (int)IOMMU_PAGE_RESP_SUCCESS);

Good catch.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

