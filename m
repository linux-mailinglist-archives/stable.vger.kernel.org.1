Return-Path: <stable+bounces-232894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFdCGEfgzWlVigYAu9opvQ
	(envelope-from <stable+bounces-232894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:19:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5363830CF
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7697D304C042
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D835A381;
	Thu,  2 Apr 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8+18lwy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF291EEA49
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099736; cv=none; b=KTWssiif5tB3lIyvBBtexq2QTy0VMUbrFRLoF2yboM5kWFR4G+prfVnzXxJWNJUHHrDqu+n26oKoHxf9eC0oDfgKK87iX/dCnAPru6GaVQq5cU7mme4To4KzGXe2rpMNMYuOLbh2JYAm/TqN6bJGF4g+9QVePvbOlLUbLitFF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099736; c=relaxed/simple;
	bh=+U5YCeLnFCr10ql6pv7WP5QPq8vkzAnNfXnFLLYzeYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRvV4bg+0Tp6z3PHQImclWaTb2dKaTSNZYR2YqI0fzDLenV3QxIcGJPq1lco6s/NXsAne4iGFj8dxmNGM+XoFTCSlSN/07oHwF9gnRL/8TVf3EwMxUkeVI1NdKwSG8Wt1/HiqGbtPdk3XSqxocYlIsol8DGq801ahlCuG+qyZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8+18lwy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so171529b3a.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 20:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775099734; x=1775704534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9STGGY2Htk5v7wwUUe6PKHmgTmA/fRjyuHgcYn5ATI=;
        b=O8+18lwyc+57Uz3B/K5J+KNzd08HDnmtZ+AdxiEAtH6grRXdtZDfIMnsVzaOQvdH9y
         PFmgLMOnhoRVO/ehCEDm9pQ6jtcIVzV3ZD85x6HMaZEwy1auAgk4pt1/4XFg2FRxgoEi
         FxA/k3fcQVyXEPSi+Z1oynaJ3hfQrZwRhzvbrjuvpYztR/nvzXnRFVTbHqrqHENzWf9q
         VKID7qcY3RVnGk8ZCiqjbvzrsSFLtPtuTlPfgbAr9VtK2LnQNQ+cgbH6seeaUeY7iqy9
         KudXhtETitPsdAJPq4vd01P9k9ifz0KEzyV3IIq7SJIDW49dh80y11pM4ShdBoEnZvYB
         eD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775099734; x=1775704534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9STGGY2Htk5v7wwUUe6PKHmgTmA/fRjyuHgcYn5ATI=;
        b=kP7m4gowpCmXQT/I928N26nGRo9XKV75JuDdHRMIv0Nk0n535vw/p0t35uVljjV//k
         0UxiO2Tqc01MklcxDWO2DNNSOuEplhhxy7e+fjVh8n0VqJuxQEkgET2yepeyKDV64z9X
         e9EfyTzVw0+JIrQKq5lkVrVb9ckGhsJ0jHCtm7KBmODQPMn8N7pHu87P48pDZoZIOfS6
         5c+6Af4Bo2/MV5Yb2FmGxGIg2jVIgFLbjwE8WBbJSmaT/gHYuEffJffeZKvq4Kqux1lk
         79o68bXH8bjZTfZp/e8HAMJsZtC55dh9WObOgAZh06PfVxD+UwSzkvMzR4jPIvUJSw0D
         Y9qg==
X-Gm-Message-State: AOJu0YxziFjnx+/6Cq3XwQKOGQeIoZRlGBBQDaLs2on5/cbSjwoIPGdd
	lNH+5lDfMmeyu8xdeWzzFzVTpzZlbG84NXDC+K7JTMmNZy11lQSFUPw/jpJFXr/N
X-Gm-Gg: ATEYQzy03AMD9Bzufp/IfZ1Oj5hxdJUI9IZbmSlC/DSKre8gRDWluClXParplmTvuhr
	0F2h+hajBu5RNATVJwmWGYK+Zm4ZUGMxHG+kdxmXBeaAOsDdDiX3BF73363KPBjMpZGXgyLMyBf
	ZpDZZhI+CWZ+7jC7Z+62GVS0+zn4P7pq8vvfw6ZvEArx26VMEtAyWXvcOQrRJlTQuUcdVjivXrX
	Nlx28N7Xl/ywy1+0+A0twFoGxGvZf5ZE3/tktJbvYiCeyXNn9Iswwyccvigw1pApiSQrgToHHEc
	55b1xwLBwGHSv1fveJwWlcaQei2mkZUr4+oXcZ3LTjUj6/B4lQxQ/yjcJvUTFpUKAszK/MK9v+j
	51yVw93Ctbmus+6sIlHRQxOae8EyN+Sak4X5Ib3zo23fBqPfrBwLulEQkBhsqtYPWZ/a6Iqcs+j
	70w7C5laQeGovqvRTQFPSc
X-Received: by 2002:a05:6a00:188f:b0:82c:d6d3:31a1 with SMTP id d2e1a72fcca58-82ce89b9465mr6273072b3a.29.1775099734153;
        Wed, 01 Apr 2026 20:15:34 -0700 (PDT)
Received: from abberation ([115.186.198.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261absm1518280b3a.7.2026.04.01.20.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:15:33 -0700 (PDT)
From: Daniel Tobias <dan.g.tob@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Daniel Tobias <dan.g.tob@gmail.com>
Subject: [PATCH 6.12.y] x86/CPU/AMD: Add additional fixed RDSEED microcode revisions
Date: Thu,  2 Apr 2026 14:14:45 +1100
Message-ID: <20260402031445.48620-1-dan.g.tob@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,amd.com,alien8.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232894-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dangtob@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:url,msgid.link:url,gitlab.com:url]
X-Rspamd-Queue-Id: BA5363830CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit e1a97a627cd01d73fac5dd054d8f3de601ef2781 ]

Microcode that resolves the RDSEED failure (SB-7055 [1]) has been released for
additional Zen5 models to linux-firmware [2]. Update the zen5_rdseed_microcode
array to cover these new models.

Fixes: e980de2ff109 ("x86/CPU/AMD: Add RDSEED fix for Zen5")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7055.html [1]
Link: https://gitlab.com/kernel-firmware/linux-firmware/-/commit/6167e5566900cf236f7a69704e8f4c441bc7212a [2]
Link: https://patch.msgid.link/20251113223608.1495655-1-mario.limonciello@amd.com
[ backport: 6.12.y uses a custom check_rdseed_microcode() function with
  a switch statement. Updated the switch cases to include the new
  models and revisions from the upstream patch. ]
Signed-off-by: Daniel Tobias <dan.g.tob@gmail.com>
---
 arch/x86/kernel/cpu/amd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 437c1db652e9..042849f576db 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1034,7 +1034,14 @@ static bool check_rdseed_microcode(void)
 	if (cpu_has(c, X86_FEATURE_ZEN5)) {
 		switch (p.ucode_rev >> 8) {
 		case 0xb0021:	min_rev = 0xb00215a; break;
+		case 0xb0081:	min_rev = 0xb008121; break;
 		case 0xb1010:	min_rev = 0xb101054; break;
+		case 0xb2040:	min_rev = 0xb204037; break;
+		case 0xb4040:	min_rev = 0xb404035; break;
+		case 0xb4041:	min_rev = 0xb404108; break;
+		case 0xb6000:	min_rev = 0xb600037; break;
+		case 0xb6080:	min_rev = 0xb608038; break;
+		case 0xb7000:	min_rev = 0xb700037; break;
 		default:
 			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
 				 __func__, p.ucode_rev, c->microcode);
-- 
2.53.0


