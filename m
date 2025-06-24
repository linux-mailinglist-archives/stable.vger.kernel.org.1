Return-Path: <stable+bounces-158436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E398AE6D3E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95E416B4CB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020E22B8D9;
	Tue, 24 Jun 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSIc2NTA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190A307496
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784672; cv=none; b=AKsm8lzjheB1P0OBBc8ZnpoNvmPfsBPSv62Z1kDrkA8Q0/fjFMt1YpNHHCnltr0fMAnjDbuoG9FyjpQeWdzOSoNHjDf7aham5tI1JCj8yB+4+Rxx4JjGOv9378DzyR8KqP/eEOCjxjhAMZhjZY0Y6N4djeAlN4YhPLUoVTEJ7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784672; c=relaxed/simple;
	bh=qteff5OfPTvW7i91rP204W222Nqa2CAGyBXFUikTEjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GN28AVqb/LUTh4fy67dvxo1qGQAZeet4zJdkMJ6DdShV7aB88PfgYBErDMX/7HKjy9oU59cWHmrHSbW0bIogsBCA++OffZLwxPqr1tHJm7bkFoZv3+LcAw+h6OxWJdcJE1V1d99txpEiBLi2AQT9rPR3ATTo26YplvvFIQYpQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSIc2NTA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso494262f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784669; x=1751389469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/5U6jCETnnl7UxdYyeKuhfhx9Vxem6vhjgxrmX0igs=;
        b=WSIc2NTA+HY3H2flx+i+ULjtFBloP9hJAJUI6jCjparrjIqhDl4aQ7pdUJHJQREdQb
         0/p+vVy13CgpiYVakaAw9HZOPbVYsTavs72fwsPE6u+woFoDiSIuctyeh7aWB4L31v4M
         Wr31SaH8Z1kokZJtIj9XYbvM7aLtyIpRL6vhTCj/wzOV9ry7WfqfvQQbDQLQVihT9yoI
         JgEFUUYAQz4D6xczu1h18Z4j2NhqCNRuUUuN3LWskPT7s9Qc1VVwzEJUo0FKRrRmF4/e
         FSy06AmL9TcJIABORVP4Mx0+1jLahmHQhjVPE511e87YOcjjFk2H32qOTmb3U5ngGy0j
         0Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784669; x=1751389469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/5U6jCETnnl7UxdYyeKuhfhx9Vxem6vhjgxrmX0igs=;
        b=r4focCpZzcdoG+jmHawFCn2IScn716o3GQM9ySoOMHKpZCEly/qI/coxfsDqbNC7jM
         //msOLiPIfVQ58roZiKhvcRIQjIWCpuuECjKDnLalPwoGbxxBwxa6TyV5Zcu+JX1ybnP
         VFNwR+8NnkUCUraYuRkpEqof1Qgcu+w4O8BSV0DxMPwfcO1LwOjfnOWXJVJhEeslK60I
         5Vd32rBGMdqc1FkMJPAqmzyYGRAQPq7T1l/NAh+mu/YAJLRbMeD4AyNxo/onz6SZ/NEZ
         ZZdD2hsQCt/En47KBwGJ78uf/hqpqkKpF1xiv2EiW/GMlxjc96WGtZ7sVrYcVLBvlWt7
         izLg==
X-Gm-Message-State: AOJu0YzOQ9rx/N0Fy0ffNqCUa5/s15uQD+/sHZknGb2yQtuSjYLLinpk
	CWhKbrbjiKbsQc+5uwinUhhPAr/ee5scH8T2L4m9JOBRiTJsIlVn2PdMQ1C9EREi
X-Gm-Gg: ASbGncuS1GW1Smbm6XRnNxdpqcm4MA0LMXXSkJ22oekYakrhhh3eETQ85eU50rN6ngU
	fzV40egzxs971V5taQ1JjuJWwoM1fQt3ggVOxBPe7+5zUN/y7Fm2rLhS/qcO2bl4E/tsH9v3VQu
	9crg+kozTbqFZvDpGBtN9+aXFcrYKQrVXyWmC+ZKT5TapMbz1qtbEXwh5Dwo3E9pMZD6xQig4+t
	6NP8pNmEHLPeHWW5t6dQzHM2mK+PS6tUZXW6dILi3Pzot8BkMzsN0BiyznDQl/BG2doWKjFOE1q
	xGdkTgRPqbKUorcj4pzMIPRJozU//xVn+qHuktFthrFOZCUroZsez5zBD1vbgDKzQF5hXEWF4ag
	PMwyjWTcwfdgRfH8HJwBTHLp4aA==
X-Google-Smtp-Source: AGHT+IHNb1rARe2y+ZP665yAJCMclz4csKvfpRUA8PAAPmUZPOGaZNxArTnECNx1E+ct2ebc/UnWqg==
X-Received: by 2002:a05:6000:4021:b0:3a6:d145:e2cc with SMTP id ffacd0b85a97d-3a6d145e448mr13618380f8f.15.1750784668804;
        Tue, 24 Jun 2025 10:04:28 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8069d78sm2386276f8f.45.2025.06.24.10.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 10:04:28 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v2 6.6.y 0/2] Kunit to check the longest symbol length
Date: Tue, 24 Jun 2025 19:04:11 +0200
Message-Id: <20250624170413.9314-1-sergio.collado@gmail.com>
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


base-commit: 6282921b6825fef6a1243e1c80063421d41e2576
-- 
2.39.2


