Return-Path: <stable+bounces-33373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B319D891B8A
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CC29221C
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7A17556D;
	Fri, 29 Mar 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGx8wLBX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D0175568;
	Fri, 29 Mar 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715731; cv=none; b=QsDWG9QrMLI25Ygh+h3O3Q8+mx9/pKoNNOyoXDVlzxqpVlbfPqFxTGBsrJWC1QXF+i+rCY9vUqe4EPu2kEzjkYywv3useUOEUblOnSZb5Hl0pviM9Gy4CoSVJgOl8z0O3LVNO6UgfIG3pGtDMBiYIovfH2FqCeF09qRFLzRljF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715731; c=relaxed/simple;
	bh=+uHwfZ62RMXerS0nEStQgHY8Yp6ppGe+Mm9EyPS2VnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBomPbu31njbqc+8VQ79u37cDUQExf5odBV11vaTY6JdwZDPerYjMdkYpZXuYQwO0uTRfzyyugXrTdNXVOrnO7xN5i+PjnA/5g7D+/KoNYcCFeBPj3ukJGgwz/uKikBGTnczX4dcOP94+Q/dSK5EBB/2ly/mKuQ4WbIZqu2Z4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGx8wLBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BF8C43390;
	Fri, 29 Mar 2024 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715731;
	bh=+uHwfZ62RMXerS0nEStQgHY8Yp6ppGe+Mm9EyPS2VnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGx8wLBXq++EdLgYnWLn15tE5X4FNMZWLSwLNEM3R5ELXyo5CGkPiuQtP4PWgrEVc
	 R+EZqbX+fkUTkujPgor7eLScQMJMSNwolIKbzmW+CbrYfMcJ2m1jG9na5+14cVPHXS
	 s3C9BAj+cF6xoF5t/xUm+xJZg2CGv7W5n62CfDExyD99ghVqFLC4C5pkb6XQ7VkPSF
	 0nCJ//NEv1Gkt6dq3x4WxeUnQtbw/JFI/FcHzKCm3XfZdkc9XZcQSUfxBEHcWqHP1p
	 FrgA1ks0fIDTugXse29C6xUmp3lUlpMQQn8TsMuvozf3EV4PqhC4r94xgpCf+7Ivcd
	 K7GoVBML5iImQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 05/11] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:35:11 -0400
Message-ID: <20240329123522.3086878-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit f85450f134f0b4ca7e042dc3dc89155656a2299d ]

In function get_pkg_num() if fopen_or_die() succeeds it returns a file
pointer to be used. But fclose() is never called before returning from
the function.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 2aba622d1c5aa..470d03e143422 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1112,6 +1112,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


