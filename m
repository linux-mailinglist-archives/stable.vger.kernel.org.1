Return-Path: <stable+bounces-60468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3069341DE
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1971C2281D
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7921850B0;
	Wed, 17 Jul 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="E6k9g+uh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51A1849D8
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239668; cv=none; b=D76ifLOqpnPePYlcoAr6yBI5OsnCfIv9hHMZ9nh0dRiWWB78aO6mX8zpQe1BKlqVNBQcpGOKlpzRWqkKer4JMAH/I8UYUohu2Ud7hjd7zWFDIdKXe9MQoYM0ncP38GcjWMMGG4MRax3uQiGbBfl2Wsk0TNcpzPUs1HT82aYV5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239668; c=relaxed/simple;
	bh=xchOwSYXtxsqBDYw69vFok/L+OqHNdpkjtFyuZKp8v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVzFyATSiSPn5SAJtJ1RTDJR+hdEIr84W6r1plxBQukJbsZhH2N8ssQ4L1LI4BX181u8dwDoKaVdDb6L7CoWujm0pffk6UG1ajgi3bIEJD1b1uNzM2kVdkJJOyRMC4UJYmTjb7AhFZJCH8YEgNdWJX2cLxKRh0q5np/YT0ZdckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=E6k9g+uh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso3962036a12.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721239666; x=1721844466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v0PQPo+2UsBqPXbCT4QAwtg43AqtiWUCtgbmmFr6Mk=;
        b=E6k9g+uhvSuK0hwZwn0RtQ9qJbzCS6ypGjOggvwh67sYaAY/LZMykyHXtZARy3AUMx
         hGsV/WLc/HFfWbDhO1k+GgLoaQd4OB/mi4237BHUxfUu6vVrH3EYzdslbcSxrIegXr5y
         qZb2X1imcR7TTtWZ2Y8EvB/BGyOnxPu1DzBko8nICRfcLIlv5r8RgTHD0Dv2PBEYuGNZ
         5aU8X8r0TeHTAMCBTut4Nkkr32IYzxO0U5EVb/QDVhquW8HDPo7cSelWd7vSRtI1eICU
         Ob2ja//b5ARSrH48ZpxxN5xnN/aLNnw5xW7Zvx1eU4INhK27TV9UctE1hwWnkcq76aUt
         0UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239666; x=1721844466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v0PQPo+2UsBqPXbCT4QAwtg43AqtiWUCtgbmmFr6Mk=;
        b=R59g3AQtpczjQwtUQ2xb+k/k9SJZi8MHUQK1fV9ENtgeigmrjvjBDrmuiZupOHvfXr
         OVzJcLNV6iLNk02/BIKu9UnbkjaU+9qa3PtTaZDwTpFOKlph6MohIWTeeJClFMNIhsS2
         kBaJrJjE+Em8dDmX1RYTstjtH7AZY9P+a1TQUaUMTpAhN+SBf1EBq1EW+BOBdcOPyViW
         i3kngfUYzaP2AN2kPW4a/+XIWZjLnJmcZpGny4AFW3//hCc+HksnFsLWdidixxmLNUcO
         Baz/6Y396ye7bX9rfPSKQpwxjX1djdDozS8V4DPXAM+NQfECNh6K0N3Ey34KHTBw9Tum
         gQRg==
X-Forwarded-Encrypted: i=1; AJvYcCXUKpL2CLSFLG7IC1Lnt1xuG6EeQvqXU/HLmuC+k1O6O7nyAVxCzIfE+e/xH+hxo8rdAScn4fqEnsAQYH2VLvEbSMNOMvzO
X-Gm-Message-State: AOJu0YwYYyPuolmdkJ7WW95qEWjg6ScO6Qbw4pcpcMAQvKaLesMSG+j1
	l28v8saicc/1jaC6EbH2Pk1XxP2GUOLQKmknynZCa/FT21H015r0Mo0LiL/nF1Q=
X-Google-Smtp-Source: AGHT+IEy3+PK+qr4IDio0BsLMYxFRVKEQ5xv4rsHRx7ZJLo6TisZYFkxKaOoewodSBviFRWBegZ3ZA==
X-Received: by 2002:a05:6a20:6a2b:b0:1c1:31d0:c7a7 with SMTP id adf61e73a8af0-1c3fdc9a8d6mr3633482637.16.1721239666522;
        Wed, 17 Jul 2024 11:07:46 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c969sm8432332b3a.35.2024.07.17.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:07:46 -0700 (PDT)
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
Subject: [PATCH v5 3/7] RISC-V: Check scalar unaligned access on all CPUs
Date: Wed, 17 Jul 2024 14:07:23 -0400
Message-ID: <20240717180727.4180475-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717180727.4180475-1-jesse@rivosinc.com>
References: <20240717180727.4180475-1-jesse@rivosinc.com>
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
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Cc: stable@vger.kernel.org
---
V1 -> V2:
 - New patch
V2 -> V3:
 - Split patch
V3 -> V4:
 - Re-add check for a system where a heterogeneous
    CPU is hotplugged into a previously homogenous
    system.
V4 -> V5:
 - Change work_struct *unused to work_struct *work __always_unused
---
 arch/riscv/kernel/traps_misaligned.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..9a1e94383d6d 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -526,11 +526,11 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
-static bool check_unaligned_access_emulated(int cpu)
+static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 {
+	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
 	unsigned long tmp_var, tmp_val;
-	bool misaligned_emu_detected;
 
 	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
 
@@ -538,19 +538,16 @@ static bool check_unaligned_access_emulated(int cpu)
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
 
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
 	/*
 	 * If unaligned_ctl is already set, this means that we detected that all
 	 * CPUS uses emulated misaligned access at boot time. If that changed
 	 * when hotplugging the new cpu, this is something we don't handle.
 	 */
-	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
+	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_EMULATED))) {
 		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
 		while (true)
 			cpu_relax();
 	}
-
-	return misaligned_emu_detected;
 }
 
 bool check_unaligned_access_emulated_all_cpus(void)
@@ -562,8 +559,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
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


