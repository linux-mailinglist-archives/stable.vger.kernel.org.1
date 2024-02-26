Return-Path: <stable+bounces-23611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE7866FD9
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9041C24F31
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA55FB88;
	Mon, 26 Feb 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dgLqfTQl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3A5F869
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940481; cv=none; b=kKOAa7TZHsCpK08/G5oN6HXLF+RLrm9w8N6+zJ0g/48nooLVmH2Od/8zcOprEAd+WRF7ON3Uqg1XV0/S3mo7RSbD9s/xjMrHQ+XgfVIi3svJvsVxPHa8qkq2e4wGU4KKtxEQS/rXZ/WPPFsvfeokTYSuG467vSkzxKXUgCP74CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940481; c=relaxed/simple;
	bh=vTbbnU0AQBSusnj9unjWrvIi8LxU8OXeteKwp4FBQTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjIUoVZjunQ9qpqScQwwRHFWaosO5wUGjzqWizPGvQhuLFhb69p8CU8uMClVinurlug7FqG03mHCJIghCnuzOYbUP/uu+cSg8KNlLV+N7APA5rMthceJp0JcQpkmlDDg0ruQgBmexq/WxIi18ktP/RYAGZZ5BdmRyM+7BXY1e+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dgLqfTQl; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6e4e2380588so1046154b3a.3
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940478; x=1709545278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YFU6WdZM9SQFy2Ur5i4rzS9kbd1FF1r6Cyc0pRvjOk=;
        b=dgLqfTQlM2kwZWexxnIzIltB0VVxRl+VVR2RCVA+ZbBzoS4bqmncoJ0PDMbJee7CsD
         OPLFNNZ51dAGOog5kh0qwqjhESX9mD2jKCVcrUqNUm4lysYyKr6VqzXUR9iZLiWlokFn
         3oWyp3ovwPVdSQimK/dn0W5LJBp3dKQHYN33psyOT0oj2DvE8z4s7cpuY91FfAc1vZmX
         0MOsn4q+W9EySwmJUiXshWfaYeqlNLsz3flNx3sPEVwh/VDqYvTMi/EeunafOIlv/jRH
         GLSb1QyxmJFKFuyVdIAR+MeVW9MzedadE9kSuZbw+1no9ktsfoECem2Qkiba3wBOSs4l
         gCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940478; x=1709545278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YFU6WdZM9SQFy2Ur5i4rzS9kbd1FF1r6Cyc0pRvjOk=;
        b=XxRJH4WFcC65eb24eHaZN4xfAV/Zyz3FB8FDXVcwj71kOReA188sZVGfHudt0R/SLL
         cQlgmLMy6TVbRL+S6nlqiJHhVlw3eWQfoEqCZuNs1fZXLUFKDraMTCenAfwRHioBTnzk
         bPh8sASDSOGe0RbF3bTrlr3gtLyqiGGFJHKp7w0qLAg5aVGKCaO6SDG7ZOPnjzGnam7v
         LyifnWEa2p821nfj7bQ7f4FzP16JzZmRYsnDr0QTwG+wu2k4F6qu7k6b4MjZ7MaLb8XM
         67W2Q8PXgq19sv4tcPR1B1M+HRiGP5FP6uhrZ544AztteDYyItEbaMvyxJns178g19tq
         qOXw==
X-Forwarded-Encrypted: i=1; AJvYcCXj7TIkE7dlTv4hGFdD0QkVG3EfJBwKnqh3lIhyZwBp8RsknisOY/qL/6IojALYvUS2gZ93IoZdueYNfdCtoivXzgIgJCrz
X-Gm-Message-State: AOJu0YyJn1BO0GZNgkFTpwx6HipTLS6UsUSIwer8UWdinAbXknyt6o4H
	tCb49qulV+Vvxfmhx+E5XTT9qVKnzIAmIbD6e2NUMIQ7Mx/riMpFrihgAH4wD90=
X-Google-Smtp-Source: AGHT+IFval8ZOQaomGfAH/X9BgRIO5rpmmlEDreQ7v8aTjUX2p97jTehIp8TC5ziMI2SYFw8658Bwg==
X-Received: by 2002:a05:6a00:4e5a:b0:6e4:df65:8335 with SMTP id gu26-20020a056a004e5a00b006e4df658335mr5107611pfb.16.1708940478025;
        Mon, 26 Feb 2024 01:41:18 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id ls22-20020a056a00741600b006e533caee00sm949194pfb.155.2024.02.26.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:41:17 -0800 (PST)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
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
	qirui.001@bytedance.com
Subject: [PATCH 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Mon, 26 Feb 2024 17:40:59 +0800
Message-Id: <20240226094101.95544-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240226094101.95544-1-qirui.001@bytedance.com>
References: <20240226094101.95544-1-qirui.001@bytedance.com>
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
2.39.2 (Apple Git-143)


