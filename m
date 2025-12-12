Return-Path: <stable+bounces-200892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E40CB8764
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64EF4300FB37
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91B02F25E4;
	Fri, 12 Dec 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb/dtfAV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B13128CA
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531765; cv=none; b=G/jppnjxFVSFyHgiYpxx2D7vzU1RGvNb6hbxTBOup0mOUE+pVYOx4KVHIO6LksjI6DV4LS+zbBjynkuJbjEWNsRApWlWfHGjqeb165aJ+H4lVdBJq3qXOXwIRySPBst58muvxjeI+MavOc7II80LvTUAlltqzgdEw7mdjBlZUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531765; c=relaxed/simple;
	bh=xbfbJ+D25xL5Y2kJ+E8oaCoCd5FlSh9bYUODypEu0zU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QIFTfbXvLOp1KDzampFTVV3PizRQc3ygdVfUkAkx297wbQqE49hIJYpvdmWkYDAvtQt4TQTSKU17Lm+OCGqi7vzzxYle+yzO1+JbD5M73WJoCTQDEelmyUm84ECipQpuln6SUHwk1kj8mgsu83vTvaIp+ZUw7670xJUnion89GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb/dtfAV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso1274970b3a.1
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 01:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765531763; x=1766136563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TqBCCuMDo8XkanA9t4q1Yalkj0pckYKIk41K6zsONlc=;
        b=cb/dtfAVIUQZFlLOHUPkfGReKTW+SvEDtxNcQAkDJjxWRbviR56ev/6RCyQxwKzipo
         b2ScCJipi4UBaECatIfpMX0Va59TfsOkVcfYI9/xeQyIKycodPRnVl+edRtqGC6E1VFG
         M6BKCQHU2na0CW85gm250hyOd6eh3Y6p0/96TJUSruZ/FLUi5oyf//oOgHw4ngjFaVVJ
         GIJ3fM1w+PUSFLTNr2WoxYnH6JKLetT356+bKSODsMId/YokfavFBRl1A1yETMmGHL43
         jkTtZ1oZ5J5/O3Ajo+qrt33/wKh4IgzMjBlZ9VgrDaSgMxm3NLww0CHlwFxYQkgkwXwJ
         6L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765531763; x=1766136563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqBCCuMDo8XkanA9t4q1Yalkj0pckYKIk41K6zsONlc=;
        b=jRN0jgfzarcrJkfzmsZSgenyOgchHXuWmMegDTFlymTezkBaxSE3w1i3uLAMS9xxxk
         SgJPFmpo/N/87MoMBAR8OCWmYi7znz9msZBI8Tc83mlqT+DNYc12HUFyAZ6vTEn/B8gi
         WX5eFctqWXrEuSAxQSYRxCeyR/FKi+wU07To2mXzXmJRt35Vm1ZeedC12IYcL2NkI16g
         JH8DdywvTSx8/pBTX6SAGoh7R0HYDt6xD0JVZXdVW3LRVg6b664ep1lv0xzej0zEygcU
         RevCZdcICkUyiGEzLUt4LTDNbxiUNmVJrP4qYWXRwcXrBKLljGnO3jLr4lK9tS0yjggw
         t6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXOeCNFM0yw2RCDEQfM9tAN3DEcKeyvHIwPjC45Xkmr40KnaqHqm4uqHbxtqeongcxWe0RXZrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KNzhlXjOzceVCttVFMcz8YBfNR99JkMcjDI46Zk7izvJHfE6
	R20BV4FPUyMbc48tvrwdOVsKCh6biwAW565o1UKvPso6tdZNbhUAC55h
X-Gm-Gg: AY/fxX5B7swO2KKJ2jDMuCLRlTTS4dqJvjJ0Ib4YTcQfVIjoCv0VbWMV7oGK4xLjri9
	2a2IcWjIC41RJ4XWB6wUZsPgs/NM4oa9p9K/zwAji86ay9eFicuwdcRkJ1X7ss/uk1sMNHHgIhl
	+tBePdFZjhQ1a6Bor+GQ0JkLRq/Yc2P60+vZmYXc9NPhJKt1b5rOz6E4xN3QlBJd9SlfBhU8jFc
	rng+pAmGcwfj2s2znvvXmI671bOwDvni5NUqn7bu+pdQ5E0/3L0XkSwCs+WtxDEp+zadecRYLWe
	49PlwL7BZn8+5HfR9jXSqHKfgXxV69kLBuh8vDjWRzwEJWx4Am6835unabSItsPUjF4YtsgHA+M
	C4dfdhUL8eTc+AS6Ud5Fz4qJX75M98qcIeoQJxnqH9btwBBBnyjRBEfHNewY3cX/MEd9asg8B56
	RUZdJrwC+G
X-Google-Smtp-Source: AGHT+IE4GkrmjiEKubwBC3E06sLn47erp8gSJb/6WMPDYnjsxpuc5QHpftFLPESuDZbHLqLMyjd9pg==
X-Received: by 2002:a05:6a21:e083:b0:34f:e712:348d with SMTP id adf61e73a8af0-369ae1a9b27mr1432502637.30.1765531763439;
        Fri, 12 Dec 2025 01:29:23 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c0c206cf429sm4753659a12.0.2025.12.12.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:29:22 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: pmac64-cpufreq: Fix refcount leak on error paths
Date: Fri, 12 Dec 2025 13:29:09 +0400
Message-Id: <20251212092910.2454034-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_cpu_device_node_get obtain a reference to the device node which
must be released with of_node_put().

Add missing of_node_put() on error paths to fix.

Found via static analysis and code review.

Fixes: 760287ab90a3 ("cpufreq: pmac64-cpufreq: remove device tree parsing for cpu nodes")
Fixes: 4350147a816b ("[PATCH] ppc64: SMU based macs cpufreq support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 80897ec8f00e..0e0205b888ba 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -356,8 +356,10 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 		use_volts_smu = 1;
 	else if (of_machine_is_compatible("PowerMac11,2"))
 		use_volts_vdnap = 1;
-	else
-		return -ENODEV;
+	else {
+		rc = -ENODEV;
+		goto bail_noprops;
+	}
 
 	/* Check 970FX for now */
 	valp = of_get_property(cpunode, "cpu-version", NULL);
@@ -430,8 +432,11 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 	 * supporting anything else.
 	 */
 	valp = of_get_property(cpunode, "clock-frequency", NULL);
-	if (!valp)
-		return -ENODEV;
+	if (!valp) {
+		rc = -ENODEV;
+		goto bail_noprops;
+	}
+
 	max_freq = (*valp)/1000;
 	g5_cpu_freqs[0].frequency = max_freq;
 	g5_cpu_freqs[1].frequency = max_freq/2;
-- 
2.25.1


