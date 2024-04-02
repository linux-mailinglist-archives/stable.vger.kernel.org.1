Return-Path: <stable+bounces-35569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F412894DE5
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B3E1C223D6
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B0C4CB4A;
	Tue,  2 Apr 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b4xaxt3b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97946B80
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047707; cv=none; b=Mf9IRI4WMVYEaORiCtTX37jrOBVarW1u0qfwIYVe6+PNwdHbTgRyiMocesbID4bW1WguFBErrY8HcCOby41XHG02ESRPZehm+6GD3cXlqWmjJx5z4Pm961WhZyTOerJ065leDaOqfqHFVeXM+lF9RhNVDppB2vd/snURhKEK6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047707; c=relaxed/simple;
	bh=R6RPSilVAjM1NlOpXz8vUhNSeBgb6HeVc8XvoJaV+yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jwPGtSbplJfTWYhRwZ6wShZU0xgVaclrCdu9rIPLLSmeuSiaIa+5truRfTx9J6WPRpM7j6pwVbK8+NtQjmDDwxVY1FQkcw8PFXC0xQ0TlgKmY86UqEysitU9RNs+tP1egT9wYXj5lZc8fTUq2RU3fqoW1vDwTiJo7/SLLcGCegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b4xaxt3b; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1e0189323b4so34286445ad.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712047705; x=1712652505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9676X4fYIim/0sElrYns+vTJTQqEov76qiKy8ITTcg=;
        b=b4xaxt3bK83Gd5lXY8taNX9xOdCR7HYsq50BnV5rVIh/Ga81MSb1hnUC6fh6Mnb0NV
         m+pbIiLlgpOE4oancNirJNhwx1QbDM7FZrIjxpOJ3v0fVyL6mTavBTokDOg/6Id/Xl2m
         ps+vNEi2hmGzWBIe81++SQ6eiUl4dfwrCotfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047705; x=1712652505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9676X4fYIim/0sElrYns+vTJTQqEov76qiKy8ITTcg=;
        b=m6335m8v1d6hFjtsT3OWAUWHGeV3+olwCk+/q4YslvkU8QWIDlB2A+ISpMnzHQgUhU
         MSjdXjzHcohRcgA3GGKla6fOgesHKwNXyd8WC8V74d+qNKyOzBll6OX+CtbjOJsXXggU
         JHb7S2ev9Wc3k+/aF7LkDc/sym8PtPQUYwjCHTY4DJDilsko8RDSXRpfWNZV9hBlt7aj
         CN9JZmm82tIKtA9bgPHsKJSChjQaiD7urJajZTiVybbmSmXd//dJ7j1S2ywgoiGgy05K
         l+2Srel04teAjQvVYb2vP/KYG79EQ9cbD4ad9R1PI7iyUy3oy1NHSac3UZd+/WtE3DKa
         Si4w==
X-Gm-Message-State: AOJu0YypKW2GMkdSgWyVN47g1e/7A2EZoAghGeDNMMpdYrLsI/Gh0M0l
	qd7xMVDG+aPTrbpBP5aubwtbVseCUChm+PhWfTNpYFCVgBFbeUlb7hf4e6RCPGR4p83ujyKLR9b
	PTarfbM8eqsvjczDRp4CQXDMZ+7607FIH4ShJfkMCU7eV1+dgICzA65FTjhun+XZJUz3S9fR5z+
	10dOPzc7XaQju6kSmPCnA84SEY02GF/PgLrMFVEKhtfV6gu7BU
X-Google-Smtp-Source: AGHT+IE7jZjWCI69n3OhJLr4fNBJh50hOsw44XMOQ2qGqsJWbh8Wz+a8CfoO1dEwd/UBwa7lmB2xzQ==
X-Received: by 2002:a17:902:ce06:b0:1e2:3db0:1d84 with SMTP id k6-20020a170902ce0600b001e23db01d84mr13818169plg.32.1712047705227;
        Tue, 02 Apr 2024 01:48:25 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([152.65.205.51])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ab8a00b001e00285b727sm10448511plr.294.2024.04.02.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:48:24 -0700 (PDT)
From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Pu Wen <puwen@hygon.cn>,
	Ingo Molnar <mingo@kernel.org>,
	Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Subject: [PATCH v5.10] x86/srso: Add SRSO mitigation for Hygon processors
Date: Tue,  2 Apr 2024 14:18:09 +0530
Message-Id: <20240402084809.82243-1-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pu Wen <puwen@hygon.cn>

[Upstream commit a5ef7d68cea1344cf524f04981c2b3f80bedbb0d]

Add mitigation for the speculative return stack overflow vulnerability
which exists on Hygon processors too.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4ecc6072e..8aa43c8ca 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1168,7 +1168,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED),
+	VULNBL_HYGON(0x18, RETBLEED | SRSO),
 	VULNBL_AMD(0x19, SRSO),
 	{}
 };
-- 
2.35.6


