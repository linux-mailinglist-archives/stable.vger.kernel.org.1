Return-Path: <stable+bounces-245905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCgNLcRnA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93B5261FA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFCD7302BE20
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F23DC85B;
	Tue, 12 May 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cv8MbCpl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF93C8C7D;
	Tue, 12 May 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607856; cv=none; b=Zo+Z/Kncsje5gq82Xrr0tvzemSJGSzC22NmK7b9Zj69xJ1kkaoRyukmY6WMP3rY0OchfgKMoBhzSZJJLwFotyz6iwYkB/xGa3RGujtS/Q9Wtnxg6G4UWnA6U79qfHoCIrTpquI0KjryK8MizF+J+7ub8vtnQIfeoT03u/YDAXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607856; c=relaxed/simple;
	bh=GDV7hEm/jjyShnWeJPSjzHgtNHgiprNLOj6oszjo9fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+Kyx1qMblu1UEQviu+lUiclw+xL6iDF3eRtKW9+A9vQ1QqylI+Qrw8PFH2G1/Z6htiuuctJ9MRTQNuYTEJxfngXqpQz9LjI4KU+9yWIY4Ij6PdgUh7AljKGoIRRcQrgnk6DxE7IHrpJeLaWX0y6sqrlZLpDtGHwCcuup31ZlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cv8MbCpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A018C2BCB0;
	Tue, 12 May 2026 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607856;
	bh=GDV7hEm/jjyShnWeJPSjzHgtNHgiprNLOj6oszjo9fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cv8MbCpl0ik4MBgAxBiaUxsrk4Ds1FKECq+5EhPGgg/im8E0Kfti5bHVADuTNd7FM
	 OxFvHjjeSG/oazwd3GgCDv68gY7YkK3pf8kHuBKj3XPPiSQYAl4AwMH7+z2SzbaCJA
	 lnwmogn329NomteKidEqDm02jEU8qGZ0+jU/kWzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uros Bizjak <ubizjak@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 018/206] iommu/amd: Use atomic64_inc_return() in iommu.c
Date: Tue, 12 May 2026 19:37:50 +0200
Message-ID: <20260512173933.207806897@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2A93B5261FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245905-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,8bytes.org,amd.com,kernel.org,arm.com,nvidia.com,suse.de,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,amd.com:email,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,8bytes.org:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uros Bizjak <ubizjak@gmail.com>

commit 5ce73c524f5fb5abd7b1bfed0115474b4fb437b4 upstream.

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241007084356.47799-1-ubizjak@gmail.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Stable-dep-of: 9e249c48412828e807afddc21527eb734dc9bd3d ("iommu/amd: serialize sequence allocation under concurrent TLB invalidations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fecca5c32e8a2..24e2de90ac2e4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1266,7 +1266,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
@@ -2929,7 +2929,7 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		return;
 
 	build_inv_irt(&cmd, devid);
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd2, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-- 
2.53.0




