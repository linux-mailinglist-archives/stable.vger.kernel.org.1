Return-Path: <stable+bounces-161882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B9B047F0
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 21:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE133A9552
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60A1D5146;
	Mon, 14 Jul 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EKxP0IJB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4A1494C3
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521793; cv=none; b=iH34e+AaJpBInkJZmthfzQqj0GwHLjKzRw0tSF+CaIz9/gZwTzfUZU+A/Hsmn8NUx5z5Rg2GbEIkXH3nWgr33n4qrt8EJyV6G2ulfupNl5YDnTFYH9BKY3StPCxwkHM54s4FyI3D4y/ySX8KvNY8NjCrjU7w+QFIxcZg1a6+DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521793; c=relaxed/simple;
	bh=pqJ98NRUNId5tkMcqcycViCk1Vu8rjovfCCq2je/IPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uk8HV+Rz5Mjw4B5/5PP48GOyZMr9f7OXHB9u2LrLoQNqYl3Y8USKrt/niqQa9w3IQDbyHYL2vdNzn53Inu52IdEJ7744yBe5wnLpxZsyoj6LAQiKDSYztFFDeyvtaGMxeQrGgQBW1ojAHKh5AiCerqQv2GEEf/R8w820f460/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EKxP0IJB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so691335f8f.0
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752521789; x=1753126589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYqQ9TjJbT1LLuRhivUO6Zo1A7nuXFQGAsqqr0gCf9E=;
        b=EKxP0IJBnuuwy83UBTutWA3wYvlgQC2wj9ujJDTdNv3OlX+PwVkp+GulQQl4l5q05z
         MqwJaNXxpZpsXwb12+FCioTVgCULCzwcGozPwVl/87nf0T9QzJu3uRzFixWCgJ9uBu/L
         0e+hNAPOSxbW4Pq7oLVERUQy0Blj9bz6jVDP3YZbCgSBvcAf88gNSrd9SVN9dZ6sdzj3
         QPbdMLa9V1AsJF44wGiZOBcL8v8ltp7FidNwf0WgfxnZRjG/5Pvz6Fz4HKA35IqakcB0
         gyNr+mXqTvLvVEOaN+bPVGJcOmK752lM74wjBm8WP63HTenhhqiRYmVlgyVWTV5I4b1b
         ILqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521789; x=1753126589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYqQ9TjJbT1LLuRhivUO6Zo1A7nuXFQGAsqqr0gCf9E=;
        b=EDcU7gYnu0P8YqShy906B2CH1ZMN0vdV3ls62qdYLaiKzQnWeQmegIamXaCkHTAf6A
         tsiiu9g3mBLD/Yp3bR/hUVoh/If9JsJBQNAv2Y08i/udzaCkDoGXdDO8zbcHSFjELgs3
         GInItrMcd9nhLc+vmC0zQuB4DHPBSXHprnL82HApc2ClXNpCFYFmV5h2c+bFAzt1fyAK
         Y9UHVtneDvP29wLadF0l9+ydwBj6J3usOa58xlkaYcDH6UEARfBQQZFi4u6q8APNUTT4
         TLv2KAnfIDlu35m6qB6z0118XqvpyRKkv/yCNF8Atz3/Yc0JaE5Wfpol5sz1n6LpMVFU
         Rb6A==
X-Forwarded-Encrypted: i=1; AJvYcCV28IT4OqMgTONOkizBPE1klUNnSFAZ6DuL/2k4GnkUc1li/yuERwR3O5dqOqn1t42Eh9emtbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/03vNpSrBu3BEuqHn7o6LeDeB8tCpikV4KeCW8GioOcDyvTzf
	9A/+4w9N/HVWP6TboHnxXX5V9B0/9DfIJwOz1HPDs/3IvpFOWe1jg2ASfFQp3fC8mriRK1xNig0
	hVv7YXjc=
X-Gm-Gg: ASbGnctRmtUwV2mTGnnYX7mhgHgdZQFvgyHxCN4pVRd0gURX7gH4CHRTQuuacI0T9JD
	k30mmOXN+DbNCeJ0pRXIb3KpkS1nCCnSaa0/fhziROkGcWFXPTYUYsj1a/2X1Ogn0OrMD4npLp4
	UWkTVBXUQm8w+XTGuGuBD4a/e0JoKmXv6pwuv3/78NCstev3q0c1wMA52qIy8JT+zaPPX6Y97cT
	HscPVykpyjqrItTqYmcKfv1JFR/nfEZlX8lP1U2/TCmpq9FN6QzuhWmvYv8U0aj1ig7CFc/86n3
	ySB0moc5IqPAWncMZswn7AR0k8eHy02oBT63e+8AsnhWInKfTr3rBCwYam+OKp56fxKoYkWoBwY
	CN7adXmH7QM1hyJAAlygbJTmxRYbSNou0t01g2pPDeehIOQ==
X-Google-Smtp-Source: AGHT+IFXOXkPtsRgzHB6uGDgtAShfgUfN6XQSNaWu7j3acz2LGJzjOCTMnaRLVg2v4gQZ5bDJQw7mw==
X-Received: by 2002:a05:600c:1e11:b0:456:23d4:4ef9 with SMTP id 5b1f17b1804b1-456245eff8fmr6349915e9.3.1752521789498;
        Mon, 14 Jul 2025 12:36:29 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:1466:dc00:11d5:2c1:dc02:c7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm12839356f8f.8.2025.07.14.12.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:36:29 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Subject: [stable-5.15] x86: Fix X86_FEATURE_VERW_CLEAR definition
Date: Mon, 14 Jul 2025 21:36:28 +0200
Message-ID: <20250714193628.7273-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a mistake during backport.
VERW_CLEAR is on bit 5, not bit 10.

Fixes: f2b75f1368af ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 63b84540cfb3..b8d945d8d34f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -418,8 +418,8 @@
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
-#define X86_FEATURE_VERW_CLEAR		(20*32+ 10) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
-- 
2.43.0


