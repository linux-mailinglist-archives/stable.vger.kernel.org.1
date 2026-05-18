Return-Path: <stable+bounces-249202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNU4Ani9Cmrb7AQAu9opvQ
	(envelope-from <stable+bounces-249202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:19:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D0567584
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 256D23005A8C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B7C3CFF61;
	Mon, 18 May 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=senarytech.com header.i=@senarytech.com header.b="AoXi7o26"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A303CFF4F
	for <stable@vger.kernel.org>; Mon, 18 May 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088755; cv=none; b=Z03sHvD71SWwyY7wteFCnlUP9ye0xYUNA9lMuvp3uRcvjvVvs9JLjp5uxn9oT04hhA19QamOr1DIm8lQQrCokuC/4WDgWHfzzUbzZqLAYA10riKmOu4+4shfoIwblLq+oPApD01JbOw9lrbvbqRk4LuDDp2jrb+Yyw5Ehuub3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088755; c=relaxed/simple;
	bh=YNDHFGw4ihqGtIxZeuvgltX80g59Xg3/02BKNmx0EKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MeH/8oUnPLz8pfB9gesC5xeEHAn7Zjc9yhNESy3IEWMrNQ6a8r18VBhQeeAw2Kelxq8Eu0uIrJZ3w5gdj+3dAqKD0dqWpfZ1ySD/KSMjUcaiiBC07E/+jsCwQeH8KCKXxv3ztAFMdlhGOPn0HSvdjEanmOf8Zug9d5P2J5MoMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; dkim=pass (1024-bit key) header.d=senarytech.com header.i=@senarytech.com header.b=AoXi7o26; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from localhost.localdomain (unknown [112.95.78.112])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ecac9e39;
	Mon, 18 May 2026 14:43:30 +0800 (GMT+08:00)
From: Mao Weiming <alex.mao@senarytech.com>
To: alex.mao@senarytech.com
Cc: stable@vger.kernel.org
Subject: [PATCH] cpuidle: coupled: Fix use-after-free on device unregister
Date: Mon, 18 May 2026 06:43:24 +0000
Message-Id: <20260518064324.3240-1-alex.mao@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e39d34f3009d1kunm95b8b9af3338df
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR5OVklDHhpPSU1DHxkdSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSklVQk5VTENVSkpJWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=AoXi7o26+nWvY4MIvenWLPh9Cx7KnnhfDKCOZfEgHRuVReQe8VFIDydDK2h/lsNZXDvixsaTGqKZcE/GeBYBM3XoIBtn8xnmDpGCbV7tevbUtKYGKUU0w7v8zgLxW5+Va7Pv95MYyCRtWcej4a96Y6z4Nlq6AU5Tl6qAOeBgHis=; c=relaxed/relaxed; s=default; d=senarytech.com; v=1;
	bh=far6sSUU4mMODSVZfSerOZIHCd5KgiZn30F5uvCwMd8=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: D52D0567584
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[senarytech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[senarytech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249202-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[senarytech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[alex.mao@senarytech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: maoweiming <alex.mao@senarytech.com>

cpuidle_coupled_unregister_device() has had its refcount check inverted
ever since the coupled idle infrastructure was introduced:

	if (--coupled->refcnt)
		kfree(coupled);
	dev->coupled = NULL;

A struct cpuidle_coupled is shared by every CPU in a coupled set.
cpuidle_coupled_register_device() either allocates a new one with
refcnt = 1, or reuses an existing one and bumps refcnt. Therefore the
struct must only be freed when the last CPU in the set has been
unregistered, i.e. when refcnt drops to zero.

The current code does the exact opposite:

  - With N >= 2 CPUs in the set, the first CPU to unregister decrements
    refcnt from N to N-1, the condition becomes true, and the struct is
    freed while the remaining N-1 CPUs still hold dev->coupled pointers
    to it. Any subsequent dereference (e.g. from
    cpuidle_coupled_cpu_set_alive() during CPU hotplug,
    cpuidle_coupled_update_online_cpus(), or the coupled idle entry
    path) is a use-after-free.

  - When the last CPU finally unregisters, refcnt becomes 0, the
    condition is false, and the struct is leaked.

Both behaviours are wrong; the UAF is reachable on platforms enabling
ARCH_NEEDS_CPU_IDLE_COUPLED (OMAP4, Tegra, MIPS CPS) via driver
unbind/unregister and CPU hotplug-driven re-registration paths.

Fix it by freeing the struct only when refcnt reaches zero, matching
the kerneldoc above the function and the symmetric increment in
cpuidle_coupled_register_device().

Fixes: 4126c0197bc8 ("cpuidle: add support for states that affect multiple cpus")
Cc: stable@vger.kernel.org
Signed-off-by: maoweiming <alex.mao@senarytech.com>
---
 drivers/cpuidle/coupled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index fb91a9e0e3c2..25d8a6b27a51 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -687,7 +687,7 @@ void cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
 	if (cpumask_empty(&dev->coupled_cpus))
 		return;
 
-	if (--coupled->refcnt)
+	if (!--coupled->refcnt)
 		kfree(coupled);
 	dev->coupled = NULL;
 }
-- 
2.25.1


