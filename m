Return-Path: <stable+bounces-155259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9BAE30CC
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644C31890AC4
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906081E376C;
	Sun, 22 Jun 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FElBpVvO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379ADDD3
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610100; cv=none; b=BIxGEY0asVHQfIBu5Erxn/odsm7OZSNj4ubpFCoSIT52surZKfMqbW3YtOLJYLBlnVJQKJcLt+9Y+wQByoJwq/nFyPoWv9d2KOeRffjlcbXK4nZ56pGnqAWfmS3YbzfcdAmXFr2meL67v+l8F8Y5ebeEvg4yfEaRqHychvFTSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610100; c=relaxed/simple;
	bh=qDdx+48h9hTa2TN/qjEDtOCXk5jMhutrVElbm/aEyhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpBPPSPPi0Myo1l7FcfakiHmhJdfcVJ/dn0w7BKquuVqD5krWJKXAaUFdz4aUKiMPWMND5nQFFAkazp6KVpOLCJLc4sn6vYI1j60P0+vW8rCaTP/58acQwFsU8UJ2zW9UdGHAy9LBRwQYOIl3qhMS/MUGma7qmarzS40bQtWIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FElBpVvO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45348bff79fso38588165e9.2
        for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750610097; x=1751214897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNjO4sDMuK+T4J0VE/NK+gi/eJODe5eq63+5j/G9To8=;
        b=FElBpVvOKpgMTMlgqDAPu5ziO5YszBjacIYz15K0lnmmsmIOGx5Uf52cIamK3RB6xX
         n5EaNfrDYAYNTqtfxYUI7XPueKqyLnAHhe2AubkZI110Y17T0CKBtfXUInQhp6ugx1gN
         vj4YRdl/PWeNIjkiaK2GysgqGO0xEf4GN+Bu9zc20xVMOc1I9XhgX9erQuc+MfnCJ4Og
         Lw5QOKpj1Gk00c8wFHfQijsBDzuHvknsBNLM8Ti/t6+thJN7RmJlZrLWf0+ZjDvXaoiR
         yfi4epO4bieVd27hFzfEphwQewFhHPtnMZs/bCSvnJg4ndlPk7VxSy+nwwFbHZQ5MRQd
         SEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750610097; x=1751214897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNjO4sDMuK+T4J0VE/NK+gi/eJODe5eq63+5j/G9To8=;
        b=m7FRqBR+kCw8CPXSSeZ0mpYMTFYpg/b7S3mQ+WkAYB1LfhzqXOKRhIW8i75c+PKFhm
         v+GwzsMrPxNU6bFmVpEQ5WHGtsiys1dCVU8D1yVv2wWHMPOwdRl/WmJ4UTJrSLa8D6SB
         ns1RYYIkNBSQKAOu2jWfjJ8aKe8vvlWhyq8Bz6Q3VI9N1q526gKNxx48kIzzb8Uu+QQI
         7X7Qp8MIdfzmH8i8n4AVWnTZ8C3glJ7272EK7msgxLMlY706z2M3b47U5+yGzTw3zbPL
         S3zKUv8KpjPRFKmYkSUSFYypkSzu4tYuAg9xRIHhshVbFJfXU8yuQX2lJcxrCYuzy0Xc
         Tb+w==
X-Gm-Message-State: AOJu0YztyoKegNko8d6JDVBvmG33pmfSmXjPhMipHaWojn88UIQwoPDM
	tIUbwSKxykpqPS5Mp3c0R4iW/jXQgWjEp4E2QJMS3vi2PhTzU122EIEQAVfFiFUL
X-Gm-Gg: ASbGnctx6KqnhWWC5wckZ8Ya5wID4n4Xr2TP0I35bmcFz3Wd3Tz+ozzDzZQIoknMW3N
	oA+jr3ysVZyIxtPuEbFKoqJIPIA0+58xh2/kpwmDCCBt7i0qsSms3CfjXm3WnNIm0ht+7fzREi6
	0Naf0H1sMd3ZFt0FqAmu5DFaMoVWCff++WopfSSUUuKYwmtTR7OlNR2TppR0/DYnaG8VE/gjQqG
	fnwZ9WbwUjetCCcYmyJdkRcN9wgp9jcWgkuRrM81fY1vmnV1LKkkm2MhY+TOPitV/ObG/giD6sZ
	yMKGDxQue9rCEYmPWAb5QIIKbN6MmNEpykEczfyTdOgnfAUPKXgP8rg5VfKLbRhLTNE4GVONfoY
	PqAwFghm/XUiS40zjwfgiW83olg==
X-Google-Smtp-Source: AGHT+IFl3SdgURvpl9yQuzt7yj/Hc9Sb1eaW4gUHgX7mcwgK0J4M270L9lSUXzstN0ZcLajgatbpiw==
X-Received: by 2002:a05:600c:1c11:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-453659dc8f2mr79100225e9.22.1750610096383;
        Sun, 22 Jun 2025 09:34:56 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453596df276sm96418495e9.0.2025.06.22.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:34:56 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 6.6.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Sun, 22 Jun 2025 18:34:39 +0200
Message-Id: <20250622163439.22951-3-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250622163439.22951-1-sergio.collado@gmail.com>
References: <20250622163439.22951-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.

After commit c104c16073b7 ("Kunit to check the longest symbol length"),
there is a warning when building with clang because there is now a
definition of unlikely from compiler.h in tools/include/linux, which
conflicts with the one in the instruction decoder selftest:

  arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]

Remove the second unlikely() definition, as it is no longer necessary,
clearing up the warning.

Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
---
 arch/x86/tools/insn_decoder_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 6c2986d2ad11..08cd913cbd4e 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -12,8 +12,6 @@
 #include <stdarg.h>
 #include <linux/kallsyms.h>
 
-#define unlikely(cond) (cond)
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>
-- 
2.39.2


