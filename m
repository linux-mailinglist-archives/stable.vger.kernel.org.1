Return-Path: <stable+bounces-221512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBKRFZyYo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B281CB346
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903F1318F567
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4F2857F1;
	Sun,  1 Mar 2026 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ98Y3kx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF95284662;
	Sun,  1 Mar 2026 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328453; cv=none; b=aEPPSLCIKb12eUOC6Lfckeu270vZfJ/mBjF22wddS1hmukqcsFXLpbTKcK4Wuq4eEqz6UKYFjxKvzVeOZzK0E++d2k3/rm85/POyrn1ilq9tvFVU0KzvMrBgZ6yiCRidLLf8i6WcT3hwGcbuxGr/NuTIXRZHwRsAK6VJ/MHRWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328453; c=relaxed/simple;
	bh=r3Jgvb8jz+L5WMeG5DTHuI16r8QaIgcV+xF6YXhFXWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNlNV0ZXN73dr4n+0yOCBfktiLfb7nLwWBJgvx5DAixlMsDI4ojdZLzSDU1PjMERFyPPPlQeMNwY9E5+CP4f97hDy+nMc/9e75yLe/T1k8vJYT6PJN4npWD2v8/1XFbwXSOhy/0RsGOUFj1nMS2NSTVvk/ps4qh72e7OSfGveW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ98Y3kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B38C2BC86;
	Sun,  1 Mar 2026 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328452;
	bh=r3Jgvb8jz+L5WMeG5DTHuI16r8QaIgcV+xF6YXhFXWI=;
	h=From:To:Cc:Subject:Date:From;
	b=HJ98Y3kxjdgv0E2F4TaxfQR5/IZGYUEVBOpxPxX5ze+tyZkCn/JFoFkd+KCVq0Q/5
	 IiLHsSWVMBwjYPmEkTTfwzWEfpeKUP/h3dF7Wb0BbXipfM66PKMmdnHnX9cdywaAso
	 l2UT1GtosltaJ0m3sETCjUJp0z/y9Je+53aNuEJrQiRKJsNVKy8oWKYwcpRnZumrF/
	 sC411Ukflrr+oygT4j7PHw9ICaNqcCAwhMVo4kA2lo2SbgMGvB68hZ2/UXcI5p7XCu
	 QOwNIAcbfroI2qceAku0tFRVPmDPJMZSM2501tnWoLeO88c5ZL7Yi4OEzFCubGHRrk
	 P4pIMc+zF9+fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	john.g.garry@oracle.com
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:30 -0500
Message-ID: <20260301012730.1685022-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-221512-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A4B281CB346
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94b0c831eda778ae9e4f2164a8b3de485d8977bb Mon Sep 17 00:00:00 2001
From: John Garry <john.g.garry@oracle.com>
Date: Tue, 10 Feb 2026 19:31:12 +0800
Subject: [PATCH] LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE -
which is a valid index - so add a check for this.

Cc: stable@vger.kernel.org
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index f06e7ff25bb7c..6b79d6183085a 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -12,7 +12,7 @@
 
 extern cpumask_t cpus_on_node[];
 
-#define cpumask_of_node(node)  (&cpus_on_node[node])
+#define cpumask_of_node(node)  ((node) == NUMA_NO_NODE ? cpu_all_mask : &cpus_on_node[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.51.0





