Return-Path: <stable+bounces-164933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFEB13AE7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972FB1894F37
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE5265CD8;
	Mon, 28 Jul 2025 13:01:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA64A33
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707676; cv=none; b=Un/30iveKI1yKtf9rknvm4h9odKxfltkOYHf4Bc0FdbtUU0GFca+lviAf4h0XjTDe024tQ+4z20CyBog0D0DDz2lVw//gv+5BI7XHP1xiBaBiQfXvG3QIgxfiO7UJUH/d+maBoO4EQXlUcnlUnmgQdHYAnA/8hbFq571JBlxeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707676; c=relaxed/simple;
	bh=RBBks7ElwRnE4tdQkdlSokumKHd6riLazRHa9i1DBbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4aAbzGFYfldeOLqoMPoHF1wRZXlRE6RBrEMSfF5+yfotgPohWftOVW16T0ZOilKoOgsTBbdk0H2nWPkBPGcFKocW3yqG5ACQK406EtkVvDV8HGu7O9Lcr1So3e315d16KrdlLdJqlrFDuA6NjNJv6/0gbeZ/QK2G7pFrpD+tfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4brJWW6K58zYQv7h
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 21:01:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9108D1A0F66
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 21:01:10 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCHTxB5dIdoqAwaBw--.4896S2;
	Mon, 28 Jul 2025 21:01:10 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org
Cc: stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH 6.6] arm64: kaslr: fix nokaslr cmdline parsing
Date: Mon, 28 Jul 2025 12:46:44 +0000
Message-Id: <20250728124644.63207-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHTxB5dIdoqAwaBw--.4896S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUXr43Ar15tF13AFykGrg_yoW8Wr17pr
	s8Ww1ayrs5uF1UAa4DX3W5uFW5u393t3sIya4UK34fJay5AryUKFWFqasavF4UtFyUuw12
	yrZI9ryktayUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
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


