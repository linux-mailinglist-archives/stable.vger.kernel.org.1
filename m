Return-Path: <stable+bounces-89218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2B9B4DB0
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4921F212AF
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5B192D83;
	Tue, 29 Oct 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Hn7PH2id"
X-Original-To: stable@vger.kernel.org
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0056192B77
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215381; cv=none; b=mKY1Z4RDJyvB0rm8pyKg/lcwnYoUvAyTwdNzr7GBDknSwcog1sDRln1/76H5bbelpCSBW4ufLzVl5FVBkxiMfy36wTfFu5/F3j0ihmFG5dmKQ0LzdLF4pjErxl8RcRuNd8Xj9i405zMYQp1K2k3subi8ie5nK6wKjcw4qAeqO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215381; c=relaxed/simple;
	bh=aK14jjJrUM9yqTtPk5MuYvytwMRLlOrdHUoMfN/DzUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJq4sHasPxmD7XTcLBwY5bS2jm5fRR0N9ezYnaeNZW4Hjv7r2umBNh0UdHMZQOhiRtD8R5abX+A7v+8sJNKJLNDwCsd96cNx90WPHaPYtKpi2P0QWnil5NC0Di/g147q56sTkeemR4xl2GXLFaQR73od+FoA5HnxX1fOiL1PfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Hn7PH2id; arc=none smtp.client-ip=17.57.155.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730215378;
	bh=wbQ0FfkPPBr1JdDLuso918FJA3/rnwBd3dOT7ZpkweE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Hn7PH2idmhzclOu0iT5pY4qGuyP6wn+wA9HqDVj8dTU02iaaX+J1Nh+WVYiXnnnEP
	 yq8aidIEpmQ/vaYg6edUYjPdZ6enVO/Fy5FFlYqPMXWQJi4QfzKXn2sB/16klLM3yS
	 rmc8rfzE1VZqMMDyqEYxJASwl+bCqE/ap4Atdh5ZWEI2RbR297+jk3S0meYa6565fk
	 1NHCYOgB9boc+8B+yRrk75tFqZtEQwgQt+33gMtC5ZicxdyshfbkohYgUAPh7jJfu5
	 MYfyAMKk8OuD1mP/ebheCNhVLBK03Tq8bYmfYN/THufezlyhieoGQ5enTmef5kyMqT
	 veWEmpkMm8efA==
Received: from [192.168.1.26] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id 5FE3116804E5;
	Tue, 29 Oct 2024 15:22:50 +0000 (UTC)
Message-ID: <e40e8451-9672-4423-bcab-8e0cc6ff3624@icloud.com>
Date: Tue, 29 Oct 2024 23:22:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] phy: core: Fix that API devm_phy_put() fails to
 release the phy
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lee Jones <lee@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, stable@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
 <20241024-phy_core_fix-v2-1-fc0c63dbfcf3@quicinc.com>
 <ZyDlsWaA5aiRa_ry@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZyDlsWaA5aiRa_ry@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dbUSnKj2WHhcUGiHrlHH5FpZ0NcN0xRt
X-Proofpoint-ORIG-GUID: dbUSnKj2WHhcUGiHrlHH5FpZ0NcN0xRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410290117

On 2024/10/29 21:40, Johan Hovold wrote:
> On Thu, Oct 24, 2024 at 10:39:26PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> For devm_phy_put(), its comment says it needs to invoke phy_put() to
>> release the phy, but it does not invoke the function actually since
>> devres_destroy() will not call devm_phy_release() at all which will
>> call the function, and the missing phy_put() call will cause:
> 
> Please split the above up in at least two sentences to make it easier to
> parse. Split it after devm_phy_release() and rephrase the latter part
> (e.g. by dropping "at all which will call the function").
>  

thank you for code review.
will take your suggestions and send v2 (^^).

>> - The phy fails to be released.
>> - devm_phy_put() can not fully undo what API devm_phy_get() does.
>> - Leak refcount of both the module and device for below typical usage:
>>
>>   devm_phy_get(); // or its variant
>>   ...
>>   err = do_something();
>>   if (err)
>>       goto err_out;
>>   ...
>>   err_out:
>>   devm_phy_put();
>>
>>   The file(s) affected by this issue are shown below since they have such
>>   typical usage.
>>   drivers/pci/controller/cadence/pcie-cadence.c
>>   drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>
>> Fixed by using devres_release() instead of devres_destroy() within the API
>>
>> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
>> Cc: stable@vger.kernel.org
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: "Krzysztof Wilczyński" <kw@linux.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Diff itself looks good. Nice find.
> 
> Johan


