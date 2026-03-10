Return-Path: <stable+bounces-224593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB2ZB5mWsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:09:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24719258B7F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36DDD3023DB0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F273E8C44;
	Tue, 10 Mar 2026 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L00YXZHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC323CFF4F;
	Tue, 10 Mar 2026 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180562; cv=none; b=mwsvLCVY5tmgIWxaBNf//QDM/3Z/VaFIiSEvCQ/9K6ogT2K6wS7VcBOW8FsLLO9o/2PCyX+FV0PHZlKNHnAj0vzVvioJz9QPxtlU88hjHlaIW6jy1ZWht7N5tyqGB6Iz7Wko8NLju43abYig63AuA8uDb9r5ziS/wV/QEFmuVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180562; c=relaxed/simple;
	bh=W80lkFXkPyxzZPzLe6vTEN0SYi+yr5xZNTGscVmS0ko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PyfdK/Me9Qp1k01OJg5UPVhyxHoGxUQudxatPJlCBUfUow3aRdj5nnFfV4XqzqSvfaHcFr44aHuJDWoTdm9djNq20etf2gQz6TdOjKbIwlKOARqa91xkj9ou0v6GiCpTVy0ScxaIFiibB7RcmNZS02Z8ExyIsSgk976/TJXUwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L00YXZHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F86C19423;
	Tue, 10 Mar 2026 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773180561;
	bh=W80lkFXkPyxzZPzLe6vTEN0SYi+yr5xZNTGscVmS0ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L00YXZHPMVeEfxwGWu/AsurKr2xWM9c1K5M3MtDaIn5nfcen4jicy1Q3i8rLIm5yf
	 WfvG20wIi1QYyAKqVzaODlOcIZAjN1oBjLxF9C/amXt1SGV5lxTwZfkpQvXdvW9gAg
	 U5fgwzShrDb/Z15j0gztxNaymw4OC6qlveBz2cGZnyhROtlLohCqWPm8uXMsbT9F27
	 CbZuzIyVxmIfJ98YaFyJMcT3cZFIirNKa3bxELZvJJRpc3CFl/8aYvCTYeWpkA6BN0
	 oBTJJOco6wPHguHYPtf3q7EkbWZ3hux+WxUaIr/01eGtMcm8Pr8xqHRXg8MC7nxSZp
	 RRiGt6sycGkpg==
Date: Tue, 10 Mar 2026 17:09:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Chengwen Feng <fengchengwen@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Kees Cook <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Huth <thuth@redhat.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Zheyun Shen <szy0127@sjtu.edu.cn>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Xin Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	James Clark <james.clark@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
	linux-perf-users@vger.kernel.org, stable@vger.kernel.org,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v5 2/2] PCI/TPH: Fix get cpu steer-tag fail on ARM64
 platform
Message-ID: <20260310220920.GA826995@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657142d1-1632-4a3e-8800-ee1dd5763d78@arm.com>
X-Rspamd-Queue-Id: 24719258B7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224593-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[63];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:58:49AM -0500, Jeremy Linton wrote:
> On 3/9/26 10:20 PM, Chengwen Feng wrote:
> > pcie_tph_get_cpu_st() is broken on ARM64:
> > 1. pcie_tph_get_cpu_st() passes cpu_uid to the PCI ACPI DSM method.
> >     cpu_uid should be the ACPI Processor UID [1].
> > 2. In BNXT, pcie_tph_get_cpu_st() is passed a cpu_uid obtained via
> >     cpumask_first(irq->cpu_mask) - the logical CPU ID of a CPU core,
> >     generated and managed by kernel (e.g., [0,255] for a system  with 256
> >     logical CPU cores).
> > 3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
> >     MADT table, and this UID may not match the kernel's logical CPU ID.
> >     When this occurs, the mismatch results in the wrong CPU steer-tag.
> > 4. On AMD x86 the logical CPU ID is identical to the ACPI Processor UID
> >     so the mismatch is not seen.

> >   int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
> > -			unsigned int cpu_uid, u16 *tag)
> > +			unsigned int cpu, u16 *tag)
> >   {
> >   #ifdef CONFIG_ACPI
> > +	u32 cpu_uid = acpi_get_cpu_acpi_id(cpu);

From AI review (gemini/gemini-3.1-pro-preview):

  Does this code need to validate that `cpu` is within bounds before
  using it?  Before this change, the `cpu_uid` parameter was passed
  opaquely to the ACPI firmware via `tph_invoke_dsm()`, which would
  gracefully handle invalid values.

  Now, `cpu` is treated as a logical CPU index and passed to
  `acpi_get_cpu_acpi_id(cpu)`. On architectures like arm64 and riscv,
  `acpi_get_cpu_acpi_id()` uses `cpu` directly as an array index
  (`&cpu_madt_gicc[cpu]` and `&cpu_madt_rintc[cpu]`). On x86, it uses
  `per_cpu(x86_cpu_to_acpiid, cpu)`.

  If a caller passes an out-of-bounds `cpu` index (for example, if an
  IRQ affinity mask is empty and `cpumask_first()` returns
  `nr_cpu_ids`, or if userspace passes an arbitrary ID via
  `mlx5_st_alloc_index()`), this will result in an out-of-bounds
  memory read.

  Consider adding a bounds check:

    if (cpu >= nr_cpu_ids)
      return -EINVAL;

I agree that this is an issue, and I think implementations of
acpi_get_cpu_acpi_id() should validate their inputs.

I don't know if there's a value that can never be a valid ACPI CPU UID
and could be used as an error value from acpi_get_cpu_acpi_id().  I do
see a few mentions of a ~0 value meaning "all processors" (ACPI r6.6,
sec 5.2.12.13).  

