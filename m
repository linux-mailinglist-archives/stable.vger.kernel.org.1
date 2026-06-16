Return-Path: <stable+bounces-264623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eb82F+x8MWqkkgUAu9opvQ
	(envelope-from <stable+bounces-264623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:42:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 768876925C8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:42:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=a8CRVF1G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264623-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264623-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E03FE3032EAC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C924508E4;
	Tue, 16 Jun 2026 16:21:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F444DB64;
	Tue, 16 Jun 2026 16:21:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626877; cv=none; b=hmAksEv15mZb3gHGx0CdL9WRT/PI1w5pAeGpPm17D8CzN0h+6ltcMIhlxcMdtjRPxowK50GE+nv2krbD5by3BC8Ugees5TmaiA6N83qilHcPQkCREFP+ail2SxTzH9mpZQ+moMitewaA3CCwYyJxA/eQ+PInbYCDqdtBCaHJBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626877; c=relaxed/simple;
	bh=mg9GTzCXArCFC4K6tBma18Fw0uekh8DILTTqxzSuB9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOh/XzRZTnFiY37QP2cp7dqCjtd6UXJCDFcFWIMRbKCTdhb5X64XAo/0hJNd8J9uZlF3qntJufy9ovPTgsxiYqq4Cq8mxiuQJCM8HynyWz9zrjl6q2Fp8+PkZNkHliVYR0PEHSd7QW4HwFCPxDLOR2rZwHyMnA3gBs4+u9JL7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8CRVF1G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2E51F000E9;
	Tue, 16 Jun 2026 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626876;
	bh=HRHMAXCR3kBdFnhXc/ibKg4pRKn0tAP1FhNk/XSaVY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8CRVF1G8EBLvAJ26CgXnMtTGfLNHVRvSK7IM7ehtbzZLF/12IT2iP+YKQUoDKW/U
	 y055D1aAT8nuSYUssjWHiB+rH2UCba6CSbSG15xiMwFn4IG5IpId9Jk8yGUTMv7dgb
	 FDVP1jgKXlPIJYiqHgkc/LJp16J6SWpLfNh9JXG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 087/261] net/mlx5: Use effective affinity mask for IRQ selection
Date: Tue, 16 Jun 2026 20:28:45 +0530
Message-ID: <20260616145049.075350836@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shayd@nvidia.com,m:wangfushuai@baidu.com,m:tariqt@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 768876925C8

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fushuai Wang <wangfushuai@baidu.com>

[ Upstream commit a7767290e77ca2e926b49f8bfa29daa12262c612 ]

When a sf is created after a CPU has been taken offline, the IRQ pool may
contain IRQs with affinity masks that include the offline CPU. Since only
online CPUs should be considered for IRQ placement, cpumask_subset() check
would fail because the iter_mask contains offline CPUs that are not present
in req_mask, causing sf creation to fail.

This is an example:
  1. When mlx5 driver loads, it initializes the IRQ pools.
     For sf_ctrl_pool with ≤64 sf:
     - xa_num_irqs = {N, N} (There is only one slot)
  2. When the first SF is created:
     - The ctrl IRQ is allocated with mask=cpu_online_mask={0-191}
  2. We take CPU 20 offline
  3. Existing ctl irq still have mask={0-191}
  4. Create a new SF:
     - req_mask={0-19,21-191}
     - iter_mask={0-191}
     - {0-191} is NOT a subset of {0-19,21-191}
     - least_loaded_irq=NULL
  5. Try to allocate a new irq via irq_pool_request_irq()
  6. xa_alloc() fails because the pool is full(There is only one slot)
  7. sf creation fails with error

Use irq_get_effective_affinity_mask() instead, which returns the IRQ's
actual effective affinity that already excludes offline CPUs.

Fixes: 061f5b23588a ("net/mlx5: SF, Use all available cpu for setting cpu affinity")
Suggested-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260605102112.91772-1-fushuai.wang@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 2691d88cdee1f7..589051ffb49d3a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -94,9 +94,12 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
 
 	lockdep_assert_held(&pool->lock);
 	xa_for_each_range(&pool->irqs, index, iter, start, end) {
-		struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
 		int iter_refcount = mlx5_irq_read_locked(iter);
+		const struct cpumask *iter_mask;
 
+		iter_mask = irq_get_effective_affinity_mask(mlx5_irq_get_irq(iter));
+		if (!iter_mask)
+			continue;
 		if (!cpumask_subset(iter_mask, req_mask))
 			/* skip IRQs with a mask which is not subset of req_mask */
 			continue;
-- 
2.53.0




