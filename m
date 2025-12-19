Return-Path: <stable+bounces-203106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18123CD0E39
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B58530636F1
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56211284674;
	Fri, 19 Dec 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="FhMe46pm";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="fzhnqClj"
X-Original-To: stable@vger.kernel.org
Received: from mail137-31.atl71.mandrillapp.com (mail137-31.atl71.mandrillapp.com [198.2.137.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4522D780
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.137.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161929; cv=none; b=dky3+PdtZctcgdwqdJIT8OLBQ5gaRe0IASeSbgIEBpbBBvJhy/TSU/UqnaSniOAS0cjyGEKeZLxrN8sFypcRCw34UNsX8jQcMGMLq+xba4o6MxHzqyZrzicDFKWiYBF1k8Zxum07TXsUZW2urx0di2YCAdmPJR15t0lAQ00hbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161929; c=relaxed/simple;
	bh=HHnbxlNe0vk74Y9p/lrQVTe2XtI0XUjzNBbVLkGBTzs=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=akLYjg0WfV+gSNC4NTFnJGG/WbnPfvnGg7Y0kW8HaRQujjos10KOQvTR0D2KJ7ORiLVDFOmTsJe7lCePOYq1RtQZu4LJS3/b8Tji95KVj5kGtkWGfTFKZ7ZFLM0o1lx28njFURTJqsvOx1b5p214FbniIoFCl+YlIF9X9hJbK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=FhMe46pm; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=fzhnqClj; arc=none smtp.client-ip=198.2.137.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1766161924; x=1766431924;
	bh=OvdSDejbcaHbbKQCG9MCRtVqRVp7XVW/Zcf/5kBSYys=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=FhMe46pmpX66MZ07xPFxJv8TX57iJejMscgBg2O1PvzwbnhpIeQNXOe333PWmAdsN
	 r36wjTkkGb1G7R7HmAtu0MCosVD4UKOdNTKUUM//h0CaUYVM4eIoGsYnbQAn7+8mZT
	 OV2VPwtFvpeJAsORjAVgkLQ5mz/n2yK2TPEOW72c+ErVtreK0IC3MOtaX5TYXT2P65
	 G4mVoZz37ZBZt2Fltcad7wSaQbxPjrLJJXNiqjhFjaxrGsEYRpVOv8OpjFAIddHyNU
	 dBhdaD5AxFbVX2kVz4d8Wt7tszgD49BOCstvnuWZfh2mgmRzQKecCCPEQwFf4nl5Zp
	 7wGsiSbQ329Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1766161924; x=1766422424; i=teddy.astie@vates.tech;
	bh=OvdSDejbcaHbbKQCG9MCRtVqRVp7XVW/Zcf/5kBSYys=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=fzhnqCljjECFxU61YjaEi6jlKQhi17QtR7I9jxfW6vFbs1Yzef2F5e4CmewtcNAY0
	 MzDQVCkB4+o6jDnsmVBT6vNxJ8e+FRTHlH28xe0A8p0AjLp/3hVVPleDEhOOG8GLTq
	 GYWKeUv10YafhFfgSB+PE6qIuera82ThY0RXV6d4545amvqW4z+mIV6n3Uja/WwCvK
	 JMpRKwhbmbrIdWhfGd62xG+rgzQtDhlcEGCX+4T9cqYrHRJnrMY24ewKyDnEVXx3g7
	 jv+n8Yr0EaOzJ1005uviU7RFQOVZsoyUHG7bwXRZz/EGfPACP58eADAjAObQlfelGQ
	 efBqDjTDQvJSg==
Received: from pmta07.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail137-31.atl71.mandrillapp.com (Mailchimp) with ESMTP id 4dXtNN1scpz7lmRjH
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 16:32:04 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20x86/CPU/AMD:=20avoid=20printing=20reset=20reasons=20on=20Xen=20domU?=
Received: from [37.26.189.201] by mandrillapp.com id 6a0fd5e84f3a498cad5b04333eb3bc98; Fri, 19 Dec 2025 16:32:04 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1766161922383
Message-Id: <dbe68678-0bc4-483f-aef3-e4c7462bcaff@vates.tech>
To: "Ariadne Conill" <ariadne@ariadne.space>, linux-kernel@vger.kernel.org
Cc: mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com, kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com, peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, xen-devel@lists.xenproject.org, stable@vger.kernel.org
References: <20251219010131.12659-1-ariadne@ariadne.space>
In-Reply-To: <20251219010131.12659-1-ariadne@ariadne.space>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.6a0fd5e84f3a498cad5b04333eb3bc98?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20251219:md
Date: Fri, 19 Dec 2025 16:32:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 19/12/2025 =C3=A0 02:04, Ariadne Conill a =C3=A9crit=C2=A0:
> Xen domU cannot access the given MMIO address for security reasons,
> resulting in a failed hypercall in ioremap() due to permissions.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> Cc: xen-devel@lists.xenproject.org
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/kernel/cpu/amd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index a6f88ca1a6b4..99308fba4d7d 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -29,6 +29,8 @@
>   # include <asm/mmconfig.h>
>   #endif
>   
> +#include <xen/xen.h>
> +
>   #include "cpu.h"
>   
>   u16 invlpgb_count_max __ro_after_init =3D 1;
> @@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(void)
>   =09if (!cpu_feature_enabled(X86_FEATURE_ZEN))
>   =09=09return 0;
>   
> +=09/* Xen PV domU cannot access hardware directly, so bail for domU case=
 */
> +=09if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain())
> +=09=09return 0;
> +
>   =09addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value)=
);
>   =09if (!addr)
>   =09=09return 0;

Such MMIO only has a meaning in a physical machine, but the feature 
check is bogus as being on Zen arch is not enough for ensuring this.

I think this also translates in most hypervisors with odd reset codes 
being reported; without being specific to Xen PV (Zen CPU is 
unfortunately not enough to ensuring such MMIO exists).

Aside that, attempting unexpected MMIO in a SEV-ES/SNP guest can cause 
weird problems since they may not handled MMIO-NAE and could lead the 
hypervisor to crash the guest instead (unexpected NPF).

Teddy


--
Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



