Return-Path: <stable+bounces-31645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561188968B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F7F29AA7F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DE3718FF;
	Mon, 25 Mar 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWQfivTn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8012EBDB;
	Sun, 24 Mar 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322023; cv=none; b=o8IPhC70oAV+3+IZmGBqFh3s+JDaeXp+4lOxwuszf3HfgPGSQqgzgtJMcxf7+vplx8JveDbhvZVji7G/v9mWHuhS8JkcwU7vrWqPZDa5GZYo9SQfhgUNfaS0eakyhV1JttlDETWMT5zafeOUAbETvx0yA+IXGKz0PsbeaOHsuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322023; c=relaxed/simple;
	bh=3v2u52gHV9cGUvW7r3oyCpl4u5Lb7Ipc60LXIYLcw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4LDdjhjLUpXMhO8APIZqOrFqyUIGu3ji8SRt3Lo1JQn27QSkqDYuLHrBOS3nKkdrNwlQ6D+Py73eWL83xUHqmaSvUqMwHBj0wyzrcfCSv0PNWeeWftxKmRKnC5boPtWswyiwOuJeNhw8jV7B41kwif/99GCZILkY2rXs93wLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWQfivTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D6FC433C7;
	Sun, 24 Mar 2024 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322022;
	bh=3v2u52gHV9cGUvW7r3oyCpl4u5Lb7Ipc60LXIYLcw5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWQfivTnZOZxePbrVziu0p27r4rzY4dTM1sSJMs5+F5HvgyqnyUjC+gMxw4A5fefS
	 arZz8ocYJ8SIe59/hgLbINN7tESbKrH9/xFS1Y1b0DTQOz9xGJUfooW7BS9Ee8wTXV
	 g/tNqK6LuwaHN2dUe996Y4wcdw6zZBONPlYPVqj05MK3tmEASbXxGYDcMh8dLw+4bE
	 uLGkZJ4pUNoc+u7ED0BGKacvX6nCQdDenMiV4C4phWyJY4u0ylJn1sydWtk+3qBhcH
	 AvLyLgMZLg3Fvxdpi1VdzFsSL/zkx6bRZadPxtx+w5q4XnYrpZOFPyXCF4+7qo4o8Z
	 8uMvaAVeu/SAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/451] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 19:06:11 -0400
Message-ID: <20240324231207.1351418-96-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Anastasia Belova <abelova@astralinux.ru>

[ Upstream commit f661017e6d326ee187db24194cabb013d81bc2a6 ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return 0 in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index f644c5e325fb2..38ec0fedb247f 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,6 +481,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return 0;
 	struct private_data *priv = policy->driver_data;
 
 	cpufreq_cpu_put(policy);
-- 
2.43.0


