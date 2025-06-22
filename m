Return-Path: <stable+bounces-155257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A26AE30CA
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2FE7A70C2
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02E132111;
	Sun, 22 Jun 2025 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da8qmzX8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392CDDD3
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610089; cv=none; b=caSdC68xXkC4+fox6DGR7PAJvX0dvDAbqzzJbONVP5Ayn7+k/9yUc4nKWlPGQK+sZHikNMaejWAVocfKDdX4/VQTYHts3DfZj5tIWJdK3ptN0x1NNM1Mbqyx+yqBGadyWCNxa90KRIRwu7XTodSlG30jwV2uri02yYpSfY7yEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610089; c=relaxed/simple;
	bh=s4DucR4UtjIWgtaYei9PFXBeaZzOtFNa7oTjqsDs1GI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lgMyMvmaYjUZzdTP6QIEh7Te3cG5382Auujq15eNLtZJHmBb7fTSFMw5gEBa0gL/1nyxIvobWUv3BY46qXn3dYIG4Sduj4joQFWnlnNKhg3DCXCxJqmM8MrLOuygtDYa7hgDzAyhR43ZY5hTbFSvMFDMeJBsTEKwn4S59+U/6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da8qmzX8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so26925095e9.0
        for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750610086; x=1751214886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whLrJPK+iu37Lr7bZcsruWI7lE0LglXqOh1v9xa/uvY=;
        b=da8qmzX8Nk49MKZOdGTA1Hcm826nzuuzKpRxp3Jb67qSEF3qyXMQAriOPSwEgs5zAQ
         Ieox236t66p2WCO5NoWRGIpM1OINsb17sqEcrTjAT15KPki790gEbXvhEeQsqMYmLT00
         eELKAV7qqq6FyvEB2e5eY0IcXBELEA8dGovkyd/EYYaA5MUKu5izMZXdrZj/hNly2xXP
         /HxCEgEyyw+MAUsiqnPJGobdiCTlGxiBWhlBwsFFNMQ2/NL/wCt6SbX5BqG8JREJ50my
         4HRlEVVOtNDcEq2usNS2vNA6nzbGuno0muZrRzulk2KjPEuranZkisCr2piu39OOFLWe
         5RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750610086; x=1751214886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whLrJPK+iu37Lr7bZcsruWI7lE0LglXqOh1v9xa/uvY=;
        b=uUilBY3oE1nu1WQo0GFDj8vpH2d/+aBhLTHoVVyrlcI/y1vKSJxhNVZXblp74hPgOA
         E6PZ3VRqWItJ0Dr8IshOu8qMcuiNrTtVYJihs4hEfpQUg0BWNxk+k2TE9vYN3/p5crsG
         UKyeNEDVrdkQiRlvW9LfRR45hCBpDw1lge9TMae38m/EZboHF0YbLOrHmUqx7KAsDLxF
         bqpHhZxhdUxqKEkwLB5kyw8TxZ/iA2Iz742oMo5IZPQqBRq9u5Ac51NW/pG/Pj7ii9rd
         v4orzEIdM7nN9Zo+jwDFYvcLvSpFg5rPksFBQUNJYdLK2RmD9feTFhKb9Ir00CGhtzjv
         vNzA==
X-Gm-Message-State: AOJu0YyTpXNpU62eZMaFCvKsViC/mt4+yeo9KIxsBlqq1qZuSRNBzEOn
	ardEZH3X2lBOI9NH5TUem/kbEgqh+snWOxvoj7ldp6/mMh2LhaguSZzvnQGE9ASR
X-Gm-Gg: ASbGncsWJA4h5Jl9ODTSWhjUTQ3fbltAFEWrBTjyB1ssy+lzqO40vRicJaUoJQVfHBR
	+pu9wb3clX2/O8TI9oYTOqlqzB88FaCZnquWQURyJu7b0sGppMs4w5cV0g/Gjn9a/JwSYwH0osR
	0E9camLJ+DKtTZmeqXZ/XacemSzOYkPh2RpV3w5iBQyf9AKsc8EknR/yxlzXyzYG4Yx/Xtbhau1
	YPjDkws6a7EeH4yER+kkpbvvUXvAla7ngy+wJhkDyBxri+XhA1RjGplZBrfaUtX25VYwv7nlKYu
	D0earHedNTALckMWgp6nqgmfEvlDccRviNtMK2xQ0I60zXWGorKVYvBTjbVA2J7OKhJhQhs3sQy
	F7C73iFBdqvfn72xRGrc2V8Zykg==
X-Google-Smtp-Source: AGHT+IGYYTpf3RB31aQhd7ueMRfRLz7LSjsTuhVgrUe91donWahuFJXIV2GzixH8//lxJc1A4v2KvA==
X-Received: by 2002:a05:600c:3b91:b0:451:df07:d8e0 with SMTP id 5b1f17b1804b1-4537186dfc9mr18473505e9.11.1750610085514;
        Sun, 22 Jun 2025 09:34:45 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453596df276sm96418495e9.0.2025.06.22.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:34:45 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH 6.6.y 0/2] Kunit to check the longest symbol length
Date: Sun, 22 Jun 2025 18:34:37 +0200
Message-Id: <20250622163439.22951-1-sergio.collado@gmail.com>
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

Please consider this series for 6.6.y

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


base-commit: 6282921b6825fef6a1243e1c80063421d41e2576
-- 
2.39.2


