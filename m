Return-Path: <stable+bounces-152768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC49ADC92B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3DB3A9560
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF93221F2C;
	Tue, 17 Jun 2025 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e4L6vCny"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15063202F8E
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159136; cv=none; b=ujVgogCwSSrKKoGlltjUlmDgBb3E4VqGTRD6+CXn8+Yv0nTUfPqnkNwrC0fShAXg1W7oCHduc8qMSVLpLB5YEzTfn7XMm2Ltq7iVrEACtIHBTPK0R21+CLEyIrMoRSFUhw9TaeIOqm0VCSKYDkNr5Zw/MGuhztPq8BRZSANcjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159136; c=relaxed/simple;
	bh=29gHefX2Acn25Pr5rBxaPZDTCIN7Ah6ZohM2hamRncM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZflSvaox6UIA+qw2UH9ZNhHuFGm1GkKkvk0sVQ9ePLPE9g239swgkOObk7VC3YRM+f9ilamKamlDVWTr7jH8rd3mR+GnwSJHU8HLjxX4lGI/F1BmhPWIYHCjXBOiWjtnfOAjyOlE9Nyf+j+R4K0OZoPyR4hjAJN4Ng8Pt2MSPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e4L6vCny; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6G
	eYxXZn0rnluBGy6K6is1YhixDyTKsLsZVNuTi6rLk=; b=e4L6vCny++ZaNjE6PT
	2ly3OQ590aLvLqmHq5LLyYSJw3rS496IFLKfS1S6gtkFxBG93UhLj3nPJ8AItb7s
	zK5HaEkiCrK0Xv8D7q6BZkll441MOMf3EXeON49NMerX33HWVHyfkZisRfJ2kL+q
	WeGE7brEDGDeI1Z3V6XSW79v4=
Received: from pek-blan-cn-l1.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnsa_7TlFoq7RtJA--.32629S4;
	Tue, 17 Jun 2025 19:18:32 +0800 (CST)
From: jetlan9@163.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
Date: Tue, 17 Jun 2025 19:17:56 +0800
Message-Id: <20250617111756.970-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnsa_7TlFoq7RtJA--.32629S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1kArW3ZrWDtryktry3CFg_yoW8GFWUpr
	WrCw48KF1DXr4j9a9rG3W2vr90g3srAry2grZFqwnY9F17CasxZ393Kay0g3ykurykX3WY
	yF9xJrWIkw4Iy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNJPRwUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiWxpoyGhHg2G4lAABsB

From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

[ Upstream commit 426db24d4db2e4f0d6720aeb7795eafcb9e82640 ]

Check if policy is NULL before dereferencing it in amd_pstate_update.

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20250205112523.201101-11-dhananjay.ugwekar@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[Minor context change fixed.]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7a16d1932228..62dbc5701e99 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -482,6 +482,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
+	if (!policy)
+		return;
+
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
 	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-- 
2.34.1


