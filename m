Return-Path: <stable+bounces-89220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A067F9B4E35
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252E61F23C14
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6467192D84;
	Tue, 29 Oct 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NPBYxtEX"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA119415D
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216313; cv=none; b=o/GU1EJovgi5bgS8qADvlLAbrOtP3Zr3zgRtm7Nz1ATpi1AdkjvHzvqPCxiooivlUOCyEVWEod20KGSUf+NA0pvCRpxoJEYo5BidRAblQpBgiR4LqpXiv3EJeyl6y5i035f9Tce9WqGsWqzsQHH6lrGNl1SPJwhN09VgBPB+sWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216313; c=relaxed/simple;
	bh=BxFCJrpmIt5f4Q0NSGRVtQhYihssSV7pZLUvtKg74cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ+BNYQz+jEUdouUiOa+wpiiyF4UiAJpmJzp+pgfxyms3qfpulfP9Ws4tR3+FiGCSyywFX/7+q8ggxj/5ehBqxZNwjeMEuCWnvSkw9v/8e66VNEKNsLraD1sTGDYValti0JvUSMVyYpaL4Horz9+0+wlnYWGYTLy1RvOm8heSzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NPBYxtEX; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730216311;
	bh=2KSkPA7+qf6t4Dsy8rcGUwLn/SXlZohyYSOg8qTI+BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=NPBYxtEXg/gVPtDzcJ5LljBXjl1/9YatYWDs7QPW0x5pzyoVSe1FdxaavliqeptkL
	 Ci7fKquB/d7hud6MUVXMDUsEY0+9foSG8Ufd3HLwlfglsqYTfknCoFr2WGOIccCZYi
	 MQx+WMfA64rOA4aAn4DY0A7NGtXmiVHJ8vZiz9/aspLG4mHK/BH4VhegEqBnlCb9g0
	 r0vYQ1S3xo4TBqjhOFfPebragCqx6oy5u26OUVRd7qvZuat+liHxUF01z+EiUXlHIR
	 vSQn2sG/zV40pxtUeEoxKDdQM/Dg13YuuzNMypcjZN/Z0AK7T/rX1ZD0CtWh5PsoRa
	 V5WJjHm6cAn3Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 1DDC94A02F4;
	Tue, 29 Oct 2024 15:38:20 +0000 (UTC)
Message-ID: <c00c8669-cb1d-4125-9c9a-34d63641c226@icloud.com>
Date: Tue, 29 Oct 2024 23:38:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] phy: core: Fix that API devm_phy_destroy() fails
 to destroy the phy
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
 <20241024-phy_core_fix-v2-3-fc0c63dbfcf3@quicinc.com>
 <ZyDm7IMUBYkiHPyp@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZyDm7IMUBYkiHPyp@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: r1XHksgHMKabJrGc9FocPDS7La9C2fEt
X-Proofpoint-ORIG-GUID: r1XHksgHMKabJrGc9FocPDS7La9C2fEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=868 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410290120

On 2024/10/29 21:45, Johan Hovold wrote:
> On Thu, Oct 24, 2024 at 10:39:28PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
>> to destroy the phy, but it does not invoke the function actually since
>> devres_destroy() will not call devm_phy_consume() at all which will call
>> the function, and the missing phy_destroy() call will case that the phy
>> fails to be destroyed.
> 
> Here too, split in at least two sentences.
> 

okay.
>> Fixed by using devres_release() instead of devres_destroy() within the API.
> 
> And add a comment about there not being any in-tree users of the
> interface.
>

okay, will do it within v2.
> And consider dropping it.

okay, will follow the same action as [PATCH 2/6]

> 
>> Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Johan


