Return-Path: <stable+bounces-55122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49886915B29
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 02:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3891C21647
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6D8DDC3;
	Tue, 25 Jun 2024 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cBV4AMXQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613C1BDCF
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276665; cv=none; b=i/HWHsPl1QWhoQQPg8kNCrhnpTCB8Z3Mj+RIkivWCMpiygATs3nkzDHfZp/3paDmLccRdHbIFuaVJbm4OLmMZ9pzSrCrLR/Ghd0rnqRuTSecE9aE0O1nDv3KReiZZigKp9KoPRgCpxurGKREAnFBktcIt4jtNgsLlk5xCr7GSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276665; c=relaxed/simple;
	bh=1ymjgr7C6ukV7q6a3KI7rEkdG0pKL1Yf/T1h2mYGIwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7NA5LVj6TOPNSIeh6mLtP00Sc6pYYiMeqWCzXsytJuvpkfLlg3DTGYSzZsP7fLw+odJL3os0i47V0Qc3B44fg1UfaFhaKwsb3BfXLcDIb5J/elhJoiZQWabUR61LSAwWOpW7RC44qMMIAowN/1JT5fnaI2fL7k/fznqFBdYHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cBV4AMXQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so33430285ad.1
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719276664; x=1719881464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8PvHLug8r0Usox0R6aX+Qr/KVZBRToAr5dZQC5ZPHA=;
        b=cBV4AMXQIgWXBfLtIz6hhJjHcbtq9pTxkTnN/df07/sEvMrnElTqn7iStYoS73qXPh
         vcLX4R6rzihavnoogTbmFOnOOlYKvO02FR0Sft/xJyzDjkS4sQHQFIyVuC6LUYDbyO+d
         SCUWp6LcEY4mGtuELjPa/TTm6EqY49LAjI3PxHYq4SPwjKNOiyHXXzpTGWCXjx9Tu2/L
         2eDjdOzsOfj/6dM3UixLoN4eO3WQaMLeCjmD7nz09i/Yle4vPWBzBCPBFJe7KhL/JLK5
         7ttnsOmFIrxMo0SZkahuc9NplpfcFqe16nIdLWqdo9c990PRup4Je/gq0O8teZGhp3oM
         MCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719276664; x=1719881464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8PvHLug8r0Usox0R6aX+Qr/KVZBRToAr5dZQC5ZPHA=;
        b=idl0PkcMeHQp+WMxPp1UJSuxyz5Dc9X3/YfeiF7nUtrx+JnwYc5sciPITqs6jqjxQ2
         9dB4ZJc1AzWYsEYRipDhTJNwqmC99+++343xBrE2BgMDIt3SyQZkMi8T7/EorE2D1/IG
         VITQIgvO+7kGs2/ES3VhdrwvMQ/beEpXjq7uw+rpbk1lS91Sk7ryF4HVCnU79+GK/hU3
         qcBHhh+Godp7WCSDoUXo1cI1npdmbm0YREdnMQXWRok5S1t+90wYe/m3WapbQeowGpli
         n301wxONDCYlTzc/yYWx96EkoGAGo2L01p5scBcCZ0NFrJ9VofrllvsU57N6omrsLLVP
         f1LA==
X-Forwarded-Encrypted: i=1; AJvYcCVjacyiAYo3m621Y7gyp6g2dWGgNJhn8nSlc25O00fk2k6MmGyvSCvmq1b8pX88mZNHDxQEIgAf7xDnSPMhdCO3VW132R7k
X-Gm-Message-State: AOJu0Ywdljxh1a2XAxABsS8JVl60aTqcCd+DFKRGtu8rmlnvFZDu2rcG
	yatsoWd63IdWrPf32mNAvda8GTdXXF+MzNtIbEgaoWYFR4tqe8Oo8+bi24YpbCM=
X-Google-Smtp-Source: AGHT+IEAP5AqPSLGnRbl2LW9e1HkZo4YnWE4Xye4a5nUkIMhcY2MADnRmTPJFFoHvz1mEZkNhxwJ0g==
X-Received: by 2002:a17:903:c1:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1fa0f8cdcd6mr55557855ad.18.1719276663833;
        Mon, 24 Jun 2024 17:51:03 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb2a7csm68150235ad.256.2024.06.24.17.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:51:03 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/8] RISC-V: Check scalar unaligned access on all CPUs
Date: Mon, 24 Jun 2024 20:49:56 -0400
Message-ID: <20240625005001.37901-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625005001.37901-1-jesse@rivosinc.com>
References: <20240625005001.37901-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, the check_unaligned_access_emulated_all_cpus function
only checked the boot hart. This fixes the function to check all
harts.

Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Cc: stable@vger.kernel.org
---
V1 -> V2:
 - New patch
V2 -> V3:
 - Split patch
---
 arch/riscv/kernel/traps_misaligned.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..8fadbe00dd62 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -526,31 +526,17 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
-static bool check_unaligned_access_emulated(int cpu)
+static void check_unaligned_access_emulated(struct work_struct *unused)
 {
+	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
 	unsigned long tmp_var, tmp_val;
-	bool misaligned_emu_detected;
 
 	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
 
 	__asm__ __volatile__ (
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
-
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
-	/*
-	 * If unaligned_ctl is already set, this means that we detected that all
-	 * CPUS uses emulated misaligned access at boot time. If that changed
-	 * when hotplugging the new cpu, this is something we don't handle.
-	 */
-	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
-		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
-	}
-
-	return misaligned_emu_detected;
 }
 
 bool check_unaligned_access_emulated_all_cpus(void)
@@ -562,8 +548,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
+	schedule_on_each_cpu(check_unaligned_access_emulated);
+
 	for_each_online_cpu(cpu)
-		if (!check_unaligned_access_emulated(cpu))
+		if (per_cpu(misaligned_access_speed, cpu)
+		    != RISCV_HWPROBE_MISALIGNED_EMULATED)
 			return false;
 
 	unaligned_ctl = true;
-- 
2.45.2


