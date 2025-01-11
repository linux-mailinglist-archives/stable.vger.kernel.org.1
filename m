Return-Path: <stable+bounces-108268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46565A0A392
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7F3AA6DB
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02081632F3;
	Sat, 11 Jan 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UIk3sgLB"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-69.mail.qq.com (out162-62-58-69.mail.qq.com [162.62.58.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891324B256;
	Sat, 11 Jan 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736598077; cv=none; b=A4U6LTD5opv0ZG2wyzxtUripUnOhhbPqtX+McUmiYaDjZhd4Y+lg+AcQf4N7N9OmwQ2fy0utd5GqeHTKcmgvzuzXxIRVUChuO78GUwSFlBvtlhsHgpLOE7oJdwlu4dFQu/DradxR9I7ocwMF5zerU382k0aZHBOGIN5N4lAG848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736598077; c=relaxed/simple;
	bh=16uvyolSRo286m8yQNvXbhZmHPl2EyM2u2hDRkbNMYw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VCEjWroA7s60M6Kgpqo8a+Jyt5ycv7G1gUVoYd5ZyK5wLmdM8y0oRD+b9dj9yHTeuRUSR5O7pzX+SsK/vCRzoTtwl3aPcC4b2ssGiTgPbWCBR2WZmXCerykmhqCaoVXNy3jDupBOM/zThD1jVdwp1pciYnffhrix3zxug00nDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UIk3sgLB; arc=none smtp.client-ip=162.62.58.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736598067; bh=rjIk5IWPX/sFgqupdD4dSWcOuD6lN7+QBI/rBP5fj18=;
	h=From:To:Cc:Subject:Date;
	b=UIk3sgLBgDHTzb0ByMHjl7qXH0T2/7HNIMjfAAwGcIwhud+ogX5XjDdYGgbQyKzgD
	 Q5hYMOrVhNKhspKLrI3rkAbUFXCSfJKpFKnwMgwzbK7elsr0wX1dum0kVoW7YJeekJ
	 0q16l49/66YfjCu8bJ1M9DSAKlCIYFsElxipUlz8=
Received: from u22.. ([208.115.96.45])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id E24AD6B7; Sat, 11 Jan 2025 17:56:36 +0800
X-QQ-mid: xmsmtpt1736589396tszkecd4g
Message-ID: <tencent_4B60C577479F735A75E6459B9AEAB3F54A05@qq.com>
X-QQ-XMAILINFO: NmxDRtNfo6mLCtlJ3NUEaLEv/0UxDoISsTe+ak3zBbPJ4DaE9J0Bm5Sg35AlKD
	 xVEZndEBtZP7yjTu40DZ2oUisibTHpHr0mPtReka6BXItsdxGNZaDPulzeNrL14cBuM0eKXSeidU
	 V8NgmPhuJxhPjLNwX2lR3mtbBSSHsVVIGhzsHtkNUYTdXoK9t/ySxGrzHCOcwvyETY221kbeNj9s
	 PgoxUQHGkczthhqIiuQvJT4s/jghKb1WVRBDjkjxVYSZUl+TGONl9nyVbgG7+iTejWy5Q0QN9wBS
	 eMoA405b9zTJLiGBYqi/OUJEjGMuq3xBDXU1PA3e/n4gCBci0qS4qIWL04aWAhioXnMcycw5SgYm
	 nmv74Wa+agBgIDobFq+C+Imunn8z/5m5voXLdZF8oGK/LUkGf+REam0C12PogLO2GwbXO/c9Fuz4
	 MspoA2dZbRNa8uqQKpuBxEZn5LG2DkSSCebUeby9/UDKHNBogelDYM9Yc82N/CAZR2iM4uZOehw8
	 euo86vPTdNs9u3Sji123Vc12K+6pWdLx+9snYJbo/u1PV/NFLlb04peJtdBRdzPIKVPVqXIAU/7+
	 CJ18duhpMjrkR7WebAd0FEjJ4dxNSa/qB01HnJpTk13va4OCsePnOcj3WjVgwedrU6ZqGak640Qi
	 oMpCv2TYow0Pj43EHmHt+79ceuFCKlBUhJCeL7pRJKC9Jv5wdtovwJVVbtQcLZ2e8SCHrs2cOkVE
	 ZUIdGSfaFKYk6HFiYovSMibCfFbPFqXJSAkXAJvj3iXHGDx7j+EzI1zHwflXb4D5aiuVRIPQ9ob3
	 dD9IrzbKY5rdgDJo/LxB3R18ZesZ2zcjp4sju6xC+nkMWj5ec3r9rURHGPUC1RrBHzh6qhcAe+8j
	 rEGOG1g29it7go1dcemiAuMbWPWyWdV2NpsGsROty6kRCBi9K61+UPhZ3OB9vOW2f4HdD4GtmnL7
	 ZhHtN/QvYYTy1yXSMEqE8e5HcJfUyIsuLn8DuV3Z4T53JzKgTsLq+/RidJqyyz2ube5dgH3KQH0x
	 mieEzFHVIr4UBgdzvUw7+/JdJiJZsa3sAiNQceyl1CkMoZPGa+1DJm2dtEA0k=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: 1534428646@qq.com
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: mark.rutland@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Yiren.Xie" <1534428646@qq.com>
Subject: [PATCH] arm64: kprobe: fix an error in single stepping support
Date: Sat, 11 Jan 2025 17:56:32 +0800
X-OQ-MSGID: <20250111095632.738024-1-1534428646@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yiren.Xie" <1534428646@qq.com>

It is obvious a conflict between the code and the comment.
And verified that with this modification it can read the DAIF status.

Signed-off-by: Yiren.Xie <1534428646@qq.com>
---
 arch/arm64/kernel/probes/decode-insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 6438bf62e753..22383eb1c22c 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -40,7 +40,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
 		 */
 		if (aarch64_insn_is_mrs(insn))
 			return aarch64_insn_extract_system_reg(insn)
-			     != AARCH64_INSN_SPCLREG_DAIF;
+			     == AARCH64_INSN_SPCLREG_DAIF;
 
 		/*
 		 * The HINT instruction is steppable only if it is in whitelist
-- 
2.34.1


