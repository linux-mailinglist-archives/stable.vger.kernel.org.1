Return-Path: <stable+bounces-224835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKfHOpeRsml5NgAAu9opvQ
	(envelope-from <stable+bounces-224835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:12:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BAC27027F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73915314C20D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D33BED31;
	Thu, 12 Mar 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n56DtOJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D283BE151;
	Thu, 12 Mar 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310011; cv=none; b=VfprJZpxqDxlBhH09SNJCqHA5ZUdbTlo14DowBws5aTpGfgyZpP9d8JLvR0v9yxxqMibZ9rgR57ba6FaaGTpG8NS1G/aofD/j0740uBgcQSPhil1TtUR47eppWOCLXB4Ksuux1g4Cc4lEtkLQof8B8Uqlx323D44JQy2ubQ6TcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310011; c=relaxed/simple;
	bh=ig08MQfGmiZ30wv+QHeTuTjV9DP7WANS0SB5wgLfghw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVdUJKe0c7quPhrMbFZICxtOEz5hZ5LkKFM1/xXSxL7d56JhQ3W0ncV8bIAtBZVztvf0CSIvQNz/97kDbCPocD+pSOkGbo0j1x/43XsI1qv3/xAbiPNbk6SgHrSvCUzBg2xxa7U+YogNFhHUOk/0z9LVVlid3VkRtHTRlzCoCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n56DtOJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F76C4CEF7;
	Thu, 12 Mar 2026 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773310010;
	bh=ig08MQfGmiZ30wv+QHeTuTjV9DP7WANS0SB5wgLfghw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n56DtOJRRTVspn3kUvvfLAgF5zqsneMu92fpX/osjlLLl2IFC3bDNW0LeSLS1V5jz
	 oVmU26DS9ghymR5PlMKbvHJ42wgNfXL8D2/w0W1OZIKb1pHacv9hP1W3K3OkODktMl
	 aHXhkgs3yBM7LO6zQPU2sc6ts2sQSIqkUU6GVLsmyxgHtz0+6yhrX4CtWoAd/nyfkh
	 33r3vIYE0uLJ8V/6cnfPJAqjB8v88s9BJMaaxAHzfcJjW8nnxI3bk2QjMD5C1167X0
	 MKST7J4wJMFcocGB+OM9NjKerj0Sh3pcmn0J7l1D0yIqgH9v9WXdKKx/US+eWqk7Rj
	 Z7wdYou/LtKZg==
Date: Thu, 12 Mar 2026 06:06:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
Message-ID: <abKQOUd0Uv4WTcYN@laps>
References: <cover.1773141554.git.sashal@kernel.org>
 <xbjybmha7fdnnm5gn6p6jyppf4ud2r72rfabvej6egg545ozsu@a4qj43d3iu36>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xbjybmha7fdnnm5gn6p6jyppf4ud2r72rfabvej6egg545ozsu@a4qj43d3iu36>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224835-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 76BAC27027F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:35:11PM +0800, Shung-Hsi Yu wrote:
>Hi Sasha,
>
>On Tue, Mar 10, 2026 at 07:19:29AM -0400, Sasha Levin wrote:
>>
>> This is the start of the stable review cycle for the 6.18.17 release.
>> There are 314 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>
>BPF selftest is failing due to backported commit efc11a667878 ("bpf:
>Improve bounds when tnum has a single possible value"). The fix is
>commit 024cea2d647e ("selftests/bpf: Avoid simplification of crafted
>bounds test"). Can you pick that up for both 6.18 and 6.19?

Will do.

>FWIW this failure does not point to actual issue of the codebase, just
>that the selftest's expectation not aligning with the kernel.

Great!

-- 
Thanks,
Sasha

