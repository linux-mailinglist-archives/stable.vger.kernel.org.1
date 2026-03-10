Return-Path: <stable+bounces-224185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPIIFsEAsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:30:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92124AD64
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E5E31B2CEC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A838945D;
	Tue, 10 Mar 2026 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIGJeyJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628238757B;
	Tue, 10 Mar 2026 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141641; cv=none; b=ADTc7PRqJ1UfP2b7ej54kg7F4Pe8ioFM3Co/Rbk2pS1Shtooatnd4JGFFaUt7ZFAssy7bkgHsyqcB3qgxNbVZdjVyh3qVkCSYllImCwttZwNwFGzZpoA4SjHQGEQTsrnkbvGNkieFTfuIrNPpf3i8WJRl307SAvO0sClDlJNDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141641; c=relaxed/simple;
	bh=Ef0XUYcs3hPauCEzNSc6II6zQVnnJTN18Qfu/ET8wy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp7ni1P+S0xBVgaZn+754137/bXm+K8uB2HEZXNGcK0ydRHM5VO84la6XkoDM0uY/iQaYlqkJDTdl00UEmoNEri4Fbdezpzk28xl/fwSsk/gULzmBIW9dGugFa5y5GyMlNM8HJJAoHtBXMGa3Hm3O4qJEpZ8lHJb0+WkjR8YSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIGJeyJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80802C2BC9E;
	Tue, 10 Mar 2026 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141641;
	bh=Ef0XUYcs3hPauCEzNSc6II6zQVnnJTN18Qfu/ET8wy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIGJeyJTQc9qIP9PXyU5Mjzwh1Fd6hGbqZW9AyAZgh8przM9X1NlKroFvb1hGGNgH
	 3BYo+bP54uJbtIZV1Op6xiGncaBxu0NhSbPeMPtNT3gnjlErrhubWBX9TRI5KHuXUr
	 5RMJvvedt8+TRql6SzjG5XnF5bWYkT+chZ4ygbZ4Ps5RnjQz8OzdMMuePy+QZB90AB
	 qouOfvvAdlw6r3czozRTmHJcrZm4xNsU7DQXU1daaUQuJPextC4iLuktO4s1ZlSyzA
	 I0k/ffQpSIuVu+UJxJVLpyzKI0pveMR1QgMm6/R3Y4z3YhuktIDCbQIgpB20w8yDPo
	 bI6S7tPLDhmeQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Fuad Tabba <tabba@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 006/314] KVM: arm64: Hide S1POE from guests when not supported by the host
Date: Tue, 10 Mar 2026 07:14:25 -0400
Message-ID: <c694fd7e8b71832ba4f7742994ee2e2236ff633e.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F92124AD64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224185-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Fuad Tabba <tabba@google.com>

[ Upstream commit f66857bafd4f151c5cc6856e47be2e12c1721e43 ]

When CONFIG_ARM64_POE is disabled, KVM does not save/restore POR_EL1.
However, ID_AA64MMFR3_EL1 sanitisation currently exposes the feature to
guests whenever the hardware supports it, ignoring the host kernel
configuration.

If a guest detects this feature and attempts to use it, the host will
fail to context-switch POR_EL1, potentially leading to state corruption.

Fix this by masking ID_AA64MMFR3_EL1.S1POE in the sanitised system
registers, preventing KVM from advertising the feature when the host
does not support it (i.e. system_supports_poe() is false).

Fixes: 70ed7238297f ("KVM: arm64: Sanitise ID_AA64MMFR3_EL1")
Signed-off-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260213143815.1732675-2-tabba@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ec3fbe0b8d525..7b7f3c932dcd5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1801,6 +1801,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		       ID_AA64MMFR3_EL1_SCTLRX |
 		       ID_AA64MMFR3_EL1_S1POE |
 		       ID_AA64MMFR3_EL1_S1PIE;
+
+		if (!system_supports_poe())
+			val &= ~ID_AA64MMFR3_EL1_S1POE;
 		break;
 	case SYS_ID_MMFR4_EL1:
 		val &= ~ID_MMFR4_EL1_CCIDX;
-- 
2.51.0


