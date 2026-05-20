Return-Path: <stable+bounces-250454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKRlKcPyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0964A594648
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B333771B0C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601B36405A;
	Wed, 20 May 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hn6wTe9b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D24352016;
	Wed, 20 May 2026 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295454; cv=none; b=pjkbODrLJ6D+2fRbYPlmEscEACdBqzY0H6CbcV7PiCCzNycwRf0v28nSyTNOfsbXwGtRYz7xuQ+4MLxgJR12P8UBDeIKS/Oq7Y1X3rnjSfwlf0QmMpuDF2mBcNn6m5NlGolqOVR7mTPfltU0JmZZF1XrGv7iC1pPBK1OQKWFVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295454; c=relaxed/simple;
	bh=coorjHFbkY+MsUBYDvxPK30Hj1p+tQlJ9Fn/QJEa0j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7vxoCXRlUq2ygmKoTFKgrhVIuvyvkzgdXXTe1G4li2Yc58q3YYWAJ3k7LarbFg+iDvpC9TR6MHVyn/29sJq7LGr1PvKivSxEDIg1Stvi2CgKktleIysPvzip4bqzhtsgOygT/6hOAkaa2XATmuJz4srHfrupUEO3OqJd5DjzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hn6wTe9b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01411F000E9;
	Wed, 20 May 2026 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295453;
	bh=5u3tjGgS8X2edg+MLtdB3TtU1uC+X5R39C95fJzYbow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hn6wTe9bK9Lq4Dx29Q5vzdOuD3ATrifGaS0lXA3AVmwsE1bLnss7sW0Qeh9lWkdpr
	 drSDtFThj5RayczSkNL9w/BQikjNhOz+G4jyOLmatt96jE3thf5uOFAc/bWbbLNwBo
	 d8bZrjnXYi+oaMsN9ecL7m1RdSVjuHAqpEIQxJOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0388/1146] crypto: iaa - fix per-node CPU counter reset in rebalance_wq_table()
Date: Wed, 20 May 2026 18:10:38 +0200
Message-ID: <20260520162156.980561271@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250454-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,apana.org.au:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 0964A594648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 590fa5d69c27cfaecd2e8287aec78f902417c877 ]

The cpu counter used to compute the IAA device index is reset to zero
at the start of each NUMA node iteration. This causes CPUs on every
node to map starting from IAA index 0 instead of continuing from the
previous node's last index. On multi-node systems, this results in all
nodes mapping their CPUs to the same initial set of IAA devices,
leaving higher-indexed devices unused.

Move the cpu counter initialization before the for_each_node_with_cpus()
loop so that the IAA index computation accumulates correctly across all
nodes.

Fixes: 714ca27e9bf4 ("crypto: iaa - Optimize rebalance_wq_table()")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 547abf453d4a2..f62b994e18e58 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -906,8 +906,8 @@ static void rebalance_wq_table(void)
 		return;
 	}
 
+	cpu = 0;
 	for_each_node_with_cpus(node) {
-		cpu = 0;
 		node_cpus = cpumask_of_node(node);
 
 		for_each_cpu(node_cpu, node_cpus) {
-- 
2.53.0




