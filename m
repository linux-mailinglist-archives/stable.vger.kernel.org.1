Return-Path: <stable+bounces-100403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEC9EAEA0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A3188A0D8
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515422153D4;
	Tue, 10 Dec 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bx4DDDsQ"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C2210F56
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827629; cv=none; b=DD1DstCaAaVie8xgRBTT8dJC8NbmNljuVeraKLjLs9GAg/qFH+iDFt7xrJaU+84mFnwB4knnvXmN/a9pSlNPQIunLVKVRQ163uiCOySk/5aVYLEdhulAfzDHtR3KtgiQ8W7viYjUaTI1u/+YCHvTZoH4tRQTc90xE/1fBFzRuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827629; c=relaxed/simple;
	bh=7cAOtHmWFYFxgF1IS9o3UOEreFWIfHIRpa4Ir9G603w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJoCBD2XJPMh6RHoGCePIlB3jXswOAe2tNwI2UsAly42KUW6RpMgjD02JVCyy6tkvpkJDcntLvKe8dBHq9GrCI7++xpWNBqyu4H+CE2tJOCZ7Nh+Q0nb5UGD6QbGEZ/0eBMrVJmN4AG2ol7xwO34ot7YGvPdaxVkm6HzaG7sO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bx4DDDsQ; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733827627;
	bh=XDhu6vDHGLx6cprcO+YAHj5YlGKsZNZFDkv2iQGYj6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=bx4DDDsQN7vJAMKzkOvOlpiD9K7dNA9HTKSqWet2O92TrtWQAyt4WdlJpSaUAEnGO
	 LcMjnkciSIGzVdhisw9pUZ1XbZ7snk0eE8ZuI5BmDLmQgjUuRPxFQAxloxTfU/IKrK
	 1hXVEYqi7ZPamkMD1eS2KO6D01ZGWwrW1jKlOE3uqAQkz9gFSsq/3RHeI3aNirTOQ0
	 9Uv1105+0iH1HyDiwX+/JBjTrw1ZQEQ2kVLxa9kqcsaiV7rgL9K8Ck6oj4hQuYyfyJ
	 B+IiH1V7axITVKp7y5iEI0UMAfDzUwrbmEv6roZMZM+RuvtGbK/Dquu1am8zkc0rJ4
	 TUSQVc+se8NeQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 373D03A0D9A;
	Tue, 10 Dec 2024 10:46:53 +0000 (UTC)
Message-ID: <3bcf5847-6f54-4bfb-8752-e121d15ea1ff@icloud.com>
Date: Tue, 10 Dec 2024 18:46:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] of/irq: Fix wrong value of variable @len in
 of_irq_parse_imap_parent()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
 Stefan Wiehler <stefan.wiehler@nokia.com>,
 Grant Likely <grant.likely@linaro.org>, Tony Lindgren <tony@atomide.com>,
 Kumar Gala <galak@codeaurora.org>, Thierry Reding
 <thierry.reding@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Jamie Iles <jamie@jamieiles.com>, Grant Likely <grant.likely@secretlab.ca>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
 <20241209-of_irq_fix-v1-1-782f1419c8a1@quicinc.com>
 <20241209205613.GB938291-robh@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241209205613.GB938291-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZLpPG5aPyRsHGBD9VLHiX7wdEYhWswfl
X-Proofpoint-ORIG-GUID: ZLpPG5aPyRsHGBD9VLHiX7wdEYhWswfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100080

On 2024/12/10 04:56, Rob Herring wrote:
> Applied, but rewrote the commit message:
> 
> of/irq: Fix interrupt-map cell length check in of_irq_parse_imap_parent()
> 
> On a malformed interrupt-map property which is shorter than expected by 
> 1 cell, we may read bogus data past the end of the property instead of
> returning an error in of_irq_parse_imap_parent().
> 
> Decrement the remaining length when skipping over the interrupt parent  
> phandle cell.

thank you Rob for these good corrections.

