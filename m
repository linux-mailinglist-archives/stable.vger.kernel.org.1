Return-Path: <stable+bounces-224770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNnpHpf4sWl7HQAAu9opvQ
	(envelope-from <stable+bounces-224770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:19:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBFF26B51C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371EB302C906
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 23:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2863A16B8;
	Wed, 11 Mar 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/mqPfDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A22E5B21;
	Wed, 11 Mar 2026 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271099; cv=none; b=Mtlx8ALJkWN4SX11G0HbBu+Pw4GklfhijATcMLb+Zc3bYHRbug7pMmCa4ZIBPucjePdHyZrrmHDKpocCzKI0wx/TfFtkEXHXKUmzbsrwQmOj5xsdhuQo6e1AG/EyZAGnoy3Y28KyW1geDm+u2frHq9RES+rZtuGyICxSxCCwd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271099; c=relaxed/simple;
	bh=7+jLz9RF1riOBizFTo+5FfBbhWht070qXJFZUbh5X88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyD/br7okldeaORDk+6tDSAAAa1uXmlhJy8IyYOTC+4jcNpCdxSyX/bFAvIIBj6yxqJNOHmXIqSecVI71R09P3am4PucATJNArBexG2vsVcWnVhU1j1OHmYJGngf2rF1+Te+XqYb14+WcizEGJ+/Z0NF915jIC6IoV6RQwFa5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/mqPfDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A1BC4CEF7;
	Wed, 11 Mar 2026 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773271098;
	bh=7+jLz9RF1riOBizFTo+5FfBbhWht070qXJFZUbh5X88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/mqPfDz2osSTDz6vEgm57t493wdQBUo0oYc7C84yDAXqbyFKzm848ffZN/XbpIxm
	 ZPbxZlal9kmfRT5QVD7c5uiRRi+L6D+O1U16fgmfa7q+CmTgEWPfrhEsIOm6WXb4Ix
	 taxJK2GjPw0nvHVnesk8qpXTgbZXSUod4ytF7Sh33PQ+G6KMDCv0UeFyFwsumGI/9x
	 HGxR8DRXtyJcLezz8fi/KRqGMFzWKyWeWC79evx2o3yX0u5ZtfbfZM1RGzWq040Xe4
	 3LDFb7Y1ZZ9o3aq9UvZmp8sC6ATEwwj4rAtBjixpVbZtcI3QPkhFAiCLexywdCrTLQ
	 Ia7byZEby8/rw==
Date: Wed, 11 Mar 2026 19:18:17 -0400
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
Message-ID: <abH4OYeVMctC3Cs-@laps>
References: <cover.1773140654.git.sashal@kernel.org>
 <75302bf4-3f06-4e9a-8d05-1706d60f44c6@gmail.com>
 <abDACatouF12XBX5@laps>
 <97a13d4f-e1ee-42f5-ab90-d6dc589ecefc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97a13d4f-e1ee-42f5-ab90-d6dc589ecefc@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224770-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFBFF26B51C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:47:16AM -0700, Florian Fainelli wrote:
>
>
>On 3/10/2026 6:06 PM, Sasha Levin wrote:
>>On Tue, Mar 10, 2026 at 12:09:32PM -0700, Florian Fainelli wrote:
>>>On 3/10/26 04:05, Sasha Levin wrote:
>>>>
>>>>This is the start of the stable review cycle for the 6.19.7 release.
>>>>There are 311 patches in this series, all will be posted as a response
>>>>to this one.  If anyone has any issues with these being applied, please
>>>>let me know.
>>>>
>>>>Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
>>>>Anything received after that time might be too late.
>>>>
>>>>The whole patch series can be found in one patch at:
>>>>        
>>>>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux- 
>>>>stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
>>>>or in the git tree and branch at:
>>>>        
>>>>git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux- 
>>>>stable-rc.git linux-6.19.y
>>>>and the diffstat can be found below.
>>>>
>>>>Thanks,
>>>>Sasha
>>>>
>>>>-------------
>>>perf fails to build the pmu-events for all of the freescale SoCs, 
>>>I am not sure yet whether this is a build environment issue or a 
>>>genuine perf build system failure:
>>
>>Could you try building with a revert of b56111d7a464 ("perf jevents: Handle
>>deleted JSONS in out of source builds") please?
>>
>
>Yes that does resolve it, thanks!

Awesome! Looking at the patch, it looks like it's a backport regression and
upstream should work just fine?

Assuming it's the case, I can revert this commit after the current release
cycle.

-- 
Thanks,
Sasha

