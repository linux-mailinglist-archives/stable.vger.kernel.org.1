Return-Path: <stable+bounces-155254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF3AE30AB
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F6D188E942
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066B77082A;
	Sun, 22 Jun 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cypAa5Gc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C23FB1B
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608024; cv=none; b=EfDmjfHBm8nzN/tnEB7LUO2RPbygdSQ0L9AO1c+RU54VbHL1UVq0dMW/SSbSiLnO50m0JrY6SK5HMtOzdjnhtVOdhA8PnEByVD+WWvqpkkoMp4W92yPA9m8jXGSY93oXyzmh/wYq+mpVMdo4Ecscg3x1NQZqm/LW76mjk2NH6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608024; c=relaxed/simple;
	bh=bLN7zj6H2/GIKrTH+251Vc8RM0+eWlS5R0eCtk3Fik0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=atZiZqWiqZEMPnpMCgOzw1TqHJnr/tXPDEQU9zNM47DOXJtgjw+5ASQHjEEtjpdYH7AezOBCaQAuCAI4Zfc812lyv4x2qG1j9Yb8F7z/7gElFyDlvBUDqA5l0kfu9zW+4bqTwdKPTBrUAGqt7bpF/JBCMrOt9jtu1X0i9XJSDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cypAa5Gc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so2903648f8f.2
        for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750608021; x=1751212821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJNBupqORlovPITJo45z7J6bOAiViCNVEaMFt6wShYA=;
        b=cypAa5Gc1uoAk44nhugXUpDzjhZYtz7EqkVRz2jzsdHX+91hZBtmZ6XCMYt7e120u5
         oSKvoKmf9BoIap9MrhdfFLDgiYcJ99L620CTM08Qdf//8o1Fbt9VtFtprbfXcVMb0dzK
         RDPw29H8pK4zrzXP3DH934/P3r8CJBwFOXyhcsYaGdAoOAwikrjxfxr3lRngymwy12ZM
         DPmiCtGCMPRe8e8PCYWBXinWSGkHVDKSt5nhms221wrce8gR59FTl8S3E2TII4bsUiql
         QMzX01nrWbqAT7hJI1yo6b0KMXvTkwXVO/kLWpH2t+sf/sb509WPecW7+3Umkv6HqWL3
         mUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750608021; x=1751212821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJNBupqORlovPITJo45z7J6bOAiViCNVEaMFt6wShYA=;
        b=tmZazXEXZb9NDdjP91HpctQ/1tyT7KmgP8mtvfnlFn8ijarjcTX838SK6fpax3j9YS
         SHSY5puoZ0a/M3d4crrJStbqJQdDbplfosMe+LfiNIfUw2gK3R5/Fx5otcAN5CqKUSfE
         he4060hMz8kyFyr4ZSKRXw+CN9rlUvk6Pi9/aPsvXAL4kAI7ck9cfk3Eb8mSzFM5LuqX
         DLMIrVVajHOU45yh1eMn4uAqnbXVk3iu2Tg0R3kBret1ZcFlpmi12klpJuu9PYVfUJ3h
         RWi24aEKuFZOEHwEeKjwEHH0zZTIz9uywz0/kF8QMU8e6wM6k4wtCvOZQPypQpVKXtvd
         2bTA==
X-Gm-Message-State: AOJu0Yw/k6K+iNh6z4dre5Ni/FZl4DoANg9cBJueHi461DKfksSsyKG3
	I+9la5gd8skF/jAqL1rCh/6YhErf1ekc/oIB1W0WGETZCJ+fbinCDkEMTch7Jguk
X-Gm-Gg: ASbGncsTt/57vKsl3/jgsJBn6ZlEpNWAKRGrA98znrMcubb4Oc9ThuF52emNYGsGYcx
	f9tBztTv9/E+cLqsMkCTUVRJqOtrFlmtx4uGgF7u4n5e2yMZ83IbxTWJj3UCLSAqTc7RmEM/hUY
	un4omZcpyTDxvPFbiEF5noWa4H6sX2GHbTOpiBv9DReIe4NKwKNZzuetume9/dMRXHH8qWsBkXS
	Pi+fsmHWWlySvPyTTNahdoArsqEkvbv9S+azMfkT01wykF7ARPz/rAcsp08C3/48sQwzCOfrLsM
	oeM97j+kZTfMDtXaFcXfyJWGYcvV7uiNv8M+eTQsASqJOzluHz3xSRxxtEpabpG8ZS6Nqn5ymlY
	0+1WLzO/fKoWwfHGsM+B7nnPyYQaAiTe0cvIv
X-Google-Smtp-Source: AGHT+IGK4/wxl/j5kpkpAgkp5Lh5B8j90oE7/ER6nIwSBrXb7y5Pziin35nKvOnvJBxCr5fFNBCFLQ==
X-Received: by 2002:a05:6000:3ca:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3a6d132e118mr7635573f8f.49.1750608020838;
        Sun, 22 Jun 2025 09:00:20 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19b30sm7408369f8f.37.2025.06.22.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:00:20 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH 6.1.y 0/2] Kunit to check the longest symbol length
Date: Sun, 22 Jun 2025 18:00:06 +0200
Message-Id: <20250622160008.22195-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Please consider this series for 6.1.y

This patch series backports two patches that implement a test to verify
that a symbol with KSYM_NAME_LEN of 512 can be read.

The first patch implements the test. This commit also includes a fix
for the test x86/insn_decoder_test. In the case a symbol exceeds the
symbol length limit, an error will happen:

    arch/x86/tools/insn_decoder_test: error: malformed line 1152000:
    tBb_+0xf2>

..which overflowed by 10 characters reading this line:

    ffffffff81458193:   74 3d                   je
ffffffff814581d2
<_RNvXse_NtNtNtCshGpAVYOtgW1_4core4iter8adapters7flattenINtB5_13FlattenCompatINtNtB7_3map3MapNtNtNtBb_3str4iter5CharsNtB1v_17CharEscapeDefaultENtNtBb_4char13EscapeDefaultENtNtBb_3fmt5Debug3fmtBb_+0xf2>

The fix was proposed in [1] and initially mentioned at [2].

The second patch fixes a warning when building with clang because
there was a definition of unlikely from compiler.h in tools/include/linux,
which conflicted with the one in the instruction decoder selftest.

[1] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/
[2] https://lore.kernel.org/lkml/320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com/

Thanks,
 Sergio

Nathan Chancellor (1):
  x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Sergio González Collado (1):
  Kunit to check the longest symbol length

 arch/x86/tools/insn_decoder_test.c |  5 +-
 lib/Kconfig.debug                  |  9 ++++
 lib/Makefile                       |  2 +
 lib/longest_symbol_kunit.c         | 82 ++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 3 deletions(-)
 create mode 100644 lib/longest_symbol_kunit.c


base-commit: 58485ff1a74f6c5be9e7c6aafb7293e4337348e7
-- 
2.39.2


