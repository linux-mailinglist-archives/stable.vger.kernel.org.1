Return-Path: <stable+bounces-241334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKVlI+xo72l3BAEAu9opvQ
	(envelope-from <stable+bounces-241334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:47:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AAF473B61
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E880C302B50A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1A3CF690;
	Mon, 27 Apr 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ACj7EZ6x"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E813CD8D8;
	Mon, 27 Apr 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297474; cv=none; b=N9SshOj1dt04lh0ERExSKXM3bpVyvxq/tgAO5OYMTM+lq36PRIyHybdLrUwmkDPhv5H77+52gJfQl9dYOkxrSTv4fi2o2S5W+zbHVOsHhjsshcYYrADO7yBNQHTiFcT1c0F2Cc1WVGMFpsd91w7ds8jrvimCyHhbdSDKNG0LFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297474; c=relaxed/simple;
	bh=Px/W/Ya2SR7lP2+gVdyjKWhgWqDhPeYV/Ic2w6HMEeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVpnJHp1JbAy7lT50DFcX4SFhGpAtPrXA4+7Fa3jYEUZE3lrKSR7ajWyggJZ98tBExRP0EsmPbQJ0QGKdHH5npwEOs3otrMj7LmL70txcze6UCup1x79JSayV4zDbw9LVcEub7hinx3jIaCdLoNs8X+87KoELKO79PrzdrA75XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ACj7EZ6x; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA1A1684;
	Mon, 27 Apr 2026 06:44:23 -0700 (PDT)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110773F763;
	Mon, 27 Apr 2026 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777297468; bh=Px/W/Ya2SR7lP2+gVdyjKWhgWqDhPeYV/Ic2w6HMEeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACj7EZ6xUTVoXpW8tnBi3R3snDJlEy+3KZmtG/9Wl9R+21vW7Uw0AZHFgRINaOlCM
	 7DsKo5KWBHKjcDPED2EljkY/Vjt1iJRtmC4/V/Ov1Ee0KI3tSqvTrZTNKNv42KYi/y
	 CyOHEaCImUHAGG31urirAnZnsSCzfATmJBzTGlNQ=
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Huisong Li <lihuisong@huawei.com>,
	Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pjaroszynski@nvidia.com,
	rmikey@meta.com,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: arm64: cpuidle: Tolerate platforms with no deep PSCI idle states
Date: Mon, 27 Apr 2026 14:44:21 +0100
Message-ID: <177729716542.3579760.5742318124586748645.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
References: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05AAF473B61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-241334-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 20 Apr 2026 02:27:13 -0700, Breno Leitao wrote:
> Commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
> acpi_processor_ffh_lpi_probe()") moved the acpi_processor_ffh_lpi_probe()
> call from acpi_processor_setup_cpuidle_dev(), where its return value was
> ignored, to acpi_processor_get_power_info(), where it is now treated as
> a hard failure. As a result, platforms where psci_acpi_cpu_init_idle()
> returned -ENODEV stopped registering any cpuidle states, forcing CPUs to
> busy-poll when idle.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI: arm64: cpuidle: Tolerate platforms with no deep PSCI idle states
      https://git.kernel.org/arm64/c/3ea4415015d6

