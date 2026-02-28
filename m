Return-Path: <stable+bounces-220480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CZNJOs8o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:07:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7DD1C69F0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054A434A68DD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575D3C548A;
	Sat, 28 Feb 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUmQN5gq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDD3C4C41;
	Sat, 28 Feb 2026 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300366; cv=none; b=Y1+p3SPLwHm/02bbBabSf5A1fdMFzOMqelEOt7hai+/hP35Wwe88O8HiAIkC1+DUFGa/T8rPZmBCp82jP81U1o7sVVt41/QmSlEIFBAjHbO85B9lTfZOineT+gc+fJuIULbQaGwIbCTx0wTBdTeEmqD1+zf1krTDvntZIODc4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300366; c=relaxed/simple;
	bh=rVn4T+1vnnJGADQEtIx/kYDPe7oJdBkEqyDhGHEpXTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIC1dnihWI8P3eYBmw3+3nl7m+l+r+jv+RmUso0hpbH4yBZw7zVd8lwCCEWtU2MKze5BbUTg2p/obyFHxDk5BCsOW9UQfqduQhDwkkhxNiehq+bE0+fa4dl8/iRDEofm5KBeZa0pw2t3Pl22GfAwM143MArM+Ass1dvmzmuuq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUmQN5gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF729C19423;
	Sat, 28 Feb 2026 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300366;
	bh=rVn4T+1vnnJGADQEtIx/kYDPe7oJdBkEqyDhGHEpXTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUmQN5gqGhtOZ+LvTCAl8liZzG06ZRWTUtaWbKBmL1Z6CQDfiqhGJitCyGx8law/G
	 20wS8bz0YVRSazuBXJeixbMmMEsX6nbi8yVR0O8uCo68pYXUcDRqDrg8AYHzDv7ylR
	 Sw74DANhX2P54ZRL0T2b1IjFHwxckL82mMxg4JKsVFC/YvWPmVFma52/vZo6tqwfVy
	 v9xAoYkr4iFRf7AVL4w6qTjynYfH92FVHHmzn4kR0HiFdZ3I7Riq/Qd0ZLQWjeY2W0
	 h6FXQfq6RwB9+eiP4htXGN84MgtWZtR5dg4qPiGy/8Z55FhWZm+3DHQa+cSwtfq524
	 dmLlGPy+j3t/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 401/844] MIPS: Loongson: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Sat, 28 Feb 2026 12:25:14 -0500
Message-ID: <20260228173244.1509663-402-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220480-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,loongson.cn:email]
X-Rspamd-Queue-Id: EC7DD1C69F0
X-Rspamd-Action: no action

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit d55d3fe2d1470ac5b6e93efe7998b728013c9fc8 ]

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
is a valid index - so add a check for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mach-loongson64/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 3414a1fd17835..89bb4deab98a6 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -7,7 +7,7 @@
 #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
 
 extern cpumask_t __node_cpumask[];
-#define cpumask_of_node(node)	(&__node_cpumask[node])
+#define cpumask_of_node(node)	  ((node) == NUMA_NO_NODE ? cpu_all_mask : &__node_cpumask[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.51.0


