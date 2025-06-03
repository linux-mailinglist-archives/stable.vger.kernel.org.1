Return-Path: <stable+bounces-150713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7EACC758
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0300F1895728
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953D2309B5;
	Tue,  3 Jun 2025 13:05:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39922F740;
	Tue,  3 Jun 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955936; cv=none; b=Nf5WsoMwkQF15XJwAmyk6PqEnuLGFO7faLCqm7okCtlnw8FnF1VfOG3yUooyJJKXW+V48YykuGUlxq43tEE0rDhNuhRBG414WiHGKEpwASNtdEtDSGIAaYp5DFLXL/Fug6Q2+GddJ1x1zq9HOKY94gbcip4qKiq1k/SJN2YVpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955936; c=relaxed/simple;
	bh=Zknqswh8USYRXH9E7sikPWaoUxkbdqaBWulo21WEy5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dm5HpTrgvQT/CTo3TVEHWAX3H4aSsYIUR6pbj+qH970gMyjU5bPLrmeMlPERlqjbezAXW6rId5lCwgIGlDeLowph7DYCXRQOVMA/qWMcADC0s9T/6mIEM58lmkLc5etfygpvUjifbIaoTsbJbQcLBOcc4x1ynE0GZRwMyOyjTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBWCv6b7tzKHNFR;
	Tue,  3 Jun 2025 21:05:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4E9D81A17C1;
	Tue,  3 Jun 2025 21:05:30 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgCn+MIQ8z5osdqmOA--.37720S2;
	Tue, 03 Jun 2025 21:05:30 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH stable 6.6.y] arm64: kaslr: fix nokaslr cmdline parsing
Date: Tue,  3 Jun 2025 12:52:33 +0000
Message-Id: <20250603125233.2707474-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCn+MIQ8z5osdqmOA--.37720S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUXr43Ar15tF13AFykGrg_yoW8WrW3pw
	s8Ww1ayrs5uF1UAa4DX3W5uFW5u393t3sIya4UK34fJay5AryUKFWFqasI9F4UtFyUu3W2
	yrZI9ryktayUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFBT5DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Currently, when the command line contains "nokaslrxxx", it was incorrectly
treated as a request to disable KASLR virtual memory. However, the behavior
is different from physical address handling.

This issue exists before the commit af73b9a2dd39 ("arm64: kaslr: Use
feature override instead of parsing the cmdline again"). This patch fixes
the parsing logic for the 'nokaslr' command line argument. Only the exact
strings, 'nokaslr', will disable KASLR. Other inputs such as 'xxnokaslr',
'xxnokaslrxx', or 'xxnokaslr=xx' will not disable KASLR.

Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
Cc: stable@vger.kernel.org # <= v6.6
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 arch/arm64/kernel/pi/kaslr_early.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 17bff6e399e4..731d0a3f1a89 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -35,9 +35,14 @@ static char *__strstr(const char *s1, const char *s2)
 static bool cmdline_contains_nokaslr(const u8 *cmdline)
 {
 	const u8 *str;
+	size_t len = strlen("nokaslr");
+	const char *after = cmdline + len;
 
 	str = __strstr(cmdline, "nokaslr");
-	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
+	if ((str == cmdline || (str > cmdline && *(str - 1) == ' ')) &&
+	    (*after == ' ' || *after == '\0'))
+		return true;
+	return false;
 }
 
 static bool is_kaslr_disabled_cmdline(void *fdt)
-- 
2.34.1


