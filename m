Return-Path: <stable+bounces-143131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05BAB31AE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16D23B0795
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C342550D4;
	Mon, 12 May 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdabjSit"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDD255F21;
	Mon, 12 May 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038704; cv=none; b=reL2159idetJjqKCBmVsMCvve9fj6jOw01aS9xRfWhIYEzQOs80GWMnRQLgu+BknUo2tCgRJmFF4mPRMlJx/KUzg+HiLNEr1+AfAonJqLNRyY/ABaqwshKQlN/7lmEQUySX211JEjpZtMj7z07gJd2jIbuleZ4CfTiOW46pWE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038704; c=relaxed/simple;
	bh=f8pYJrR7b0v7xVq/4odwpNWdLzpTrC9MBNDWyIHFjZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTPnrYG3/y0iwJegUcC16vHuhTVXS891kjJgOCADFAVHkDEEUQC1Xchag6ucamu4w8UYemS7dqkiS16gSNFBKQbShSuoCE7BROElPVVHShHm4517NHHhiDT+7Zbf5lt83BKXbNqVU33C6uBdj0Z+y2CdrJ3n4CaX+UdAGrU1NYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdabjSit; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747038703; x=1778574703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f8pYJrR7b0v7xVq/4odwpNWdLzpTrC9MBNDWyIHFjZ4=;
  b=PdabjSit3/EtNRkCTJ+KffjYl+dteylWSpjxlNROpr86znUYFeUsjgXV
   9uNf3DkpMPYmOWb3H5eeLHCWq+A3NVlfXnggiIouaqBnyaNqbjJGTIbwW
   l8VVWdVA1CzMsDVbKh3yAkOsSvnVDByRgYeFX5GjR11PyhI/8Mt8+rDvK
   sHSX1jV9xGXKB97XC7JjjaeFBNR3YoZY2CpTkoaN6bYPPrO2AItL4vV2F
   jgmrieNFLuWWrECKvyPWRU2FhncsSOTJ09+X6ZBuTRKAPl2YSz+bgCfHx
   XrNivUcXKaKxAIB1Pq55wu58C8TODLQ4QQbvNKfFTi9ptMZwoS/8miNJH
   g==;
X-CSE-ConnectionGUID: /UjcI638STGqUvk+WI74Dg==
X-CSE-MsgGUID: k5KZTtARTXqroimaMVNuow==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48820259"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="48820259"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:31:42 -0700
X-CSE-ConnectionGUID: Wt0JH0LnR4aVGkyff9QzVA==
X-CSE-MsgGUID: s45XHkb/TjiYI+IeSrrSfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137000875"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.124.249.161]) ([10.124.249.161])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:31:40 -0700
Message-ID: <0ec52e49-3996-48e2-a16b-5d7eb0a4c8a6@linux.intel.com>
Date: Mon, 12 May 2025 16:31:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mtrr: Check if fixed-range MTRR exists in
 mtrr_save_fixed_ranges()
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Bernhard Kaindl <bk@suse.de>,
 Andi Kleen <ak@linux.intel.com>, Li Fei <fei1.li@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com>
 <20250509173225.GDaB48KZvZSA9QLUaR@fat_crate.local>
Content-Language: en-US
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <20250509173225.GDaB48KZvZSA9QLUaR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-05-10 01:32, Borislav Petkov wrote:
> On Fri, May 09, 2025 at 05:06:33PM +0000, Jiaqing Zhao wrote:
>> When suspending, save_processor_state() calls mtrr_save_fixed_ranges()
>> to save fixed-range MTRRs. On platforms without fixed-range MTRRs,
>> accessing these MSRs will trigger unchecked MSR access error. Make
>> sure fixed-range MTRRs are supported before access to prevent such
>> error.
>>
>> Since mtrr_state.have_fixed is only set when MTRRs are present and
>> enabled, checking the CPU feature flag in mtrr_save_fixed_ranges()
>> is unnecessary.
>>
>> Fixes: 3ebad5905609 ("[PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> 
> Next question: this is CC:stable, meaning it'll go to Linus now.
> 
> What exactly is it fixing?
> 
> Because the patch in Fixes: is from 2007. :-\

Hi, Boris

This fixes unchecked MSR access error on platform without fixed-range
MTRRs when doing ACPI S3 suspend. IMHO, though it is handled and won't
panic kernel, it is worth getting fixed, and it matches the stable rule
that

"It fixes a problem like an oops, a hang, data corruption, a real
security issue, a hardware quirk, a build error (but not for things
marked CONFIG_BROKEN), or some “oh, that’s not good” issue."

Kernel log is attached below.

Thanks,
Jiaqing

[ 173.115706] ACPI: PM: Saving platform NVS memory
[ 173.115818] Disabling non-boot CPUs ...
[ 173.126530] unchecked MSR access error: RDMSR from 0x250 at rIP: 0xffffffffa90a15ff (get_fixed_ranges+0x)
[ 173.126749] Call Trace:
[ 173.126806] <TASK>
[ 173.126858] ? show_stack_regs+0x23/0x30
[ 173.126946] ? fixup_exception+0x5a4/0x610
[ 173.127037] ? printk_get_next_message+0x105/0x350
[ 173.127141] ? gp_try_fixup_and_notify+0x37/0x100
[ 173.127244] ? exc_general_protection+0xe1/0x1f0
[ 173.127346] ? asm_exc_general_protection+0x27/0x30
[ 173.127452] ? __cfi_x86_acpi_suspend_lowlevel+0x10/0x10
[ 173.127567] ? get_fixed_ranges+0x5f/0x390
[ 173.127657] mtrr_save_fixed_ranges+0x1b/0x40
[ 173.127753] save_processor_state+0x111/0x220
[ 173.127849] do_suspend_lowlevel+0xf/0xb70
[ 173.127939] x86_acpi_suspend_lowlevel+0x14c/0x180
[ 173.128042] acpi_suspend_enter+0x17e/0x1e0
[ 173.128133] suspend_devices_and_enter+0x62d/0x950
[ 173.128236] pm_suspend+0x2cf/0x4c0
[ 173.128314] state_store+0x109/0x130
[ 173.128393] kobj_attr_store+0x1e/0x40
[ 173.128477] sysfs_kf_write+0x45/0x60
[ 173.128559] kernfs_fop_write_iter+0x113/0x1a0
[ 173.128698] vfs_write+0x38a/0x470
[ 173.128775] ksys_write+0x87/0x100
[ 173.128851] __x64_sys_write+0x1b/0x30
[ 173.128932] x64_sys_call+0x17f1/0x25e0
[ 173.129017] do_syscall_64+0x74/0x120
[ 173.129098] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 173.129206] RIP: 0033:0x7d6a19d82687
[ 173.129288] Code: 00 00 00 b8 00 00 00 00 0f 05 48 3d 01 f0 ff ff 72 09 f7 d8 89 c7 e8 e8 fa ff ff c3 0f0
[ 173.129661] RSP: 002b:00007d66c7a7f668 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
[ 173.129819] RAX: ffffffffffffffda RBX: 00007d68a8858450 RCX: 00007d6a19d82687
[ 173.129967] RDX: 0000000000000003 RSI: 00007d680881a2a0 RDI: 00000000000000a8
[ 173.130115] RBP: 00007d66c7a7f6e0 R08: ffffffffffffffff R09: 0000000000000000
[ 173.130262] R10: 0000000000020000 R11: 0000000000000213 R12: 0000000000000000
[ 173.130410] R13: 0000000070ec9fb8 R14: 00000000000000a8 R15: 00007d66c7a7f75c
[ 173.130559] </TASK>


