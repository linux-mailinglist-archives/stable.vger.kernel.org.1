Return-Path: <stable+bounces-155130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A95AE1CA6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D3A188F445
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702628DEE2;
	Fri, 20 Jun 2025 13:51:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA030E850;
	Fri, 20 Jun 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427511; cv=none; b=XWovzK0VTdajfAikk1f5sofqcHpok2mSvtlTDO0d8ykgsynmYaGu2SzVgRx0pEEQQkgdfvP7+vHEY7UH5Md4uuh3Gg1l+Lil8p6bLM9xpypWSoNR0wy0uhuwFotUOH/Wtv9EvzEy+cB5+KgAigq2O6MfoE4XGdLIKVk+sYVhx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427511; c=relaxed/simple;
	bh=P3RnPoFVhC5E6iVrRqpm8DhCQwyHFdoAwr5HJvx4Tz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ul0hL47iWcwh6JdbZGEeJQQH4kq+8xdOyqyVxoMs+bpa4CixZOSaZt70BziO50/Sy9gUEdPQLBlOIoPNgpFnIO2bPkadHrdj1VZOOAd2zaH0jAA3KYpXy4kr3iPhDHl+QY0/5vr3vwMPVDnYB8i+UqSAZ+hlg4mZ+RVsxYX1q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adb2e9fd208so376013266b.3;
        Fri, 20 Jun 2025 06:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750427508; x=1751032308;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D63RK48PWQVuxSrd45/3OwZj0o6vwR+6fGj7coNjh7E=;
        b=mozYafhp3zrAYJQI7gg24Q/vSgSmX5dmhVSsdtcyUb7cKgQs+ti+Pr9kJNRUMwfeOu
         PpM6ihcWEgb10MfoIPXKnAnao5/56XPUfVl0WlwrJbHl8VunkuH17sCHP96TVaYrBwyc
         dgvxCEHvaU3p9EOw+34U/2EF25BJHuKFEN/dWeH6v2v9BVoXB7riXDbtet05TwlTdC3J
         GLdgiH6u++SZr2qia0hMV61GVtdVafMefo/I8cj1T4smzPdbfocbsOV3iCVEJ2MvXhu8
         CbitruHamHjw164+hnjh6SzZI9L7T+shTTfg9GhLsV5YQ6JVniXCajA/HTeugPz0Kvb6
         BjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/9DV9mB3C87oadee/vdvHe2rCKvelh2AxR/9DVlZv9NQhwS9LiYQFvsW0Xmdh840F+JKlbebfGiv8nJY=@vger.kernel.org, AJvYcCWR0pQZzB/xT4jOHMWGoZbtaM5cXzky+vs1I5/EBvXSldJx5KmPVvUnSnQHhm0pcNBd3ZXI7/E+@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFcOwVIv1l9GbKYJhTJDkFXSEyRl3dg3txCfAnDIpEfOXulVw
	1QS64xL5aDySscPdGGTCApeaEY0G1rS6UmddgwsbtC09M25frTmoj7or
X-Gm-Gg: ASbGncty/7U30Mk/65mX5kIn/Dq6uB2pZpNlgI4v9BTdX/2/d5oGDpevivNvLLIa37N
	uC9tMZNc+I0iQpKvMah4HpaALI99zKDvW2c+FbuWN8CIeleYZ4Cczyxiowi3VB3Ug9wdZD7oCsN
	bMh2DLrvLH3eP4Qi4szaWekKdEUH4wcWbZUlUIDdJY2Wqx1j2DfIKiO3FXnI6BNLLf2fCf7SQI/
	95768j6V9ZxPG5GalYT6rE/XFa0NlLpi4dmBmBSDvwrq5ZL6O+R9T2NCIj62j+JfZSDA0zv+WUJ
	9H2dRW4PwP43wgopGFozOw3ZgoZliw0YJgbmc7ZnvDGN+lx7gXzG
X-Google-Smtp-Source: AGHT+IH/SFtmln+YJHoGXX1MmoNT4rRheV4oGNwPg3DsX23NPbZmw1xFYo2/+iW7Q3Sv6yR/qDwd0Q==
X-Received: by 2002:a17:907:3e95:b0:ad5:34cf:d23f with SMTP id a640c23a62f3a-ae0579246eamr257828566b.21.1750427507415;
        Fri, 20 Jun 2025 06:51:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6e36sm164010466b.120.2025.06.20.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:51:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 20 Jun 2025 06:51:23 -0700
Subject: [PATCH stable] Revert "x86/bugs: Make spectre user default depend
 on MITIGATION_SPECTRE_V2" on v6.6 and older
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-stable_revert_66-v1-1-841800dd2c68@debian.org>
X-B4-Tracking: v=1; b=H4sIAFtnVWgC/22NQQrCMBBFrzLMuoEkNMHmKlJK2kx1QKpO0iCU3
 l2w4srtf4/3N8wkTBkDbChUOfN9wQCmAZyucbmQ4oQB0GrrtLda5RLHGw1ClaQM3ivd2TG25P1
 IEzaAD6GZX5/kGQ8b+2MXeq6cuXzh7yDA/7wyJ92lZPzsXBuqwX7f3we95wmyAAAA
X-Change-ID: 20250620-stable_revert_66-092ba4e66bec
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, 
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, David.Kaplan@amd.com, mingo@kernel.org, 
 brad.spengler@opensrcsec.com, Brad Spengler <brad.spengler@opensrcsec.com>, 
 Salvatore Bonaccorso <carnil@debian.org>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=leitao@debian.org;
 h=from:subject:message-id; bh=P3RnPoFVhC5E6iVrRqpm8DhCQwyHFdoAwr5HJvx4Tz0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoVWdxDw0PsMZmI+SEZnerwoeHV019dLLjO7mYg
 LGjqq43hX6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFVncQAKCRA1o5Of/Hh3
 bf7mEACWZA6ILEvHea6yG8LbpKya1PBDOQ3CctzopUGattlAo4XnJfTeRgjCfp1+nmWeGgZPN46
 JR7m9Duwl/+ovyBPjOrocxoRlJ+DfUwbAQV6ILwVBto2qjIZcoM8R/YToVPUaQuPzxoG4FYdQbi
 URK35IrVQHDLpxW1Q/37YzM8JxQZhgt8zgPQ5T7lgQ2WNKJmJbqWPJQpEJoAmgaJtlB5DshxxrX
 CaMuDXLAzL26WDbrgpbi/5MM3/eb+mGzj+EHCMKkiAIMx7A5cbFBhpm/mI/L044q6abck/G3UtS
 TiT5dijgXRbfE8wEGj5KILm6REPAibBNvA3JDuChP4HdWx3pPc5F1NPrYT7+eRuM9Zg8hAjS6DV
 mTJvx8lsgd2BZfUQbSeCvAESb2llx6ACWod6auywn9xeT924e836bu9ytDzHDHxBnCdZMtNUfH0
 ar1L9Jw/+q3pKuEYbJ/4jB2czdpPAdX5kvTpwfbTMiDRxXxeeGfrz5nW+OFxGt0rcUl8RjT7VSy
 Wj03An8uBp46NYLPqeTStrg7guwybJ4ottj0tUc1DKx31xvS/K+i1WQxSgCqL6xbpRPNzDQJtiV
 plL5BoP7FZp4hiB9GQmjlpdR7uU3LQXl3a7BJQ61DspYvpeaFlnK2rhCr3R0dMiqZC8eX8uAF9x
 aM/8fJp/3gW/Hwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This reverts commit 7adb96687ce8819de5c7bb172c4eeb6e45736e06.

commit 7adb96687ce8 ("x86/bugs: Make spectre user default depend on
MITIGATION_SPECTRE_V2") depends on commit 72c70f480a70 ("x86/bugs: Add
a separate config for Spectre V2"), which introduced
MITIGATION_SPECTRE_V2.

commit 72c70f480a70 ("x86/bugs: Add a separate config for Spectre V2")
never landed in stable tree, thus, stable tree doesn't have
MITIGATION_SPECTRE_V2, that said, commit 7adb96687ce8 ("x86/bugs: Make
spectre user default depend on MITIGATION_SPECTRE_V2") has no value if
the dependecy was not applied.

Revert commit 7adb96687ce8 ("x86/bugs: Make spectre user default
depend on MITIGATION_SPECTRE_V2")  in stable kernel which landed in in
5.4.294, 5.10.238, 5.15.185, 6.1.141 and 6.6.93 stable versions.

Cc: David.Kaplan@amd.com
Cc: peterz@infradead.org
Cc: pawan.kumar.gupta@linux.intel.com
Cc: mingo@kernel.org
Cc: brad.spengler@opensrcsec.com
Cc: stable@vger.kernel.org # 6.6 6.1 5.15 5.10 5.4
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
PS: This patch is only for stable (6.6 and older).
---
 Documentation/admin-guide/kernel-parameters.txt |  2 --
 arch/x86/kernel/cpu/bugs.c                      | 10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 315a817e33804..f95734ceb82b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5978,8 +5978,6 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
-			Selecting specific mitigation does not force enable
-			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e9c4bcb38f458..07b45bbf6348d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1442,13 +1442,9 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
-	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
-	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
-		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
-
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1461,7 +1457,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return mode;
+		return SPECTRE_V2_USER_CMD_AUTO;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1471,8 +1467,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return mode;
+	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
+	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)

---
base-commit: 6282921b6825fef6a1243e1c80063421d41e2576
change-id: 20250620-stable_revert_66-092ba4e66bec
prerequisite-change-id: 20250620-stable_revert-1809dd16f554:v1

Best regards,
--  
Breno Leitao <leitao@debian.org>


