Return-Path: <stable+bounces-233793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEcfBRb+1Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:04:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692073B7DD6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5062A306D288
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2C371057;
	Wed,  8 Apr 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP1JMrUW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9FD341660
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631684; cv=none; b=SmJzKS2ZD+71L3bzM/HeywlsvbMfL+BSlLd/8KtEDUrzPHFF8Aj7+Yz1GL/+K6xxJFYPbVymlCz8HWZnJlfNMKJU1URZrA5r0Wm4yoMN5eQvuqjCZuJljxuWbofnx+fE3XZ6D58+k0EX56L6C+GZ3nwgSr8waJHypNWXnFyR3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631684; c=relaxed/simple;
	bh=edO3BFPXlea+cqJl8XCSCE52FEybAwQLAS/TDfDiH+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xxwdebvqyev4HMUnV70GMrWIrb3MVMEMESI2RNUyMoPTSJuBzVOx+KXDjMvEp5NeOSWno36h5R6LLqdIHolhf31Z2W5hCW1VPYU3W2MlDWkl9a/aicVw5pgFBMTbDw5n/FmqM9sZ0YFBlUz/Oy3bkHZnD5VFKFLEeDq0ibu+2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP1JMrUW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89cc797547fso69868286d6.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775631681; x=1776236481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgVbyVFvTMOOobCmboEzJiSzpNTMaTKxGh/qViShvW8=;
        b=LP1JMrUW5lFqL5C6DxLDla6u4HAe6BzHhP3cZCj2JpxZz2yecROh/yh9vMdHeHrQ2q
         TO9nJdQzIkDOsGOUJx8cnjEhnglTiU0aFrW1Mi5idI5MAuJW3Xpub+zkzszTA6LOHENg
         3HR77i5GO0wuVYVWJHHCVzuIn8IpSH/Ca9UdbN7Df/srFKx/TrLxxd43nR498OxlkQnS
         IQGSTF+N8uxnWTbgPRA3FtHiiVOxW+A1f+S+zgdJ3K/GUK1wBSHbesZdVpejbKwM9oXy
         BcPm4yICYFFViX9tEDPYCf6HBWpvWo7Iu6++BSWzWfi7OJD176Grm0tizK5kGsdof+WU
         ruUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631681; x=1776236481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgVbyVFvTMOOobCmboEzJiSzpNTMaTKxGh/qViShvW8=;
        b=LM9e2cO7LuZc0C/sCZSlsKX0LoeN61ABNj1krhoc7zvu6seKQeZcgdA7oKxP1R0kIa
         E7ITrObMTUL56BFkw4gUz9FXxxEsgU/CiyERe0/TJJOZVppbUuG8tUmsDTE3Bx7hAVm3
         9EcKjlY0LjECl90fA00o7VKBc+kzOa8vjG0Jv3Yt48NvKi+dyzZLEm7ebwOgwG0ohEkU
         R3md0BeXaADUqTeIvpmsCbzVwFjWIR2YS5rS4Rbv/1ntP8prBLtJBxUh+7sYYSaJofNk
         /7pBCVzt4GMcWrFi5fi21EyCFib8nDVgBQncuY27xwWZhyv2Ujt0b+JPe4F60xQViTQS
         TPKA==
X-Forwarded-Encrypted: i=1; AJvYcCUSvynmrpsjszSx6RpWka4OllyH5u9umWmLx+CFbJa+p1kWALMfja9ftirJNepUQGKGfvZxgyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6LDCldvUJ8rTk1W13LJJXQ7X6pssLVmcumKsf06Gs6pqjc+L
	P2pERLqDWQIcM9E00ZFeVussFPtcxwzY3ks3ueYzaN3ebe4rrpsrqS3Q
X-Gm-Gg: AeBDievBXBhLrw5chUpvEtrDV0jOZwxUn5NyaEDQ8C2WHZCJ2bXzWVutZJtPOp8xONb
	/lZ+O3jtqtHmhL8H92kcWsVY8MFZ+qPBMILYBh4EnUQEVfS83DYH5cE2H8NSE/hxi90HSrMGWGw
	jDHGz3ach50peuqs8G9dJendr15DkH7yyI4NGXvZj/8k3qHnTPmPWpsOP6ow265M6DPYZ+j1wV+
	MKj3Ejl+afCNGpGoOHeE8SdEdsleWz04pJHgCfqzCxaP9BBkcUAaSZcfsYQWNsen9LHYnrx0kMB
	O5kGHg9aAMD4r9kY9Dp2hTOGcznHDY7hXQ0kPmqGVHc4lg9wfupsePkXypWKi2Nq90OsybHwmhl
	cd7zRGkDSdcWAkXfkhF7N82YT6jdcToXo44baXu0z6FmkNkeeBrhY1NfIf+PJGy3oKDpUH4k5fh
	4aasVfF990D9azv4u80AIeJNBo1lMVHK9wspC4fnbK1POZ7RHyVcqBUATRg/SqLiA1Hrd9bpJd0
	zXFphPufyBfY9JbGZAbC1xYBKg=
X-Received: by 2002:a05:6214:c26:b0:8a6:d318:4909 with SMTP id 6a1803df08f44-8a7020bf953mr327652746d6.2.1775631681042;
        Wed, 08 Apr 2026 00:01:21 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a522sm163454596d6.32.2026.04.08.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:01:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Wed,  8 Apr 2026 03:01:02 -0400
Message-ID: <20260408070102.2325572-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407164435.726012-1-michael.bommarito@gmail.com>
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233793-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: 692073B7DD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Building ARCH=um on glibc >= 2.43 fails:

  arch/um/drivers/cow_user.c: error: implicit declaration of
  function 'strrchr' [-Wimplicit-function-declaration]

glibc 2.43's C23 const-preserving strrchr() macro does not survive
UML's global -Dstrrchr=kernel_strrchr remap from arch/um/Makefile.
Call kernel_strrchr() directly in cow_user.c so the source no longer
depends on the -D rewrite.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: https://lore.kernel.org/all/20260407181528.879358-1-michael.bommarito@gmail.com/

Changes since v2: trim commit message per review.

 arch/um/drivers/cow_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 29b46581ddd1..ec8e6121b402 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -15,6 +15,12 @@
 #include "cow.h"
 #include "cow_sys.h"

+/*
+ * arch/um/Makefile remaps strrchr to kernel_strrchr; call the kernel
+ * name directly to avoid glibc >= 2.43's C23 strrchr macro.
+ */
+extern char *kernel_strrchr(const char *, int);
+
 #define PATH_LEN_V1 256

 /* unsigned time_t works until year 2106 */
@@ -153,7 +159,7 @@ static int absolutize(char *to, int size, char *from)
 			   errno);
 		return -1;
 	}
-	slash = strrchr(from, '/');
+	slash = kernel_strrchr(from, '/');
 	if (slash != NULL) {
 		*slash = '\0';
 		if (chdir(from)) {
--
2.49.0

