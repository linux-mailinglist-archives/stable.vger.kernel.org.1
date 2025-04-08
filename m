Return-Path: <stable+bounces-129524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903DA8005B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FFC441CCE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F4267F55;
	Tue,  8 Apr 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Leax6fQb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF0224F6;
	Tue,  8 Apr 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111263; cv=none; b=IgqijTgIDXuSeo6bKgwSeLKR3bQZPTHZ/HdWVTwYzXgjRfJvCW51VhtqH+cCCz/38v8FOhW+srUFw/9x9nLvLJO7bo0AMdYEOzcCMh3xn50+DSrviXPjSClnXTkzjtldY1/V8uAnucbEG/3eEQaMgTJ6BhMqqJ+VX0d8NYH/7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111263; c=relaxed/simple;
	bh=bZ+mS6ABSEchVksu5TqvKrDu5HUQvr+NGqHd6I+QbCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDyff/kCOUWiDnLq0QuKnxVd1VViW8ocGYMmNEeoFaiPU70XjTb5g5yZs7fvJroZQGXsiz9zanX7N59eDg0sp+UIDskbGAwKyjqCKW8lJFYegvYslgf4JeEnG1YIoWU6YY0SXpdjQkTzaiU4Sg03jxCE0RNIfavsmNmdwLDLP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Leax6fQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E783C4CEE5;
	Tue,  8 Apr 2025 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111263;
	bh=bZ+mS6ABSEchVksu5TqvKrDu5HUQvr+NGqHd6I+QbCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Leax6fQbpLVOOdkCdasPUqAMQTh6hY3eJqNZFjRPh8lz2PUywcb3LgggoN7FZM/Gl
	 twA3aKdBBp3l3KrDEalaXORM+CaYba33ImmcZRFGLFOOjgztZJnNgNhoutB65W/IHq
	 eBoe28OrJzuHlzt1zzqA5TKb1Z5ukzyLcVQRoWoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Luca Weiss <luca@lucaweiss.eu>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 367/731] remoteproc: qcom_q6v5_pas: Make single-PD handling more robust
Date: Tue,  8 Apr 2025 12:44:24 +0200
Message-ID: <20250408104922.812945199@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca@lucaweiss.eu>

[ Upstream commit e917b73234b02aa4966325e7380d2559bf127ba9 ]

Only go into the if condition for single-PD handling when there's
actually just one power domain specified there. Otherwise it'll be an
issue in the dts and we should fail in the regular code path.

This also mirrors the latest changes in the qcom_q6v5_mss driver.

Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Fixes: 17ee2fb4e856 ("remoteproc: qcom: pas: Vote for active/proxy power domains")
Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/r/20250128-pas-singlepd-v1-2-85d9ae4b0093@lucaweiss.eu
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 97c4bdd9222a8..78484ed9b6c85 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -501,16 +501,16 @@ static int adsp_pds_attach(struct device *dev, struct device **devs,
 	if (!pd_names)
 		return 0;
 
+	while (pd_names[num_pds])
+		num_pds++;
+
 	/* Handle single power domain */
-	if (dev->pm_domain) {
+	if (num_pds == 1 && dev->pm_domain) {
 		devs[0] = dev;
 		pm_runtime_enable(dev);
 		return 1;
 	}
 
-	while (pd_names[num_pds])
-		num_pds++;
-
 	for (i = 0; i < num_pds; i++) {
 		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
 		if (IS_ERR_OR_NULL(devs[i])) {
@@ -535,7 +535,7 @@ static void adsp_pds_detach(struct qcom_adsp *adsp, struct device **pds,
 	int i;
 
 	/* Handle single power domain */
-	if (dev->pm_domain && pd_count) {
+	if (pd_count == 1 && dev->pm_domain) {
 		pm_runtime_disable(dev);
 		return;
 	}
-- 
2.39.5




