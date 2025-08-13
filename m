Return-Path: <stable+bounces-169347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E27B243CE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AA31888F89
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44229BDA9;
	Wed, 13 Aug 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="I8J3efPm"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081312E7172
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072614; cv=none; b=s8sn0PA6reBENbUZkpY5at4KY7xYqGn/zPtRDXMTnx11fXasy/DG3VA6iqRrRkcGHciR7gZQraUdJdvqG9G9tVpdFYaq4y7kChJfOam7YkQL+BSuzUmoHYXczIISdlklVOze6zyo/0CvhTQHtgnGnQZARzsMJH8eWZq9VwDeO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072614; c=relaxed/simple;
	bh=AB4CRxgZ/K+asTbTo0Y5VIvvzarVo9pWZDEvrp60J6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gXyW88Gso3pV5C61ryKQA2ToWejSMXFMEh4hl2Vb5WpmCKKgjkWrvUhPeEy6lTaNtByke24rJ1sbC/7aU0595uB5q1J1Arfe8fEWLQMPZmG1ZvOQ/NJlbxsgprk3XYCaMmmrCv6dgxG+p12lAQGXJTF9C+F5KOjB286jhn9sIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=I8J3efPm; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A4DF9A0168;
	Wed, 13 Aug 2025 10:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=rl1WbGMPWQ/RY5hRRY42
	uFaJEq5feAo9XpXUhJH2YDQ=; b=I8J3efPmqDQjvdTQfQamoLzL7oqALShoW1O/
	e/CvfzKfKwLQ8Y8I+Q7tzFpW3wk3WQtmLpdYA0sRjJ/xiPXYP1eMqmV2Y6tyCu/V
	jw5r85GQiL5j968a3HWIZqbXbgEM1SOILAZRiZcdV2vSeBVb8v85cyuRQa251RPR
	6UMUGS6eUFyv4FMaMlOsO1yNvKgLfQ3s4kXFUOUljQVFNrdMDhs38iHZ0Lkqx8ok
	b9wQmsyui4MnrjyC8/LnKG8i2P24+dNdTX+ltrO4uxJB+XW8o1QqnZANe6nJwYds
	yHAQStF4QLcq70dsFHuRVnxD2wXDd8xjziGCIZjvystcNtBTIQe0xf2Cqy3my7Oe
	th3xbfA0eLbOhrEk65aQWy99QcUkr1Rz49oWPPERljXFUEV72gVdN6WhHy8vj6/K
	iD8Wv1pkZIzDmHqdRGAurIS4ePn902h+fQoKHDtIz6BGh/zv1zkeL+EjHRZZ50+C
	zUBDF3FqSAEtFIyZjdVNoXsNefpMkV9N6Y8reWdWvKEsi/vLyMC0DgHW/TqQsJ7m
	YdjLf39GKsuCqH6VW1y69hk7jIZn6TFADkspW8VJG8B0rDjGl3QtldVzfMx/0Ild
	7SJ8ASY8YOKH/1UpCnjEWb8OAuyI2LgPmaXfhJbvcG26MObthA574roh6jKhhPJB
	TyNrbu8=
Message-ID: <44d15997-2c16-436e-b1f5-fc2de7afe29b@prolan.hu>
Date: Wed, 13 Aug 2025 10:10:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 519/627] net: mdio_bus: Use devm for getting reset
 GPIO
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>, Csaba Buday
	<buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
	<kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250812173419.303046420@linuxfoundation.org>
 <20250812173450.953470487@linuxfoundation.org>
 <73f6a64b-89b5-412a-94d7-07cdfa07cfb5@prolan.hu>
 <2025081305-surround-manliness-8871@gregkh>
 <2025081337-reprise-angling-7cb8@gregkh>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2025081337-reprise-angling-7cb8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E617761

Hi,

On 2025. 08. 13. 9:56, Greg Kroah-Hartman wrote:
>>> This was reverted and replaced by:
>>> https://git.kernel.org/netdev/net/c/8ea25274ebaf
>>
>> That's not in Linus's tree yet, so I can't take it :(
>>
>> So I'll just drop this commit for now, thanks.
> 
> Oops, nope, we took the revert also, so all is good, I'll leave this one
> in.

Sure, although I'm not sure what the rationale is behind taking a commit 
and its revert also, in the same release. Anyways, for the rest of the 
backport versions, drop this commit and pick 8ea25274ebaf instead (it 
should land in Linus' tree in the coming week or so). And when you do, 
don't forget to read its notes at:

https://lore.kernel.org/all/20250807135449.254254-2-csokas.bence@prolan.hu/

Bence


