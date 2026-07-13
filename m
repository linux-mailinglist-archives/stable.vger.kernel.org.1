Return-Path: <stable+bounces-273920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MWaFGXQhVWpGkQAAu9opvQ
	(envelope-from <stable+bounces-273920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:33:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5A74E0D8
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=EHyZdlAl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273920-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273920-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0BED301AA9E
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB33349AF6;
	Mon, 13 Jul 2026 17:32:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C6349AEA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963923; cv=none; b=MWYtgNn2fgpG1YQ7u7seZrbr+4S+IiZXwsYQcle6BjKw6cjU89j3S4xm08En9ze5zAStbAC8fZZzsWzyhsIRvwhKe2cyiXoTh6xGG64H7RpGFCE8KA0ICwA9Ili4kiTKYD5U/zcela77SRrKwnLeTeFW/4G+1ep6TAylxtzH8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963923; c=relaxed/simple;
	bh=bvRlhzr7jKOtOr8WJjvqiBvRjPbU/ig595Q+n8nVP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6UTAU45HbPzN6qOaldk5kJExQKy3HKHvRDOSLPaBtPg6HXE0uwh/rKr0DW6BSoT7orBmOkz3fkrPbaWzV/MFdo1nZfJ8OenBoKkEVrjlQ14BAJXF5FlfA8lUJF5U3OhVClUinBBF+hwgdjXbAFgC+JNcDyjwHH9YkoNe59E230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EHyZdlAl; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c22c61795so1148991cf.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783963919; x=1784568719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xHgMO26e+BdHEAssavg9c9wDK8SauQFv9AFW+ZW8FI=;
        b=EHyZdlAlya3cW5L7dqrvbtJ6Q19oUzdxIXEupdJbsfIhJAMM2UPcb/k+iOoStJV+Vz
         /PU8a4ySRW6fktpuhAOhT0ug9bt1xsnhfReqi0QNvdP4DUIo4fVebKGSuVKXH7DYPWVw
         YvFH6iOnHSIz8Cy5n+QoufqqMUkVukPssWKLW5Q+LFfLT/N8C77eTNgG76iu352f7lXC
         z9ekdlCa7GQR4JwnvIMsElr7qUK69IDeIER70xqUF+s8H9tEFlmZDjiL/jal5Zmvgwes
         wN7TFWo45ljVrlTm7D9eg6lpXPU9iAU+yd3oRAn0UtVs8gDdx8vVnYYDl01ESHu0QblW
         chvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963919; x=1784568719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xHgMO26e+BdHEAssavg9c9wDK8SauQFv9AFW+ZW8FI=;
        b=j4cDWqF24iHNo/2Ng8fu04zEWJV/kscgiB/nza7cyoBtiG5xW1yiTbhBdi42F9gM8X
         Cis3sZOUPinOyj7IT3W0wQSAr24ogLrZwJMG9XnvaYahNi2NYC9OOwHQpTfZWDiFtGX4
         nEo5keTI7Ti+4X+hTjtCQRshqPuLNdsRZFjnSrQA8LfiGrpm1Qj0HVByXJeQl2lUVGiv
         6AqGC4GMtFuuBQ09O1NKJOzE7/R/xOXzyGeHLCUu9GrmlVMmXVDGi2hO6Z4u8Ka/uS4w
         GUXYPIBqe91mAfLFKfK6PP8WMNm3W7Mp28SCV4hV9IxhKHXS2dnKmgHO80UU3L+7VQwu
         o3+A==
X-Forwarded-Encrypted: i=1; AHgh+RpwGbx2B6F2Fmjoa4uyqaI8UtPcU6/AOC0tW5XdG/2cCUGtQWTnynKOrRpb5AhtCwsa8xr4Oeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgoY8z8cITXzzccTbnxxRCI8ZQYdOX9LKMJQhgI3WTZn+8t2sD
	cINbF1/zdvRdqpOnE1vw/eBzD3lYoPEVfFZ2KPSqOsAIVfVCZFuyLEPyWvTiTINI48g5yhDtyAu
	ccfie
X-Gm-Gg: AfdE7cn2VWCppV5z3qHI8M0EdVpddbBnogaoFrA31ptYpphxlqjI0eGFkO0yNUO59s1
	s5QH4tBbxfFciC6iIcH2A5AN7XD1YS85mG3KZFHBuXwcWr4RZtj9dmEpERjyJ8oxqwlWcszjRaR
	ibSeIsObkn4uhOaYP6KbqioJrbOKRCKzy5Dkx7XF5z82+2jUB7C4M9qZDShyzmzrHa9ekqzAfCA
	AYBMLiQWE3ZCGHJq6plb/OXXGSs3d9R6LP67izjRC2lP9RgRXO11TyhxfVi5VeKNo2lwGw5CW6n
	zCv4Gn45hNnR9wK/9ZwUzVkU7OYPFPKhzKKsHxGqJlH6Kud7f0dhlQwP16xNK8yV3i+xIwBa0df
	lwOxzbEERzw4cH2JI33DaHWTiXPnIQL9YWZG+sYK6IOW5R878G8Rgs5lTqLwx
X-Received: by 2002:a05:622a:994:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51cbf177b90mr97106331cf.6.1783963919034;
        Mon, 13 Jul 2026 10:31:59 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae24d04sm85930261cf.18.2026.07.13.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:31:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKVZ-0000000DnOS-25vJ;
	Mon, 13 Jul 2026 14:31:57 -0300
Date: Mon, 13 Jul 2026 14:31:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, kanie@linux.alibaba.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix dev_iommu memory leak when device_add fails
 in iommu_mock_device_add
Message-ID: <20260713173157.GH3133966@ziepe.ca>
References: <76AC62D46B998556+20260711055119.1003477-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76AC62D46B998556+20260711055119.1003477-1-peiyang_he@smail.nju.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-273920-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peiyang_he@smail.nju.edu.cn,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:baolu.lu@linux.intel.com,m:kanie@linux.alibaba.com,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07F5A74E0D8

On Sat, Jul 11, 2026 at 01:51:19PM +0800, Peiyang He wrote:
> iommu_mock_device_add() first calls iommu_fwspec_init(), which on
> success allocates both dev->iommu (via dev_iommu_get()) and
> dev->iommu->fwspec. If the subsequent device_add(dev) call fails,
> the error path only calls iommu_fwspec_free(dev), which frees
> fwspec but leaves dev->iommu still allocated.
> 
> This triggers the following kmemleak report when fuzzing with Syzkaller:
> 
> Fix this by calling dev_iommu_free(dev) instead of iommu_fwspec_free(dev)
> in the device_add() failure path. dev_iommu_free() frees both fwspec
> and the outer dev_iommu struct and clears dev->iommu.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied thanks

Jason

