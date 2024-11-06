Return-Path: <stable+bounces-91669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7DF9BF1A1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B9A284F51
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21EB2036FB;
	Wed,  6 Nov 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="BtUBpuCW"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE81D958E
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906931; cv=none; b=dAdbBTE/euklNMGNJSO6WiLTIeVXsBrTAihSzKukC+f6vEutdU9hYj23QcK9D8ela7TkHrHZAxPuxarQyuMJFAcT1TOtZ7vxUL8FOv6iA6WzqXob5isIGU9gDdpepPZkWCFLXjC3vodPyvSu0qyiFxSFb+pOylVDbh8QWlOOqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906931; c=relaxed/simple;
	bh=joFVQbJDGKoV4KDHKORG1ljdEZb+4Avn08akHPViVZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toE9IQtRXOX7DDBgRFKgG3MrWkK4o+Q1Z9oL3vPVPcbUCZNpysJrZgc5KLb83rQ3mtap6erDd+a2UD8jLHa2e2WA/s+5S01WrmRCrk/90waqbo/QZ3X4czhLflFWqxGjGoEb07l0Nn47i9FN+f0VK/j/qjocAtJRFC+qyoRAbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=BtUBpuCW; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730906928;
	bh=oR3Va8z9d2Tc/eVUOUoRWon9Mc7HjZ0n4MCseiNIfUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=BtUBpuCWlzNwrPRuZx1Gl/wat4SdtvMIzO3ohgAsqQ+nR+cqBHpu7Kx2DtaDnCQ3R
	 dwNT2CnL6ZGUcsn8i4E/ZxoaKI5ukwlKStoknKsxfS8nCPP4lv0hqWHY68PFOIzqKu
	 zQkOlHI2iO1dEMX59fOEVs8q3loyH+BGR6s4w1uUsS6AY6Io38DLo8emoktuqZZHh/
	 cwhuxqgfcB2bkfvJd5fWT8j9q2XVXLOZtf/iIa+VduvWGhAxm5kQ6spwM1aXM2ER7N
	 WOGOD3Yr2MNpMHHaAmuDv2yHYqucD1MtcsBB02xyrmJKp/E7UVVy2x02rbSNOLYeAn
	 Q8lUXnp9e4Q1Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id A862768038A;
	Wed,  6 Nov 2024 15:28:41 +0000 (UTC)
Message-ID: <0699ed24-9603-48f5-b5bd-859dbed1da5c@icloud.com>
Date: Wed, 6 Nov 2024 23:28:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] phy: core: Fix an OF node refcount leakage in
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
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
 <20241102-phy_core_fix-v4-4-4f06439f61b1@quicinc.com>
 <ZypT18RpHSd_Vb-o@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZypT18RpHSd_Vb-o@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: P0XKrIbDBhf3WsrRJ3b3UEMcTA5BM8fK
X-Proofpoint-ORIG-GUID: P0XKrIbDBhf3WsrRJ3b3UEMcTA5BM8fK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_05,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060085

On 2024/11/6 01:20, Johan Hovold wrote:
> On Sat, Nov 02, 2024 at 11:53:46AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> _of_phy_get() will directly return when suffers of_device_is_compatible()
>> error, but it forgets to decrease refcount of OF node @args.np before error
>> return, the refcount was increased by previous of_parse_phandle_with_args()
>> so causes the OF node's refcount leakage.
>>
>> Fix by decreasing the refcount via of_node_put() before the error return.
>>
>> Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/phy/phy-core.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index 52ca590a58b9..3127c5d9c637 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -624,13 +624,15 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>>  	struct of_phandle_args args;
>>  
>>  	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
>> -		index, &args);
>> +					 index, &args);
> 
> This is an unrelated change which do not belong in this patch (and even
> more so as it is a fix that is marked for backporting).
> 

make sense.
will remove it for next revision. (^^)

>>  	if (ret)
>>  		return ERR_PTR(-ENODEV);
>>  
>>  	/* This phy type handled by the usb-phy subsystem for now */
>> -	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
>> -		return ERR_PTR(-ENODEV);
>> +	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
>> +		phy = ERR_PTR(-ENODEV);
>> +		goto out_put_node;
>> +	}
>>  
>>  	mutex_lock(&phy_provider_mutex);
>>  	phy_provider = of_phy_provider_lookup(args.np);
>> @@ -652,6 +654,7 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>>  
>>  out_unlock:
>>  	mutex_unlock(&phy_provider_mutex);
>> +out_put_node:
>>  	of_node_put(args.np);
>>  
>>  	return phy;A
> 
> With the above fixed:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>


