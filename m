Return-Path: <stable+bounces-89221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DCD9B4E47
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13532834F0
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2615194AE6;
	Tue, 29 Oct 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dK3dMChy"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BA194A44
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216516; cv=none; b=Hg6+Ckkfm3PkCRj6RDI/rfkvKLvR1crZ6xND1zEPNmimsUZ1XlauAneNXyFuQ82raDib3WJSEMypcUKOr4slRBepsqKtTBfXxYIoixtCaUyFa95C5FglL9WyWiJ0Wkmoh7LxL29g7K2sLgbdTqHWpslYaPNKJ+VR1yBZDF5n7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216516; c=relaxed/simple;
	bh=tAEGwxf6Wm3OUZPiEfocRLxgrOqKQsYU4fNVjxfAAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prqAwXeuQp54th75QgLbsr9+bZ92TWG2X/aw1Y17HNvD+zEd9wMjcu7NtrsyOEti6NmxsGN7m91qhrDHxetbpGftQbUFErzy3OqsKpPJ+HEockI17m+zuoKShzf7wEsX5NpBeEDwwSve6Lslt36JATuXDVwlo9Do0yRZPomtyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dK3dMChy; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730216514;
	bh=2T9klOPnu2KdY6zwuhVfSQ5C8cDsFs4HRhNmLFusli0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=dK3dMChyBUvej/LwJmH3r2B4RTyi+AFoFPFo3mkfI4rKKuBPQC1oxW3iGN+OWbUgl
	 0mt5bh81zqnoKs0QcMGMKf7xX1bOoZwOGtJqXyhpoc8KdI5MDQ6MwpEoLqSqeCeKVK
	 cKp5+JW4/TIyGBpaGdMsWE5UV45bZ/+T1B/UBXJr+3ID9XY54H5GqqkzWlOOb6C6+o
	 O+kElmhVoWWhX7+S4HieTSw0BDj5ja5Rk54g7WUj5U4HcSJLmqhuHlHDf2D6pI66tw
	 UDDYlQcix4O+W1QXT0jXica5yLHBFj/bbQhMTRgG3bLeUrMrvTYNSJ6wApsl4dul+A
	 NUYVr73LrttLA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 5A03A80010A;
	Tue, 29 Oct 2024 15:41:44 +0000 (UTC)
Message-ID: <9ddb14c5-b425-474a-9a53-d34a414c3d17@icloud.com>
Date: Tue, 29 Oct 2024 23:41:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
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
 <20241024-phy_core_fix-v2-4-fc0c63dbfcf3@quicinc.com>
 <ZyDnc7HpMTnwEs-2@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZyDnc7HpMTnwEs-2@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9cGynE53Sln1BWunVrvjJpHU5b_1TIuj
X-Proofpoint-ORIG-GUID: 9cGynE53Sln1BWunVrvjJpHU5b_1TIuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_11,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410290120

On 2024/10/29 21:47, Johan Hovold wrote:
> On Thu, Oct 24, 2024 at 10:39:29PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> It will leak refcount of OF node @args.np for _of_phy_get() not to
>> decrease refcount increased by previous of_parse_phandle_with_args()
>> when returns due to of_device_is_compatible() error.
>>
>> Fix by adding of_node_put() before the error return.
>>
>> Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/phy/phy-core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index 52ca590a58b9..967878b78797 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -629,8 +629,11 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>>  		return ERR_PTR(-ENODEV);
>>  
>>  	/* This phy type handled by the usb-phy subsystem for now */
>> -	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
>> +	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
>> +		/* Put refcount above of_parse_phandle_with_args() got */
> 
> No need for a comment as this is already handled in the later paths.
> 

will remove it within v3

>> +		of_node_put(args.np);
> 
> For that reason you should probably initialise ret and add a new label
> out_put_node that you jump to here instead.
> 

will try  to do it within v3.

>>  		return ERR_PTR(-ENODEV);
>> +	}
>>  
>>  	mutex_lock(&phy_provider_mutex);
>>  	phy_provider = of_phy_provider_lookup(args.np);
> 
> Johan


