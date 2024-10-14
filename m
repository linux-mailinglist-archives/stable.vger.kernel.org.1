Return-Path: <stable+bounces-84341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACA99CFBC
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28543B2494E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11741ABECB;
	Mon, 14 Oct 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HX+6sQsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC31AA793;
	Mon, 14 Oct 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917678; cv=none; b=VOaPlv9SY9BuecEer6ycytmNsFtaq4xsHcBXARHj/W2ZpB5dQcPoIsmCczsSLpZYFydEAI+IdL3slUJWMqQAqwElfudIgmaT7MeOMihmEJ/4VC89Lk+55DxfTQzK6KucfhSOfXarxl8didO4XBalPM0ue3HG9rR1M24JCyc/skE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917678; c=relaxed/simple;
	bh=nNYvPaqFvq+AbAQKzmNJgRMZMC/m+CoTaxhdO/UKujA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+tkCQHfV2aMmiJTNDySxznItOF+ab/StsQBVN1m2xAUzcpMUMJ5TQnGJ+iol2cG0e1bODgtr2Hi+3uAYlZT+QTk4wDmTJ0SY6XCo7JapebWWfdM0PboBV6XNdKX9AkvvPpGNyAtB/med9FNHQS1FAu0xrT1Ipb5cT1OQ0Zdtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HX+6sQsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A51C4CEC3;
	Mon, 14 Oct 2024 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917678;
	bh=nNYvPaqFvq+AbAQKzmNJgRMZMC/m+CoTaxhdO/UKujA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX+6sQsubH16bMBG02QQIFQYidBXMNAjCkVkR9ZtinqnKyA0GujrlXRlHkChOEWgw
	 3Dvab8idlb/M1lkE39Z9ZZYx14pOUbMXacD+UZTz08jvQUteA/MGIXjkx22hi4VMRe
	 XXo/Y3Z0mMl9uldIhVg1xxxVKKwJnfEeO0+Q7m8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/798] pmdomain: core: Harden inter-column space in debug summary
Date: Mon, 14 Oct 2024 16:10:56 +0200
Message-ID: <20241014141221.937950433@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 692c20c4d075bd452acfbbc68200fc226c7c9496 ]

The inter-column space in the debug summary is two spaces.  However, in
one case, the extra space is handled implicitly in a field width
specifier.  Make inter-column space explicit to ease future maintenance.

Fixes: 45fbc464b047 ("PM: domains: Add "performance" column to debug summary")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/ae61eb363621b981edde878e1e74d701702a579f.1725459707.git.geert+renesas@glider.be
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d238b47f74c34..e01bb359034b7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3119,7 +3119,7 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-50s %u", genpd->name, state, genpd->performance_state);
+	seq_printf(s, "%-30s  %-49s  %u", genpd->name, state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
-- 
2.43.0




