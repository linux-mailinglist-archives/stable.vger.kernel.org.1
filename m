Return-Path: <stable+bounces-234556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPgaLCKh1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544E3C1312
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F16630A9FFF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA23624B0;
	Wed,  8 Apr 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvVekiKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974032A3FD;
	Wed,  8 Apr 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673165; cv=none; b=NXpvpdObEuEB9+X/0UwTFCHMabGC4TuLPxSd9Ti0h0Lmr5vjLaEmFzDRBPu8qcd/fStFuObCKc/HPyktpHZ87krH2A+fWB2RojwIoTdAR+ukID2zxD7BcP6MlbApgEv2FUc4dt/SrW/1GwWJ3aZnchwxboayrJtYFbWaAxhJZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673165; c=relaxed/simple;
	bh=QZBQDN6pkmPHEq3Jew9SiPk1WbWYaoEy2t1Imo33GDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqJKphpLzre2J6dyJhgkYLrtz7IL0vXvVNI4vdPrvbIpzkqm4ZZYpKcxqWw5iNmTA3spaZmrwet3+pOkdomZLixxyPyi1hmF3GTlHUrB543a/JFjDr4egyGxlh0YLh72YJvimYY8oddp5Sgdj3Gv+qUHcRshZODrdfltx3fBg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvVekiKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C6C19421;
	Wed,  8 Apr 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673165;
	bh=QZBQDN6pkmPHEq3Jew9SiPk1WbWYaoEy2t1Imo33GDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yvVekiKxQvtjdSlGVbxmGdjowYP9kdhT+l0j62QGQ9TDlvvJeK2073vmzp7WNWRR2
	 OR91GBY7BdGyeBiNQbV4LeRBn3gkdERintdZGkBzdnLptMpQPqRFgY42xgpp9FvZZ6
	 GA+GlQWcic1zMntirGj7fGEtqfBTd0TJInooLMF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zishun Yi <vulab@iscas.ac.cn>,
	Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 127/277] riscv: Reset pmm when PR_TAGGED_ADDR_ENABLE is not set
Date: Wed,  8 Apr 2026 20:01:52 +0200
Message-ID: <20260408175938.618299137@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234556-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,sifive.com:email]
X-Rspamd-Queue-Id: 1544E3C1312
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zishun Yi <vulab@iscas.ac.cn>

[ Upstream commit 3033b2b1e3949274f33a140e2a97571b5a307298 ]

In set_tagged_addr_ctrl(), when PR_TAGGED_ADDR_ENABLE is not set, pmlen
is correctly set to 0, but it forgets to reset pmm. This results in the
CPU pmm state not corresponding to the software pmlen state.

Fix this by resetting pmm along with pmlen.

Fixes: 2e1743085887 ("riscv: Add support for the tagged address ABI")
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://patch.msgid.link/20260322160022.21908-1-vulab@iscas.ac.cn
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 31a392993cb45..b5188dc74727d 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -324,8 +324,10 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	if (arg & PR_TAGGED_ADDR_ENABLE && (tagged_addr_disabled || !pmlen))
 		return -EINVAL;
 
-	if (!(arg & PR_TAGGED_ADDR_ENABLE))
+	if (!(arg & PR_TAGGED_ADDR_ENABLE)) {
 		pmlen = PMLEN_0;
+		pmm = ENVCFG_PMM_PMLEN_0;
+	}
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
-- 
2.53.0




