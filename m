Return-Path: <stable+bounces-217675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIT2ND1Em2ljxQMAu9opvQ
	(envelope-from <stable+bounces-217675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 19:00:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406A216FFE4
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 19:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81399300F526
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF93587D7;
	Sun, 22 Feb 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4apLAmbw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DF18787A
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771783190; cv=pass; b=uY9YBZcEQb0tiexU3mcfhiKrKc93rSO3qPVXPqFouSVixiVIZCSMJ8j11h/xuihR8LXo9cftV8mMmtRj4+EY0mGKk7Lush5hZuJQ70OOIwOQ/G1T8e8tbSjntj3K1lJM80rus1mdiMGfct4zEt9/oBglTDb6Y7z9Vvnkfiz+xUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771783190; c=relaxed/simple;
	bh=eKuRo72pi3QcR/TAbX6JrQsIwy/ci3OUBS1cUlynznM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDACZfCZfFOOKlCdBONeNKWgAilNekNgqM00NB3Z11O+jEUg3OergSXm/Ls1R8LFmj7h38vU6a7aoimihS6oAQt73EpXqwuvpP5xdTNHkMpg9d4cV2DHkxfr0vlv98j6qLkPesxoPWbngRPYnBQMOSNL2B+Z4ZZYBm1ogxHot6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4apLAmbw; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a355aedfso595411cf.0
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 09:59:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771783188; cv=none;
        d=google.com; s=arc-20240605;
        b=ZyNoRybAedAF6kZe3ge/k0WtyU9TbrS9BTfjt0+SvawHSN1lamZ/R87QatXDiJdsm1
         aCj0Sv6N9jKIm2sIbW62ehW8fXNsE4a6iZodqkJiYEJgLS5FOmxFek20IGjg3NNF/LJD
         6CY7xVeMxU1CW9SfqkT7KLEZYZax2lpAVFP5PbaNqUH3f6cg5yiwKLSlewsrXl8uD67n
         WMF5jgrimBhGPHcH/srrMB+dIHXlTGZHCrT1qBAm1tZNgNAhk84FGtMaZlVskrLYT870
         NeWCVtcd7irSd6dk7btTDiDukeaD+Z/hUTvgUGXZJhMjN3QWrKzeum/DT66+PnWQ3MtR
         mjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pQ/DTelLQW8X8WLIzdKUZ9IVFS1QEQ7S0xRLul8dB6U=;
        fh=oVHs6VSs0CnfPgL6/tpE/Bxcwa/eIJpe5pIYz+svw8A=;
        b=NNQMCeC5ARIRVd/oWfai9krlCKlgWQalY2M9CWnh0C6uFwSZzW/vN6V3qrmmXec/af
         UppfKNgg1JG/lpEk+Ecvln2MpmgQYYXg/NtiyB3eAQzDXC0z7E37ndRkjgeDmVPEx6V7
         pSbv09FeDKeqd+F80tJVjhejrOx6zDOuNbpLJ11le14nZARW2ZE3LnHvolQd0BpQPiVM
         G/pp1uAvsfu8EaM/tL998/sb9OW3Y+O6rfQE78a9DRqqIvfVUwqzY1XNQ9aQEy3gFapF
         Hd0lyMdLUJxYavHmJqvSCDY/U6CqGXbbqa8ikS6CVJZJ3nfs0RHwR6rTe5uvwcHjGfIH
         Rj9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771783188; x=1772387988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ/DTelLQW8X8WLIzdKUZ9IVFS1QEQ7S0xRLul8dB6U=;
        b=4apLAmbwUxRD3+G7RgF3PwHl8p4yDeCav0Szwqclkmr/d8zgJHldok2/Oo38jsRgsF
         +OYzwTHmxlBpG79dLpvGnEENVE3CbOA5HNHcTWSOjb+zSsYXNvXjiDELxpXxz4WFX2St
         YMmRzZPgTxXbBmjmBtiFmRRq7/y10vOdmPm/J1erBh6yu6ovVIoyziX5lAMOSHXtC2WA
         y5e5Mhp7tfMJcJw3mGyKOTYZ2K3z5uq3J4MobpCXfhUwsKWmvxOCt0cGMM18gKAMJZi9
         ftIqMq2uQN8RV4RaIFhvK7XCrwENm4eExG8dgOv+c1NEPRkYanivHyrqKBgrO+zOB+kO
         9KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771783188; x=1772387988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ/DTelLQW8X8WLIzdKUZ9IVFS1QEQ7S0xRLul8dB6U=;
        b=L75DVroLeWvZCmEnyX3FlmlkWoCdc6JETFAUFRo6+tXpwdKC1lh48/L7xaSjgjq5FQ
         5fH6bD311be6LvTlOrvnoifiRLv426g/CSoLfQ9frY91xtW5CfpfRYfUrX/U9dhvlkcQ
         ppwXpC6LqM+RiV6QJaWHv0F0kXt+Cl6XaS2SE82uELcN4xQNyxNWKJaFpOkEYEAqTpcg
         kCPSExvuRFO/W67yI3o51t9MiZl5Em3dobN3p7VVid5s9ZsWn5KP6A0ptLGo5GJMlOQT
         UrAvlDcs6TS48H1I9lmFP0m1TNZPYVCRS684t5jGFe2VzNwh7iHirtrYXnM5ycIjZSNu
         f4ug==
X-Forwarded-Encrypted: i=1; AJvYcCWCGL8AOvRH3I6Pb8N2C6yHtVkZJTsocC1lXRpXWsvg7K33ndPqQKih03F/Z9TCjxxBperI0P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmt26cSip6xDtXNkzcYbGSqhBnTFo3EZjC5/66N0Ln6ZyhSmyM
	jncHShLpUeznW3I6z4eqLur2kmnyK4IzKZ4qzpEhipnKm98yyM2PVUX+GwongEkQIW8XQrMC3RR
	WXrJ85URJWCPNezqIwLvI9wnBuEdWEnci4TI9bbGz
X-Gm-Gg: AZuq6aItx1zlIu3obUJKI5d3YkHA1cLCD2G8D/vmW6gJt29jzoWe4ftVwiWNbTzI8NF
	A2Rvsqj7bsJzd0SgV/dhdMhn+f0l91VXeLJttA1G+g1JIEmXCSAU7kD2a3bZDIyDi6BpZBU/lSa
	zIGZTVR3MIaU3sEcd8vxa1z0CnunRLfD0kelvNRyMUwz4WZM9AU1VyjQJEDAvMQxlfDWp5u0Elj
	fZ8W6OnlKH5fEglu5BCNWz3MNTvltTRkcX5AMWgO5LkVNY0werg0UHdrm1m1/NBfgUiyK/OOQk4
	OSOOjUgm
X-Received: by 2002:a05:622a:1451:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-5070e8c5755mr13358721cf.13.1771783188028; Sun, 22 Feb 2026
 09:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222141000.3084258-1-maz@kernel.org>
In-Reply-To: <20260222141000.3084258-1-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Feb 2026 17:58:00 +0000
X-Gm-Features: AaiRm50zqZjqoVrNG72cEBICJ3I1cXMK2s6jm__GSaPoqNDpAt8k3N-biQWzjiE
Message-ID: <CA+EHjTy4p-Mbfr86NR9n1LgHC0EWrkdVjYb8O3z7k=Lv1entQg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Fix protected mode handling of pages larger
 than 4kB
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217675-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 406A216FFE4
X-Rspamd-Action: no action

Hi Marc,

On Sun, 22 Feb 2026 at 14:10, Marc Zyngier <maz@kernel.org> wrote:
>
> Since 3669ddd8fa8b5 ("KVM: arm64: Add a range to pkvm_mappings"),
> pKVM tracks the memory that has been mapped into a guest in a
> side data structure. Crucially, it uses it to find out whether
> a page has already been mapped, and therefore refuses to map it
> twice. So far, so good.
>
> However, this very patch completely breaks non-4kB page support,
> with guests being unable to boot. The most obvious symptom is that
> we take the same fault repeatedly, and not making forward progress.
> A quick investigation shows that this is because of the above
> rejection code.
>
> As it turns out, there are multiple issues at play:
>
> - while the HPFAR_EL2 register gives you the faulting IPA minus
>   the bottom 12 bits, it will still give you the extra bits that
>   are part of the page offset for anything larger than 4kB,
>   even for a level-3 mapping

Matches the ARM ARM.

> - pkvm_kvm_pgtable_stage2_map() assumes that the address passed
>   as a parameter is aligned to the size of the intended mapping

nit: pkvm_kvm_pgtable_stage2_map() -> kvm_pgtable_stage2_map()

> - the faulting address is only aligned for a non-page mapping
>
> When the planets are suitably aligned (pun intended), the guest
> faults a page by accessing it past the bottom 4kB, and extra bits
> get set in the HPFAR_EL2 register. If this results in a page mapping
> (which is likely with large granule sizes), nothing aligns it further
> down, and pkvm_mapping_iter_first() finds an intersection that
> doesn't really exist. We assume this is a spurious fault and return
> -EAGAIN. And again.
>
> This doesn't hit outside of the protected code, as the page table
> code always aligns the IPA down to a page boundary, hiding the issue
> for everyone else.
>
> Fix it by always forcing the alignment on vma_pagesize, irrespective
> of the value of vma_pagesize.
>
> Fixes: 3669ddd8fa8b5 ("KVM: arm64: Add a range to pkvm_mappings")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/mmu.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 8c5d259810b2f..aa587f2e28264 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1753,14 +1753,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         }
>
>         /*
> -        * Both the canonical IPA and fault IPA must be hugepage-aligned to
> -        * ensure we find the right PFN and lay down the mapping in the right
> -        * place.
> +        * Both the canonical IPA and fault IPA must be aligned to the
> +        * mapping size to ensure we find the right PFN and lay down the
> +        * mapping in the right place.
>          */
> -       if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE) {
> -               fault_ipa &= ~(vma_pagesize - 1);
> -               ipa &= ~(vma_pagesize - 1);
> -       }
> +       fault_ipa &= ~(vma_pagesize - 1);
> +       ipa &= ~(vma_pagesize - 1);

nit: Since we're changing this code anyway, should we use the ALIGN
macros instead?

Reviewed-by: Fuad Tabba <tabba@google.com>

and using 4, 16, and 64KB pages:

Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
>         gfn = ipa >> PAGE_SHIFT;
>         mte_allowed = kvm_vma_mte_allowed(vma);
> --
> 2.47.3
>

