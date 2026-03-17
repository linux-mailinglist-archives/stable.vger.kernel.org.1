Return-Path: <stable+bounces-225854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EYLCeQ/uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D100A2A9387
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 497D63028B48
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530B3AE6FE;
	Tue, 17 Mar 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOPs0psb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBFD3AE6E7
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748192; cv=none; b=q+7to/MJev/KOYpGQAO7xd7sCqSDlrlJ4kDQgfY53yPefUTled/pEWBCFqRX0LyvotG7FA/5zl1ggqhiung9znkFRFoI3eHxzkbZEt8hw+5PSiqTokLiZf7IQp6nP1eWSptqEbg/ocH1ygoriZRpowe4HtfauBjl7JGYztX474E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748192; c=relaxed/simple;
	bh=d7XqbWK5olCQTgSa82eqq/M4fOTerJ1l2YXkU9JqrKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDVyl89fe59kUNHltssLt3WRGR5Bga5DC+cRANhF6whw5YsxeCJdxU3K7lW22Vxci+s79sdhjct5eE8WbkR9BmOeCKqQE+5XWZiA2+Oi6RpsrVeQIi/Gb7yGK9lHMoLKVUyaHTLa9QErzotI6BN9drT2u89OWfcgaJZehZD7CVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOPs0psb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E35BC19425;
	Tue, 17 Mar 2026 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748191;
	bh=d7XqbWK5olCQTgSa82eqq/M4fOTerJ1l2YXkU9JqrKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOPs0psbVdxozj9HdaYBV2v3iLjjtRgoZ7DNpIwBLlfkJG+ZO3WH5hrtLJsi4jWQv
	 03Cv/eNq7k6Vk1rNiNxi/DW7nW4AoZKKjGHPYOrbyKaD5N82FhcjjH8cqc6wVemM+G
	 x27VDbtLIXV/05bOwZdjpG6zraDQRqDQG52ookKQga1CMqMydAfe+QCmCz/q/PenVG
	 iyz/jw3j2A1tnciN+geUkw+ydDt12ikrmS/IvPoO21+amOAWhQKa6tSnnrY+FdWLOd
	 H/RTS6CtA7dLCm3qL5wARVD4qH5cLDWpFI3SAuS5EKRcmRukcwdARkUYH/RYY8ZWPa
	 AvREXgi8HDweg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] mmc: core: Drop redundant member in struct mmc host
Date: Tue, 17 Mar 2026 07:49:46 -0400
Message-ID: <20260317114949.126875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031713-defeat-mobster-d0a8@gregkh>
References: <2026031713-defeat-mobster-d0a8@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225854-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: D100A2A9387
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 951f6ccfcbb7e4a18bf5fef1fb373d21e5831957 ]

The Kconfig option to use the blk-mq support was removed in commit
1bec43a3b181 ("mmc: core: Remove option not to use blk-mq"), but forgot to
remove the use_blk_mq member in the struct mmc_host, let's fix it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20210202101924.69970-1-ulf.hansson@linaro.org
Stable-dep-of: 901084c51a0a ("mmc: core: Avoid bitfield RMW for claim/retune flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmc/host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd3492f377d00..1c7b716c96f30 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -409,7 +409,6 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
-	unsigned int		use_blk_mq:1;	/* use blk-mq */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
-- 
2.51.0


