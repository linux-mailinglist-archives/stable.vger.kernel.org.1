Return-Path: <stable+bounces-222495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCW6A47epGnUugUAu9opvQ
	(envelope-from <stable+bounces-222495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:49:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C51D22E5
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C34301113F
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF71E22E9;
	Mon,  2 Mar 2026 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL6zxPOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4710F1;
	Mon,  2 Mar 2026 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412545; cv=none; b=Gn0nM7kF0W47r3EXN2cAoKeSE+Ps38EzGa8/bB89MCq2zbHWtq3Ne5n2Gwge3jzA/vsDaeuN9DDfzNPVmaeQFAUp1ez4/UuMWNQhi/yOBXFw07vO2/dUaj72/iXNOLZAzFLnei3C1yu9oyreZJoeJ61aqlSApqZ2vWIo+Z5X9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412545; c=relaxed/simple;
	bh=f87ava7OEuQp4NmAem4s+xvuHZMeIBy7JmD6uv8FSOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiemH0RB7F+eCPcyp+XtKC5o6/74Zv/YGfspYMFAWghM78zZot14VfUjL9x2N7JpJMBYLZt5XHtU7tx5AxDNUqOh52dd9k8KurNq+3OQ88YjWs6v1tmskb7UhgqOaYaIqujc2YE+ojnJ5t/r9pf8Rg2hazKraGvL533R8ObqMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL6zxPOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2748CC116C6;
	Mon,  2 Mar 2026 00:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772412545;
	bh=f87ava7OEuQp4NmAem4s+xvuHZMeIBy7JmD6uv8FSOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hL6zxPOyAhUz+2mCzdZQake5YSMNILrrCOqZwO/ndgWhAlhU7MjVx8jRHwgOfztOy
	 Bu5B7vW89Nx+AZJAlTB7t2VQAVGaa0n46ojhzOtS3X0mpsS+SOMgys//TR9144lTVg
	 hzQYODcNJ61+3SgDrAeDY3rGJoIzy4UzRRY2qzZI1+1W7ouvT6iRuwgrEuU207Jb1L
	 JGa477bBXqNLGxP5pVGEJjswF8AcPOUR4CaR9Bv8Nz7jeG3Eran15lb2ioPi8VhoJC
	 A/3Sn861IFqAYzlBsPPgxluEYuf3XW83WgfSwkjsSpVXGWpLicSubRrwNgGAt34aUz
	 8e2q2aUOMPi3A==
Date: Sun, 1 Mar 2026 19:49:03 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
Message-ID: <aaTef1CyYVhpE4k2@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <9623f4e6-41b4-4dc8-a6ff-cf0de3604dfb@pobox.com>
 <bf650251-9254-4d42-9224-0b8db08042c7@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf650251-9254-4d42-9224-0b8db08042c7@pobox.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222495-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A4C51D22E5
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 08:43:43AM -0800, Barry K. Nathan wrote:
>On 3/1/26 00:49, Barry K. Nathan wrote:
>>Unfortunately, 6.19.6-rc1 won't even build for me:
>>
>>Warning: drivers/gpu/drm/i915/intel_wakeref.h:156 expecting prototype for __intel_wakeref_put(). Prototype was for INTEL_WAKEREF_PUT_ASYNC() instead
>>1 warnings as errors
>>make[9]: *** [drivers/gpu/drm/i915/Makefile:449: drivers/gpu/drm/i915/intel_wakeref.hdrtest] Error 3
>>make[8]: *** [scripts/Makefile.build:546: drivers/gpu/drm/i915] Error 2
>>make[8]: *** Waiting for unfinished jobs....
>>
>>This only happens with 6.19.6-rc1, not any of this weekend's other
>>stable rc's. (I'm still testing 6.12.75-rc1 and 6.18.16-rc1, but
>>they're doing well so far. I have successfully built 5.15.202-rc1
>>and 6.1.165-rc1 but I won't have a chance to do any further testing
>>of them before they're released.)
>>
>>As soon as I can (in the next hour or two) I'll minimize my config
>>a little to shorten the compile time, then I'll start bisecting.
>
>Result of bisecting:
>first bad commit: [0ef5d235ab57bc90831ddf38eb1742ff68f345e1]
>docs: kdoc: fix logic to handle unissued warnings
>
>This commit breaks the i915 DRM build if (and only if)
>CONFIG_DRM_I915_WERROR=y, whether CONFIG_WERROR is enabled or
>disabled. However, the "bad" commit is definitely fixing a real
>bug, and this build failure doesn't happen on current mainline
>as of this writing (commit eb71ab2bf722), so I don't think
>dropping the patch is the correct way forward.
>
>Rather, adding commit 524696a19e34598c9173fdd5b32fb7e5d16a91d3
>    drm/i915/wakeref: clean up INTEL_WAKEREF_PUT_* flag macros
>(it applies cleanly) fixes the warning, thereby fixing the build.
>
>The resulting kernel works fine in my testing, too. I'm using
>6.19.6-rc1 + 524696a19e34598c9173fdd5b32fb7e5d16a91d3 to write
>and send this email from my ThinkPad T14 Gen 1, which uses the
>i915 DRM driver for its Intel integrated graphics. (I also
>tested it on my 2017 MacBook Air, which also uses i915 DRM for
>its Intel integrated graphics.)

I'll queue 524696a19e345 up, thanks for the report!

-- 
Thanks,
Sasha

