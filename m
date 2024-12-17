Return-Path: <stable+bounces-105035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E269F55AF
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7117C1883411
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461441F7568;
	Tue, 17 Dec 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="dM6IXenf"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E913EFF3;
	Tue, 17 Dec 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458953; cv=none; b=oFj5SeiFrHVJ5rg6LsmVyniq4mZ7v2Gdu7l6js6K1bL8NAgSZ50c2YghwZJr/Jo1Q8J6KA4GakE0ceu9HrGBlpcjEccr+Fez0bWMF8gEQNn3GbVDq5bzSUebejTpOU1FFkeF43jTfSkM7kpcIhY3MwtcCQEbE4K3OicpV6iCVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458953; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qYWQMx/YM93yHzS6sRJTff3+urMbdURZNMvkoTu9E2HsE3/UU+xso2XGgf4FVrlBi7FVAy3mkqZxYD2FSJmcj+dZp1rJxTnNhUDlet0l7uKhWAXJgjW8s1DO13pz0l0z/7EyaTrxQP/oSPd2BZOXsxJkS+o9RU2ppVCaUlP9MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=dM6IXenf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734458947; x=1735063747; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dM6IXenfbJIntLL33NwDxE6fQOih/BtUqS+bOBeL9u8tA05owX40SKmiEDIzvD0y
	 8kDtkeEkM/Qg8l0Y7CLQI1WL9JPildz5rzDPv33JFB9MyNj+TGlz07mMlOk8+qBYP
	 m1oLDWKAoQrCI5dSQmadneoviGA9LFHOO7oh+jy40plizKQnrpHuLOwSaHZII/KwC
	 0ULFw+ydYsh0gzBWfTaVCYO+UyHWafXMD50ihRXk6KNdhdhckCqBOQeRqErXK+ine
	 391DZAj6Xgk4lnLRWT5zl5mNdNN0iHzUvl95CL4tA1M/e4O8lWjspOtG5Q18w7tuX
	 bWb1g17Dvr89UMx2Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1tlAVJ2tKo-010nC9; Tue, 17
 Dec 2024 19:09:07 +0100
Message-ID: <0db22651-d40b-4088-8517-d92b24adea6d@gmx.de>
Date: Tue, 17 Dec 2024 19:09:07 +0100
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
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RILrClbPHugPfhxPCWR1OSpMYZIVSZb/NsumnOGKbUen4iYcATR
 h5zwQEFXXR7dyOTTWpN4Jl0kKECeq6p8s9huNeXttKXJEEuzupiYyrXkf+lHf5nzmFSuKHS
 kkCiO6mbwufg7OlsJlkJVMtwI0AaV8773jLEIuh/n6/FuVfu1P7QgTRY81AV16VxfNwOW8F
 lsNgDbyq26obQQ/1/5mHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sAIpTvtXFX0=;obpz/8yFEyoaxh4e+IIC/NNk5Yh
 tU5Mq0MZYCAjLSCcLnwV3/MxKTxlC+pFoJkjHzZRpO4heOdljz0tXeBAsuOyvKRRP8Askwwwn
 MG+wNlST3hXtB6AT+jild67uq+h8SWoIgkFqcYvBQRgiz6106BNgqkM9rPcn2kiPnEKhkpDdu
 kRyp9yB2BL5DqGPg7R5mwUX8a4Ctsr0O+EwNKOk25i30529rusJJy2VEROshKKUm9Bs0put9b
 NeyNGkl3XfCa6Y+oN68KdJQenQzHHAwgRwesV43507F84ynr1Qm69lzfYgU7kjpJAxA59DV4y
 /3snL+15I5QJ/3AtDVHSGmLXk3X+EsANCsDmvPU9HVWUlngtoNFUdsPtZWPj88g1AZIpYeiJJ
 CYgRriqIHYzE/1EJrW4eLL7rj0J6TF2ZC/zBVUBQYurhNRC1StbR8zw3kiDmRXG9ohXny46sJ
 V3DAXG6FJDloPTdCt8w+uNeKnk6X2Ds0bDVMo/9koE3PDty+6WA4ls/4dgb1unbom9ckzEE6y
 pYSNC/dNsHI3uaRdVIxtsQ8o/sRtX49+W1gVM/wFfcp+xChn0+e410d1nVviWx83L8+2EK4MQ
 BIbz9Hn04m4v+62hmeFTwGUBTAVZbPORIxgu1+ySklwLEWE4n43gG0xndNP75qwpQt/hotBq7
 N3NQLVmoxRzf3Xqk2pTnhl/e2KcGekzFDN6ZtUkkykbgNy6KPWonbFImXPxiJsw/23yNHb7gR
 KrJz3D/BevaA1P1R3A76EtXr7As8MXFy9kI88PyxGY5NXeB4rVyYGEqp7D3va1PODHNPUM2Rm
 vyL0CLdJz07mTn7hO0MlChY9lfNa7aJUfqtue9dgj8fc8r/0X4ZmJTEdNddHctgosRxKgoPhM
 BrMk1GmL1Di2/ChkIrVIJiHfvVnPk506WPxSd/5AHLfb942BLrFifiza16mlHaDDtXdo0QgAJ
 a7kzp+ZZ35hxEZp9UIpaMfQDz+6z3PviSfCkxpPXVVEmXiI7K24Gc7dbY3rPFdyrgQT3egBqw
 R611xySIV2BfC6l4mlJNENilXlcEvu8k1HEBGPZVeLcgyESCU9ag7tLgueEwY9QhMdDwGPR5g
 qqj0/Q08Vii3cGD7ShKhsM6sCxo1wT

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

