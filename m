Return-Path: <stable+bounces-197603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5012C9280A
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6B5D4E41A2
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC02BE647;
	Fri, 28 Nov 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIp7FjUJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F129D27A
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345955; cv=none; b=MpZQLBti8We5xg3OyMV46w2CxnBZWP2SaARmCtJJcCrEU1IfW6c1YmVW+fStrgJ+oBoCMUw9ut8Woy1WgFltC2cZ8ESduYVBlp3tY0IPcoeBc3z3cjRPXXJL5OmiI7CBQ4c6bXhvhiO1dpACeXFwUuxQhhIC6Vxn25fOHz2VD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345955; c=relaxed/simple;
	bh=BfuWtJpHFnoUxb8s7xJBVcBtioNVHYkElOeeOAD1d8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwKEAgP1N3SKeKg3PGIw893uuel/z+Y9aCo4k1DEOSXrUYdM0dwoIiwVUhvxvDr89Zy/kQ7Llg51IxULG/Cy7s1rSCMxRSVqOp/ytisqzi0aW9cjqW7yDbEkrIcqJXEXznhYUEnFyxMqMBdQZGvs4jMLUCyxPBMltqR5Unq4hQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIp7FjUJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1948208b3a.1
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345953; x=1764950753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=ZIp7FjUJ2K0go7vjjinxJFHzyZlBRz/ZV0MiR/VJUaJxe7yVtl9coSWY1KQfil1Alh
         v7/Xj/TIkg+09AA9lGvxcjPvrWjwrVcNwGf9LXE4XjTxIxjxACblZNge+GvcVYQiCUrM
         1ds2/q8smKNYPGbQRrfel5/RiDDi9KLSMG9BaCO298eDRDr3lYlb0yn5CFYgO71A36J3
         XzcBgPY0sILL5GWIdba78nGV2bia6FH5RF8qHK7efLK4bdUb90lyty7NnVyLyTE8JOLv
         scr6qyIUiO9r+ckVYl9VfOvuyPv8cLypXLBoncy0Q06QMY2dOlXKcAf7m7w23KpLXQIj
         sfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345953; x=1764950753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=SDDxYtnpGZq96nAP38lOSYpL147yDNagPUQukxQKAYWT7gm+XRFs7HDEbyv227bPr2
         gxOK0Ea9EOWJe6rf6vAg+KqbMr9sskcGJiiwwvOpLDBCNfNhA52qSmFV9gqXmKpS7PyV
         I9O9D1oTXqZSZ03s4hOPSUB+0McdXsZahOle5yKcQrrcq11m5Jr3veyuXV/a5nv7yajj
         cO4Cctqtv5PqRgUR28qblw9itoHwbj0QeKxpKd6rWy64HLwmv7X45Ce2FOfM92QjM2Sr
         IGt0/V9aFGAiqwzNAfi90SoVOAOcI0MBbN5cWF0KiUhZ5o07sz7YsywJjTu5hnlJ57QU
         frPw==
X-Gm-Message-State: AOJu0Ywh51yUFXLtYrKSi0IFrD0dffaNsGD/hPWhgHeGIpR+PFVKgBeH
	JWKg9hMOMVpGdbTuIVMWdfI8RlIs1CWsIDrmdrPGF0p218CB33H5yoOZr1UxDtDzOt9nitqN
X-Gm-Gg: ASbGncvfy8gWY1WarO5K2urkaRBJN7GSbHaL/euRB4fCMkOnTAffE9Y+gz2jquSePwD
	ENxR/LbG0zvyy8yW8Iq4C2P1FPxm4fTibtTqaotU4eH3SjHefIdC/ZjHrQkFwClaABGuZ2cUlK2
	6DNQHKmmwTy3Dv5TQ6XiXJ1eollbHAglyVYpawAY+Y/LsgrI2dsalmnGnY+ZxBlenM37hH2vV4d
	nNckTgqJwW+K8PauckzNN8V2Ws0RjjKonSs4LPUjhEdCoN+8tRZzJTM3ytd/ypdhD2P4oGhRwgl
	+4vt2UEwPxnVeC7g5soXNxAoWiC9vmcdOuSQS8ECK96A25cCRpjFkJrFl+M1WfxA68BX3KKNyeU
	toJWWN7r5tMvFs/veoyeEwoXIx7wkRVRR9ziadyvIa6X5NYsCpD6t8a6F5sKoIFL+7jtNk3deE7
	Xwcp9fGauWMEV9cFQ2BJMNGqxYQOj8S8oE4TZNA6Bc2+dAIkBh
X-Google-Smtp-Source: AGHT+IHy5Mo29j/CWbee5Q6OSCJW+TSTmTNfb4OAc8LY3nxwbKHubZG/p57p57Ap+fsLvqvjiDlwdQ==
X-Received: by 2002:a05:6a20:4328:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-36150f033c0mr33804804637.35.1764345952577;
        Fri, 28 Nov 2025 08:05:52 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:05:52 -0800 (PST)
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
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 01/14] Documentation: Remove bogus claim about del_timer_sync()
Date: Sat, 29 Nov 2025 01:05:26 +0900
Message-Id: <20251128160539.358938-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
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

