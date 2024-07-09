Return-Path: <stable+bounces-58749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CC92BADF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A63B26276
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32D15AD83;
	Tue,  9 Jul 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1mcMZ8k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975215FA85
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531269; cv=none; b=TryOYzpRIhnqwLJ3i0TcaNt4A6I0s4DMExqjBBk3XP6IaBJJZHnOWAER33HkrG8jNsNYBbyrra8KvQguaLgKlU3IlGD7auwNGL6l0UDUEbUPUcqL4V7aYLKMqlXb4FmAmGyZqirtGzH7K3/O2PFpGIOCAPvLAdd9jQFQ43QQ/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531269; c=relaxed/simple;
	bh=t3Nh4K0EgSspKbGVqz0X1bAV7PZaIwIZ1XOCKhOkTBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JaA2EiViqm47yUZng/1nllMl0kap9ckprtC9vaigpM9vDB3uwth4jd3XIsSyngFsC+EYtJJ8nfF0yBLjg4J0DlEhY/XI2vs9NwE9d6QDLhG5uRv3iPlBPHce8wa/E1jMu+ohTzfVhK4xzc1x+MsVVdwjUu2F1wFPY7HC/JPC1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1mcMZ8k; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70b1e0a2c59so2582133b3a.1
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720531267; x=1721136067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91y1ViYzzS22frzUrEAAYagk7sEQX2NaM9leAuKuoiU=;
        b=m1mcMZ8kl9L2eJ7+cmAkTvrTQHGReya4X2ZwEhfpOPmkImkqhlPqXpHb+Yf/MrwWs0
         dpxgebFhn7FdajE4I+PZowh/5zVL/l7vkx0TZeAOvisFFOk/LVfpdPlyYZB5SKac3HCv
         oNXDvNHvUKX7WOhd7Y9nT1uqi0kQ/RnDQ4Y6t3KWAAzl2RAHDpcZhdcV+gP5gqkafcyG
         4u8nl/ExJnf5ZbjpvHyBehXR90qeGaQbSvADM7snxahnC1YYJbwhzOW8vN4noxun/IT1
         to3KgoZpr2qDrmGbyo2WxQD1nk6+lzZFsW77Jencwum3CgcGbACjgERQKweAtei/zQxZ
         FKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720531267; x=1721136067;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91y1ViYzzS22frzUrEAAYagk7sEQX2NaM9leAuKuoiU=;
        b=l22MJ2pq2j0AsOlu3mWyJSY8ekRSR6z2Nvo5egT82mG2I/u2cLeQyns8XRWo7c2E5X
         rnq89h5Dtz2wBcnbvCZeTxBUmxm9+eK32vnC0SL6Wh/IeuGuK4ovCIjpkeBP+IogxgtC
         QLfTCGkw1VUyIMvMvAO6z+iejcK9OzaoigsHYIQeiZ9m+pRPdRq1skRy9K8mnT0TO7Hb
         nmX5821LBC4FMASUcZdlzoXw4FtIMQfClVuXdSPlnfSe8O1s1zGutskxNg8zSKdmhBIN
         0kOtIr3+yYELnfF2uWQ3/lB9M8ImzUs+6sLfeEB0nYW6o3aU7k19C58wHAFpvWdWnLSd
         cq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhFCM7a/U7QOJSUUUqXQOEgKpX/ntMpgjyVb/e5rbt2C6FeZlB83rESpC3T9UI98B1V9mEewl7zW6OD5vOGkFVJXBcnDNc
X-Gm-Message-State: AOJu0YzXpveMYSQfkGEe1BxBLiXZ6zqS7efRUpt3GhFoMNfYZw/ujh3j
	wau0th9PdKjxtkRbBDq/hi5zOw3mMod8MTaOQxyhD+IaJtuUAhVDIDpEaw8fGTmmye7APsBpL90
	35YH/03/R8Q==
X-Google-Smtp-Source: AGHT+IHnhhEo/FT7unUXOiYtEv21JGTtRWBB+eYjZZipziKWNkzvFRhxgaWH5sWuaB2RfGlZ23uG42E7bXzm8w==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:2d2a:b0:705:d750:83dd with SMTP
 id d2e1a72fcca58-70b44b5ee14mr89189b3a.0.1720531267259; Tue, 09 Jul 2024
 06:21:07 -0700 (PDT)
Date: Tue,  9 Jul 2024 06:20:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709132058.227930-1-jmattson@google.com>
Subject: [PATCH 5.10 RESEND] x86/retpoline: Move a NOENDBR annotation to the
 SRSO dummy return thunk
From: Jim Mattson <jmattson@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The linux-5.10-y backport of commit b377c66ae350 ("x86/retpoline: Add
NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
NOENDBR annotation, repeating the annotation on __x86_return_thunk,
rather than adding the annotation to the !CONFIG_CPU_SRSO version of
srso_alias_untrain_ret, as intended.

Move the annotation to the right place.

Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
---
 arch/x86/lib/retpoline.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ab9b047790dd..d1902213a0d6 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -105,6 +105,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 /* dummy definition for alternatives */
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
@@ -258,7 +259,6 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
-	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
-- 
2.45.2.803.g4e1b14247a-goog


