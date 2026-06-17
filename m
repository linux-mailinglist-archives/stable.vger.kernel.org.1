Return-Path: <stable+bounces-266730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BZZJlCMMmqO1wUAu9opvQ
	(envelope-from <stable+bounces-266730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10834699676
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U3tjBblE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266730-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266730-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 396F5302DF9C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDE3EEAD3;
	Wed, 17 Jun 2026 11:51:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DE312836;
	Wed, 17 Jun 2026 11:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697064; cv=none; b=YmjMQtNcCbVdU4+iQXSE9tk9sPy3ww6ibchRBBj3eJ90ZiRP7gdtDPHz+4FiWgK6lcuxk20NtkeYaB5vCeXEkNAp2rUojOIUmrxXD3u8Yg0G5UTuc2f7mEXW379I8qj2egiDpC/zyxk+xr6zfU9SMuu1r8P+zW+veOhgDoVIxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697064; c=relaxed/simple;
	bh=QDoKguxzKFFuGIB6v5JbRH4r3pRjA8d7GLIQh8BwtXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw/3qzKssVbc+2rrYU3TZyPwEP6HlkflcH6opojMumQTkXrQ2jImUJw6Mrr8/AhUNQXlp/WB47C3UgCLxmj8OcagtryFpp+3c5UrPffKdom1Kd5xGx756c4FVrYYB69MvBl+NC2z/813T2Sa0oZK6pi9uDFqh/R9eN/wtkI7Jrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3tjBblE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653B1F00A3A;
	Wed, 17 Jun 2026 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697063;
	bh=AIlauNyUqgAYjMoNz0VK8efi2k8dTc5G2grZpTKqCsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3tjBblEtEBWrJMZtXOZq2OKEyXK/6nMUJ/HsDpmrAT3InSdygNgat510MjCwYweH
	 Hu5qY6RVDKvygbfvZDQ7EWKlg9V0RJzCkaHjOZxK1a2itOTGAFGwSHWoWp7kVL5OAf
	 8V5/ce2v17iUBkFRMKR8av+iwvMnMWZ7qGknnh8lvQbNPCfwVW1+yFP4y7wblXYwfL
	 VI1MLJbp1+XagZNvrSh0sNZQr8lf/hsBh0Wht7rq4HR8YnH//kKph31ouOvnJaHqZq
	 sbhTLFWldaDco2W4ra4kwcUp0+42iuJk/oXZ3ZSWUWLLAI6CTTHjUEnombFvaro9jr
	 1mGWzPcvNMKgQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wZonN-0000000DfJ8-0vg7;
	Wed, 17 Jun 2026 11:51:01 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Xuanqing Shi <shixuanqing.11@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
Date: Wed, 17 Jun 2026 12:50:49 +0100
Message-ID: <178169701881.3049015.16397230325847247864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617040820.2194831-2-bestswngs@gmail.com>
References: <20260617040820.2194831-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@kernel.org, catalin.marinas@arm.com, will@kernel.org, bestswngs@gmail.com, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, kuba@kernel.org, akpm@linux-foundation.org, hverkuil+cisco@kernel.org, mark.rutland@arm.com, kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, wangzhong.c0ss4ck@bytedance.com, shixuanqing.11@bytedance.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266730-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oupton@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:bestswngs@gmail.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:kuba@kernel.org,m:akpm@linux-foundation.org,m:hverkuil+cisco@kernel.org,m:mark.rutland@arm.com,m:kristina.martsenko@arm.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:wangzhong.c0ss4ck@bytedance.com,m:shixuanqing.11@bytedance.com,m:stable@vger.kernel.org,m:hverkuil@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,arm.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maz@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10834699676

On Wed, 17 Jun 2026 12:08:21 +0800, Weiming Shi wrote:
> kvm_hyp_handle_mops() resets the single-step state machine as part of
> rewinding state for a MOPS exception by modifying vcpu_cpsr() and
> writing the result directly into hardware.
> 
> In the case of nested virtualization, vcpu_cpsr() is a synthetic value
> such that the rest of KVM can deal with vEL2 cleanly. That means the
> value requires translation before being written into hardware, which is
> unfortunately missing from the MOPS handler.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
      commit: ff1022c3de46753eb7eba2f6efd990569e66ff95

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



