Return-Path: <stable+bounces-262177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xTHGNJecJ2p7zgIAu9opvQ
	(envelope-from <stable+bounces-262177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 06:54:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1C65C509
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 06:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pobox.com header.s=fm3 header.b=SsQ6VpqY;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="F mM/QeP";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262177-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262177-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=pobox.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6021330207D4
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 04:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE87C38F95E;
	Tue,  9 Jun 2026 04:50:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B163403FC;
	Tue,  9 Jun 2026 04:50:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980630; cv=none; b=qc3Zg3GApu1edCjN9PElVQjmeY/hl9+axr4SI42HdBrb67oBXkwvxsAhERwFOE4QcZtVQ753/dR2QmAajSWa4nz42LD7+06cg8RdHZXyzuWRom4dq/MzMwcBP2CCGX0TVmtlrn5Hhpwx1GmO5N5K3x5HlgASL9PdC6W6DTGOipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980630; c=relaxed/simple;
	bh=VsGvokajNLEtIRfvYG8Z5EIicxWUJSH2V1uEv3ED6Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjjczIcuSer2wqFct5AMzUW2Er0qGaX+47j4wBh0MKMY4U5AYtEX+07249h2FVxVVeNfsCioA+/FlcZwgLa3F5bvBn7EScJvOZGVb9Ib9uYd81DAcKhPA8UWNCZ+/O85M9Rmt/NqO1m7RBI82yRzp/pBfnEU/yQXoA3OJGgu1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SsQ6VpqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmM/QeP2; arc=none smtp.client-ip=103.168.172.153
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 126D41400138;
	Tue,  9 Jun 2026 00:50:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 00:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780980628;
	 x=1781067028; bh=U6fVgw3xUpv4dv/u/VdsCELL4Im5kQGrsuGuzZxwVrQ=; b=
	SsQ6VpqY0vTof/iQCB1BqPH+OqirjqqLMkBTSHtwxqiROIAgYUFDRzTa3HyZ/hrB
	9tMsRv8mgklQgok5ML8uHg6iSSg3Hjrcjk0lo7uj+AkzmmK3tykDlB+2uQ5F8hLp
	LVdawFhFqAJcoBbLEt+ul4R/xkHv/kBP3nVNhhRu66CSvWxR1U8rRCPvpX7K/acW
	B530G7iCKnz6veHHz3+yV2BDS66hor16USWdl40rZLCd4uv8bR9xeDrz3Jhtxo+L
	PjDrZRzHndhpseTE3rm3J1U0HvAJLEAIhQ6kcNKv692m/CQWv3dZSkaDVceV1A42
	TcFrTg9ks1A9QKnGakwpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780980628; x=
	1781067028; bh=U6fVgw3xUpv4dv/u/VdsCELL4Im5kQGrsuGuzZxwVrQ=; b=F
	mM/QeP2GHeILwSfZ9ab7VB5FrWG7EoWCmxhXtduE44L9mWisKiSaFRrosLCPvfFx
	t9u/fARXhJh3wuAcJXZfkb1mAxL6Sy7XPr+t6f/zJTm7l9xsd5LUVgs4rVaRTYw0
	lNwAGphUyKItXLIiFVbkLt3VwaAyfMiZPtv2QjPivd5H1yYLfdYfyk8X4GNVtv1Y
	R2dhm0tPnCGQwCB6fkODZqKDQa18cq7GtWUDLgHacIJKYhqoD1ponRL9aztFuLXf
	noKBOIM7U99YitKPvorY1grs48p4HV/xSHToE4Nb+pRz0MxH7YtsCxBCMjgiEYxy
	hyH1MNr0k4UyvC63WnxeA==
X-ME-Sender: <xms:kpsnasw_z0L_Zixwws_qyeto7JlYTthustNebLLGfOBjjr-Yjev-BQ>
    <xme:kpsnasLAojnFbHS0Xk1_LTTqYEYJo5C6SampDCTiDNImDCZ8ALHO542_c_1DOUnfN
    jntMrt7UNBSmEfKcze137mmUBxQxeu5WQmIKJTU-iioJfamdImSqus>
X-ME-Received: <xmr:kpsnap1FZrvD0CrMll_yxVBrntmVbu7o6qaZff2Tz2Nuqkz6GaPJrs5Z7nAnlCCiXAh7nbjn219r7BcTaF4_FnXRrsy4gs-c>
X-ME-Proxy-Cause: dmFkZTEUa6kpnN4hu3f4G1FiTkMQTLpjB0AxApvBSlohHYSlR8SbAWjM4YSMJCH7CJedQt
    TFa9hWswJRBhKMUBwYBxrd4ZElhJOAwKe6c6J64t+eHtNSyoplbDlSISkgh4Id4L6ZmgVz
    CzzPKV/flqxGCtFVemMk+zOtyIdyh/fGGEBMWPYJyzZqymdcpsnSOcUq2F+4XWJh8Rurzr
    nuLvpNNbdCJpRLMTBPbVNSoFe77Y4uNRRiN7WNlaogns4uei2H9iiHZXhFBROnkBSen1iZ
    DweaBtfoYsIDG1Jk/bo+PmiFjt9n/vH/BcmDQ+Xc2tQ5qmRecZFGTarZ7CoBC1JMqhIXB5
    uoO/EFLL4Ph/9KvadYE/JmhhqIalEP0RtPTPqr4aYoosYe/+8oPZNNrsmm283UOYMqgq3G
    0grVEhaFNF38cVN/oQzvLEdb7ILAAPC2kJH41PzRUrP7o+oxZfAA/r7PzUifPiy5UUDl0F
    SlV7eQYZua5M2r6UwY9NOGPVNdHwTxeOdmvbt1GzlkV9Uekn4TbkyVB8f86y7JllZHKnfx
    GTA9VEZBdaukcxh1XeZgN7QuaFRMYU23+4AaC5LzQN6izUpB3Z7+CuGWq09DPUU5n2CJeO
    tI3RppNC9wd7Q9E6l6HjeyFp0Pl3otJ/fMa+0RIW9FV1lmFHd1tX9tXxbNpA
X-ME-Proxy: <xmx:kpsnauebRVPT5yJ0rEUqrRnQyvVDoZSsqbVnoI4Tjul6DHIOfaW3fg>
    <xmx:kpsnal6kFIWKT6n5ENFDF3RBBTR80-SZ_d08jAfll8IuFo5Lz3cbtg>
    <xmx:kpsnap8GegBZ_MJw25bkBZqbeRirMVG6rSgy5ZLmoghsXT21RE6J0A>
    <xmx:kpsnakLNRdzb2f-crsLsn-n7Kt0jI7ejQIpfCFRhni76BVibWw9VKQ>
    <xmx:lJsnagG3R7lIz3xmyoWqXwZbfMYPhTDxbUwtbAHZfj3XqfRKobz98OUR>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 00:50:24 -0400 (EDT)
Message-ID: <20b62545-afba-403f-9721-91b5eb72ecd4@pobox.com>
Date: Mon, 8 Jun 2026 21:50:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260607095728.031258202@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-262177-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36D1C65C509

On 6/7/26 2:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Jun 2026 09:56:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On 3 amd64 systems, I tested 7.0.11 + stable-queue as of commit
bebad396ebf699e9e385a5564919d88014b7e3b2
("drop 4 patches based on RC review feedback"). So, more recent than
7.0.12-rc1 but, compared to stable-queue as of this writing, missing
tools-ynl-add-scope-qualifier-for-definitions.patch.

The resulting kernel worked well and I did not observe any regressions.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

