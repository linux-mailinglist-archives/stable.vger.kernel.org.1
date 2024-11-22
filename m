Return-Path: <stable+bounces-94584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886D9D5BC8
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 10:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AA5283F6C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 09:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A9A1DE4F0;
	Fri, 22 Nov 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JBbzqXT+"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3601DE4EB
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267132; cv=none; b=fpiV0k25sYBNOaKkdZfX4wuHvpSRZ+wLPYZSBcs/dkdfPtNCsADE+GYs6n2HhIqs+3s1ohLwTAhTQYANGSOzXzyNjr2+kqPi/Wrp3mP6DwLDpHqccoMYJuMHU/2Aq80ELcNeWU+gUz1rH5GFclQGj8TYek56fX2f7LkU5YjMcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267132; c=relaxed/simple;
	bh=co0x6wWP/yaKTepEZbruneC/mgEXAHSa75KqvzRDN5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dInCrkfdZKhULIsUuSCf7Vanvprn6rTDgJrWCrEf0u338qTOCSMamKu34SRZ4TFhq6WuFJistv3dTL68nqimfpTYzjKn4ao9gh6A1nPTDbMdQvYh/PdsVWoBXHRqUouwYBr+cMAvGK+W3bjajRhdJlSHysJOUFRpkOovG0thuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JBbzqXT+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9D341A048D;
	Fri, 22 Nov 2024 10:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=OHscCCmYliVEb7zfJINU
	J993U7AFr0q0nKcfiSaAv3c=; b=JBbzqXT+KVqdxh6ZB4bkdFElJGUSwUTbgXUh
	FmnhlHG0hJECEW713YVNNc2+RA6EQIFhrxiZiXtAGiqVXIFzoy4UROKcae0GwDim
	p01kDZzpNiHzQc0CDyZJeV4Qs8vC0tqIhpXLNsOD8E2bP1oAZdfcuvivtgSBK+ur
	pkHz3L/MReGPBd0ksdLwLBa39Y9aBboQM2eqk1m8L2+JMZulEdPqV1gvsW03MuIr
	GMwSco/7ujEnXtLgx3JGRoS7ibMQsMpnutJAB/1NupqjTHoYCCIjqoyFA4Iwa4Yu
	F7VMxeqgLI6fBlCHrO2qPpkIET713CpUHrFH80KCqMgD651gUQz3KJgvHfwXhKrm
	LEOS8o41elbp3/gpRBIkupGnup5+t8Civ0xsWULWGo6KR1FMS4QC131KBsblzpDL
	FKulBUYtloWoILzK4OrwnVxEdMNcKgYOdHyiY7PbdWBGYqOfIbyXgY5l1jZ1kul6
	ow0zBIqc1aEGJBGbWQO50BbsE5FZ1myedG7TTeP+BhN1uDXiUki6llK8QjrYMprl
	O0ngmX+6Gzp0RKbDH51TfjlNmUeW7GeS0g4wR2QBv00WygdZcyJFbFXFUqG+KqGT
	e3RHu8WxKNpeVaAPAXQQohJlmNIuJbeOfs02jXnB0PD3g2/t1r2etKbc8xWLX8du
	jSd2iNg=
Message-ID: <ae0a81ca-01d5-46c2-8ab5-5ba16fdc7190@prolan.hu>
Date: Fri, 22 Nov 2024 10:10:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 3/3] net: fec: refactor PPS channel configuration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Frank Li <Frank.Li@nxp.com>, Paolo Abeni
	<pabeni@redhat.com>
References: <e437a6ba-292d-4a0e-8e81-074c84045b26@prolan.hu>
 <20241016080156.265251-3-csokas.bence@prolan.hu>
 <2024101822-calamari-litigate-8d87@gregkh>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2024101822-calamari-litigate-8d87@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855607365

Hi,

On 2024. 10. 18. 12:37, Greg Kroah-Hartman wrote:
> On Wed, Oct 16, 2024 at 10:01:57AM +0200, Csókás, Bence wrote:
>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>
>> Preparation patch to allow for PPS channel configuration, no functional
>> change intended.
>>
>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
> 
> Not a valid commit id in Linus's tree :(

It is now merged by Linus, please pick it when you can.


