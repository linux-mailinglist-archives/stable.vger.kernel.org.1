Return-Path: <stable+bounces-32457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B472F88DA76
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D679299E68
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878947F54;
	Wed, 27 Mar 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cBzl93XH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F54503C
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532709; cv=none; b=thlHSYHtUth2LxRUwJAiW5ta3rALmga9MEfMm7gWbY4W8xlF93Ltj8NGxjAW6A2lXn4TxjdHIZ5US53LF5F8Z2sOY5ehIIBew9Zv96RGawcBL2CH1MDYPl5aF16pZXI6TqHRVv2cFQsU7IyzI9SxelS0kxY/KGWy6y9z8ZVBVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532709; c=relaxed/simple;
	bh=W5jnX+bgKVpgCXJLnqW/MWwdx7iLA8EDehVPIN+x1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCEtr0uU7tMARG06y8PaZN3xWnkLQsheSAd3VJkrIfbJBGkFWjSN4KJFVz3hnN0GHT7O568Wl/6LAnPEZMwWlY//8G2dtiSOsubYBTNgu4K4ow1rx3o0f7q5qHueLpLzevGI2xU9pWS3ovJvevs8QaDu3/Nc97jbJyoFWgXa7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cBzl93XH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3137354a12.3
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711532705; x=1712137505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=cBzl93XH/QxELGmXA8vmdQKygZ12iA1wdLgmfP6vQmBaBXbYD6w/ywJM+by5P9BPSx
         4krkHI57EJcer3z8qDRLCenxrDzr4WgSPz8LeH7oD3ZZDzvvvrZNvIznHRYeuXP1r6lD
         vayUQ8hslgTBgp63AbqPBAZfj9sVDyN55x6GNc/MiYuM6yBrt8OaU8cw8rQJULBbwcqA
         Ni4lGHCqosaUkqpsxE9lOdrX5Ejm5FHK5xupjsFaLdHIDorCtmEglmELoBaiy5Ctfzlj
         3enIuV5SUsGvS2Kg0bqDVKZ1kefLozeEoHQAUzB2fClD8UL/ZBqFiAgqWWwL986NPjk3
         xkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532705; x=1712137505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=IHTdkSSoAXtanDzD8FhRSOgQ0S14tr/af/VMeIIz2YcF+5Hyg/ya0z/r/6HNhAbhQ+
         fnvrZez+uEaGjjokLp5Sa2DpO++F+tYX2LAAHaYYvi1Zz0xSDIglHijlmBdd49raG2WD
         C1MqPcWJP405jL0MCX+9TBu1x1Dt5E2Nv9e9QL+D2nRTovGAiGlG0ONfsaHQox0qcRNw
         t+OxNbuKBrP0h3bsJZfV9jH7pqvr+skKisdE0yjZ/rLiL0MuPCa98TXNy7j5nL5DIJRV
         6+u2edUiQnNtX7Q3dEbDaPzvN3Jh42QwdXvxrlNx+3YyFlVsC9pnXcj7kqdm+xW8i9sh
         K+wg==
X-Forwarded-Encrypted: i=1; AJvYcCVOPXojQxUQZg7SnRxy/HIu9CDkyZPVGauLA0u/JgUWYt4u4huXRgjhHkjHpAqGB+VHeLhxBB3JU5h6PsQ7THkSG3AnEHFO
X-Gm-Message-State: AOJu0Yx5euBh1hGaHpJcJENjynAjdiR7IQRUusUNnDtWkLd+qSza0nRW
	mSIg2yUr3aqqoEFmKt4KTwV6D65dRP2WkbIkKSRJmWdDKV1pn9iVa0vDO0ZnyVc=
X-Google-Smtp-Source: AGHT+IHgVLKDAxGZr69s/xspP4noB5Fo07zqXj9hvlT9c36fM5bvGpHkLdulbs7nzpU1fsapH5tmXw==
X-Received: by 2002:a05:6a20:d492:b0:1a0:f096:502d with SMTP id im18-20020a056a20d49200b001a0f096502dmr771519pzb.22.1711532705336;
        Wed, 27 Mar 2024 02:45:05 -0700 (PDT)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902e30300b001e002673fddsm8500474plc.194.2024.03.27.02.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:45:04 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	sashal@kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH V3 RESEND 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Wed, 27 Mar 2024 17:44:45 +0800
Message-Id: <20240327094447.47375-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240327094447.47375-1-qirui.001@bytedance.com>
References: <20240327094447.47375-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Chartre <alexandre.chartre@oracle.com>

commit 87cf61fe848ca8ddf091548671e168f52e8a718e upstream.

Fix is_fentry_call() so that it works if a call has no destination
set (call_dest). This needs to be done in order to support intra-
function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-2-alexandre.chartre@oracle.com
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dfd67243faac..71a24fd46dbd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1367,7 +1367,7 @@ static int decode_sections(struct objtool_file *file)
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
+	if (insn->type == INSN_CALL && insn->call_dest &&
 	    insn->call_dest->type == STT_NOTYPE &&
 	    !strcmp(insn->call_dest->name, "__fentry__"))
 		return true;
-- 
2.20.1


