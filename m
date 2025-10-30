Return-Path: <stable+bounces-191689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B494C1E66B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 06:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF0DE34A756
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 05:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14B32BF58;
	Thu, 30 Oct 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfVXhoZu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0732A3D8
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801496; cv=none; b=sVWT1J91YLgfxvjEjwdbxdz/FwMgNNYr3/MTR35FvUxY77vLrXm6hVSeRVNPhakmeVl/aexyFR1sVqrxLfrYR9mdmFqwMGl4ABvlXXDkDK7OjEOe7Koo9tOUuauzSb2J1x513Y++1Y9AtEsgCfbTtTERjLyDsNRLiNxc7amrk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801496; c=relaxed/simple;
	bh=yTB2Ypsw7haBzkxm1rv/lmJKPxOzHQ8R5zcpQamqQkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvunlFjy3qXtHXJpZopzXIRK+Dd/i34YK+QgxR13jKSdk3kZxO0rfUNaHLdm6wA+AEPzSs1+C3CFtEeO98IEo/MYg8Rqla42KlOmiywFSRAu2AwA1mfCp0pYseIV7hXOE/a+KIsSwnxUjfDtZIqchwOS/McDw0qOhFFFUnOZHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfVXhoZu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f5d497692so905374b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761801494; x=1762406294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74tfITgN+jliSCJFJEsvOUjVL101aogmvXZmW0Fyfy8=;
        b=PfVXhoZu69k8RxK/on8OOFYZeTwNGTCM/LYeKCRXkjtwdnePnOr0EsyCmV0s2Znxgg
         h2drZpduXpahge3oVBDwptf8J5LjdkFH8/LcrQmttdzdMnhT68EvWzlf2xMWV2eSpb7F
         0p6qixOewFa2NYD6RyQ5dm64GOeDmhh3w52bTImuxgeLCJnk5+l+jrFlBEVzawYUYPFi
         YlM/9r7/3/98XmBPTyiiGfp+dCCLMiea3vwJ7PjXxMNqPgsp110r+JSyUoYA76e0jkx2
         2/SbNhJWD1NkdQOlV+A+eOTM+t24rdI2x785HRsWbPBq0sMos1k5NgVWty4luMkhnujd
         nbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761801494; x=1762406294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74tfITgN+jliSCJFJEsvOUjVL101aogmvXZmW0Fyfy8=;
        b=rImwJDA/LZVupgo5opS7HH6E1yztMAKR6NMuppH61h7nN/Rbc/yqLju7O8BIZzO66q
         vri+D/TwHDR2uMr8h7Be2mvPK4xdsa3k9niMfJLDQNL7u793/DdyMw6C/qeMsqvbKom9
         XytAV6xLkzQ/ANJtpFGVQ+5pYdpU0NfEM5nyTabYjLTfcQJJTuPIXj4YPHKsjOR+6fBq
         rQpHSwYRofZsNKTk/iuB0psuokw0pl0RyvtPNxKi6xRx+DeMdB4sqGVfUq42IsVvzoqZ
         g4BBGHkwGL7vRgAvGqVu71fZW/852kVc4BlmsHRsP+xHIkB/GZZCQvZr2Aqx0rAYAEHh
         RDjg==
X-Forwarded-Encrypted: i=1; AJvYcCVaj8vgHFOm91OW2a0adI1dixvF2PpJjaHCKECdF9Ok3WPGyqQfl9auK3EereZLTG2hXIBK2dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgY4NET2Q4l53X7a5Wre/r1tIxnutHZoL03tGoIRfD5Q1SWZE
	LYeDxX0zUdL5R0qEsJ21hXesgJtmxZ9752T+JWJtygRnHogFFe3pPsg0qsswcrwmZ4k=
X-Gm-Gg: ASbGncuwCbbNSxqkVLIIxpaWjn6jDMatHTdYXee3xuB/6p4MFH9U1Q0/Klo0YuZLAEJ
	0gZpV7MJgc57D28SlODN1x6Onfv2FN+blqGapqYOwkokA0PWGFjcTkZXolnqk0uR12EWaSNsM52
	kOKjEg/ODqvwvagUqFPZCDPOOUmeYX72NmCLHLuzjn6MIYgN1AzBPqdyQsfsAvcrsKDGmltSP8S
	5zmGXXvG4Yi7z9kGPkxTepcQL+xjOoDQ1faPb2mkKKkZhr5YqLv1aSg1HeS4RmP+g1HbdL96783
	k8aJr9My56uCRoJDK9TkwIZN+qO7VZTyETnSGhfPp+7lk0lLL6SkJ4t2zPEW0XtrhmUxgS8Md1H
	d/lTBlk6jQ6eRXSRnKJ16SHhSNOgnqRFxLXgEaUykJ5WPn5HYqLu4P8ZMYwt1yoxGSKSr5/o2Ms
	3kX4Yyf0WCDSQsy6xJ2B57lYKn8eUroqyN
X-Google-Smtp-Source: AGHT+IEhzK1oEYrUQqCBBSqPHXsRDk4cferL/O21CP4C7/ru0ksQFcHNu9ziLSsqEz7nZQmTjmZx7A==
X-Received: by 2002:a05:6a00:3988:b0:7a2:183a:924f with SMTP id d2e1a72fcca58-7a62cc6de7cmr2012742b3a.31.1761801494420;
        Wed, 29 Oct 2025 22:18:14 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414066d0esm17445157b3a.43.2025.10.29.22.18.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:18:14 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geliang Tang <geliang@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: add input size check in ofdt_write
Date: Thu, 30 Oct 2025 13:17:55 +0800
Message-Id: <20251030051759.93014-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")

Found via static analysis and code review.

Fixes: 3783225130f0 ("powerpc/pseries: use memdup_user_nul")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/pseries/reconfig.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 599bd2c78514..b6bc1d8b2207 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -366,6 +366,9 @@ static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t coun
 	if (rv)
 		return rv;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	kbuf = memdup_user_nul(buf, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
-- 
2.39.5 (Apple Git-154)


