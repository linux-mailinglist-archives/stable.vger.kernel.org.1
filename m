Return-Path: <stable+bounces-232753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNslLjT2zGl9YQYAu9opvQ
	(envelope-from <stable+bounces-232753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:40:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC55378A12
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E921F30B7F6F
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8ED3F20E7;
	Wed,  1 Apr 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOvVH7mN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59E3F1667;
	Wed,  1 Apr 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039792; cv=none; b=EANQBTDIjcs5gQGV+/baDUXQJ47bakH+p6lHwJK3YvnvzF7MEO/lGmRIM6XTaA3Rcvb6PE7bIKPXi4pWYMYLkNOWr1pPRRCT4kfybFKlfEaVbnOFmZOAzM1PE7fElKvMWix4K5dA4OUoDgF7/XT7lgxVQg6paysEIbJN58N3L1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039792; c=relaxed/simple;
	bh=xtvnTDSUGx89lzG8mtjye1LfgZ1vl+5viyWjfbbqRxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsXtt/7OC38ojK6yG/5KfERLeiiri5gBBCT6pRs8i2MX0ZHfm/RVLQPHZNPHVXQscon5vuXTY1p3j5lQJLq5vxZ+FTRiwnKDeSETy7aiUkHJ/E1JeapvB7rLIYyHg/YHR5I0P5hbp1F6S1+HwAeCwmzTClwT9uAnLiuxf7Awl0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOvVH7mN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAD9C2BCB5;
	Wed,  1 Apr 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775039792;
	bh=xtvnTDSUGx89lzG8mtjye1LfgZ1vl+5viyWjfbbqRxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOvVH7mNXfyBK1Q8QeaW5W/W0DB7uVts37OEPb/rfAHs3J84QiqIgcGlnhJXcPN7B
	 ITMelKySZ3WU3k2pnEXTeq797KcUj6nckJh2VKtCP2fePC04AXbk9AIaVE/6oPQFc/
	 oxQGdDWfxwKOhDiipi5+QOC1zBcM1IcroUGgAGbb1TW5UrfnKacXcjxW0oUIUmtuht
	 /EGvJl2zcY+38M/xqqpBUriRd0GSKUcdXaSkGoyd7abHx4OMw3zh3wJVceB1eo8ZUh
	 Vz3qOBInMOd4mN0/YDtAHBAmqdQxCK7loKSN2a0KTJXw5t3ItFrQ5GbXxAID1EFESP
	 QVdkjVLE24bcw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1w7sw2-00000007oRQ-1HXS;
	Wed, 01 Apr 2026 10:36:30 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 05/16] KVM: arm64: Account for RESx bits in __compute_fgt()
Date: Wed,  1 Apr 2026 11:36:00 +0100
Message-ID: <20260401103611.357092-6-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401103611.357092-1-maz@kernel.org>
References: <20260401103611.357092-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, sascha.bischoff@arm.com, broonie@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 2EC55378A12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When computing Fine Grained Traps, it is preferable to account for
the reserved bits. The HW will most probably ignore them, unless the
bits have been repurposed to do something else.

Use caution, and fold our view of the reserved bits in,

Reviewed-by: Sascha Bischoff <sascha.bischoff@arm.com>
Fixes: c259d763e6b09 ("KVM: arm64: Account for RES1 bits in DECLARE_FEAT_MAP() and co")
Link: https://sashiko.dev/#/patchset/20260319154937.3619520-1-sascha.bischoff%40arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index e14685343191b..f35b8dddd7c1f 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1663,8 +1663,8 @@ static __always_inline void __compute_fgt(struct kvm_vcpu *vcpu, enum vcpu_sysre
 		clear |= ~nested & m->nmask;
 	}
 
-	val |= set;
-	val &= ~clear;
+	val |= set | m->res1;
+	val &= ~(clear | m->res0);
 	*vcpu_fgt(vcpu, reg) = val;
 }
 
-- 
2.47.3


