Return-Path: <stable+bounces-61885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0893D55C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8618BB20ED5
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A580182DF;
	Fri, 26 Jul 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="C606xOJz"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F712E78;
	Fri, 26 Jul 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005510; cv=none; b=ECZm1uEle016IrGr60baowqFjZamiaIrUdHFNt6DMO+wC4APHiUFx8bt0AyTKArvqDvRUHd2Ql8Q74xNZxv8pQaHbtvMHDuOKWaqtJ/UA12oZ8XSsj0ppjmAYA8uq4oFQfw6b3v7XAaDmdVCI0HSWcIUVgOPdSTsNqDleO1Cg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005510; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=G5OkGO0dkwmbB+A5bEKbCOJJ8aQ5LfngrHPtAP1xgSfIOo4S6TrwIRaoeFW3R7ZM+x2bzzeJsJrVFX8gbBPGrivAIDp6vOTZ18YiH61ulkK2puuVMfcB5sdkF8gtvj1+QOkXQOdr3JannSmhMP/u0ngCInaYz+OgEl4FWntSdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=C606xOJz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722005505; x=1722610305; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C606xOJzVLP11P0n+XbWYPMUWXP6OMo6okB4kUgwfLliRiAZIDSX8Ky6a4Gr3JR7
	 SOoQuRJG9xsj845w+PH3DU587Jv3VQBbI0D3TATb7tDFJmixiyXC8AzqiZ90TV3jy
	 aAdAw8OGTdFd+ANZPI2BQhXyzlP0OYB2BNHeNkxElVB0JdmHWyLlUq2XTwja7Ka6p
	 6e23m5daUPUk2y2YRsNLI4SeITofURnap1XsWicvOSqs9yZTOwMeoADb1SaaMHGGu
	 4KMXApAzjHcQZsi+KhUn26vRvpVEDLzV0M6xtYHzpa/BPxjXDFsfVHY4JdvLpfmOA
	 OvFtR79ewL/FknXdPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.104]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1sbC3H0mgc-003eCg; Fri, 26
 Jul 2024 16:51:45 +0200
Message-ID: <fd3c47bf-b788-42b1-8c30-2b0b0a492ab3@gmx.de>
Date: Fri, 26 Jul 2024 16:51:44 +0200
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
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7s01lIKdg5AGXhfyXxtDvqaiUhiGSOzcwo9ktYnVMWRpcyNkHws
 mCnWlGmzT351fdXaLEKUkFXGXVnsN1UAA29Q3ZHVye1lpor+yl2FjSclS1QLG5nx6AtDvZ0
 Va3PXUgPtKK2VPE8xOjGGnMPyq72Rhxidr5VrEnWF4e4YNxMZktH2o2ZC23AZHFAd6gzwgr
 fG7WVTjyMwpnF/UqYlN+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BXOPtmf0NUg=;bEXnBdIbDSw1sY5kVA7QfaRcD0n
 eDslmrzj7UAF+DRSMjRCTV2VBZ5xdKoWwJHsc7J3kOtCsoejxjiL2D1+r17BCnP+tCTop7G7t
 6N17h03UHdu2rsfauzQ7LO19f+brgdFlmDhO0PdHP2ZhxQDMZfmnLIJhglRfgwBTmlhtp5ukF
 gkSGcUvnJqtnsQDytv0dIpCCu1vEYYWkHDuNN1ER3ZJpJn9eOf1lay4pBm/vQK/UAD37ddWE7
 nZqu47TB2AjMovKzZ3+8b2jnTC7Ja3DQJ2aiCnoRsZKkOhcXJ5gC9so9PG/0yYNMKxrPbhcZK
 V3uta8rbyB6hvOG2Je058vhZe1fCAWYYa5hNi3swo6m9xxxBJ3rexwU/0WproJOZ2/Pf9d5+o
 VdEBUUwWcF0PBqq1mXJMlAsg3Jd8Qrccg8oiInrHzNSa8jl9tAT/dgohpyk5on5pBKeEO18g7
 +r41/GFIE1NhQw9sZIZ0ragQGOwgUs40gcyQh1OnP1gzM4HescZXyeET+d5T0PyeUIL/Ml5js
 AdRz9AlBsM0DcHW49YzHikJ7BE4RrravYDxl/1586uI2VCGS/8cUt1N215GJrisdPT5GCAK8G
 z7KCW5rdGeZX6i+4rIiaK50sJH1/ZkXHITgTyikoQ2hgaQyAKzH3eB1fUZ7cr7402OpHRkwk2
 3VFoPy52V+OqnFBsqSmDyT8Ml3vLeg5v6FBPHwV4QMQz8jEsWxoZWOaIPdoVxa3dDweSRvkzc
 T+8aly8fufU0zwzC0G+BWcRqAYZWQGtf4dP+CE+y1MJM2EDwRz5ZkR5P6elhDrAj8ozr6pMcn
 COFdFz9fXkh/joASHXhm2fHA==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

