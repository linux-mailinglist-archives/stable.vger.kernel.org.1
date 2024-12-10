Return-Path: <stable+bounces-100406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11A9EAF97
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0264B16301E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F122EA01;
	Tue, 10 Dec 2024 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZoLl7eZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A521578E
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829138; cv=none; b=tvqvtt3RaQ4z1TcNrsDjMqU/dGrBexChqZviNbOQOQ5P3gK/qL+x5PVW5R+SPHjRP432k4JGIk7l0AaCBTosEx/gZBFgARimUDqWXkO0RnI6HqxGWVoz8NsOLjIDjezv5a6wRLx/1z4w28u4G+cBFmyOXqi8riVMG3ce+d05DDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829138; c=relaxed/simple;
	bh=cdXYw9Tvdme2bWVOGV9Iwh1PzUppg3Era9ijL9C/I1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0gmt/7AoMwDwQ4SIwSZRPhdPjdkWslabPCdryeCajLbm72pNpKSueCwOiT6VM6tIGKF3d6EdXaF8Cul0R3a0dvHwBAFuAHGjp1B65s5ea42Gsygo6cKm89Ww8APxtkPfXe3oxjAx9FHmDIWuLrxCctleMCQ7QHZcPh0/jyJZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EZoLl7eZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21680814d42so415835ad.2
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 03:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733829136; x=1734433936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJaIgxkkHsHoc9bLLW8P0+h7fYufIbJFfYcT4zxXnJo=;
        b=EZoLl7eZZVzJ7PmLbQ3TQKzmpRiYmOJBoR+6TYYgjAlwF+pMHm/IkWnhXK0chmxwhn
         TjCgzSH+SzmO0WO8B/HFTB7iHiog13LMp0X/LxA3WG8ux75EguWf71qM00Aqn5HY8OGG
         3efnqM/CAPvbvEr2VKj9NSyKxGKpdci8HoUt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829136; x=1734433936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJaIgxkkHsHoc9bLLW8P0+h7fYufIbJFfYcT4zxXnJo=;
        b=oO2NBf3tr+FG2OVdU74HmQuKcb2FTuMB17/qOZ9SXGiKZK/mD7oDyukJCYwtl7nG4m
         7/KySUp8XSCx0WOOmq44M7zg+Uz4aEaW3c8MG4qJIApHGFuhuHr5tqMkhS4EsDtvUubU
         G8PmAzhUAqHdyuCVKVtFI1IHRz2bYshF+wpDroUofrWUC0t9ZpXMmtSijYaibHWKgTUw
         CgQ+zNrdmN24NDBqVyWzv6B3mSTMCsHugCuNn3vDg2Ama79DUuw0QNeCg8X8kkhowsDn
         AKC4HOsmdWp+Fr6oT8rx9EL3SoPethGvhe/BfxyQ0BOQbpWgQfcoGiSG/muWusHD5czL
         2QHA==
X-Gm-Message-State: AOJu0Ywc3wf+6nlLqwrdG3IMmPnXb6xSoF59w1P6T7lb/c+tGFrtMNJ+
	7yXVhZr7DY/nniT3kSMqgZIijwM1bHxojh6pnvpaqfii79jeEc+JAAaud95uACJyO8jEjYIzL5w
	=
X-Gm-Gg: ASbGncsNnhg8s4nccda5h/sM0HrK+evoXxsjXTZKvOnZ53wU8tBlBo0ivwz68tQOtGb
	IAcF2dpqyxKzgCJEr10945cUWO0crdUiNgchKqi9ikqU2N4TlOrMrZXFpVex1OajkLy+OQAP555
	dm3hmi8LwcpBw6SR3BSXQZ6GK1QNup6NggoTiH0/3wGt+wLEySc2d85Q9uWq2YptJefiO8T+Mrb
	X+pN5O8kMqfAo/MyNMoGGsHk47c7tvzSfCZhugrCo4Y64ODU8oyDqqa
X-Google-Smtp-Source: AGHT+IH0Zj8QGTOQsI5Ij2Go7AgvGYQL1Y2aqPox5m6XSAOSWnjl/7n2V0IRZzaeCbGPBx35N524XA==
X-Received: by 2002:a17:902:ec92:b0:215:a172:5fb9 with SMTP id d9443c01a7336-2166a05562cmr61037725ad.48.1733829136152;
        Tue, 10 Dec 2024 03:12:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21659e7b7casm27897715ad.42.2024.12.10.03.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:12:15 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.10.y] modpost: Add .irqentry.text to OTHER_SECTIONS
Date: Tue, 10 Dec 2024 20:12:11 +0900
Message-ID: <20241210111211.1895944-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <2024121043-moneyless-stucco-c8f1@gregkh>
References: <2024121043-moneyless-stucco-c8f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The compiler can fully inline the actual handler function of an interrupt
entry into the .irqentry.text entry point. If such a function contains an
access which has an exception table entry, modpost complains about a
section mismatch:

  WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ...

  The relocation at __ex_table+0x447c references section ".irqentry.text"
  which is not in the list of authorized sections.

Add .irqentry.text to OTHER_SECTIONS to cure the issue.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # needed for linux-5.4-y
Link: https://lore.kernel.org/all/20241128111844.GE10431@google.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
(cherry picked from commit 7912405643a14b527cd4a4f33c1d4392da900888)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 78ac98cfa02d..fd77ac48dcc1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -951,7 +951,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
-		".coldtext"
+		".coldtext", ".irqentry.text"
 
 #define INIT_SECTIONS      ".init.*"
 #define MEM_INIT_SECTIONS  ".meminit.*"
-- 
2.47.1.613.gc27f4b7a9f-goog


