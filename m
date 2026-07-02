Return-Path: <stable+bounces-270293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oSHAHla0RWq2EAsAu9opvQ
	(envelope-from <stable+bounces-270293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:44:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA76F2AC4
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:44:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I+T9TE6I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270293-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270293-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CBA3156CB0
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8025C6EE;
	Thu,  2 Jul 2026 00:39:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331F24886A;
	Thu,  2 Jul 2026 00:38:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952742; cv=none; b=TuAZAzXl0TiX7Scvp0O2cylkTH/pulggHEN4gDtQB4Px+N7Z+uHarBFsx5hp4lIhOCvtzBkx3PLNRj/UkPsOp8Jjo+RRdWoVACgHM0WurvIF8eF0HBFDkiG0vn2bHfXBSn3ZrH0Kp4ReMOERd15qnocqoQs9x7xUs7Zb9XYcQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952742; c=relaxed/simple;
	bh=nZsZ6XvuWipjd3it5v+4uGw4kgpw5Nl0/STBJ7hjN5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv9+3i/WU3fZ9uSMCFZ/DE9uiLTJ666oXg1vUEmYcD/Zv3ZCDmsqbW12wWylVj843PAwmgKu+R69dyhDILswojH1H+aBlWLpYLD123oQgv1bgzRCGWX82UaCFOjiK7KforFI1cbdtwnHqTwMn4RWQnGlXqah0BoULI2aCUxU5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+T9TE6I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A201F00A3D;
	Thu,  2 Jul 2026 00:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952737;
	bh=x/bV7HFJfyzdDuCkRNOH8v9crT+EEgxWSV7YC4KCAEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I+T9TE6IKQMVZ23EwjzOMPhKU5WB11Mf0ZUziYjAMvScUBjSgCrryM/Q7/+5ZEsGU
	 JaWcV1yNnoirmY3Lki0oT0X2/nhBuvfQut3AVlpP9b2XQSGKFDu7evEzVybOq1NxER
	 l9F9qwvsNHEIwm502MmF3K5zwIB+BrD3CidN+Lf6m48iygncVcY+nMT3TwdUxfP0vQ
	 oMaNjJ6py51gq/pKdpLjdjFRjjiwjGP3QfYHOAzbgKjttYOZnAHlBs0RC7kNkwXqj8
	 gna7W84b38/usd98eoK3uHHKu9a/0Hb9d6XCyqOS3Wm8rymZgQAnGK5G1srrIaresj
	 TrSxmGkpxiSFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
Date: Wed,  1 Jul 2026 20:38:35 -0400
Message-ID: <stable-reply-arm64-vhe-66-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701204342.2654385-1-coltonlewis@google.com>
References: <20260701204342.2654385-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:oliver.upton@linux.dev,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mizhang@google.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:coltonlewis@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270293-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2DA76F2AC4

> This series backports VHE CPU boot fixes to the 6.6.y stable branch.
>
> These fixes are already present in the 6.12.y stable branch (and
> newer), but are missing in 6.6.y. They are required to enable booting
> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

Ugh, yes, the sha1s don't make sense.

While respinning, please also consider whether upstream 3855a7b91d42
("KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()") should
join the series.

-- 
Thanks,
Sasha

