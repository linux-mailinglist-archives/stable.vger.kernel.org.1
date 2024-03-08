Return-Path: <stable+bounces-27127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B134875C6E
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 03:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27CF283910
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE92C68B;
	Fri,  8 Mar 2024 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTvPK80o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661002C1A6
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865951; cv=none; b=b7BUCf74ueIeaWUyjq+YYSbRl/2DHhRRf2VTKUPNfTv31ykP1MvMKJ1uQBFSf3kGMg5PfrVqOmCiRKJ7Wz7k3mtl4IdnABAhC4/Alw0m7jiUedXt52Wu0dIvWlYS9Q1lkJ1OeJTN56DfLdHOyklc6IojvtuG209s+ZxL/gV/5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865951; c=relaxed/simple;
	bh=W5jnX+bgKVpgCXJLnqW/MWwdx7iLA8EDehVPIN+x1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgIi7iPm9xZB7CXQ5EdoryFQNG34u/m20Pem6Tou0dbCyWg1py810bTgxh8mhlTrKzrw6DxDWmcooKH8QH+IVWHcRU8szGbMVLQVoK0CkibXF00UABj8ELtoDD1ls1SqtBCmcwC4kGLSiWEkpxlDtedIhTqg3GhwYPKhUT20pOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OTvPK80o; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1063227a12.3
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709865950; x=1710470750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=OTvPK80oNGhj0mq/o+hdmPmmytRwnTsqS7e4aSaf7mjpa2yHJevU5cVz/VpzvPD6jo
         PbitksuxGdYHQnzw0+K3zhjYu6Hemx8vEueLymAK2GMWbL20UDrXXXUbVPz7hOFiFogg
         iBFLMn5zThv28PTKzL4H8Ky2kxKRbXRhLDVIMQJDPRfcfZfLUXBj5NNziNiiaXFLIlZ/
         jXQFbOde7p86ZvEdXidKGB28zvAYDQoqX2XUhJDJ/+eu7DGvv2+/hNi3sh1d3Dj2rfa8
         mQziUiPZ+3Vl7TV9I58XsedOmjobwO/WeKu1VWjijp07TAuyidaBiv+HysT7+f+wBOD1
         9heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709865950; x=1710470750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=lFLpdMZVA+e4BhXQGo3RGSZL3f64nEQgMc8SpG0Ku5MxaPRJswAGnxFo/QrGoaftl4
         ja8FCTBVBYXWQbq7OdRQRHmjLxMjJX2UzAxbXq3t5RYfauvGK1YGW367aCrBaf2AeELF
         vRTcOFiOFgfTIDseypcUCzkwVO0chCdYW9+NsQiTGGrbuuB+OpH60su8S8mxpZLcjoGa
         Uq/PwTL8Xj3RUJ63PWsu+eYgFerXqwN2vRkxuYPnRkdHF5qTDhWORfBSP+XhgmGYCM37
         C0l7FSm8NAGgDigM9ENaa7+WAufhBAi6ZfeCT+pB7e98EytC/buvbsOEA7oBACBIMB8X
         XxJw==
X-Forwarded-Encrypted: i=1; AJvYcCWNESBg3LLOHTe6uVYRvOR9NnIl1KOEXQ9tHoM/jUw533klHPFRytWNKX56faGPy+2kaG6KrihKzp3gcj8DCd1s9gZ4AGwb
X-Gm-Message-State: AOJu0YyouPwpZfmCj6dRkCwrYeiTITKWoVyn2L2d4cB78xqoQYNZ4xi2
	bU+r5CX2VjecmKFLjcmaO0fl01OeXNC8L+KHjbW114DGUnlO1h66GApZCTlrZzc=
X-Google-Smtp-Source: AGHT+IHfqv2VeQUZO5OpjG/niCqlZWhURb4+gfcYwXm93T3wKXkIC2RK2QhIV8Pp46SWhhYaqMJS9A==
X-Received: by 2002:a05:6a20:244f:b0:1a1:7821:d012 with SMTP id t15-20020a056a20244f00b001a17821d012mr2882525pzc.26.1709865949817;
        Thu, 07 Mar 2024 18:45:49 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:4])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001d8a93fa5b1sm15244360plr.131.2024.03.07.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 18:45:49 -0800 (PST)
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
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v3 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Fri,  8 Mar 2024 10:45:16 +0800
Message-Id: <20240308024518.19294-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240308024518.19294-1-qirui.001@bytedance.com>
References: <20240308024518.19294-1-qirui.001@bytedance.com>
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


