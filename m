Return-Path: <stable+bounces-155352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E8AE3EA3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7649C3B99AA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91A24169A;
	Mon, 23 Jun 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kD5DKkcB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E10188CC9
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679664; cv=none; b=hNcgxIVeeSeRJn0grxv8SmhMMJIreRrNnZKlc15ImUuBb3AeLS7kws9A9+tdk8Ny8dG9dwkwFv7KjfcN4Bll/F0K06vOQq1Jmp53QSrXsmVQ19TzUXRnLvm3Te6u/e9GQ3plBmZ96aZFh2NCdx4I9itPrzk3eNV6k0Hy4PTJMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679664; c=relaxed/simple;
	bh=RmSyqeGl9qSPME1Y5nvzfT1OPPct1yEXNEFA1XoGIlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqtKRaDVFdjl7JEDICUMIlyr3r3RCdcrtynw1hFcESm2OwlKopK2bk0OJJtVBFcuzaz1d+e8YibxHS9eIVBceX2SyshU24zC6GliS/X9BDemQ2r17RP+Rf+Hhzf2pAorTeqki4yWKilQc6c1fC72eehk7OXyKrP2LLcI8ptvGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kD5DKkcB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2353a2bc210so34038975ad.2
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750679662; x=1751284462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6dArwzJkwdgEmK+rgjtAceAs30YJC8jeRKNr1vqGBw=;
        b=kD5DKkcBynfGds3HPSt2By2LwIep2ahwB7/vfIFhQxD/sHUwv3prwp6yLACiqIHaHP
         Y1AnqzycFI3zuJIjT1Rngtu6FgwAYc4DnwWLbmJNti3Znjnt0c9Zij0ku6u2Siv1npMZ
         DJT/eq9je4rob04Oi69bRO9kQ7HzEZsid527KZVABW4gLDfsDBYCBKIoUkNfpq4i5Jw5
         6Ng0bJ2xjCVCceXX/GhurQ8K54NP/cJemRT/9vBRp0NTsbtKZLp029AvN19bWXbDkjC+
         p9w41hAtrr7Z6p0PfscoQOoAEopAYupKDh9URLNkpstXNHBUQ7Sz3rYZ+h/HWV6tBQqa
         6Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679662; x=1751284462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6dArwzJkwdgEmK+rgjtAceAs30YJC8jeRKNr1vqGBw=;
        b=fMLnnMMpB2j5/S8tZ8xRx0tQo8Exuk3uH4O25m3AzW2JPJfwe54hwkowAcqVaK/MxD
         zKNzlXv+fJTPoBzUhZ6XE5qyyJ7RslWyaJqvCeqZpMkpr8BC+JZcVlun7Wh8R8QuC1ss
         qULDA9ds9wtf70gg4kJdFyM2910iQ1l8W2oa40FCQj7H4YVe03fjrOjk9coB0g+4/Zo1
         Y+M+QftPtCH74yN8n1+2L3HEyDYoG3g6/xCfLbLsbLFHvU0wRuSYSdTORekGSgxNB8Fe
         RAv/DdkqsY3JYPnGM2SvU9yxlGE4rikNbJa+VInMuCbXE5/soaLHD5Kc2CA3gR0IzvWn
         UhaA==
X-Gm-Message-State: AOJu0YyHMMYuI9z0cNb+QJEJnGJn3k/pH6I8LSbl2F/qPduGGWqhqVQq
	Ru96IvaQl4VLTSDDWiVinD38ZGCa+Kg4vSbWeFwK8DXOSNGTbReHQ5+D4Z9Cksk6XA==
X-Gm-Gg: ASbGncttCZpo3m8LXuIlduLeg0YNjSMwu2qvhGEJAeGDxEd5e1WpxtTIPGqJiXwnOrO
	SDxTSdIrToAIQeN5RFM9OpPMeIKkhd5R7PFFaPOfItm7aGesbaCL+0TGyExyXOs8whNPGO+gHb3
	n4btISsffKqkRBcfLq+CQF5Sojx2Tik8qbG2UIkp1YemeNO7NNDctX0vHJk0DFvpuMp2nYKsZu3
	j9Mt92aKTkpabWnkLCPQxmbFw6GK2xVs2xuIGWbo/Z6Bt4LafvHJX0kjllDhr2LDQkthcfsKl2c
	lIAMcrHPAAlEaemcQEZiDtbl9b43UEY6Hx00oOnmCy7z9EJ9AO9o/LZ5zmPChFM8XunFrvLcNa+
	SGPm3Shy/U6AaJOiFWfEJof+MY4tsUvQy
X-Google-Smtp-Source: AGHT+IELHD6QKBBD2pUJXWWKqxnw0mZNgq9j9Cp8jroIrvitW0vCWln/xzNdrYd8gbX8TvEWy3oghw==
X-Received: by 2002:a17:903:3bc4:b0:224:10a2:cae7 with SMTP id d9443c01a7336-237d9981dc9mr201720605ad.40.1750679662042;
        Mon, 23 Jun 2025 04:54:22 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427b7sm6597716a12.40.2025.06.23.04.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:54:21 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 1/4] Revert "selftests/bpf: make test_align selftest more robust"
Date: Mon, 23 Jun 2025 19:54:00 +0800
Message-Id: <20250623115403.299-2-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623115403.299-1-ziqianlu@bytedance.com>
References: <20250623115403.299-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4af2d9ddb7e78f97c23f709827e5075c6d866e34.

The backport of bpf precision tracking related changes has caused bpf
verifier to panic while loading some certain bpf prog so revert them.

Link: https://lkml.kernel.org/r/20250605070921.GA3795@bytedance/
Reported-by: Wei Wei <weiwei.danny@bytedance.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 36 +++++++------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 7996ec07e0bdb..5861446d07770 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 
 #define MAX_INSNS	512
-#define MAX_MATCHES	24
+#define MAX_MATCHES	16
 
 struct bpf_reg_match {
 	unsigned int line;
@@ -267,7 +267,6 @@ static struct bpf_align_test tests[] = {
 			 */
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
@@ -281,7 +280,6 @@ static struct bpf_align_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 4),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
@@ -313,52 +311,44 @@ static struct bpf_align_test tests[] = {
 			{15, "R4=pkt(id=1,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			{15, "R5=pkt(id=1,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4. To avoid BPF
-			 * verifier's precision backtracking logging
-			 * interfering we also have a no-op R4 = R5
-			 * instruction to validate R5 state. We also check
-			 * that R4 is what it should be in such case.
+			 * resulting in auxiliary alignment of 4.
 			 */
-			{19, "R4_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
-			{19, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{20, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{24, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
-			{24, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{23, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{23, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{27, "R5_w=pkt(id=0,off=14,r=8"},
+			{26, "R5_w=pkt(id=0,off=14,r=8"},
 			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n). See comment for insn #19
-			 * for R4 = R5 trick.
+			 * variable offset of (4n).
 			 */
-			{29, "R4_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
-			{29, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{27, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{30, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{32, "R4_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
-			{32, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{29, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{35, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
-			{35, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{33, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{33, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
 		},
 	},
 	{
-- 
2.39.5


