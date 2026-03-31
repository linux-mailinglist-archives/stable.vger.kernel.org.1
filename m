Return-Path: <stable+bounces-232364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBfeHFUDzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A936EA2D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BA8031243E3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E31301708;
	Tue, 31 Mar 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hmk+OFeG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062CB3016E3;
	Tue, 31 Mar 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976557; cv=none; b=ddSri3xvdX69Gntf61cumn6Pcae4IPZs7UZffTZszEHDZwzzP9lBwLjiMmFTp5HJgX2iIhlugZatq0AgRA6Lw+SGW6ZURJ06MK/NJ0tdBHCXAnrERDGP/v2RcMtEZUOHbTu7Dq9wQmz0nPDi/Nr6YOCU3pgfxVCRFre6qZ1Zxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976557; c=relaxed/simple;
	bh=/eBJ28zVPr4+1PGEAqeXYUHUtRNmklR65e/FZtKvl3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soSc06ml0c4CaYpeTxaWLzdoQ58e1Y9fedOvYKwolbjb4cUeW5uFVZpDnnx0BNLdUkak50Hh7Y6jXE7HwoKB2HCvyd3Jsq4ABg5/TqocknIGbnC/HloszJ4JN4lUDk1DBwMUG5uUN7K/6QZNG/nAeeY3dH58cwO3E97biO1zLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hmk+OFeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93334C19423;
	Tue, 31 Mar 2026 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976556;
	bh=/eBJ28zVPr4+1PGEAqeXYUHUtRNmklR65e/FZtKvl3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hmk+OFeGUUGGcp7LU/jy8wt1PUjEygYu45huhvAu7TbLzefUVfP2OcBxwz2/tk7fr
	 qZthQSzFVzVGUjV3s0GQyRw5coO1NyAhiKGjaBfiRuqxihwdCiTVh1ZceHaTWn6lFt
	 i0rIFf1JTpRyqI/bCUg3I1qbvqQELg2u/mJe538Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 139/309] RDMA/efa: Fix possible deadlock
Date: Tue, 31 Mar 2026 18:20:42 +0200
Message-ID: <20260331161758.592504301@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232364-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 734A936EA2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit 0f2055db7b630559870afb40fc84490816ab8ec5 ]

In the error path for efa_com_alloc_comp_ctx() the semaphore assigned to
&aq->avail_cmds is not released.

Detected by Smatch:
drivers/infiniband/hw/efa/efa_com.c:662 efa_com_cmd_exec() warn:
inconsistent returns '&aq->avail_cmds'

Add release for &aq->avail_cmds in efa_com_alloc_comp_ctx() error path.

Fixes: ef3b06742c8a2 ("RDMA/efa: Fix use of completion ctx after free")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260314045730.1143862-1-ethantidmore06@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_com.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 56caba612139f..e97b5f0d70038 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -629,6 +629,7 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 	comp_ctx = efa_com_alloc_comp_ctx(aq);
 	if (!comp_ctx) {
 		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
+		up(&aq->avail_cmds);
 		return -EINVAL;
 	}
 
-- 
2.53.0




