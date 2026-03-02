Return-Path: <stable+bounces-222664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDVyAQnOpWm1GwAAu9opvQ
	(envelope-from <stable+bounces-222664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:51:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2E1DE11C
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E835307CE8E
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137D42DFF9;
	Mon,  2 Mar 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYULeo8o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBF41B37F;
	Mon,  2 Mar 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473742; cv=none; b=iLusVV1bIXt+iGvFhYgniN5YM4xfjjnFQO4TwNQEvyHnDz5Wa39/IsaPBocDmttUUux8xhxyNZIHzFYCfIB3yEQlTBTw+hkqT0l5XL02/ZWn+amnclUPXR9p3zS8p34fWtiLejcC/FS52QUpl08yBCLKman/ExB60+0zk1PhY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473742; c=relaxed/simple;
	bh=RCiMF3vdBKpdctxDA1suM4SQXUy3SOpSvrg/GpMtTb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLLfTE9tQE8yGlSqQZRuqU326YhCeGrlNiKcp8/YqsRI2uZjAvyRDuMt5GaTjDqDPEN50W+e3nKOP2jz2SdlWRSD843oy14++R88ydp9VMXloPxLO/OvamVmcbu0mxYCKmGgIdAivJlkCC3FUYyNfk2GuWxPHDB35LZX3CNm4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYULeo8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2217AC19423;
	Mon,  2 Mar 2026 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772473741;
	bh=RCiMF3vdBKpdctxDA1suM4SQXUy3SOpSvrg/GpMtTb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYULeo8od2DPN+NW7SskEa3vImrhr142fBbG+RUyIIJmoobNoMynBY5zFRGPcLoVP
	 ZIOsKrvVduj2Hnuj012plNV/cruwHnhQR6vaC4KgKP1bqYlqQg8Kn1OQy0KA9XWE0o
	 mmDexgO8KDiTnx8wv2r3YzqxC/z4HUCZZvnjcOcIyI72qQ73m39Jca1DWjtBg4LVcb
	 fuYXIenbFsJq39fv+vbrilQu/tQTAMzy4dTfUqavn7NbfzmjPV/V/UdZ6Cgq+dtYXa
	 vZeZjGXV6iJk11Ec0RNKVKv3EO83JcHzf2MvKAIEhVt6bXPM6Jih8VqiGvQuSRtGyr
	 FazIfynK1P5ug==
Date: Mon, 2 Mar 2026 12:48:59 -0500
From: Sasha Levin <sashal@kernel.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Message-ID: <aaXNiwFkUEy8SaTm@laps>
References: <20260302160943.2522184-1-sashal@kernel.org>
 <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com>
X-Rspamd-Queue-Id: 68A2E1DE11C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-222664-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linus:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:26:08PM +0100, Peter Schneider wrote:
>Am 02.03.2026 um 17:09 schrieb Sasha Levin:
>>
>>This is the start of the stable review cycle for the 6.1.165 release.
>>There are 533 patches in this series, all will be posted as a response
>>to this one.  If anyone has any issues with these being applied, please
>>let me know.
>
>
>I get a build error in arch/x86/kernel/setup.c:
>
>  CC      arch/x86/kernel/setup.o
>arch/x86/kernel/setup.c: In function ‘ima_get_kexec_buffer’:
>arch/x86/kernel/setup.c:385:15: error: implicit declaration of 
>function ‘ima_validate_range’ [-Wimplicit-function-declaration]
>  385 |         ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
>      |               ^~~~~~~~~~~~~~~~~~
>make[3]: *** [scripts/Makefile.build:250: arch/x86/kernel/setup.o] Fehler 1
>make[2]: *** [scripts/Makefile.build:503: arch/x86/kernel] Fehler 2
>make[1]: *** [scripts/Makefile.build:503: arch/x86] Fehler 2
>make: *** [Makefile:2025: .] Fehler 2
>root@linus:/usr/src/linux-stable-rc#
>
>
>I always do my test builds with CONFIG_WEROR=Y, full .config attached.
>
>The line causing the error seems to come from
>
>73b97ee06bd63 x86/kexec: add a sanity check on previous kernel's ima 
>kexec buffer [ Upstream commit 
>c5489d04337b47e93c0623e8145fcba3f5739efd ]
>
>via
>
>136114e0abf03005e182d75761ab694648e6d388 "Merge tag 
>'mm-nonmm-stable-2026-02-12-10-48' of 
>git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm"
>Pull non-MM updates from Andrew Morton
>
>
>If I revert 73b97ee06bd635433d1c429ecdbc9167da5de588, the build succeeds, and the kernel boots and seems to work fine.

I didn't even get a warning for this one :/

I'll drop it and push the -rc2 branch again for all affected kernels.

-- 
Thanks,
Sasha

