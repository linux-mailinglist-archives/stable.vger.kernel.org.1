Return-Path: <stable+bounces-224052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNTbCqX/r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4424AA65
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6423E31F2DC5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DBE38735B;
	Tue, 10 Mar 2026 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMNQXxy3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45C352C4F;
	Tue, 10 Mar 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141186; cv=none; b=MbyGZs5tYkRRmeKm58cUpZitqe/5lJzk1qLzb8T7UnP7Yif2K/+vtumzmO/r3GIatE6MeCs8abCZvVEOOzlnBDXC5hYgF0TGjlgtWVSZxmkPid6UC0Er7hwdFfqN1I0hpCQoSgO3XekaiZb5BvHa/ZkQm5tGuZWkM3gnwWLNprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141186; c=relaxed/simple;
	bh=0YIp9WWztdCyT558xYzb9HQjv0h6QBChvpN97EC1J1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfVEchxTrgEQLnPsNZ9HP/8f2+Feh8pHx3c64Wr0qVW/fscI+RoByUF2cAUmmCSLeurSw6UfFeiO3+VsB56hrmV9rWAR74Rd4xjtTHsvGp+z6JtsU0M1s5+xLc7XJMngM+7XjB/e1YsBB5n4vjYncQgG/LH1OHeHdX8NyybY5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMNQXxy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E02C19423;
	Tue, 10 Mar 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141185;
	bh=0YIp9WWztdCyT558xYzb9HQjv0h6QBChvpN97EC1J1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMNQXxy3VYzZ9y61IxYzjmo/y4CiTqkHrgJm50CiROB0grOLVTMWMO7Q0W3WQH/Yo
	 puLbKMyzSwT9EC2EnQLMql7fGnd7NFRAJOTt5c6PZ5TO3ADccCwXCRZ9AWZUesYwjg
	 3axv3MI+Xrrq+0Z+aWrNK6Eu28zAR7JbxGDuSAYtEFUiRSLcRKA7Jp9iGL+eYk75nf
	 bQXkZZqP8poQwtKjCEUZSm5b2udXtCiea/TCk3IuYMx0GcUSaySDj+ZAbL4NDchPXU
	 PXR1Rxx2pJMuRkEzl4GzSf88BANCgwhW7mHOPmjx27DxOvFrv3KWrBcac2Xspf6Nj+
	 WjDppA5teprSw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 187/311] pinctrl: pinconf-generic: Fix memory leak in pinconf_generic_parse_dt_config()
Date: Tue, 10 Mar 2026 07:03:54 -0400
Message-ID: <75333806f5b4c72b26294f9ba80a6154d7e4a147.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83B4424AA65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224052-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 7a648d598cb8e8c62af3f0e020a25820a3f3a9a7 ]

In pinconf_generic_parse_dt_config(), if parse_dt_cfg() fails, it returns
directly. This bypasses the cleanup logic and results in a memory leak of
the cfg buffer.

Fix this by jumping to the out label on failure, ensuring kfree(cfg) is
called before returning.

Fixes: 90a18c512884 ("pinctrl: pinconf-generic: Handle string values for generic properties")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinconf-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 366775841c639..38a8daf4a5848 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -351,13 +351,13 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 
 	ret = parse_dt_cfg(np, dt_params, ARRAY_SIZE(dt_params), cfg, &ncfg);
 	if (ret)
-		return ret;
+		goto out;
 	if (pctldev && pctldev->desc->num_custom_params &&
 		pctldev->desc->custom_params) {
 		ret = parse_dt_cfg(np, pctldev->desc->custom_params,
 				   pctldev->desc->num_custom_params, cfg, &ncfg);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* no configs found at all */
-- 
2.51.0


