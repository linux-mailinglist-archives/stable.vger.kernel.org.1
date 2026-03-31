Return-Path: <stable+bounces-231608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMl6Bbb3y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4AB36CCA8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D1743080147
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90726426681;
	Tue, 31 Mar 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IvUx8uFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C67423A9F;
	Tue, 31 Mar 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974610; cv=none; b=dwTrYk/eEjWi1FJYnQachg+07U4Yt0NhqO4rN8Xo9JY7IBbz/6g9yxwsGsjXarQt2vXxO2ZVeAPFmXt5VqYoAh1jjHP2J2aER2RdDMuSsieMXh0hjMZFUVnLru0Niou4hwmJvxY8Tae8R4SctGH5aoRk7zgXJ4+N4T3jYGgnW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974610; c=relaxed/simple;
	bh=ueSIGnWsYw3KYqrCU2V2SeNjCE9dgvfrlc5p2oTE+lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su1CBCshiOAQ33K5JROU/vCQ7VZtxgErXop3zgFUqHJTfsJ4BHVadmFkQ1XEGwCWfnKQr2/10jqjFbbUHx+0IrzsL6nzCRzQCwGxAW34VWFXTSIP4OTIZrfblcrW8c2LFsb11sfQpPo0CWlVaMFRc3V5Z8qlNA5KQxgGIypY9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IvUx8uFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83FEC2BCB2;
	Tue, 31 Mar 2026 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974610;
	bh=ueSIGnWsYw3KYqrCU2V2SeNjCE9dgvfrlc5p2oTE+lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvUx8uFsZYDAWwPDehgWF39fO8Kmsu0c4Scon6IshEl5ouftx3lWzi23Zz9/ctHWt
	 fnJTFoRr+i7NG2+KRC9ujGfOHrYod5sHjy7QWNigdSjXr1Bp56hBpn7oMrQunq6p0o
	 mYYt3Vm5goT9i1ivfSgL+N1SgWrw0k5lzUlbnG8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.6 109/175] KVM: arm64: Discard PC update state on vcpu reset
Date: Tue, 31 Mar 2026 18:21:33 +0200
Message-ID: <20260331161733.784204046@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231608-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: BE4AB36CCA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit 1744a6ef48b9a48f017e3e1a0d05de0a6978396e upstream.

Our vcpu reset suffers from a particularly interesting flaw, as it
does not correctly deal with state that will have an effect on the
execution flow out of reset.

Take the following completely random example, never seen in the wild
and that never resulted in a couple of sleepless nights: /s

- vcpu-A issues a PSCI_CPU_OFF using the SMC conduit

- SMC being a trapped instruction (as opposed to HVC which is always
  normally executed), we annotate the vcpu as needing to skip the
  next instruction, which is the SMC itself

- vcpu-A is now safely off

- vcpu-B issues a PSCI_CPU_ON for vcpu-A, providing a starting PC

- vcpu-A gets reset, get the new PC, and is sent on its merry way

- right at the point of entering the guest, we notice that a PC
  increment is pending (remember the earlier SMC?)

- vcpu-A skips its first instruction...

What could possibly go wrong?

Well, I'm glad you asked. For pKVM as a NV guest, that first instruction
is extremely significant, as it indicates whether the CPU is booting
or resuming. Having skipped that instruction, nothing makes any sense
anymore, and CPU hotplugging fails.

This is all caused by the decoupling of PC update from the handling
of an exception that triggers such update, making it non-obvious
what affects what when.

Fix this train wreck by discarding all the PC-affecting state on
vcpu reset.

Fixes: f5e30680616ab ("KVM: arm64: Move __adjust_pc out of line")
Cc: stable@vger.kernel.org
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Link: https://patch.msgid.link/20260312140850.822968-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/reset.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -293,6 +293,20 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu
 			kvm_vcpu_set_be(vcpu);
 
 		*vcpu_pc(vcpu) = target_pc;
+
+		/*
+		 * We may come from a state where either a PC update was
+		 * pending (SMC call resulting in PC being increpented to
+		 * skip the SMC) or a pending exception. Make sure we get
+		 * rid of all that, as this cannot be valid out of reset.
+		 *
+		 * Note that clearing the exception mask also clears PC
+		 * updates, but that's an implementation detail, and we
+		 * really want to make it explicit.
+		 */
+		vcpu_clear_flag(vcpu, PENDING_EXCEPTION);
+		vcpu_clear_flag(vcpu, EXCEPT_MASK);
+		vcpu_clear_flag(vcpu, INCREMENT_PC);
 		vcpu_set_reg(vcpu, 0, reset_state.r0);
 	}
 



