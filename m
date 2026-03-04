Return-Path: <stable+bounces-223044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCWnIEgiqGl3ogAAu9opvQ
	(envelope-from <stable+bounces-223044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:15:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DACF1FF8C2
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1E273026B72
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A993A4528;
	Wed,  4 Mar 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa3yYrQp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA32381AF1;
	Wed,  4 Mar 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626501; cv=none; b=bWrCV5WYtu6iTFV8dtKjFbrkwH5BDsjcrzrlOXxGMKdsox3Cn1HIb5V6JCy74ZfBY5TTCpdIuQ5UB1bgqfBE726fxCUkKYzfx3pUhaqA5XpBlzayCbnZDYYk3FNYNSt5dcVESC2VdaDJYZM3Egt8HxWHn40dAxXqaYgyCC+9CYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626501; c=relaxed/simple;
	bh=iiOFnWr2yTnBCGDX9Fa9OLfNIKFpg5Qvd0Pyr9i4e0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObZLQqg2cZxBOxC7eEZ9TrgDckTEQoI1Cnm0ToGsvlEBUD+24Nw2jTJJe/F67uf+qBqZ5ghxDjri9XA4Ma8z/LFvwoZrPbSXF7TTBzhjAYRrthzxK8YWbMsHcGByyrieqfniAfkbin6Bz+ojt6ttwJeEalCVhSGU2dhomf5bFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa3yYrQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF1C19423;
	Wed,  4 Mar 2026 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772626499;
	bh=iiOFnWr2yTnBCGDX9Fa9OLfNIKFpg5Qvd0Pyr9i4e0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oa3yYrQpkNul6wkj/SRpAvnmJedXPKCvET/mMDAYf63x3OBnJgVUfSE8rD9SYsFTt
	 hPk2eJzJEccWCwRCgsX/bhCbyTxMHuPYcpGvpJC4abIWPNQSU1wn1Z3CcNmjGl/Ui1
	 AB5mEy619sPIdkGxua+G75+mxy71cBoPfcGBtsl2impYwqBQeTsT8t/6ne2ZWcSjx2
	 x1nWK0kDMVDcjiHEFb6K9awwKQ0w6v3EbsV2ixYx7kBFk1FlFiPh6wfM+lx7PY2TjL
	 OrICf8weYhsUspM8aTJf2N2krKZfaRWhR5Qmx62RCB0R2qimQZtQkEPUbyrmbl7tMZ
	 5Il3ukX/Essuw==
Date: Wed, 4 Mar 2026 07:14:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
Message-ID: <aagiQjT1eBGEHV--@laps>
References: <20260302160934.2521545-1-sashal@kernel.org>
 <20260302193559.3432-1-bacs@librecast.net>
 <aafiF3Mtc17i7Y72@auntie>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aafiF3Mtc17i7Y72@auntie>
X-Rspamd-Queue-Id: 6DACF1FF8C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223044-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:41:11AM +0000, Brett A C Sheffield wrote:
>On 2026-03-02 19:35, Brett A C Sheffield wrote:
>> # Librecast Test Results (FAIL)
>>
>> 020/020 [ OK ] liblcrq
>> 010/010 [ OK ] libmld
>> 120/120 [ OK ] liblibrecast
>>
>> CPU/kernel: Linux auntie 6.6.128-rc2-ge6906aa7f5ea #1 SMP PREEMPT_DYNAMIC Mon Mar  2 17:31:27 -00 2026 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux
>>
>> Builds, boots and passes network tests.  Fails to poweroff.
>>
>> Bisects to commit 3ba77c48498f0fa29456e2435d7d49eafc0a279c (upstream 4589712e0111352973131bad975023b25569287c) and affects 6.6.y and 6.12.y. Other kernels are unaffected, including mainline.
>
>Are we dropping the offending commit from 6.6.y and 6.12.y and retesting?

Yup, I'm going to drop it from both trees.

-- 
Thanks,
Sasha

