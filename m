Return-Path: <stable+bounces-225855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMurGN1AuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:54:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDC2A9485
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC789307BAAD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1091379EFE;
	Tue, 17 Mar 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7RRzmBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C613AE70B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748192; cv=none; b=rmWVZknBJOUrQhlUHXXC7E0yu/mmiS5CWkoCci4m9gK7E7bzvVNZHUNizJIgnjlHY79xw7BTJoKMQ+t0baPdc6XfIFRf26djFX2xgrSzYOQA6c3pKLdeW284WWSGudEaZLmZSyZGZ5fif3p8GcDD1FtNw5sFcMd4rQsJAN27Evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748192; c=relaxed/simple;
	bh=ElWfHroQIHg43juAArLvBER9My8/Tgzdi6OI2knhwoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFnOEornmJa/BpPFTt3PgifhaV00m/w/oiG5Nf91HCdIjDpkvU9HnFAZjxUEIyNAu7C1PpnpPpN/mH7OUnfJdlsCiFRQNSADdX+uyS6KsyniLcGh5unfAZuwKjizRHEdaTHluJOAHGDGiVkhP1R1WEqKURhPvlYk8DyPJMscU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7RRzmBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE92C19425;
	Tue, 17 Mar 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748192;
	bh=ElWfHroQIHg43juAArLvBER9My8/Tgzdi6OI2knhwoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7RRzmBcsMc+zThr7YWVoEDjpcLqmCNAJXzmnkaJYGaiERVipf/svjVRzw5qh1Y85
	 0UI1Wx6SUquwdFnJC6TcL+yvkeBIvIF4TDx5ct1EDp5RmZwf8uLwYD6UYnZazLUmEl
	 Zy/SMdDGEVbdm2XvgP6LPgTlfAxTMtiE2d7gzmpslSUpzO0Gb3TPkX/rp8Ps1VzrPT
	 3zFmu6zL9ooRME1E28qgkSD/NZWWEC5kInTQmcM95gqlZrXRO0DZAbTQsBsMRwVQIz
	 N74ET0KKngO9+Wq0T+5OLRNtMN1EgVfzQjHVgYeesbDZpVGO9tsk6V9lxV1ew2d+QN
	 pi3oRWF/APejA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] mmc: core: Drop superfluous validations in mmc_hw|sw_reset()
Date: Tue, 17 Mar 2026 07:49:47 -0400
Message-ID: <20260317114949.126875-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317114949.126875-1-sashal@kernel.org>
References: <2026031713-defeat-mobster-d0a8@gregkh>
 <20260317114949.126875-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225855-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: C4DDC2A9485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit fefdd3c91e0a7b3cbb3f25925d93a57c45cb0f31 ]

The mmc_hw|sw_reset() APIs are designed to be called solely from upper
layers, which means drivers that operates on top of the struct mmc_card,
like the mmc block device driver and an SDIO functional driver.

Additionally, as long as the struct mmc_host has a valid pointer to a
struct mmc_card, the corresponding host->bus_ops pointer stays valid and
assigned.

For these reasons, let's drop the superfluous reference counting and the
redundant validations in mmc_hw|sw_reset().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20210212131532.236775-1-ulf.hansson@linaro.org
Stable-dep-of: 901084c51a0a ("mmc: core: Avoid bitfield RMW for claim/retune flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c |  2 +-
 drivers/mmc/core/core.c  | 21 +--------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 71ecdb13477a5..2756a5f149f1d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -987,7 +987,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 	md->reset_done |= type;
 	err = mmc_hw_reset(host);
 	/* Ensure we switch back to the correct partition */
-	if (err != -EOPNOTSUPP) {
+	if (err) {
 		struct mmc_blk_data *main_md =
 			dev_get_drvdata(&host->card->dev);
 		int part_err;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d8169c8c3f405..cef46bae60b6a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2096,18 +2096,7 @@ int mmc_hw_reset(struct mmc_host *host)
 {
 	int ret;
 
-	if (!host->card)
-		return -EINVAL;
-
-	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
-		mmc_bus_put(host);
-		return -EOPNOTSUPP;
-	}
-
 	ret = host->bus_ops->hw_reset(host);
-	mmc_bus_put(host);
-
 	if (ret < 0)
 		pr_warn("%s: tried to HW reset card, got error %d\n",
 			mmc_hostname(host), ret);
@@ -2120,18 +2109,10 @@ int mmc_sw_reset(struct mmc_host *host)
 {
 	int ret;
 
-	if (!host->card)
-		return -EINVAL;
-
-	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->sw_reset) {
-		mmc_bus_put(host);
+	if (!host->bus_ops->sw_reset)
 		return -EOPNOTSUPP;
-	}
 
 	ret = host->bus_ops->sw_reset(host);
-	mmc_bus_put(host);
-
 	if (ret)
 		pr_warn("%s: tried to SW reset card, got error %d\n",
 			mmc_hostname(host), ret);
-- 
2.51.0


