Return-Path: <stable+bounces-224453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCgZGAMEsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6924B708
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0C603087188
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8263A1E96;
	Tue, 10 Mar 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROpTAolk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3C37F007;
	Tue, 10 Mar 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142185; cv=none; b=qtgmjrXt7uXXpOr6kEB/nRo/fJiD5OO7EseljPa9lCYnGAkSf0lAMk/n7TSq+X1RqZoulO2dArzuXnHNkhPddvMr6MixyEVWaTwXJpKV927Q3bZ3gY8D9JW0TpTTx+eMK3vZgcVtPCOpm33KspZZ9i1ogMY8CbX12vyZgMv1uoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142185; c=relaxed/simple;
	bh=upzLWnSw6gmSNi3HrFwIgcISvTGcora75jAfgvJ6hTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID+NFn4qdTimOKSyE6m1hyYwKMX1piHaHLFy0iJC4hmaj/1mNhyGDoytpdX8rAvtlvfUjUr2bQbxltN+LhWyOhr4XPvw2WC/i3+IvGmONZTfhR0gdmrqJfwpQ6rNbwHMsAj+mobAC/s6whjMasZKzAZXxj1h+Z9PB2jhIiAZqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROpTAolk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D7C2BC9E;
	Tue, 10 Mar 2026 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142185;
	bh=upzLWnSw6gmSNi3HrFwIgcISvTGcora75jAfgvJ6hTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROpTAolkDYpX2wK4BgCVh2ZWYFqHN412cOMccc0coepNAsuQe+qeUR3RaJbr+7t50
	 bC4HiIQnNjriTGjEYBbT5nJc72OtrR2j9RKvUmezll9tcKqJP1WovivlP3ejCke/dI
	 nzftcpKSg0Zpu1lqHmutYRPtQULA46XoM7ypzVmCKHBOtSC6dVbSUxAOuuHcVX0TX/
	 qTeiqdy1QQ6D71giryzjB84j7uNIsy6i3L34IRdIab3Krn/AEajGASR3w4u76Kf98N
	 4Q5X2B9mmdiTM2mLntBhTabMm7n645DAgAPl2DDwkMUvEKUvmd1zoyDcLiVm4OBtkh
	 fwUi1TNuz3Bew==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 274/314] drm/xe/reg_sr: Fix leak on xa_store failure
Date: Tue, 10 Mar 2026 07:18:53 -0400
Message-ID: <855a84f4c711050bc36d1732f3e50ecf4f682d40.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 79D6924B708
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224453-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 3091723785def05ebfe6a50866f87a044ae314ba ]

Free the newly allocated entry when xa_store() fails to avoid a memory
leak on the error path.

v2: use goto fail_free. (Bala)

Fixes: e5283bd4dfec ("drm/xe/reg_sr: Remove register pool")
Cc: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260204172810.1486719-2-shuicheng.lin@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 6bc6fec71ac45f52db609af4e62bdb96b9f5fadb)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_reg_sr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_sr.c b/drivers/gpu/drm/xe/xe_reg_sr.c
index fc8447a838c4f..6b9edc7ca4115 100644
--- a/drivers/gpu/drm/xe/xe_reg_sr.c
+++ b/drivers/gpu/drm/xe/xe_reg_sr.c
@@ -101,10 +101,12 @@ int xe_reg_sr_add(struct xe_reg_sr *sr,
 	*pentry = *e;
 	ret = xa_err(xa_store(&sr->xa, idx, pentry, GFP_KERNEL));
 	if (ret)
-		goto fail;
+		goto fail_free;
 
 	return 0;
 
+fail_free:
+	kfree(pentry);
 fail:
 	xe_gt_err(gt,
 		  "discarding save-restore reg %04lx (clear: %08x, set: %08x, masked: %s, mcr: %s): ret=%d\n",
-- 
2.51.0


