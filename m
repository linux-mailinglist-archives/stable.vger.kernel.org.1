Return-Path: <stable+bounces-65528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E294A27F
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 10:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1742813DD
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B71C7B94;
	Wed,  7 Aug 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="nBZZfm1l"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2D1C462C;
	Wed,  7 Aug 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018531; cv=none; b=udqYITkh2U87bC1zEIgjKIe7Xdf2cXYsLl4OdRcwrm3CCW6u3PGLQgHnoyAdyupc6IDn61xWDjr53J9WIn0P8arX37DPfOoxy6aWTSROy9w0We7YzBblzf4uibfWe4hNp1KnmwuYk8GvtpgOTzvOS4Ln5Z7tjkhw0xVkpHEUaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018531; c=relaxed/simple;
	bh=3HLdx6Qq52bAig9I2YiswJ7XZVgwdbcq5D3gxl27GIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIljhEHtyAtrGVNPU/6iU+koFzeeqXKKZCXefPIfid4UkagrZdewLYqoh8nLPE9kYjvbuLhPOysLyutmNWCMYBbH2N+QOMQKMCWXuuFfUXI6ByhlTM7l0cJQTyLppGa9sxTywMlqBriV2YxoEFu5iCoPGnnytSa3gIGVGf91oKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=nBZZfm1l; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zWyab3dKHon1ao5B2EKivYVWOxCs/6+X0YTUXB+UsrA=; t=1723018529;
	x=1723450529; b=nBZZfm1l/ZWt3KUXY7a0v+hT9UvIyJ8iY1f+RTMY3ABiV6UEWvejYLkywKY1r
	+a9eDDCtgeN4UFWi0pM/n7lOp8gKZR2Q7vPGCZB6hXAuyDE4p00995Tzn0T5+H/eKrsWp5kwamRI0
	CcPmCsRnMOJCn7/DtWS3oMVtN3upeQ77njKxeU/B09A89EcwB/jN0BDkpuH0M9VYb4HAqoPZ6rluk
	M8dlKQeXJ54C1SgVb+yy7pPliJAgOUefiuCrCqMgO5h31pbtlJHQj6jiTwCyrlG+k5KMu+HQ3Easw
	2Ga1r7P4fcF9E+JAooejvUoT72xR8ASkgXGkCBIneacBUChpRg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sbbpN-000766-Ja; Wed, 07 Aug 2024 10:15:25 +0200
Message-ID: <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
Date: Wed, 7 Aug 2024 10:15:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
To: Thomas Lindroth <thomas.lindroth@gmail.com>
Cc: stable@vger.kernel.org, tony.luck@intel.com,
 Greg KH <gregkh@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723018529;aa70abe7;
X-HE-SMSGID: 1sbbpN-000766-Ja

[CCing the x86 folks, Greg, and the regressions list]

Hi, Thorsten here, the Linux kernel's regression tracker.

On 30.07.24 18:41, Thomas Lindroth wrote:
> I upgraded from kernel 6.1.94 to 6.1.99 on one of my machines and
> noticed that
> the dmesg line "Incomplete global flushes, disabling PCID" had
> disappeared from
> the log.

Thomas, thx for the report. FWIW, mainline developers like the x86 folks
or Tony are free to focus on mainline and leave stable/longterm series
to other people -- some nevertheless help out regularly or occasionally.
So with a bit of luck this mail will make one of them care enough to
provide a 6.1 version of what you afaics called the "existing fix" in
mainline (2eda374e883ad2 ("x86/mm: Switch to new Intel CPU model
defines") [v6.10-rc1]) that seems to be missing in 6.1.y. But if not I
suspect it might be up to you to prepare and submit a 6.1.y variant of
that fix, as you seem to care and are able to test the patch.

Ciao, Thorsten

> That message comes from commit c26b9e193172f48cd0ccc64285337106fb8aa804,
> which
> disables PCID support on some broken hardware in arch/x86/mm/init.c:
> 
> #define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,     \
>                              .family  = 6,                     \
>                              .model = _model,                  \
>                            }
> /*
>  * INVLPG may not properly flush Global entries
>  * on these CPUs when PCIDs are enabled.
>  */
> static const struct x86_cpu_id invlpg_miss_ids[] = {
>        INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
>        INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
>        INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
>        INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
>        INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
>        INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
>        {}
> 
> ...
> 
> if (x86_match_cpu(invlpg_miss_ids)) {
>         pr_info("Incomplete global flushes, disabling PCID");
>         setup_clear_cpu_cap(X86_FEATURE_PCID);
>         return;
> }
> 
> arch/x86/mm/init.c, which has that code, hasn't changed in 6.1.94 ->
> 6.1.99.
> However I found a commit changing how x86_match_cpu() behaves in 6.1.96:
> 
> commit 8ab1361b2eae44077fef4adea16228d44ffb860c
> Author: Tony Luck <tony.luck@intel.com>
> Date:   Mon May 20 15:45:33 2024 -0700
> 
>     x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL
> 
> I suspect this broke the PCID disabling code in arch/x86/mm/init.c.
> The commit message says:
> 
> "Add a new flags field to struct x86_cpu_id that has a bit set to
> indicate that
> this entry in the array is valid. Update X86_MATCH*() macros to set that
> bit.
> Change the end-marker check in x86_match_cpu() to just check the flags
> field
> for this bit."
> 
> But the PCID disabling code in 6.1.99 does not make use of the
> X86_MATCH*() macros; instead, it defines a new INTEL_MATCH() macro
> without the
> X86_CPU_ID_FLAG_ENTRY_VALID flag.
> 
> I looked in upstream git and found an existing fix:
> commit 2eda374e883ad297bd9fe575a16c1dc850346075
> Author: Tony Luck <tony.luck@intel.com>
> Date:   Wed Apr 24 11:15:18 2024 -0700
> 
>     x86/mm: Switch to new Intel CPU model defines
> 
>     New CPU #defines encode vendor and family as well as model.
> 
>     [ dhansen: vertically align 0's in invlpg_miss_ids[] ]
> 
>     Signed-off-by: Tony Luck <tony.luck@intel.com>
>     Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Link:
> https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..6b43b6480354 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -261,21 +261,17 @@ static void __init probe_page_size_mask(void)
>         }
>  }
>  
> -#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,     \
> -                             .family  = 6,                     \
> -                             .model = _model,                  \
> -                           }
>  /*
>   * INVLPG may not properly flush Global entries
>   * on these CPUs when PCIDs are enabled.
>   */
>  static const struct x86_cpu_id invlpg_miss_ids[] = {
> -       INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
> -       INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> -       INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
> -       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
> -       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> -       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE,      0),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
> +       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE,     0),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
>         {}
>  };
> 
> The fix removed the custom INTEL_MATCH macro and uses the X86_MATCH*()
> macros
> with X86_CPU_ID_FLAG_ENTRY_VALID. This fixed commit was never backported
> to 6.1,
> so it looks like a stable series regression due to a missing backport.
> 
> If I apply the fix patch on 6.1.99, the PCID disabling code activates
> again.
> I had to change all the INTEL_* definitions to the old definitions to
> make it
> build:
> 
>  static const struct x86_cpu_id invlpg_miss_ids[] = {
> -       INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
> -       INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> -       INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
> -       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
> -       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> -       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> +       X86_MATCH_VFM(INTEL_FAM6_ALDERLAKE,    0),
> +       X86_MATCH_VFM(INTEL_FAM6_ALDERLAKE_L,  0),
> +       X86_MATCH_VFM(INTEL_FAM6_ALDERLAKE_N,  0),
> +       X86_MATCH_VFM(INTEL_FAM6_RAPTORLAKE,   0),
> +       X86_MATCH_VFM(INTEL_FAM6_RAPTORLAKE_P, 0),
> +       X86_MATCH_VFM(INTEL_FAM6_RAPTORLAKE_S, 0),
>         {}
>  };
> 
> I only looked at the code in arch/x86/mm/init.c, so there may be other
> uses of
> x86_match_cpu() in the kernel that are also broken in 6.1.99.
> This email is meant as a bug report, not a pull request. Someone else
> should
> confirm the problem and submit the appropriate fix.

P.S.:

#regzbot ^introduced 8ab1361b2eae44
#regzbot title x86:  Possible missing backport of x86_match_cpu() change
#regzbot ignore-activity

