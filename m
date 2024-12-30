Return-Path: <stable+bounces-106560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87EE9FE901
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2AF3A1FCB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4B1A3BD8;
	Mon, 30 Dec 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="DQLHX1rV"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B72B9B9;
	Mon, 30 Dec 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575727; cv=none; b=P7RabxL6gO3P2kRwdb8Z1Q5qgnAI1dk8Co1SoRICV3TvfWQa41oE2ITmrEjXZw+E8SuuNJJwSh76MICACGpiSn5DedxFzpQ3C0Knm9x8ZZVQMiWI3y/x75mJtaTa3Lx16z99Rjm7JuYlc4xnuSF2o+sl8PI6QcjMHSGkVk3+l84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575727; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Em6ccXs69rse5xPhAggRWMaMNCMRZY1SxyRT6t0TvSMroXRZ1TA3dG8V5ZnCHH8LHzufHUeJ4bFt5UqbIjxVp0FWxv9yaaMc+JcUdC/HQU77Yb7IB1IOg60g+QpHPHb4G1+NDBuYB8ju8LqfOibjlBXNNO2Y+6BcbggwQZVf0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=DQLHX1rV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1735575723; x=1736180523; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DQLHX1rV+1ZXxbHA6yHoKATzd0lwisyIKcIt2uQale7CRx7mPCmryr+qhe6c8ZXG
	 Eu/XRem3EBRzE3+phcmpqLzVAbpyZlWh2Fn7ps/I8nGB2BjODJ0stODVrwpbn1rTj
	 k09d7kVv4PWXNIZshrdhL4LXY7w80nSiiSJLuutIFYy6rb8NAlWqJdkvdLUNQOTYe
	 tlPCNDtjwBOMj9wEz0KXEUKg/vCoGsuAEfsIp+nEReoSz9a48zLCAZOxfTTQb2zJ7
	 sE4ycO/fgk6DeEg7xsR9xWpyG2BTWWAtZwm6Fb6X7VbNPNMQ1JmqqubEV3+hV/CSf
	 BM2Oo2BM3+NsyvwDOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.35.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1tcqQ53uo7-010qPY; Mon, 30
 Dec 2024 17:22:02 +0100
Message-ID: <f94e6933-a64f-44ed-9d27-072a7333938b@gmx.de>
Date: Mon, 30 Dec 2024 17:22:02 +0100
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
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R6t2K2KVwg7Tl/y5IvaD1WFZ4BdfUyg6qUtDnzXumbbDGqmo2WR
 wHFiBRmJmvp1+Tu1dBSDkZaRIMNYlzr21FZTIf6Pwt4NtIDSGNXkNXH2sEDfeVPM82SgsP/
 Ii0a1a08kYz3tZWH2ETr1MI09txTE6IzaTSMqdCfi4qA3z7gtBUz8aKAUux2oHKk15p2EJt
 z+ntBrLd7gwSX8eCFe3dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BgCq1IFsick=;HCld88uLaqVFsr79IIJd9SUCCoo
 IjVYGRPt4D+it7xnCVPiCXkAx45KTX9uqqpf1T6ELCAcB2VwoCk1rCWsFg+lTgYzIOuNYGbqy
 L19JH8KHK1hyE9Jw1pcLfIwg9qfFJpeMm6DFQRWOU6Zq3V1LqJaWY49Z2u29khBRXGyuoaTat
 fcqjmHqEtCvFGAKUShGkvtBIQ3rox/Aap74OdBHJlfdj+UaWBTlyjQC+brTeDxpLpaeDa48Qq
 htvlOB6GCtAdTP9cmkI7PJmafIQXsIs1HfFWu41UZOSLyDu5bPoFljzO5pd593/yxbzxKlOhI
 NFnmZtMHX4h5vzkQYrcfwKsM1tam3gccD5xdwWHctsZgFpz6gNLtj0/EtAwBXQg25ZLqHv082
 Y51kvE4sHa9nk3APqCkp3Mul5+mdMxNfYu02+rW173HypUlL8CmNEnC4yjUTNovCGzD7wdhia
 lBwrHEpHe057iqW0m4T1cpKeuEEAJKw1dOxCM15m7C+qKGQ3OCil7stBGC3rsCGcVNdaDUY1A
 7M0DClSzxNF2Kt40VmJSmHTkJh17h0+4UtrjYm+yPHgz0YSkSqpHE6A7/l8gDgj/SkqqVcd3C
 vvR0NYAVwCYeOG0WCpZEsUuPZsBLCCbfJbMGApyh4RAalqR6RCiK9yNnZ/9kH794UmU/I1jCP
 ORYpFIvDSnW7LCda2rq+SQzo2RqDnQsN6HTVqW0CJ5HynIY1FFxEOxf3ir7bXcW6Dkr9rc3yM
 TRjXwpRn7sRXszjHS8/DafT/uA6TYBUsPXZa9sEOPpJUJCy+2S5Bx7b060Ktnhu64Gh98NCFt
 jk0kkIucR0TxnHud3GyJL7gU5SPMGK0Eh6IBAAd/2R3y/PkCzaGSXYuKX40MGgvy1tw9yzjO4
 La9e0FGL7EvyoO+8y69y/rwIPSpEQBiWy7Mds4Z85dKSZlfYh8s1NYyf8CmvRd9GYC4wHjxli
 JPBfXyUZO+t99GuP2UA8g2YnQ2Ta6yGf4MZa6mHnQUjdqsZfeZ/0O6TzyPjqbnXQTlnNHYazI
 umjqndfqhyiV+ovh10UC8+8W7tFM/RX50VlnY1YDcabxUitHKfFTWqBSWfZdm1pJUWh7nCTbs
 03lROGO6M=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

