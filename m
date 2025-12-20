Return-Path: <stable+bounces-203127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D4CD253A
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 02:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBEF530022C0
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57ED2BDC29;
	Sat, 20 Dec 2025 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="PBEvis+G";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="E8a+b70X"
X-Original-To: stable@vger.kernel.org
Received: from mail179-28.suw41.mandrillapp.com (mail179-28.suw41.mandrillapp.com [198.2.179.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE832299954
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.179.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766195066; cv=none; b=j18ykkVSswnk+Guibi83ToSgGbJx8CY0dmj4+Nw5RcEc2rbri8qZaoZucbK6chcKnmlM7zEowFq6O4II3EnZlFHj+/OLRNssmU8wnG9DktgMOLV0KFUD78VnwlBFJIPcGFqUzalmLlGp/HAJOg49pVNYezfo/fPMXdU6J8G6zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766195066; c=relaxed/simple;
	bh=m8fJVJvAQ94HmpdCjouS2lRkYZp2iue4NfrF50uyccc=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=uzXVQtQEt700ORJQdLwmdoLkLhOVpa8kRZGaEqQ2cJFF78mfeGmaU+uHMgr7VFkFunt2XLBbUEV8LIEwJ+/e3Mstn+qp8H6zM5wYNmHXLhpqjFJ9FPEcxUCODs6dO4l3A4honbtqWupGWBSfDdtXVY/fYHgeq3MRFuuxuZWxgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=PBEvis+G; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=E8a+b70X; arc=none smtp.client-ip=198.2.179.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1766195063; x=1766465063;
	bh=LZATy/epkYlb1ti/O9p96Bjn8vhz+ABv2T1O/KGgVBI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=PBEvis+G9OAicqGlNopG/X2a4PL53btrB3FUPQjY/nf3cBtRtZx6Lr55CaXDZw28R
	 yoQ36Q28eb51fyPaPAReFwwDe8acirSn8Ckw5td6GGbmGyKv4ptjdMJeHQVSH5OyIm
	 KMf3EMOh6Yo9fm3M+e7iVqvej2gX2lp8C9/PqFivoWPtF5o/yPb146atj3wxyXQPUz
	 eql+iXryXw9TvZXNPNJ82vOo8NCZ2HnclHh4em0tEpS8HdiYIuF24ubmLQZEJwp1C2
	 x+3P2J1NgeVHLGMnU3kIl5CA0zldFuEeRW+oi3+5gqIBgY05tbDdY6hqbojVFSIsjO
	 Jz8SRAzyePswA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1766195063; x=1766455563; i=teddy.astie@vates.tech;
	bh=LZATy/epkYlb1ti/O9p96Bjn8vhz+ABv2T1O/KGgVBI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=E8a+b70XjtXUheN3RW3dbEPw4uUHBUSXt79sTliHF0cncRljPRnHMQTBhDRZ72nQp
	 yXMlrlX2o3mMtYXZs2zPZ9cq8oOAURnaAonaJ7haJUzHE2NLGScyTSjcSFvVGv1Z8/
	 Kv2hTchsXc3luweGn+n57wdBY2jEzhYPO3FNuoqfl/puUJtjWmRKGib+9JosygRR5I
	 42Jb9wJm8OsNtUWKtUREuuMdZ1L9eu8S7UEMoD3zNpT6sGmLZfeMkCRFvNaTwziuAc
	 ENrgmkLaCIA3zmxq3zLNuxuQ8dcMbAXseFOntUs4Iv2kYB0xqBaD7yaKtUI+VaLHOu
	 hCm4p9BMkIwLw==
Received: from pmta12.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail179-28.suw41.mandrillapp.com (Mailchimp) with ESMTP id 4dY6dg4JDPzMQxY3K
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:44:23 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20x86/CPU/AMD:=20avoid=20printing=20reset=20reasons=20on=20Xen=20domU?=
Received: from [37.26.189.201] by mandrillapp.com id 6dd1e9bb41644c8e8a6b61aa595e72a4; Sat, 20 Dec 2025 01:44:23 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1766195061283
Message-Id: <190f226a-a92f-4dab-ad7a-f7ea22e6a976@vates.tech>
To: "Sean Christopherson" <seanjc@google.com>
Cc: "Ariadne Conill" <ariadne@ariadne.space>, linux-kernel@vger.kernel.org, mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com, kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com, peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, xen-devel@lists.xenproject.org, stable@vger.kernel.org
References: <20251219010131.12659-1-ariadne@ariadne.space> <dbe68678-0bc4-483f-aef3-e4c7462bcaff@vates.tech> <aUWNlTAmbSTXsBDE@google.com>
In-Reply-To: <aUWNlTAmbSTXsBDE@google.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.6dd1e9bb41644c8e8a6b61aa595e72a4?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20251220:md
Date: Sat, 20 Dec 2025 01:44:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 19/12/2025 =C3=A0 18:40, Sean Christopherson a =C3=A9crit=C2=A0:
> On Fri, Dec 19, 2025, Teddy Astie wrote:
>> Le 19/12/2025 =C3=A0 02:04, Ariadne Conill a =C3=A9crit=C2=A0:
>>> Xen domU cannot access the given MMIO address for security reasons,
>>> resulting in a failed hypercall in ioremap() due to permissions.
>>>
>>> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset"=
)
>>> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
>>> Cc: xen-devel@lists.xenproject.org
>>> Cc: stable@vger.kernel.org
>>> ---
>>>    arch/x86/kernel/cpu/amd.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>>> index a6f88ca1a6b4..99308fba4d7d 100644
>>> --- a/arch/x86/kernel/cpu/amd.c
>>> +++ b/arch/x86/kernel/cpu/amd.c
>>> @@ -29,6 +29,8 @@
>>>    # include <asm/mmconfig.h>
>>>    #endif
>>>
>>> +#include <xen/xen.h>
>>> +
>>>    #include "cpu.h"
>>>
>>>    u16 invlpgb_count_max __ro_after_init =3D 1;
>>> @@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(voi=
d)
>>>    =09if (!cpu_feature_enabled(X86_FEATURE_ZEN))
>>>    =09=09return 0;
>>>
>>> +=09/* Xen PV domU cannot access hardware directly, so bail for domU ca=
se */
>>> +=09if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain()=
)
>>> +=09=09return 0;
>>> +
>>>    =09addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(val=
ue));
>>>    =09if (!addr)
>>>    =09=09return 0;
>>
>> Such MMIO only has a meaning in a physical machine, but the feature
>> check is bogus as being on Zen arch is not enough for ensuring this.
>>
>> I think this also translates in most hypervisors with odd reset codes
>> being reported; without being specific to Xen PV (Zen CPU is
>> unfortunately not enough to ensuring such MMIO exists).
>>
>> Aside that, attempting unexpected MMIO in a SEV-ES/SNP guest can cause
>> weird problems since they may not handled MMIO-NAE and could lead the
>> hypervisor to crash the guest instead (unexpected NPF).
> 
> IMO, terminating an SEV-ES+ guest because it accesses an unknown MMIO ran=
ge is
> unequivocally a hypervisor bug. 

Terminating may be a bit excessive, but the hypervisor can respond #GP 
to either unexpected MMIO-NAE and NPF-AE if it doesn't know how to deal 
with this MMIO/NPF (xAPIC has a similar behavior when it is disabled).

> The right behavior there is to configure a reserved NPT entry
> to reflect the access into the guest as a #VC.

I'm not sure this is the best approach, that would allow the guest to 
trick the hypervisor into making a unbounded amount of reserved entries.

Teddy


--
Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



