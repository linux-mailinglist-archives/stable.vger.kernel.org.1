Return-Path: <stable+bounces-100405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2A9EAF8C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5A16AC33
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC77212D86;
	Tue, 10 Dec 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQpu/ErG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31A1DC9BD
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829056; cv=none; b=RTeeK9Fmy/koMWRjxSuoeDsOB1f0hE1hJSyO8j2QZpLHDubjbNtcBQGMQs5OecxwTTjWXnJWLzQ8SuTDCDcHnH/oc8yRVVaEE7GQ0mPCxN4uPHE0fgWWMDVldWOi+87R6ITfnHEWYXY9JaU5xTPXNzWzFnrZv14sx21SCq3jNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829056; c=relaxed/simple;
	bh=owTvWL6AADlpZXQCpFXiMeLwthOENU5U7gw8f1CCC+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfMS9fy6zPeHzElYbSebArclR5K5vvio1Agft8qXyd6GncLt8McFBNn7v2HbBy7c7KbarTh4eLPMP5tP7MsPb9zdu9vfHguMuDKUynOlbGg12FcDvZUCvO+oTSN69G4PlKjukdal9RwWdCcJKUgMVrp/XJaEecOhvqWmaSvLGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQpu/ErG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso6616b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733829054; x=1734433854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5zrLc/39AZlyzb39aeGuRl+eLq3lo9ABTDZAWs7vGc=;
        b=RQpu/ErGCWmyL8NrTqk3A2lcsaD2qzI2pbbsstSCdaRK9u3gC2jUwg9V/+cObmGoxh
         L5RDWQetzuHA457lpKTbts2+XrOxWIRjiDhTvNTlKlTNEHFRN4ZUWybUUeGdlC4/aS6+
         MCckc6XmI/sepw7K3akcXE0asS50H+osQHwng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829054; x=1734433854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5zrLc/39AZlyzb39aeGuRl+eLq3lo9ABTDZAWs7vGc=;
        b=TO3qGjKDIpAv87wvB/p8aS9kzND/K28R92wQdGj8M5hIBfJT+JT4Mlx/rExycDr7rP
         Kl1HIFmAAITcYoKWYGhT5oNMadfq7e3B+HyOJDP5Pr9ogQVRUL7S72XYagA81/medJAp
         gVH+BuY6XvfgXrbyPUyigK7bLhy8ajJ5oJb4ZFSFEVjyau3EcYFmi8QAEJ17376BmwMU
         NvMnxwHGjrb+kWSrJJ3zWEHUcHmZJvVKdf6AqFr1rTO7OYU/YhP+N5DdeSDg86f/7iG9
         /xkjWNBNzKbkK4iGTBlwg3Y2nDg1af680Jvtk82S0eVooGMKZV2FMPevBgKqqEHTqYTn
         3Pow==
X-Gm-Message-State: AOJu0Yw4WyG7DWzuO/79tNQgh7qGjTCBWX3N3MlBofnVLnXUDW0A50Hg
	Kb40qoZPOfa0GBWcBYxjfuZyYi/qmOHYs6ikYIOBs21CwjL+KIbkE85dWj8vUnQJtwi5JirVTTg
	=
X-Gm-Gg: ASbGncuOW5BFMO5yCBC59S/o8hwEVTbJyVvy5JnhEP5ERym+pL1hHTzF/dtejyctarj
	tZNv4qrn9Kvn4OoOFySmbJBnG2Nwpoz4XSUz2ffrqVkzZxuzDPEaU4gyT6Vi7rhOCdBJbec4wTt
	TiVZ1vSF6VPPE4ICJQgT3hZ5R1Gy36ByPJlGY0lWQvgupcZPcwtP8DXjMQ1KKLY4YQACbCevNEy
	L/jueHgBQhZLM9beNhf4zwnonCoex8p4e0Wjxy/N0A2/uRJNo+UMjMX
X-Google-Smtp-Source: AGHT+IGAiKC3VKqVq/bNO/7RcCelHBv8DUfSMA/xCt32VdVmJNeLVFIOfoyRCEEk9lYy53JxpiHhFA==
X-Received: by 2002:a05:6a20:6a20:b0:1e0:c3bf:7909 with SMTP id adf61e73a8af0-1e1b1b98e5emr6786489637.41.1733829053832;
        Tue, 10 Dec 2024 03:10:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725df830510sm4879024b3a.29.2024.12.10.03.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:10:53 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.15.y] modpost: Add .irqentry.text to OTHER_SECTIONS
Date: Tue, 10 Dec 2024 20:10:48 +0900
Message-ID: <20241210111048.1895398-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <2024121042-refined-ducky-6392@gregkh>
References: <2024121042-refined-ducky-6392@gregkh>
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
index c6e655e0ed98..5962c4f94f4f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -940,7 +940,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
-		".coldtext", ".softirqentry.text"
+		".coldtext", ".softirqentry.text", ".irqentry.text"
 
 #define INIT_SECTIONS      ".init.*"
 #define MEM_INIT_SECTIONS  ".meminit.*"
-- 
2.47.1.613.gc27f4b7a9f-goog


