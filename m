Return-Path: <stable+bounces-223927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA5GCHL8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:11:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 992EF24A0D1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EADA30E8ACB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0F2D24B7;
	Tue, 10 Mar 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW39Z8L8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF776248F73;
	Tue, 10 Mar 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141062; cv=none; b=eAZIhFGENRdPEpD9klu6vuM6f0onekD/vACi4mNv5wqU28X/MQJt8HocIV/BKmUVPC21s23FG1A7fsfHOnE4A9FgFqYsrY4iUf/+LM+RdCqXDcF/WHMzYU52W1dyPAEVkjw4/WnqsOVab3zNBVETUJMZ16U6OuZbRlQKADoM/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141062; c=relaxed/simple;
	bh=AsxKRBUPSd5PSGCaNl27JzIJm+DCnXWK4rQr8azqblM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSs3e10SyVQrX/UrvfvDznJP74qBXVBPRf0Pv3j7ZryvJB7/R7+n+7pcZ/VcuB+M+SDEwUPBnI3PMcYUhArkgfHusOdz0gW7N3RiMYgjpBUmYiyOQeUId+dnh6gO005G2XQMlzAME0fIu23l4faeDB+8xuzG0XnOCLB6yxVdLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW39Z8L8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98447C19423;
	Tue, 10 Mar 2026 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141062;
	bh=AsxKRBUPSd5PSGCaNl27JzIJm+DCnXWK4rQr8azqblM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NW39Z8L82jkSQEK+0tERG3vWdbjd3DZ04lTrU6e1HQEIEro7xv4I5oRnO0CKLt0zh
	 kjdHseQgU8w657bJdchPVTUY/msJ6HfK2LiJ2olWacLSGp7FfqUtLDO50l9YGSsFrf
	 M+Sp1UXCotGN5meU60bbXlsfIOYEzGLHzicLvhpQ6/klkjxKnGF2c9mvbzjyAmuaQJ
	 vpDypkhLL+p31eTXAzj1lEbhWLyMEEmqhc9D09V6t2Lmm0PrbWeoFKQbJPdI9PCOBm
	 aAJvPS+AxmSXjIHgDIag4aINfXAaNNeZa/AHW+9rf3mJlTSI4lwgd/MZGXOKj8AEyW
	 DFRd0wUUYAY6g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Nikita Dubrovskii <nikita@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 062/311] s390/kexec: Disable stack protector in s390_reset_system()
Date: Tue, 10 Mar 2026 07:01:49 -0400
Message-ID: <f17efea50b4215485d685d7fddd74d1a7cb8f2b2.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 992EF24A0D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223927-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 1623a554c68f352c17d0a358bc62580dc187f06b ]

s390_reset_system() calls set_prefix(0), which switches back to the
absolute lowcore. At that point the stack protector canary no longer
matches the canary from the lowcore the function was entered with, so
the stack check fails.

Mark s390_reset_system() __no_stack_protector. This is safe here since
its callers (__do_machine_kdump() and __do_machine_kexec()) are
effectively no-return and fall back to disabled_wait() on failure.

Fixes: f5730d44e05e ("s390: Add stackprotector support")
Reported-by: Nikita Dubrovskii <nikita@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index dcdc7e2748486..049c557c452ff 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2377,7 +2377,7 @@ void __init setup_ipl(void)
 	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 }
 
-void s390_reset_system(void)
+void __no_stack_protector s390_reset_system(void)
 {
 	/* Disable prefixing */
 	set_prefix(0);
-- 
2.51.0


