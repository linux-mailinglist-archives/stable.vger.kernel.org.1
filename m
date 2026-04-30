Return-Path: <stable+bounces-241982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ40LMDM8mmWuQEAu9opvQ
	(envelope-from <stable+bounces-241982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:30:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DD49CE3B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FD89303172E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46626365A19;
	Thu, 30 Apr 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtcaGla8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C2365A17;
	Thu, 30 Apr 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519562; cv=none; b=f2/YD3tV3szmGxdiKZ4ExIZs3XA0YgZ0DJmqoJ8HCv/xGj8e7sA3+CLYC4VWWuQ4nQkRgCU/3eeJdtiS/+IGYhIWddI19c0feJH+0HkVQk91aptVpASCTVIiu2pXEa6BOuUxFjAAx5BN+AASbwIft01q7v6rd0RDAT36j1tLUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519562; c=relaxed/simple;
	bh=S8ESDWn2FV212MQ0O36a6N64V74CpKEgoDR0Cwb1eYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fNsbJXlU3243pmZBd2iBGql3vQ7Enw+DO2r35YjNj1wR66kFqcbAcYW4g7aM4fsYxI84v153/NL1M0FX+CS/aqsY7mEfOpfizRmFiWDA8XIH1JPQJ09FCpabOps3OgCEm148DC9K8ZdExvxjkOPnuYjbbRwawx6FCDCJZO+6KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtcaGla8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C6C2BCB8;
	Thu, 30 Apr 2026 03:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519561;
	bh=S8ESDWn2FV212MQ0O36a6N64V74CpKEgoDR0Cwb1eYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RtcaGla8SJMvzp565cZWG4JA/pd6x2rokqKWLW76DsXVVSBMWfvO7M+j3tfPr4WiS
	 iYIi3LmvsvftG5YY+oM7g4PvJ9jMSl95DFA2LT7Ri+Y57wvJYObh7grdN4/wFxy9Bp
	 3dNPBrE0VUHIF5qHqtQDM1L3bZLqpe75efGu9RIosM9YKInDL4ti/opEBCchGSV7Ed
	 NJ0t/2yQEWiWU4UX0J1SMMnzWayyrY3pGrDTZxRSaZcqhSakDi4GgjEzwKf7uPPJCg
	 fYiHoJFVnaikAgVqNlokz3BThqsRnYRJYWEnZONwh0eeFUJrF4d3CMi6aMhGsxyQjO
	 srXFfj2h9HOug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F1A3809A07;
	Thu, 30 Apr 2026 03:25:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v10 0/8] ACPI: Unify CPU UID interface and fix
 ARM64
 TPH steer-tag issue
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751951654.2274119.17258357457134506240.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:16 +0000
References: <20260401081640.26875-1-fengchengwen@huawei.com>
In-Reply-To: <20260401081640.26875-1-fengchengwen@huawei.com>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: linux-riscv@lists.infradead.org, bhelgaas@google.com,
 catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
 mark.rutland@arm.com, x86@kernel.org, liuyonglong@huawei.com,
 anshuman.khandual@arm.com, linux-doc@vger.kernel.org, kees@kernel.org,
 linux-pci@vger.kernel.org, dave.hansen@linux.intel.com,
 Eric.VanTassell@amd.com, somnath.kotur@broadcom.com, kai.huang@intel.com,
 kevinloughlin@google.com, punit.agrawal@oss.qualcomm.com, hpa@zytor.com,
 ilkka@os.amperecomputing.com, kernel@xen0n.name, thorsten.blum@linux.dev,
 linux-acpi@vger.kernel.org, corbet@lwn.net, masahiroy@kernel.org,
 si.yanteng@linux.dev, peterz@infradead.org,
 pawan.kumar.gupta@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, szy0127@sjtu.edu.cn, lenb@kernel.org,
 thomas.lendacky@amd.com, thuth@redhat.com, ryan.roberts@arm.com,
 darwi@linutronix.de, make24@iscas.ac.cn, suzuki.poulose@arm.com,
 james.clark@linaro.org, wei.huang2@amd.com, bwicaksono@nvidia.com,
 loongarch@lists.linux.dev, jonathan.cameron@huawei.com,
 sohil.mehta@intel.com, boris.ostrovsky@oracle.com, xin@zytor.com,
 andrew.gospodarek@broadcom.com, wanghuiqiang@huawei.com, jgross@suse.com,
 wangyuquan1236@phytium.com.cn, seanjc@google.com, guohanjun@huawei.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-perf-users@vger.kernel.org, wangzhou1@hisilicon.com, tglx@kernel.org,
 heinrich.schuchardt@canonical.com, chenl311@chinatelecom.cn,
 robin.murphy@arm.com
X-Rspamd-Queue-Id: AA2DD49CE3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-241982-lists,stable=lfdr.de,linux-riscv];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[61];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]

Hello:

This series was applied to riscv/linux.git (fixes)
by Rafael J. Wysocki <rafael.j.wysocki@intel.com>:

On Wed, 1 Apr 2026 16:16:32 +0800 you wrote:
> This patchset unifies ACPI Processor UID retrieval across
> arm64/loongarch/riscv/x86 via acpi_get_cpu_uid() (with input validation)
> and fixes ARM64 CPU steer-tag retrieval failure in PCI/TPH:
> 
> 1-4: Add acpi_get_cpu_uid() for arm64/loongarch/riscv/x86 (update
>      respective users)
> 5: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
> 6: Clean up perf/arm_cspmu
> 7: Clean up ACPI/PPTT and remove unused get_acpi_id_for_cpu()
> 8: Pass ACPI Processor UID to Cache Locality _DSM
> 
> [...]

Here is the summary with links:
  - [RESEND,v10,1/8] arm64: acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
    https://git.kernel.org/riscv/c/7cd5f5659ac8
  - [RESEND,v10,2/8] LoongArch: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
    https://git.kernel.org/riscv/c/d78ef9d2e1f2
  - [RESEND,v10,3/8] RISC-V: ACPI: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
    https://git.kernel.org/riscv/c/0c8231994e43
  - [RESEND,v10,4/8] x86/acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
    https://git.kernel.org/riscv/c/3cfe889f8965
  - [RESEND,v10,5/8] ACPI: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
    https://git.kernel.org/riscv/c/f652d0a4e13c
  - [RESEND,v10,6/8] perf: arm_cspmu: Switch to acpi_get_cpu_uid() from get_acpi_id_for_cpu()
    https://git.kernel.org/riscv/c/1ab03189793f
  - [RESEND,v10,7/8] ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
    https://git.kernel.org/riscv/c/a7034e9e4491
  - [RESEND,v10,8/8] PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM
    https://git.kernel.org/riscv/c/abdd2a86535b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



