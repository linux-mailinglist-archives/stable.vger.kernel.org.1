Return-Path: <stable+bounces-116784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6DA39E51
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C9169CC9
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A705269AEB;
	Tue, 18 Feb 2025 14:09:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72842269822;
	Tue, 18 Feb 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887780; cv=none; b=btELK6kRXBT08u50N8Zb4NGIBpCd+QLpmYWM6IDmaAyncCrEdXy1nh2L6t9AXm8s423wrBhhaf59j9vXKubAEEnuj+WYKAZYNY4eOQHIzVPBWgASoKOx8h0RHbHgm6vRPX9tKqOZRjf1BTAvfH7y2Alj5FpJNwbfxZT2pk1plbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887780; c=relaxed/simple;
	bh=LDe4YY/D/KG814sUzaFt57nrvQqaY4+cHfBTOTZhp4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCK5CbnYyzXpPSE/lREwqwFvqMdpd7SaruZYQrI02LNEJTohZxIEwkqgnjH2LI+PGczaQwkRZIfprY8aZTdaKUgB9i5YXldBdfJW9el8e8ufP1g8waPrkmjEyNHH+a7tCwGFb3DG/wNhVpRMnf0xli5ynx/pT0iW95tP4eQ+rJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb8045c3f3so355634266b.2;
        Tue, 18 Feb 2025 06:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887777; x=1740492577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOqpNPfprzC/VuOUsgbWKiDS4uVsWF0Gzq7YLXne2M0=;
        b=VDIH9ZSbm2c+20VAqaGeXZItmHBPdLypTZQQvvz1B52IwAi+/BbHTjmcmUuwec4KOm
         GnOr47vW+jFnAGiFDHmJlwrJCxgSDZ3GWC1RYRXB+4mGJcGpOheGFYuH/IDi6zyZfw3b
         XwW6I8RSneh8fH93nbys07fE5ntUuH6Wv6ngOeLiW38PhP8rPhuCvWxiJlsEGZnM0j+1
         sRpuSuM4pUv9tPmQ4moyTw5FEtGODDAtk1aO0SvHFKrBl5IQ+CSMR8NcbOMmo8Vxfoxf
         d33Ri2LsdDtipYZewwUTPyZK1gHdnd/PZjjOgHb8c3D0r0xdwHVXVR1y+rNaEApIQMYX
         0njA==
X-Forwarded-Encrypted: i=1; AJvYcCUkPWp3IgTa7adRPqHV1DYhnVyDqaGggXCy1dpPjVJaCRKrNpWdjHGf93tdeR6bKj45WoQBxtqw@vger.kernel.org, AJvYcCWcLOfOwqyjJTuaE/ohYvcAgD//BCR9nTlnzc1Egf6xQdR6KXzuQDLAuPh9ZNltsHy/zz1p3X61b5CwByY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47dufIgoNkXJgyTKaqqHuH5w0uy/rGO0puPUz3WoVwP4AWs6M
	kNmgoa+bw9TtVT/ObS+E832sTRW/9j4YQEJ19PwalywvW/IZFQL8
X-Gm-Gg: ASbGncuSmq8+wjLXbcwNsFAG5gkSEQ0CzTYhqBlSpIWXW072GEG6yGNhOc48Ww8I8HS
	yRFHTLeznGIqgdT2GZAUyRnohFgupdzLWwkQqh4eJwR7ZjcOUehz8EFMdutPfg8F1fSRRdyuxHQ
	uC3VzQMvFG8HdodJql51PMhKmK9DkGwcjA+oNu5MJNNoF+lchV5vClhjyJf7IprfHYJWwdnkmcY
	sg1ns5YqBeA7/cM9bHNJaaBKyWJllqKAVUaAzzgPajGSFQaLVFjeqA3ofaO4sJvDbIt5fABnLxd
	I3EhVu4=
X-Google-Smtp-Source: AGHT+IF5nwrMpEy7s0eR61eGJJWsqTPMythWKfZZ2UKJQmRW6VNlsUYbb7Fb2C34VdjEApYgHubpIQ==
X-Received: by 2002:a17:907:70d:b0:aba:5e4b:b0b6 with SMTP id a640c23a62f3a-abb70e53b7dmr1229698566b.54.1739887776310;
        Tue, 18 Feb 2025 06:09:36 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba4fc0c29sm295532566b.157.2025.02.18.06.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:09:35 -0800 (PST)
Date: Tue, 18 Feb 2025 06:09:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Message-ID: <20250218-meaty-clever-buffalo-9ba688@leitao>
References: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
 <Z7RdnR2onJ2AZIJl@shredder>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RdnR2onJ2AZIJl@shredder>

On Tue, Feb 18, 2025 at 12:14:53PM +0200, Ido Schimmel wrote:
> + Breno who also encountered this issue

Thanks. Please add the following if you feel appropriate.

Reported-by: Breno Leitao <leitao@debian.org>

> On Tue, Feb 18, 2025 at 10:24:21AM +0800, Lu Baolu wrote:
> > Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
> > locally") moved the call to enable_drhd_fault_handling() to a code
> > path that does not hold any lock while traversing the drhd list. Fix
> > it by ensuring the dmar_global_lock lock is held when traversing the
> > drhd list.
> > 
> > Without this fix, the following warning is triggered:
> >  =============================
> >  WARNING: suspicious RCU usage
> >  6.14.0-rc3 #55 Not tainted
> >  -----------------------------
> >  drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
> >                other info that might help us debug this:
> >                rcu_scheduler_active = 1, debug_locks = 1
> >  2 locks held by cpuhp/1/23:
> >  #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
> >  #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
> >  stack backtrace:
> >  CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0xb7/0xd0
> >   lockdep_rcu_suspicious+0x159/0x1f0
> >   ? __pfx_enable_drhd_fault_handling+0x10/0x10
> >   enable_drhd_fault_handling+0x151/0x180
> >   cpuhp_invoke_callback+0x1df/0x990
> >   cpuhp_thread_fun+0x1ea/0x2c0
> >   smpboot_thread_fn+0x1f5/0x2e0
> >   ? __pfx_smpboot_thread_fn+0x10/0x10
> >   kthread+0x12a/0x2d0
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x4a/0x60
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> > 
> > Simply holding the lock in enable_drhd_fault_handling() will trigger a
> > lock order splat. Avoid holding the dmar_global_lock when calling
> > iommu_device_register(), which starts the device probe process.
> > 
> > Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> > Reported-by: Ido Schimmel <idosch@idosch.org>
> > Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-a@shredder.mtl.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Thanks for the fix. I tested it and the warning is gone.
> 
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Tested-by: Breno Leitao <leitao@debian.org>

