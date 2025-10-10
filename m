Return-Path: <stable+bounces-184009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A924BBCDAF6
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08414FD9A8
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7512F83C3;
	Fri, 10 Oct 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOJWUjGY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CB2F5A10
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108587; cv=none; b=GMVpZX9Ya+kzKJk8ZZtSBJ/fMa3ksXiFPatqmHe6EjSyIqEfFJnr02BVuNuL51BEq1n46XQg9SDPA3yo4yvg7vUihkCra3Ke5M6rOFd7rkineR3xkPqB6Rfov27DF+RWZow4nulM6+48TUsqDsEI1CJ7NQDPLOWo6hXRpodO45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108587; c=relaxed/simple;
	bh=BfuWtJpHFnoUxb8s7xJBVcBtioNVHYkElOeeOAD1d8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT0VhZRld0wwQeCDyVc6aM3MMJXfmbXDmEoQtKv+vhsryoy17pyZbnxxUWdK9DlPt5VQtNy8BR/YRSFZNrxIAnZou//5bVCmJHNxSL2upa+un35tEJfONc1Lri6Jg1NNdHxJL/YGAExPxZORpZP8GXqBcTDBz3KAGsHdhTeCso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOJWUjGY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so1881755b3a.2
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108585; x=1760713385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=jOJWUjGY7g5vkdEDoSO3DnDTAix7UyGmMzh8e0cJ/t4f9axbWimQr04i3E7aoAoQmh
         fBeQZnegMtpgC7q+xdRAJaoMK7Y+XxIdLkxoFzLIj4Yrg2t9xf7Saqkgje4gAEU4dHTi
         r+3wV4FnrKAck7RQp9w1zrtkzvuqAruNl+vs+04ACZFfqzG1uSDnHk6J31jmrhilqf5l
         Qoaxwi+BhNX8gyn/vYIu/V4gnyDcAF9Kn75IcrxT4d6BZbXzRAQG/+Y4tlkunxWIT4pr
         9MPxCCqtkwJRW0k9KsfYrtMOOQsVUu5CeBRVJYaPn7OTte78Y1HFMMaMEYH+Di7Fgj/2
         lF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108585; x=1760713385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=p78NlobJdEi1ecoh2rUbdXvipKo0EYNRkieK+ogg+MxbjQwXk1Lw1pp06GiQOHEjGr
         YGMUvDRVvNk1r3UPutf5buGtJ7I/iUCakK5uHPxjuG2fuQUOqqGxUD9v+zftQsq6yH5d
         VSeY2QhbPQaFr21Y+0hfc3GI/+snDRZ1JZh/FUfPtsAgGp0PF//5pFp1ZUM9EIrD74I8
         okKbXF87woIghn0wJyHybs4BVX6N//iWRWhvGBSVAzMwsvyjXEx3TssnPwThOdl/FMtD
         +c7B+PLep5or+KQObM9nuYMnNo/IAAGJI0Z5s/RLwRH3sXF+TDKAZVcpB9xrQuqm/JBz
         0OfA==
X-Gm-Message-State: AOJu0Yw+vkCRRKIP0yYwUxTaHLpHuCkUar/E2v2mL0qE8e+TQGqkv82+
	nBtrDc4PUkdynO45E+E1X9dSnW29BWC/UyXIyFPk0aa4bHuTeju+RQKcCRqc+Fp2gt/OMA==
X-Gm-Gg: ASbGncuFz2Lz196ZjFDe37QE+Ja1RiXXdkRblnOQCdgR/TwlbZKrD9zwz95tDj3YJC3
	KyzZDvNtWKd3ztMp74XBkJD5reXc8Ua1BS04JdFZaEHxFpf82tCGJPa4b2NHorpCF04GGy1hGUT
	yJmooeC/cnxgw/tgIATwhew1TFdTBTFF9mnwlwjZAoLL5+tSHJq9hezFadpctlvhkTgGgKkvs6z
	wzozAvjFES6vFPqu+XQueDvgaD51hK8GTblap5edZ45SBVP2C7qYqfRYl0LaQsQuOSOOlG+KHLg
	bSXbvzwxcONiuP79U4fswgjzVAGncSYHJHy6g9SvMe9C+TMqLvv5IP/jrzmliH85DSbZXXAcjRe
	1OgjyiaNWGBhOotA4fBLBH6UN7kURkftuRiRavPNf4y18I5tner6nE+OlU383/hD8gL8hSZG/QC
	Jno5Xr/DfFumwQYw==
X-Google-Smtp-Source: AGHT+IG6Mclomm9HYyi1FtTvYUfbr3VX3dwyeq2EoCOUrPpK9DPowb6JOh4ejWKRDTNNO57tGjljAA==
X-Received: by 2002:a05:6a21:50f:b0:32d:a8fd:396c with SMTP id adf61e73a8af0-32da8fd3980mr15458796637.35.1760108584393;
        Fri, 10 Oct 2025 08:03:04 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 01/12] Documentation: Remove bogus claim about del_timer_sync()
Date: Sat, 11 Oct 2025 00:02:41 +0900
Message-Id: <20251010150252.1115788-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit b0b0aa5d858d4d2fe39a5e4486e0550e858108f6 ]

del_timer_sync() does not return the number of times it tried to delete the
timer which rearms itself. It's clearly documented:

 The function returns whether it has deactivated a pending timer or not.

This part of the documentation is from 2003 where del_timer_sync() really
returned the number of deletion attempts for unknown reasons. The code
was rewritten in 2005, but the documentation was not updated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.452282769@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 Documentation/kernel-hacking/locking.rst                    | 3 +--
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..b26e4a3a9b7e 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1006,8 +1006,7 @@ Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use del_timer_sync() (``include/linux/timer.h``) to
-handle this case. It returns the number of times the timer had to be
-deleted before we finally stopped it from adding itself back in.
+handle this case.
 
 Locking Speed
 =============
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 51af37f2d621..eddfba806e13 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1027,9 +1027,7 @@ Un altro problema è l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
 alle corse critiche, dovreste usare del_timer_sync()
-(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
-numero di volte che il temporizzatore è stato interrotto prima che
-fosse in grado di fermarlo senza che si riavviasse.
+(``include/linux/timer.h``) per gestire questo caso.
 
 Velocità della sincronizzazione
 ===============================
--

