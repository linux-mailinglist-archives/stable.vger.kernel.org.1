Return-Path: <stable+bounces-151931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7927AD12CB
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97130188A785
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76424DCFE;
	Sun,  8 Jun 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhqSUiyd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226D1FC0EA
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749394508; cv=none; b=lLpYaJg77dUGxPe/CNjx1ffbS4B+0wvJE3An+dmcwg9RJkukn9WLp0PZnXfi8CVibbYUXhfl395aQefCjItEQK3Vd1sS5Z7Espb76X8daycVaXfIWqkmbIWWGNttrKuyt/wnZSoaeBYAbhf+oqSAlN3ZB2z/jVgFJw74ehvO6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749394508; c=relaxed/simple;
	bh=9saWt+BXVfJDWIF2iRG2a2rMhzXiBX2q06/3aC0J2AM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qvil+z47xiPt8fpRZgf6bRhoJRzEM9xtXksn1R3Kb0te+2O+wdnT6TG5E0ujizqVI3g68bJeFkEUwTpzlupavV1aymnUT22gPxyJejolM0/RJZi0s6XKfOpGwV08vIarxAcD6WV/vuNb2WYRponSXbL481p95jteQfeYE/kcDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhqSUiyd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a35c894313so3192805f8f.2
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749394505; x=1749999305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmvdkYbT/pRvAllcAkfofQCE2tKpiY21Vc2xaeU25Lc=;
        b=DhqSUiydB7JdRWCCLXtZXtZtqpg5ajs/9qagp3T+fCkvhDvAA/yd4p9crPB77muEjd
         7Nt9MHC856neneSs5BF2FrpgauENu293L23LFay3OHfm4d03yrGabakJ3ocoSs2LVVCW
         QTvT62c+w8rc9eEwETh39GUIWVmKHmdDq0XxMKeeCD5Cgje6qRbQRNxfgSehl0udao2y
         ITLoSFCHJV4lGluPiU27ImIyh7v44RT0Vqu2/w2zh0+cldliI73o0hU+Gnuqa6xoa48O
         mNfop9dwJx0aey7gOet2L9oul7TbKEe38fhB6dBhWvxEfAEwGPyaCzyJstf1Rdt1aApv
         UwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749394505; x=1749999305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmvdkYbT/pRvAllcAkfofQCE2tKpiY21Vc2xaeU25Lc=;
        b=jEqSz0VmxzjfSdWwYc4nqRZ43/pLyZdP5plu2P/OoxhlwskIKm1Muw3yRRVYIQLIrW
         5ZdBMY9zUpNdU+MgNdWwtoxTqOhSfKAZwhR99qCgdyynlITkakYR9UZ3BCS4nfnjjDBE
         0midv3Q58I8uKB9EbKA2MQ1MztQvlJvX88/sv6DCHVFtQhQpZ9LvoMC3y2/5vsn7KY9+
         /f2m45RgLILDuaISuIcRDfBxvj4S0l7nS90spMlMiaBh7WCikOrCozxcl7AEscop0Yiv
         JYq5CDa5uew4hyBQUSfSdA1fMDWk5tB7huZ01qrYMZPGd6hV8x6qhZtGAlCKi9zLX19S
         T/Ag==
X-Gm-Message-State: AOJu0YzJa2KDpUFBg4I9mNPnXMPBhkqNmZ0fVCKZdap6/zmmxHQYDULm
	PXMshrKgk9tfgmnqljrd9ArTspcw/RuMVpgScRW9bXAhEpLO6aOeDWNwaRMnv9p8
X-Gm-Gg: ASbGncvNyy7Vb4GtcD6FpVMEUr89ozniNA/voq5Mxj9UiCHKvaAxDyQeQAXTJ9ikSHO
	JM083Rt41xBGemu0tD4IaRhtgKzXraNJpS9wQjcPQLJIszUenN2ytkbJu5sW/6WuNFAZgR0o+Ho
	ayg+sTLwpDFwmm+r2ykkkPcu9MogYs8nI/ewtQ2OyaJunozMPf5c5n47ml0gFZHmy81XZyQlXvp
	GY4kHn13JvcjRl/3Nsru+50ZFSH/muieCZG5rgxKEQ7qkxCCd/miGSnsVJvnOEbv7gM0GUJvC7V
	1kwBXx9HvbZ0fOxd3qK8dm/cueO9rXZ5ONIZR7GTJjqkOKNoToQR9sdDc0WoS+T4q7TKQ5kZVqq
	e96KrypXsVkHtww8ceo9wC8EtZg==
X-Google-Smtp-Source: AGHT+IEamMp7niVzuYtqX0/BmgzaLKQV3aJwl56c5VQkdggrKzW/43ZkgZUvBXIgvvMXX9JyDIB5wQ==
X-Received: by 2002:a5d:5f4b:0:b0:3a3:727d:10e8 with SMTP id ffacd0b85a97d-3a531ce7122mr7206504f8f.50.1749394504868;
        Sun, 08 Jun 2025 07:55:04 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324520e7sm7345817f8f.84.2025.06.08.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 07:55:04 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH 6.12.y 0/2] Kunit to check the longest symbol length
Date: Sun,  8 Jun 2025 16:54:48 +0200
Message-Id: <20250608145450.7024-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The longest length of a symbol (KSYM_NAME_LEN) was increased to 512 in
the reference [1]. Because in Rust symbols can become quite long due to
namespacing introduced by modules, types, traits, generics, etc.

This patch series presents two commits that implement a test to verify
that a symbol with KSYM_NAME_LEN of 512 can be read.

The first commit: To check that symbol length was valid, the commit
implements a kunit test that verifies that a symbol of 512 length can
be read.

The second commit: There was a warning when building with clang because
there was a definition of unlikely from compiler.h in tools/include/linux,
which conflicted with the one in the instruction decoder selftest.

[1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/

---
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


base-commit: ba9210b8c96355a16b78e1b890dce78f284d6f31
-- 
2.39.2


