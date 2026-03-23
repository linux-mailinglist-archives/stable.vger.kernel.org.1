Return-Path: <stable+bounces-228080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG0GG/xIwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D96FF2F3D6E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5051830E9FD5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01C3AE1A3;
	Mon, 23 Mar 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VukMmbuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711281A6818;
	Mon, 23 Mar 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274066; cv=none; b=Ie+IjzJVa+Kb/DKKIt4sJ6RChG7jr3HXPx/6i8mQEJmgs74bMgY7IfBgiCL1jSCb2jiNXIK7j335OYrvENYtLd368qpwOUOIZaBFWdY8osGZHM1A/Y1neb5UJi+BhrrbePZ+MqayxFR5/ygUd0drSiNzhantepjsdJS6rLWY/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274066; c=relaxed/simple;
	bh=2f+2rcVWzFTTXJX/a4Xmu6MasNCreZ3o2y4k+i5lZZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT0HOZEslOqGQEa6iprfdJMU5o1CUHtcmu2Id/l0391zdiRLU0VhQxHlAf3j5lwusKL7uXWjZmB0sbEedQinmrY2pJCm61y27w0YSxw+ox3y3urRoowO1otwzU0xGJHBSBVd1aZGxcstvXjrUCu6VFoBvDba0ZPLbz14vlTxXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VukMmbuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24F9C4CEF7;
	Mon, 23 Mar 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274066;
	bh=2f+2rcVWzFTTXJX/a4Xmu6MasNCreZ3o2y4k+i5lZZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VukMmbukxVdBn/c/fJ2qf0oFC1MDOxmv7Mtm3JUD+iEelj6YYnjcciMRG8VD4g1T5
	 cMTFb2vlMSQGo3ZAJAx5WuWh7AIJ/jck9VwEALD1O7oR7GPOte3+USTGKe72uPMA8s
	 GjoWtyJ5obE6ho/HPtG6QHvws6Vy/T3VBQPnv9gQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 098/220] cache: starfive: fix device node leak in starlink_cache_init()
Date: Mon, 23 Mar 2026 14:44:35 +0100
Message-ID: <20260323134507.694186018@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228080-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,huawei.com,microchip.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: D96FF2F3D6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 3c85234b979af71cb9db5eb976ea08a468415767 ]

of_find_matching_node() returns a device_node with refcount incremented.

Use __free(device_node) attribute to automatically call of_node_put()
when the variable goes out of scope, preventing the refcount leak.

Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cache/starfive_starlink_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
index 24c7d078ca227..3a25d2d7c70ca 100644
--- a/drivers/cache/starfive_starlink_cache.c
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -102,11 +102,11 @@ static const struct of_device_id starlink_cache_ids[] = {
 
 static int __init starlink_cache_init(void)
 {
-	struct device_node *np;
 	u32 block_size;
 	int ret;
 
-	np = of_find_matching_node(NULL, starlink_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, starlink_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-- 
2.51.0




