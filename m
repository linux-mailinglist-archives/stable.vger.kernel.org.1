Return-Path: <stable+bounces-108245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014FCA09EC8
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 00:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA6B169092
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E067222569;
	Fri, 10 Jan 2025 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="Bmasmyqm"
X-Original-To: stable@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1220764C;
	Fri, 10 Jan 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552321; cv=none; b=LLY3iSFG/YbTF8fItYM0ZryVS8yNK2FFqsIMWX9+7r5MjU0hI8sJ9dd9+c2bfITfXRVl4RJt8VuE5AGEUDorYYTtLLO2hpwlf0PhC7/UjQ1rn6kzpq5rAXJrpFABJp+dykYdXuuMUKPWxQDQHPUNChSLI1T++Y5eCZ9cCyA8/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552321; c=relaxed/simple;
	bh=3bCVOz2057ZEyGPYIcxhXtGk2vRvimyxNDA88omMxHc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPVPXXrjxqbzN/bNOYRLZ+1G6+mmh6SIMIJvPXlx7a8GQ2M7AJT/M4YiRUu/14UryTuvlFxeWqwtTnMr3DMNP3rOPWSsbAlH/N21LhFTrsSJCDwojj4UGRD/LQUdGopqp6HwKnKLeum074E9K+soGVFC8D6DXD6zdfZd2jz5vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=Bmasmyqm; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id DD47DC0009;
	Sat, 11 Jan 2025 02:38:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru DD47DC0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1736552313; bh=GmaAwylkbZObqLfu3xpFEaMhMB1R64yqjc4keSGeo1Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=BmasmyqmwwHzeNQwBIr/tBTs+krXXWfBUY/la3AyKtY/OZvdR3Nxo3YHzMTi+4vYC
	 cy60stoPXzuQEf0jZEDYOxhD1aHyjpnI+GB+NFCPKz0UpDTN6nByuNd3/aCOu8yRiM
	 07bYo9sCLaYMX1lmYPI60jw4GRKEqNZO4EBZzTSEzRzry1MvuDQXYymcTYXDFxIa90
	 sko1YT0c4lrV7BYYOs/yPftLRe5nKpGCIUeWZ4+o3CIrEWol2Un2UnAj6Iw/gVxfP5
	 AhlQAQvulhOpE8Djyqn0WbWsuj80w/vicCFOftSiv22iMylL450sPtMaCc7XiF8xv+
	 YYWosdUOPr/Fg==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Sat, 11 Jan 2025 02:38:33 +0300 (MSK)
Received: from localhost (5.1.49.10) by mmail-p-exch01.mt.ru (81.200.124.61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Sat, 11 Jan
 2025 02:38:31 +0300
Date: Sat, 11 Jan 2025 04:37:53 +0000
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: Simona Vetter <simona.vetter@ffwll.ch>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	<syzbot+9a8f87865d5e2e8ef57f@syzkaller.appspotmail.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, Michel =?UTF-8?B?RMOkbnplcg==?=
	<michel.daenzer@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vblank: fix misuse of drm_WARN in
 drm_wait_one_vblank()
Message-ID: <20250111043753.b4407fcd52413ca37ed80ce9@maxima.ru>
In-Reply-To: <Z4Fy04u7RjaZIsqI@phenom.ffwll.local>
References: <20250110164914.15013-1-v.shevtsov@maxima.ru>
	<Z4Fy04u7RjaZIsqI@phenom.ffwll.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64--netbsd)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/10 22:20:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {rep_avail}, {Tracking_phishing_log_reg_80_90}, {Tracking_smtp_not_equal_from}, {Tracking_redir_with_at}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;lore.kernel.org:7.1.1;ksmg01.maxima.ru:7.1.1;maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, FromAlignment: n, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190270 [Jan 10 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/01/10 22:04:00 #26969692
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/10 22:19:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Fri, 10 Jan 2025 20:19:47 +0100
Simona Vetter <simona.vetter@ffwll.ch> wrote:

> Hm, unless a drivers vblank handling code is extremely fun, there should
> be absolutely no memory allocations or user copies in there at all. Hence
> I think you're papering over a real bug here. The vblank itself should be
> purely a free-wheeling hrtimer, if those stop we have serious kernel bug
> at our hands.
> 
> Which wouldn't be a big surprise, because we've fixed a _lot_ of bugs in
> vkms' vblank and page flip code, it's surprisingly tricky.
> 
> Iow, what kind of memory allocation is holding up vkms vblanks?
> 
> Cheers, Sima
> 

I don't think this is because of memory allocation. As far as I can see
there is no memory allocation in vblanks handling. Okay, there is a kzalloc()
call in vkms_atomic_crtc_reset() without checking a pointer but this is
not the root cause of this issue. My first thought was that somehow a
vblank might not be successfully processed by drm_crtc_handle_vblank() in
vkms_vblank_simulate() function which always returns HRTIMER_RESTART even
if a vblank handling failed. But this hypothesis was not confirmed -
all vblanks are fine. The hrtimers in vkms have a hardcoded framedur
value of 16ms and what I can see is that the fault injection creates
some delays by unwinding the call stack when it simulates an allocation
failure and this caused the hrtimers to lag. This what I was able to
investigate while I was debugging the kernel in the gdb.

A similar issue was being discussed in
https://lore.kernel.org/linux-kernel//0000000000009cd8d505bd545452@google.com/T/

-- 
Vitaliy Shevtsov <v.shevtsov@maxima.ru>

