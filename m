Return-Path: <stable+bounces-202913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B47CCA137
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD00301F5CC
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4662F7AD2;
	Thu, 18 Dec 2025 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz7PbcF+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945741EF36E
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024687; cv=none; b=qRevFotTMz0Iscy12q8kkRaIgkahjl37UormP3yh5F55VThoViRNIisaFA2/o1B3Jd9GZP78mzFBR8uDGwNh8LC0D1xE0Q+ZvnsIl5f0kK5KC8SEZE9lzxEja/r+ZkcVFwFOVaxZGu/+mkVswRerbkw1CiXFc0YJgEPdxujvXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024687; c=relaxed/simple;
	bh=B+DJMun+cjBml2nPXS9/YiX1Wo40EajpPwX/VyRkGec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIHCctGGjk2ZXpDxpArwXWlBkkrh+bbOaCHtsNzk2KP4QScp9tV8tRSRF2ZyfX+JczBt8FiZsce2kMqSLG+xI0RXAPIo1pXsXxJcYAJMc36XXyR0XFhRy7LZERmz/lJz8MDfVXg+NbIOdrAQ2H5g6eSJhnFX++0F7jqsNY+T8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz7PbcF+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so198132b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766024685; x=1766629485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSN0jeaPEeJ4teJrBbhIc7BawQKTJhYmKGqZDP/gGuM=;
        b=Bz7PbcF+OzzSsmFyUlzK25IfhtMfBKGQjtJbyCFcyC1nxilt87A7bPbGJvuLH5w6TA
         oU4R2HGCTjxldMFuA05fXfoOFmIr0nv5WBfmF3ULMkzpkPnfCUYO+Mh96cGaFH08CeaY
         PiSu2xbSK6j7rvaIWVglndElSd34FiqFRHZlJ6XCy3XxMdFIxxcnPpS1pAmZvLJL9H/C
         /VtDOh3oiwhJS+/GxWws9LtcOQNmvhNyfBRW7A7MSJIjly9gMnrrBjlH9k8XsnAlvOSc
         B1F0S+wmeQPrpc/iTaOlmvwme7J1tPWZwGjvngR1helI+wGOgTk8Dwm2fEWC7vl3/ADk
         KHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766024685; x=1766629485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSN0jeaPEeJ4teJrBbhIc7BawQKTJhYmKGqZDP/gGuM=;
        b=pcjgYkSCJvVrkSu9NVl4fYRuU9KbCCQRz2Y75ZnDCvdjr8EzemThAGG1676OGkHUwy
         8Kutg/QrUthsa+47Er7yXcH1cM6/NkF6AMYR5u0ZWYuWK+zA0Tdv5dJ5cNgsWlcFBTVE
         6/8+ohEJoxQo/Dwl2h6c4g1GcIiemvYiBOBF+iWWh11nr0wUxX2fBCEejv7yM2i6K41I
         eKFfPuaL8DbIOFhgwmD3OwzwS6wxwzIuyYYbYcE6GE3/tOV4cBOz0q8I6I8+W3ST18AK
         R3WAjxtgmc/5iTGDK/IVgcoSaH9T7GuB8NhkNkPTqPk4PvMIMcyki0Ux/zkmYJAQQgzE
         fSPA==
X-Forwarded-Encrypted: i=1; AJvYcCXhASKdvpV2279T32scaRRqPGpWjXm56s0JmMCwsXG0sRLT6+Rulk58Stzzxa5uG5RZRO646BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IvlI1sSDuMETAAogBlqAcMEtQzI33hB9XzkXF/FMWlXTrHhF
	fHHgwBHrXB0SS2eIWTZfZ4CVu77isfBSPrDTYCL2k+He22mZD80xBCNF
X-Gm-Gg: AY/fxX73LFViK7Ed6KA5hHJbd4om6TaBAqPobaaRQO1xGw9oeGlq5eX6ZsSQovQSQ6y
	z9uXRWL5t13+D9W+d2biu0VyEygTzSP9nVMJWfu95CcyetDvq3KA1EpHQiM523lfFFMf2Sy6WzV
	rB/nUbomafH5SNOvakhFr4u+hQD/M8FEaiw2J69eW1VKg6PEsR5vnlM+HSaCaWDqqm1LyvfG5Te
	x86MoxmTiCYjxezFGgZfx6NNRJaSMs+c+ZwuTxdjNCNACXcl/XQMiniaPobObU6LHOYG/vtaSqH
	cZDrQxacOT2akzpajJMRvzbD7k5duId4AuIMiJd9nMu606xpoE9RsRhgPjrd3sqqn7RwO4cnrFZ
	BikZYyZOVNj9whaMck4Eis1ZoXFocylqV/2xZPS7sSqk+/0j57sdb3ONh19rSm2nv9Vl/wOYy93
	kQAqM=
X-Google-Smtp-Source: AGHT+IE8Rj4P/oC+EGdSGouLOTDDgxhlAA7RZvqicDLoLVKHPGg0PdhGKk8a6U9XOc17xQWVzhf5Cg==
X-Received: by 2002:a05:6a00:1bcd:b0:7e8:4398:b369 with SMTP id d2e1a72fcca58-7f669c8199cmr16024062b3a.60.1766024684756;
        Wed, 17 Dec 2025 18:24:44 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe13d854f2sm773595b3a.38.2025.12.17.18.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:24:44 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: 
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	stable@vger.kernel.org,
	syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
Subject: [PATCH] exec: do not call sched_mm_cid_after_execve() on exec fail
Date: Thu, 18 Dec 2025 10:24:36 +0800
Message-ID: <20251218022439.44238-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_mm_cid_after_execve() is called from the failure path
of bprm_execve(). At that point exec has not completed successfully,
so updating the mm CID state is incorrect and can trigger a panic,
as reported by syzbot.

Remove the call from the exec failure path.

#syz test

Cc: stable@vger.kernel.org
Reported-by: syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9d5ebc9d15b0..9044a75d26ab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1773,7 +1773,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_fatal_sig(SIGSEGV);
 
-	sched_mm_cid_after_execve(current);
 	rseq_force_update();
 	current->in_execve = 0;
 
-- 
2.43.0


