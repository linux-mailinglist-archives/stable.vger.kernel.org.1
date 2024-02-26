Return-Path: <stable+bounces-23615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A520D867016
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA022890E2
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95283629FC;
	Mon, 26 Feb 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j9aE7DNg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08092D058
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940983; cv=none; b=UW4Uy+BC0daMINDoczJHHtuTQ/XsgXvnOczmplwdF4NmeicKmL/Zljrk5kAgG4KLN0xuoDnBqbIPZIOXCSbKteQdFhLbhlFj3GaiWvhk7rWwQyEb9ZYfe6vXB08OybKx70MSNUPjAnMOYRTXzpji9viLQDXgcJUXCbaEGh36cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940983; c=relaxed/simple;
	bh=vTbbnU0AQBSusnj9unjWrvIi8LxU8OXeteKwp4FBQTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyC1mct2gTJ9mbUujQYLXJKSWSCfogGjBtqbVW9B/qtbSntaUUr12/2RE5NIi94ginC/JoCp4VkkiUmfj3L5vaGBNPVTCEraWVACIZq8bhBythIDmJcVSyUP9+/q33NDGyhhd2f+/SlLiMiRmYDOhT3OdcQlvZOUb0oYYG7l1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j9aE7DNg; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1dc09556599so24765935ad.1
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940981; x=1709545781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YFU6WdZM9SQFy2Ur5i4rzS9kbd1FF1r6Cyc0pRvjOk=;
        b=j9aE7DNgNIhyVrQEsOfxi/oYHFRykmAN3ACnkHjxFUDgzhYhtcx1VIM0ZjoJ2EcRaO
         DaLY/iaaIMR0G3tiGhYNtVwx1oW3t2RbGhz0+2UGcd8kl5UUYz1Viabzq7DTTQhXULzN
         r7tycG+rqshOv8hNnsF8FbtM1/xXvsfg95KxzrhoWSXM1CMv60pCm3L0aOrSys8ui74D
         QRBetEYCm4QcfcChqt1vXC3N/hBGGIkTk1+iCDJLf4Vxkij2/HQeazogKd1WvF3L0lgI
         Cj2xiGLsKape7lA9yTCx2BOD3p0qRM7i5nILFGcRpM1CfQyDTGY2cMhpIVazMPI7Xye7
         S3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940981; x=1709545781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YFU6WdZM9SQFy2Ur5i4rzS9kbd1FF1r6Cyc0pRvjOk=;
        b=dVTZ71iFUUKm8J54jxwpV8bnSXTYB4AYMF8iQup97DEXan60HKy6SOsf0kDWlRvwI+
         PGcdr3pglg8Qn1ImN6CknXF4bHGWhZ7z/QnDRqAVCONImwQZRc42lHSD7lijkonbixAn
         sOV9bSJ+tHAYMJtIbqaa95wiBEnLOaYAXhleyjgfuSUSDS7ypJBYOgqRfDb+vAqPEr3c
         Vx+PTTSlZoNh5FyvxHxdSAw9I3FDiaF4sUvsl7POjBLyMvJBI8f4Cbp1il6/yv9d9/Fz
         VgcyoyK40ztXQ53+OBv7Dg623vBnvaQIkcIJqTSW5UVBnkVgvNZdH4ljchcgJsqDFSq/
         RCaw==
X-Forwarded-Encrypted: i=1; AJvYcCUktizDVXH7USKlsqQanbbVtMWnhCn99myQSn7agJ0Jc7uFb7yigjmkq2//Z9ka/a9WgRYNhFX1nAxo23wHhnbdSfmf68Z/
X-Gm-Message-State: AOJu0YywbaKOBzEKaY4DkkwKWP87UJcDpqgYk9EmaaldJ1FgSIL6rL/H
	2d9+tuiqwwxtq1/DrlFJLXvgCmYNgfABM0TNf5ssEQFSdTbrw3QNQ28nQWlC6DM=
X-Google-Smtp-Source: AGHT+IF5Q4fAG2eyABgwlgAjPaHlaQPi0yWnBqyVInoAxr/Abf1TC/57inS0YEkAUywRxd4riAPpHQ==
X-Received: by 2002:a17:90b:1103:b0:29a:9fe3:3d92 with SMTP id gi3-20020a17090b110300b0029a9fe33d92mr3110121pjb.44.1708940981319;
        Mon, 26 Feb 2024 01:49:41 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090ab01300b002990d91d31dsm5934779pjq.15.2024.02.26.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:49:41 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Mon, 26 Feb 2024 17:49:23 +0800
Message-Id: <20240226094925.95835-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240226094925.95835-1-qirui.001@bytedance.com>
References: <20240226094925.95835-1-qirui.001@bytedance.com>
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


