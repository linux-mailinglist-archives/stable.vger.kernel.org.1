Return-Path: <stable+bounces-104451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E79F45A1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B633216D54E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836791DA0ED;
	Tue, 17 Dec 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c5Qz1fMd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58216EEB2
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422577; cv=none; b=G9hQWwIOrmK1QWVNTNXLLyY7L4O4iL2R4vER0lTxaP0IP68vOqoTT1FIuh8hcFKdHOwFEXcq0Q3lIE4b5UYde3FSAdkWe/42Cey0+VpNYBbJXdiG/BTbVmpFf73GxUJNheZKf3Ee7+33cZAAD3AIEq7cnQ9qagvvXm+JEAl78x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422577; c=relaxed/simple;
	bh=5+q3PAAa85EV6gH3/InwufUeQXzYxvvH56z5HKeFGX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5Fz9RBYiSJSHLZEOTvlRgFft4I2ekrcXicgRQgb123Y8XCcJ44e6iMrD9NgOgAzxfrzQ5m2KHoqxwdv8XQ1/DVVxQhDNILqCDoRf5wmjn7kqmpGAEbmylv4G6PaJmH0AqAOHS5c9Iw88r1KJoQU0NRhoRi+8OoSq/QF81XXLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c5Qz1fMd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863c36a731so3550083f8f.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 00:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422573; x=1735027373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3es6et9RuPWWBKMA2JhOsqJKfM+EJleukqKru3rdSMc=;
        b=c5Qz1fMdWUn2eNU9XI9EAjQk4pLDbD5IlLlDl90aFjMNItqGz6NCCybF/U3S1yWE1j
         MXx2fQfg+K/xcT5XObGnzfhdM7xC6D4nNhkt6dWt5T9wTUh9Q+JTR5BHrGYt8QRo3q1b
         EkVStCH8ULpkjfEZYp31Q1vFeRGgfImKIR6EYAhiDCqQgdx4dI3qixeuT73VzzquDE92
         HNT9QMYLYlKBzyoMVsyZP2d4F2/2lWP2rkQYrdRFsEt9iabNOX9nI/UviHBeQST353sN
         z0vFYo7Z+RAhWm5evpfTuy72XHD09isywozoKYUAEbV36J1pEfsUTkD4/SDa8D4u1m/4
         kJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422573; x=1735027373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3es6et9RuPWWBKMA2JhOsqJKfM+EJleukqKru3rdSMc=;
        b=h6WJrDgDbro4phUTjWOdM/qWnMOfk7rWJ3J89bvNT0eyQeGmgxKodtM5qHQN8Pmqwr
         BqQB+O0d02WYD3PgRVsD3JCtWhrensbMFW4AmLlXKnwqvrQJQtX3RfjFKeJFZCs2pdWW
         p7J2TfuyC/TaFHC7QVVSl0QGzBfRT5ekA3xBoWbX65PFzMmM8AVexh6Adh2uj/yItSG0
         IHnG3iLY1kTfXKe/d74SeutWGWdWX1wT+A7yHuXor7a39297IRVvpUyjOnAmp2TE38TP
         KtkrvbCPRLkqAJLwWfpL+AmJ5ckAfjfWLpCv0udoamrYzp3OTCvCqE2pjeMa1vXD9Iui
         q2Lw==
X-Gm-Message-State: AOJu0Yz7GLWr7mFNff0FJ8BEbhj2ysSEYSS3pF2XxUByxsGw6XUzFLG7
	voL8QFi1KJXEsusOPP3vPwAABFIbfAuUeURan+PVutz4KPT//xHQGq7SVaVXTXejTt71RBhRez8
	KDrc=
X-Gm-Gg: ASbGnctSH/EJHW283evD3fkGnLrujB0PeDMIc9sSjnY+Pq/DJSKmjBG4YKl+OdrsbNN
	04nEXts4Wad7Ki4n/aXc08Gfl6vruv9xSFdYzaiFB5ji9VjWLJcpdGjpvkkWd0vSdqCyJmuJIEa
	zdg8Litzz0GVM6Tb/Ue1Z8x81F8ngv2ubTCn/fNmx+g01DTzH73n0N5DK5LQGPnD3ne5GHji7ZM
	LTVN9wKJjGWa2VgOlbqfStEdOm5mRqb9LOuROhGT3Ejz7f5vCofR5ScO3A=
X-Google-Smtp-Source: AGHT+IG7NhdmGWdByfyl6pchEiF9G063LfLlq/ZAbHZU+YW4hmyFFX3NICIp4poejFz0fcs6ktvC3w==
X-Received: by 2002:a5d:47a9:0:b0:385:f44a:a3b with SMTP id ffacd0b85a97d-3888e0b9944mr13508738f8f.41.1734422573046;
        Tue, 17 Dec 2024 00:02:53 -0800 (PST)
Received: from localhost ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db74e3sm53759825ad.30.2024.12.17.00.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:02:52 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 v3 2/2] selftests/bpf: remove use of __xlated()
Date: Tue, 17 Dec 2024 16:02:39 +0800
Message-ID: <20241217080240.46699-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217080240.46699-1-shung-hsi.yu@suse.com>
References: <20241217080240.46699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 68ec5395bc24, backport of mainline commit a41b3828ec05 ("selftests/bpf:
Verify that sync_linked_regs preserves subreg_def") uses the __xlated() that
wasn't in the v6.6 code-base, and causes BPF selftests to fail compilation.

Remove the use of the __xlated() macro in
tools/testing/selftests/bpf/progs/verifier_scalar_ids.c to fix compilation
failure. Without the __xlated() checks the coverage is reduced, however the
test case still functions just fine.

Fixes: 68ec5395bc24 ("selftests/bpf: Verify that sync_linked_regs preserves subreg_def")
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c    | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index d24d3a36ec14..22a6cf6e8255 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -682,22 +682,6 @@ __msg("from 3 to 4")
 __msg("4: (77) r1 >>= 32                     ; R1_w=0")
 __msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
 __msg("6: (95) exit")
-/* Verify that statements to randomize upper half of r1 had not been
- * generated.
- */
-__xlated("call unknown")
-__xlated("r0 &= 2147483647")
-__xlated("w1 = w0")
-/* This is how disasm.c prints BPF_ZEXT_REG at the moment, x86 and arm
- * are the only CI archs that do not need zero extension for subregs.
- */
-#if !defined(__TARGET_ARCH_x86) && !defined(__TARGET_ARCH_arm64)
-__xlated("w1 = w1")
-#endif
-__xlated("if w0 < 0xa goto pc+0")
-__xlated("r1 >>= 32")
-__xlated("r0 = r1")
-__xlated("exit")
 __naked void linked_regs_and_subreg_def(void)
 {
 	asm volatile (
-- 
2.47.1


