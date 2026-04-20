Return-Path: <stable+bounces-239267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDZdL/xQ5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A542F338
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34AE1336D68A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F252C15A9;
	Mon, 20 Apr 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI7W8t5/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51952C0298;
	Mon, 20 Apr 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697965; cv=none; b=ATomhtX5C+af0ZTUfh49mVszPygYYfnrUypXLhoZI8W6wZ4tXC2gkseQTOR5QAcE/nGu/gDJoYnTKf3volWoW44CEvrE/dyJVlV5nQs0mByidqeFyMzuiE8yNNSwhjQuEQZzTwEO9E+8d/sKTtc7n4i+79pmk6PvVFlttjUaN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697965; c=relaxed/simple;
	bh=AkblC8kko4q96b7WJ+PNC2zvLeLeNj9THfCDY3hArU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3izDaSdFSyCx30jyRFAMSDfKwWNAkZJeqsjFlMRKXtixK5mJFg//7jxcHt3k843SPy9xy4XgmM/XLA9hNAFsech9aIFB/Ph5YKVWzvNddqQQmvQXSXOPANWrTBOWZZgNi6+toII4EIl/c4WZKQ8NWQIjG3/tAj6LedWn8EfTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI7W8t5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D006C2BCB4;
	Mon, 20 Apr 2026 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697965;
	bh=AkblC8kko4q96b7WJ+PNC2zvLeLeNj9THfCDY3hArU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KI7W8t5/ljbsJM5Tc2oIgbBUVLkMg3SXyCjhscPwrECFw59NFmudoplIVD2+dGLGT
	 /6wkTTvcNyKsAtFe56JTM1Fwf1ntfRyk5dHtILh8aDNPHTiYBsoNfJFmzc0RR+EIUd
	 Q6NQTY4tu6aAi1nHP+wZ4/ZP01FyrUvZyEvGdEtznlxv3YcKF/dRfw/B4Oh+9iqj91
	 cSZv5l4fVjO/FZAvxo+cjuABOUEcn8WP1dCPr8Nl2i1s8T9vybTQK4/gGjNfzl0+5z
	 fd+a73D7/SaFCI3paj2KLhlYRwIgahSdcKapzBUAITpasQvHRGB98G3VOU1IQjpx23
	 9BhP+0IqF1KPw==
Date: Mon, 20 Apr 2026 16:12:38 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Huisong Li <lihuisong@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, pjaroszynski@nvidia.com,
	rmikey@meta.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: arm64: cpuidle: Tolerate platforms with no deep
 PSCI idle states
Message-ID: <20260420-sturdy-unique-shark-c4ca8c@sudeepholla>
References: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239267-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 409A542F338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:27:13AM -0700, Breno Leitao wrote:
> Commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
> acpi_processor_ffh_lpi_probe()") moved the acpi_processor_ffh_lpi_probe()
> call from acpi_processor_setup_cpuidle_dev(), where its return value was
> ignored, to acpi_processor_get_power_info(), where it is now treated as
> a hard failure. As a result, platforms where psci_acpi_cpu_init_idle()
> returned -ENODEV stopped registering any cpuidle states, forcing CPUs to
> busy-poll when idle.
> 
> On NVIDIA Grace (aarch64) systems with PSCIv1.1, pr->power.count is 1
> (only WFI, no deep PSCI states beyond it), so the previous
> "count = pr->power.count - 1; if (count <= 0) return -ENODEV;" check
> returned -ENODEV for all 72 CPUs and disabled cpuidle entirely.
> 
> The lpi_states count is already validated in acpi_processor_get_lpi_info(),
> so the check here is redundant. Simplify the loop to iterate over
> lpi_states[1..power.count). When only WFI is present, the loop body
> simply does not execute and the function returns 0, which is the correct
> outcome: there is nothing to validate for FFH and no error to report.
> 
> Suggested-by: Huisong Li <lihuisong@huawei.com>
> Cc: stable@vger.kernel.org
> Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/acpi/arm64/cpuidle.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
> index 801f9c4501425..c68a5db8ebba8 100644
> --- a/drivers/acpi/arm64/cpuidle.c
> +++ b/drivers/acpi/arm64/cpuidle.c
> @@ -16,7 +16,7 @@
>  
>  static int psci_acpi_cpu_init_idle(unsigned int cpu)
>  {
> -	int i, count;
> +	int i;
>  	struct acpi_lpi_state *lpi;
>  	struct acpi_processor *pr = per_cpu(processors, cpu);
>  
> @@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
>  	if (!psci_ops.cpu_suspend)
>  		return -EOPNOTSUPP;
>  
> -	count = pr->power.count - 1;
> -	if (count <= 0)
> -		return -ENODEV;
> -

Does it make sense to retain this check like
  if (pr->power.count < 1)
  	return -EINVAL;

Though I see the assignment to pr->power.count in drivers/acpi/processor_idle.c
is through unsigned int. So I am fine even without the above check.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep

