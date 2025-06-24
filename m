Return-Path: <stable+bounces-158432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77EAE6D22
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AD23B8944
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26892D3225;
	Tue, 24 Jun 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsFrhlF8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AA26CE15
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784347; cv=none; b=WDfiTBb6aqzA70tDaWI7sEzQ1GOu0HgHZW7yxAcVcu1afklVGkn85mLTwHTZiTjIClEapSDZ4J9AgsEP2LFekkdTBZU3vR2B/B5/U4KWAOBmNvcZ+3DcGZwc+O3907kc/LiWnZWTLiM6OwOgdNM9Kg6ETKM5Nl8xABaDu1U2DwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784347; c=relaxed/simple;
	bh=ZlmfvnrPlIot/bV25Ex9Q8fE07o9PDSg0wgWbr+TyMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ovK47CpUeMDBdat+7t72EeZsutcHwYdZSBG9zS0ILfzNHLClnGPvb/CJNzhvLiRkjC0yZKAYO3ycHd63EWuyQ/rJOQ7bNxFNDy0PiMcmBzArliqWDA63MUmPc67sr29HGyKB8gBfjPTnKRCxPWxTcA7zmgBUc0erGGu4lKf+Kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsFrhlF8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453608ed113so49615585e9.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784343; x=1751389143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oNMkaqIoHBdn8ycjAEFcZw4bU/cx2kxBCt7F2j8mG4=;
        b=GsFrhlF8m/eFO5GG6kFQ/A2NmbnNgp6u/JZbz1P9LrnsTiJTrWvQslvnLHEP2vGvTt
         susntqzeDyT+3as5WoL6fNgz97szWg4Zk60cUHTfncda+r+aVxSpjoEwwO/WhJRO8EUN
         C6XLFYGCyrcXFxVy/qyQZBWYayC/HFONwQ7ylluiT5mr1LuB/ieABmsjY9faRAZO+vwq
         Ps3bDJ9gH442Y969fGxfBrym5WYRCmgjZZs4hKEJB3XnAkNvBiwSN4vvQa+U8W2iQBdO
         U7KEck98SE+3Twfeu8sNu1g1rpiXPlQLM30D98unAIu9Ee/Vm6h0Su7TnJUHEccFVcuh
         xURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784343; x=1751389143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oNMkaqIoHBdn8ycjAEFcZw4bU/cx2kxBCt7F2j8mG4=;
        b=atKLZb+hpZxKx407laEFTxonc42/I9ogAFjrAF5T5Bd0laQlotUIh+l3+TbgH7b/kW
         S5pFn6OdEcFcFdVBdkjGdQqfuL2bGbgTw/clmqlDFVYRte8XBN48drj0NH48wceVhufu
         wMKq05rDDe/XF9rT1vQm7IFkgxEBTqj6W6ZJP7qooREsyRsRbDyeI8w/FEkVOj8S8/uh
         G0Zt4XcBovB13eqf2zlTJuyVpVd3f/Z0DJAl2dFwRL0PJEeYhsdURAuXNMfKJzfAYTA+
         Jb/WrEucz7beq/8Mnrq4Iue+hXzwF6xqn0T6jvJLB4XD7gtJe7E55W3ZIAcB39JKOuS2
         419w==
X-Gm-Message-State: AOJu0YyOaEfIpR+34YWuM0OZLuF8SCRM4P9j2OyWp5Ukr/RY1NZzHaQb
	tc8yUrc0spA11YvTaRiioouO+n784SgrPXBpdfbPnfQel9kbHe79y56G8JN4XxzE
X-Gm-Gg: ASbGncs86ICPwjals92sho/MyIf3+daQoVMFoDBknwRTfXBFpK4Ayrdfc7EwkCNFLRJ
	IBAI4G/Q7J2pLtYAK7zlmjO8hFNzoz9EmKT1PjqpXrn3yq2GcvjEyq/Ux3noywKKqSQ3b3pgEOE
	OvvzpSmXzWm9DvRBV0bydVT8dlusTMaL2KJ5vdJ1u2zVU5CM6VRFB8VKiMjXYXfBIXGhK2r4jJV
	sjcwfg878SvrBDi/XnpUgouTzZ9g3Eqw6A9rU5BoSX5A8w1VekZrbCs9g4TEEjmGANhf2/usmMD
	t7aRUewfWtzhh4V0VgWKC9urQwsq8GdQ0oR31AIdcJaKp12tUMzU/jgTdBUeul+jgFGaJbMEjMu
	/xKjGXtZLvAKxxh4sDJsVBfiQTQ==
X-Google-Smtp-Source: AGHT+IFcl41LDTMoSNfChdcc7EWsGlWUX11cHw/UfNXBcDmPsvjTQm7O8WacP0mvTuH++OlWjzNOrg==
X-Received: by 2002:a05:600c:468e:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-453653c7fa9mr178173535e9.0.1750784342856;
        Tue, 24 Jun 2025 09:59:02 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebd02basm179191265e9.39.2025.06.24.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:59:02 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v2 6.1.y 0/2] Kunit to check the longest symbol length
Date: Tue, 24 Jun 2025 18:58:50 +0200
Message-Id: <20250624165852.7689-1-sergio.collado@gmail.com>
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

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
Changes in v2: sign-off patch 2/2

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


base-commit: 58485ff1a74f6c5be9e7c6aafb7293e4337348e7
-- 
2.39.2


