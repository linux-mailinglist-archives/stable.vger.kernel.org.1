Return-Path: <stable+bounces-254088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELERI8nnE2pdHQcAu9opvQ
	(envelope-from <stable+bounces-254088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:10:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900495C6371
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB8EF3002F69
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D733CEA7;
	Mon, 25 May 2026 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eIZDaU6x"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFF13D53C
	for <stable@vger.kernel.org>; Mon, 25 May 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689409; cv=none; b=IiiMkY+qG0MfprFi7PmpkZOESgC8RUaYB+YWWAGbgmUJmK3y3/JDbBH60bACA5o7gdfDNrY6Px4EF1QZSZhLiuy8q4PpY7eqr/i3Ja6cLosw3ufjNcNX4ZEIAJ1vAy0uexEDCc2Qsc3CRlgz2fxlmuixrI7r7ZZ8aX1RbYdWgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689409; c=relaxed/simple;
	bh=T3KgAxuMokRmxQ7nmg0fDH0OJrByzi8Ij+MkZ5pNHgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vEzUE2q0MNeWgJ27M5QsVmA2LDY/dg9lujhVmYPB1AaOwVQELFgzDEipy0YICeCarGm6tkYwHnjFdhW1mGyzu4MFpSTTg/Mwf8ZJ0o4Qh0BLi49laIRcJqaoHgINfb1tJjksw5OERlaw2hhcuZ1WCmw0Qo23q4GNqT7i1Qmvewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eIZDaU6x; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8bZl1WU5DFRU4xLo/FS1V5QGz8HfwH4Oe1vPjGyagGY=;
	b=eIZDaU6xVHEKss4KvbkJZPu50LMlLJWd3fQ7ZYJpBZOC7cPPlGVwLeyzB2mjt+uRq46RoytOI
	fKhMx9OhS74IoJ+UDtssXIOAWosy02nLTiqbRSXDzpfcdNSAirLD9xAKc7QB6yman4/9JzjPFxc
	OQilW/EBnTm7j6Btk7ub2vY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gP4zB0hwWzRhQk;
	Mon, 25 May 2026 14:02:14 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 15EDD40569;
	Mon, 25 May 2026 14:09:58 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 14:09:57 +0800
Message-ID: <d7a31f72-ed53-4c73-9c9b-781532403bbb@huawei.com>
Date: Mon, 25 May 2026 14:09:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH OLK-6.6 4/4] iommu/arm-smmu-v3: Fix pgsize_bit for sva
 domains
To: Greg KH <greg@kroah.com>
CC: <patchwork@huawei.com>, <kernel@openeuler.org>,
	<linhongye@h-partners.com>, Balbir Singh <balbirs@nvidia.com>,
	<stable@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@ziepe.ca>
References: <20260525023539.3587618-1-xiaqinxin@huawei.com>
 <20260525023539.3587618-5-xiaqinxin@huawei.com>
 <2026052547-delusion-entrench-8185@gregkh>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <2026052547-delusion-entrench-8185@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254088-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaqinxin@huawei.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomgit.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 900495C6371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/25 13:57:56, Greg KH <greg@kroah.com> wrote:
> On Mon, May 25, 2026 at 10:35:39AM +0800, Qinxin Xia wrote:
>> From: Balbir Singh <balbirs@nvidia.com>
>>
>> mainline inclusion
>> from mainline-v6.15-rc5
>> commit 12f78021973ae422564b234136c702a305932d73
>> category: bugfix
>> bugzilla: https://atomgit.com/openeuler/kernel/issues/9215
>> CVE: NA
>>
>> Reference: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12f78021973ae422564b234136c702a305932d73
> 
> What is this for?
> 
> confused,
> 
> greg k-h

Sorry for the noise – I forgot to use --suppress-cc=all when sending
the patch. Please ignore the previous email. Thanks.

-- 
Thanks,
Qinxin


