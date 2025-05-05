Return-Path: <stable+bounces-141121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD9AAB61D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DA84E349A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89AC27C167;
	Tue,  6 May 2025 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji5vc+Ga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF532D2CA6;
	Mon,  5 May 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485204; cv=none; b=Ssyj4/WxdxJKYoirFRhtF2uwPFrB4EEQCBCfT+sIxrwyBk/8q5OTOl4NufLL7Y30s6Yc0Kv04idB8spzG5bNbvJLkwoDyE3/Ot8CL3urFQTtV+UqbkH9DAB6NrtYCidJfldSYEd09fsNbH1G3/ekwkzBHwcomITSXPs/t+1Y9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485204; c=relaxed/simple;
	bh=cCrEAMogMpgyxQQnR4HUoIsCd8QZ/yNP4hYC4KY1i9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWCiCBvRh1IGCCiP8XHNTGoHvUQddIu+OsjjUwzdnGvVhBmwsPEQF9/ab+46661VDx3sxqEMnEhZuc7z8qc0+oa1yBe/KyKTUliSBYacY0cxihuZQWbY2wRzM7TnJO6WZD1JncMkt+o2HSDkPAqr3yZsldMjoa6fJ5bQySAvsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji5vc+Ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6339C4CEE4;
	Mon,  5 May 2025 22:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485202;
	bh=cCrEAMogMpgyxQQnR4HUoIsCd8QZ/yNP4hYC4KY1i9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ji5vc+Gatm5A9gT7aN+TzBbVGk1ZBeTPLDDBFuDfPojKVrv8eyVLDo/n3KP6KchMM
	 M8/bY70ZOJ5e6THI9I3488s5Z4j/8rGzQ+Dp4nM8NXazjIXZ5mQLGNCNdLBqkljaKC
	 v76DVXZPqA1xMPG86Z+7ekXjySK+9sQixVsbMYSIgpTrwOcQBqygExcMzA2XwU0v7c
	 hKhrZzikDMuzzzFRZive0TdjN+BoBmnOTqwcXqEB52gpjS6e+XvHoqgN9QANKtbI99
	 VJMa1SCnAiVHVlOgHqh8u9lQhkfsBJ/LHrcrjKOmQX8WG5nae7XuzMzQuBkvMNnPOE
	 dvpjxW6iZCa8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 208/486] dpll: Add an assertion to check freq_supported_num
Date: Mon,  5 May 2025 18:34:44 -0400
Message-Id: <20250505223922.2682012-208-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 39e912a959c19338855b768eaaee2917d7841f71 ]

Since the driver is broken in the case that src->freq_supported is not
NULL but src->freq_supported_num is 0, add an assertion for it.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Link: https://patch.msgid.link/20250228150210.34404-1-jiashengjiangcool@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/dpll_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 1877201d1aa9f..20bdc52f63a50 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -443,8 +443,11 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 			     struct dpll_pin_properties *dst)
 {
+	if (WARN_ON(src->freq_supported && !src->freq_supported_num))
+		return -EINVAL;
+
 	memcpy(dst, src, sizeof(*dst));
-	if (src->freq_supported && src->freq_supported_num) {
+	if (src->freq_supported) {
 		size_t freq_size = src->freq_supported_num *
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
-- 
2.39.5


