Return-Path: <stable+bounces-221435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFs5E5WVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD171CA89F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08CAF302D599
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E55274B28;
	Sun,  1 Mar 2026 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGaZ8hVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9713C8F0
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328258; cv=none; b=fe9nTV7yhKc5ABSMoBXAWlM1jV7YF04bbdlNFnk4R5buxfvryh+5IVa9AGlIq/S1sVgS8dQz638br76H3HU/Cmr/e45A/vf+XlpzAFSc0JqkZba3KX6TzPm1yYA3P2pkaRtw4v0C5hEqu92xzU+b72K9YlmjEjlz8W87tX4M9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328258; c=relaxed/simple;
	bh=sSC7oe0HeCpeKh8oQAfJfXfKX/UoFXz5ALZDNb2y0x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruBUHOU9Ex4v0Ox7ioiZMoojgfBjoFY/wHXuuq3GfA7vkP6lVSbIX84jeDKeeqCb9bG/CHT3tbw6LzmWoB8B0C7+908sdmqc3HNTXOxAim0owEPPw8Gto1qanovnFWIbAzrn+fGAmjUVyPfrgyrJWVzIsAz8P2Ue5154ooIhnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGaZ8hVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D141FC19421;
	Sun,  1 Mar 2026 01:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328258;
	bh=sSC7oe0HeCpeKh8oQAfJfXfKX/UoFXz5ALZDNb2y0x8=;
	h=From:To:Cc:Subject:Date:From;
	b=pGaZ8hVY5Cdw49b/i4m4G5xHU/5Dz5wW7nDZWlI0MJ5KPNLS6J4vI/hzJr0ItzXmx
	 DfaI4rwqoYOFNEgu3Z17Is5SLQynzK7cs79+pzUXr1Vl2PI9H2IjzigOLqvCqnuVKP
	 duqQ4unDAkF5zC1v2b9Uc3Zd2aDhbHaID/UTinxkd7TpeQvMcD3fVHmSXoJaSncD6r
	 mJinNha67HH3q2TZqwB6vRkDK+L9fvtj2wS5YbUEsGyz7v4l/M9DPFQU+pRX1mD+c1
	 eYw2KkS697UZcg2DyVIH8N3OBqAc520GsaaBCF+gjbqRRiby+f+70/v1UKqYWO5pBi
	 jB7NqtL+yvSHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	joey.gouly@arm.com
Cc: David Spickett <david.spickett@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "arm64: poe: fix stale POR_EL0 values for ptrace" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:16 -0500
Message-ID: <20260301012416.1681087-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221435-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: BCD171CA89F
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1f3b950492db411e6c30ee0076b61ef2694c100a Mon Sep 17 00:00:00 2001
From: Joey Gouly <joey.gouly@arm.com>
Date: Tue, 27 Jan 2026 13:39:26 +0000
Subject: [PATCH] arm64: poe: fix stale POR_EL0 values for ptrace

If a process wrote to POR_EL0 and then crashed before a context switch
happened, the coredump would contain an incorrect value for POR_EL0.

The value read in poe_get() would be a stale value left in thread.por_el0.  Fix
this by reading the value from the system register, if the target thread is the
current thread.

This matches what gcs/fpsimd do.

Fixes: 175198199262 ("arm64/ptrace: add support for FEAT_POE")
Reported-by: David Spickett <david.spickett@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b9bdd83fbbca0..8a14b86cd066c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1486,6 +1486,9 @@ static int poe_get(struct task_struct *target,
 	if (!system_supports_poe())
 		return -EINVAL;
 
+	if (target == current)
+		current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+
 	return membuf_write(&to, &target->thread.por_el0,
 			    sizeof(target->thread.por_el0));
 }
-- 
2.51.0





