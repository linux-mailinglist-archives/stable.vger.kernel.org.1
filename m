Return-Path: <stable+bounces-109145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08394A127AE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 16:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928743A66CB
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245A1487DD;
	Wed, 15 Jan 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="eyrGp6gV"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72C142903;
	Wed, 15 Jan 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955589; cv=none; b=niEHPo+mQtB8PUTGbY7vpanDyQJpNVVO5CVqHjEqzGPmumqnMdv9G/7BPZAx8kyTwSFwH/g1DncGOn0qAfqISYWExka2Rf0Pr8GQOdXf98xbXtB0kxjmD3Ee5huZk/zY1xujw51JyIn78x7yess9FegNJC6ThZnD4LZrVjvN6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955589; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ln74J0Np+7sp7gohMLVea2orUKk4J2RGMONv62hyH4Gk0NHHbJWImcsT1Dg4rmpiRjf9JZ/O2Lsw0rtlaHhWwGOPG7IqdFwcWbGT1QTvoEuaV46CCeJdo+jbvfyLvDQ3HmfiyhCnxSlp1C3xdUtmwnsPq059L4X5GlBeft4IVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=eyrGp6gV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736955584; x=1737560384; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eyrGp6gVllEEZ6ZoIYglFu8QVqPRUeFhQ7xXGdkb9vcU9qjzxF0y/DFJkO0u8L6y
	 aDtd5BfmfCMBmpB4Cos1KMv8f/TbxOIJfZ/to1oKoCcaiVZLsk5BilcFngjwE8/Aa
	 vb31suvaXEq2PiVKkei+9SoHxCJ3AZ0vBC9nozuScK3UPVqAFcwrsOZyS90iA1eDw
	 fURvyRYeKoU8PoAYKkHdSjmRftzV5WCWdPoE4fepupyB0jtxCqN5ZemNrzPsYi9Ki
	 jLJMWaxBk4BjqCSl8+sR8dKA4P489npzYejBHnlnsx71qp7cJDWpXiMDkrPF/RFMX
	 A8QvqnpvqVtVJhKyuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([87.122.77.77]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1tkkgk2tQQ-000mF6; Wed, 15
 Jan 2025 16:39:44 +0100
Message-ID: <d2b94e68-be91-41bb-9824-9642082e52f9@gmx.de>
Date: Wed, 15 Jan 2025 16:39:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UkM7FIKQjEb5P1Dn9qyjVZu1VhajK90qRrsOr7Owe/wIh7lvD0I
 F9/x3Ab0byz5hc8TcgCd/FUt0gZ+XAF303Qc7ItlANqr3ZS3jimSYs2vpIccBt6u76M3bTS
 z5injZkw+lgEF5DznMxMzJ36LxcuQCAgWDCK99wLA00VHxOGo1Eh1ZqMmde7/G7ImGF5oyn
 kE6mYj59Tjz54OOWgzC+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BOKpER1lTfQ=;XUrP+T76Fmx+/p4YIXifa9X8EWQ
 cBwbecT1WMZB/SQ3YnGMIuNJcM/tZgxKygri+E8scVCN+vkG5aqQOZo1ABapluRSfyrdBsH0D
 CuY4Sq+O7GIFD5IU1qMIb5L39WNwrfaqeNqwAWEA7Xuhd+YNCf3zXXvcA/48TlviJ9doav0nB
 mAzmn2nip1cyYpOIhMNK1lXTCdtHkNpJx6VyYjdoz8Fh1afYZMBS/p+vQry7yyRccGzbZPZ36
 bWyJgLDLmMJ7Ke4NjyzUPdZ0MaPoGzKwK8jIgbefhnsk8JPwGt3FSvHKVOoMNI88LapyT+LAm
 A/OOi6jSqFSoclKVjxoWxeHoa3NJcvT3omA4+Smp7Aju95trEej9xNn/apLy+ce+SKIP/s69l
 c641f/EGmtHy1Us1DoGnX/mNwGjzf+F7oJgvpWJatEnmQap4AL4k/i42b/QXSWW84svP/Vh34
 QHZ86pXaQ9tbtKrKUlj/GDHtrLwWQXJhaN7hURFWLXLp1Ca3TBJCcsLtMXMMKkT7p97pve3Pb
 1MY/zccKzOr7+CnFMpBCqix0/MCJYLPkDZIV5LlGrb3Qs0mi9y9xLRIKx4fxbWTuOjiJkyNjQ
 eeFzNA7GZXwdk8ec7MNOzbCWlC/Lsn58KDHmd3SL1zLbS69PiJH6ZP9AYmfjTpiV/a5ajJgzA
 NUiJTXXH0bhO482FC39+AEoHSDXFa1BvDygFXxgbtVqLCVaJWt5qz/nvHRKA09/5GnBw7pFRp
 tLt0aWr+hfOZDtefMRyYmKKjfqOI+r5qjHPMUR78OJ7hAcYaE9qA4qiHEuOcXdA/S76r4LrR8
 4gg0ZN8n9z3p2BQgCLx8bL2PpcApeH4ub9TLib1kFUhUnkDUHsNdwnFXPSN3Teh+ulCqoHE62
 BJuHkzzX4qNttjSiSbKzDgNkb37BYnE/AoGiOclzJ7mom8ntrTNsU5pOt9PwfwC3PFtNCqVkx
 /VQvddsdsZYmu1We/y/zWaSqjFY98m9a4GjihTfGf5FKb5eqrjkAj7p2I210nfZcl7TcY8w1s
 /M0i9sPff3Qew+LsiKJW+XbryHLRmAwfvUbv45bF7y//FsxYPkOoQ1aGbTVVLPI5kS8NuviHp
 9udmybngmwT/ljj0KJq5IFQFE/eGKOtZmvyeCm8VBtZbmIwrjfIzPSxzbeMP1DqPFMkEccpEc
 ynEUZr4TJVjy0vbf7My6rgAkzd3WAY3mw9L7zHreSNg==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

