Return-Path: <stable+bounces-158438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C206AE6D40
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141D03A8EAA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F5F22D4C3;
	Tue, 24 Jun 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKMhAbJb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3A1E5219
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784681; cv=none; b=WXzX0NShKiU7UBuRugRnoZyvZov7lpW7Pt1WntVxXg1N3Ic48l59iJkcCd3ZPm1GJC6YksAlpohsyqweIvjcGS9vDWFV6vNUE5li1jAQ/pGwQBg7R9x7AEcpubKO2QwVp+lAAlQMvAEH60v9obftlKCBHel26oE65IlCJ0Pd+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784681; c=relaxed/simple;
	bh=58kcgFOD1RHRrBQgHHL1uMvdKxJf0WroDEhGy+lfJFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhOD3RJgP6I+IJBc1bJaLCWjTGNh/w8eyZP3yu4ODHGv9gzRoyja8+WqG9o9WwDqIsy9a9wdYoD6vlN8ss2n5EzO0j9NY+qoG166cFV5Bwj+Py0mFkYOjBL2e28Z+gJvenvFZYTpiPL2th28XxQN1rRKBSspQT+PxV1fIgJ+Y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKMhAbJb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso494390f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784677; x=1751389477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmK3Mm3VnYwR1mAYmNz88dJoBd6LZQY2x4R8sZw9hDg=;
        b=lKMhAbJbCrT+9w/vPZdVrQfx1Nds9e5+DKUhIbrgnnHRhSMQVKxGsVLj0/vJxtuyf1
         hdk5X3sBG/ponvxFcGmZuDr+3GfvYh/JgGKIl4BLPy+ZvCugHMjCPmLfMvbEAnoZRIuH
         aBZdhz6skPBouqoSlJLzg0MG/U/EnpubK6eaR0jiXonKVRosBcxAU/zEKkMTzoD+pmcU
         2FDV+rY70NOhvb3rXCIv9rPF2RTcuhfnKk6kQrCxf+AVK8jjV8UL0zfDY7g/x+sgEggJ
         z0MkXLTdHqsN6mBa94i/mMIRQhWVfgLltSJi/Dn5qMyH2IfORKcr4eTtLPu3P6nXqAJ1
         jZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784677; x=1751389477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmK3Mm3VnYwR1mAYmNz88dJoBd6LZQY2x4R8sZw9hDg=;
        b=HvRirBb0CtmuKO+txJPxbCi8EbPJ5XMiep9ylfc7Sgo+kFFc9n0Xclj1X3cPM28GJ4
         03cg/ZEzGLXHGutt2bTOmsC7VSgsdK/wWGu7jAuD9SYOGw4n09o8Ie53pyZ53zto772w
         3WkAH39roJxR6hE6Lbdd4AXNv3l4tR2D8LEoE4hDU4qptrpZMutwU2D5gcgBTnk9OOR9
         NVMCFTvflc5Y3Tc9rWOgemhqXd5+wpBv+OsP87rPiVfOhKtmBYeLhqKtq0ab/P1xqvle
         UsPz/AdPDFUu1l+Lx7fhB8sjwVccPHZ7/OVRhSWpaHMjCBnBw+Vo4O8vWpr1wdykKiBk
         pOpQ==
X-Gm-Message-State: AOJu0Yz1HAJbMZK2c9G8enIpvRzzKyFBjhgCFZBro53iRDcxGCvqbUCi
	zp/WbhLoqJhHv+guSgBXIOLIQ/ZLQMGurahVM7cFP2590mZ7sBIrkbRWp0Aa7pdM
X-Gm-Gg: ASbGncv+JtQOOMuKemhK/Kv345aZeq58GP1ig3RJWOkf+Mi7AZ6Lw4O7xEdWDK+JMxI
	ekxe9tT3ucb89E5HPH7pw4Ysijfcvt1PB9sONNEVE4+y8jPyRVc0dRuK2tbs8FX0umYiHf0tgM1
	+esVHD72AepsEYqa+0xRpjk++WgZTGr6K+IKOCgFJHxouiCEuVfs6Aa3ceg02zk4ZzP86socNte
	ZXwZn+ve6lLrLP8oj2+2JQKCgZyUNO4BVpB+4kZ7SwYQpVZ5Jhn5My4kGqYJ/7iTNzd6+BmAGbi
	BXLtgHXxsdJWYoSKbEtJk9yYOlB4NjFF1QByKzBVmi9vh7V3b0l14ToWOH7HffGiJ/0VQb29c2+
	NWFjegO8OqWbvP75yIPtoA0PK3g==
X-Google-Smtp-Source: AGHT+IHKgN2P0lUc2h0CDW+1OY55xfaPBy1onzyYUDwOiy4d5qrOl+gmRiQ5pR1Z5f2qQmQShgWQNQ==
X-Received: by 2002:a05:6000:2dc4:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3a6d1322b77mr14626342f8f.34.1750784677243;
        Tue, 24 Jun 2025 10:04:37 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8069d78sm2386276f8f.45.2025.06.24.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 10:04:36 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v2 6.6.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Tue, 24 Jun 2025 19:04:13 +0200
Message-Id: <20250624170413.9314-3-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250624170413.9314-1-sergio.collado@gmail.com>
References: <20250624170413.9314-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
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


