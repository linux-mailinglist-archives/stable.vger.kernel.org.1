Return-Path: <stable+bounces-139116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1CAA451D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2449917C5C4
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040471E9B03;
	Wed, 30 Apr 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YF/tFCNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231E20E33D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001240; cv=none; b=kBoBJ8jZz+vJne8TBEXl+0qB3bbD2mcQpg3cJdAOms5ulELbmz7/Nz/5w4wgRVrbh5zCcBfmBTrQGUygZj4ns2qBi6nZWsb5Q1cHqIOsna5sYutuQJxkAgABJGdNTZoS/GYj1ekU8ZY33M6qrMLZrUD8/xoJgJEE9CBWU77EJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001240; c=relaxed/simple;
	bh=h3WWGha8yofJfFoMKVnvFLFStdR3xt8iMS2H4UXRwiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J344b6wX2kKixJYMEuVyuCQ/fMLj5StftwsoRafvOYwZWkOt8UpetKSpSlPq+wda8VgtBImUn2ealHK9LhorN77wxp88JVKvDLgqsk1j2zL2aP0pANg1Y5voa9RuQiHpuUsmQ5/MK6NLoMfNKncSVSgV1ZpUEzqtyeGhi9zqUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YF/tFCNF; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso5394077f8f.2
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001237; x=1746606037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FibNTRybCaFE3D5/INo5R5t1cEgvthdkJBvNc2Cnzn4=;
        b=YF/tFCNFvO7nZW3EpQu9SZhaRD+PyfYu9/AIvdp/BTcP5HA+JoDUqbOh42XkT96TZ8
         vux4fvalvQo22TfRtdCzQUx+TBZum7yCCanH+tlqCs/7t7D27B/614GndGHsw2vekZxk
         Ik48tbskdqbZPc/BOTKUo4mprIlqAFwg2pK3rJCF3YinyG13Gpv0irbP8OliOBmGVQIn
         l3uksW+VsdQpSjqZMUnxekiYg0hDRXhKF+G1k3qapO5wMZR2zKuJMOl40cUblc+fIP6J
         +IHeVOzU+reatdLmC0lPstlNpmRadQ+rKhMXhgjIaHqpumQLg6/DU/LGI9ermKaK0URJ
         EuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001237; x=1746606037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FibNTRybCaFE3D5/INo5R5t1cEgvthdkJBvNc2Cnzn4=;
        b=a2xIpQywKMsRF24tTpbAV8EKeFqp060Rm05B8cVd0iiKMcRAGA1/aqsecdyMN740CC
         XeqcwPctnm7X4CG1jlFCoEMFa3rLHaaabXjR0BOvH7X8md+FaxaNEBNvd756C1mUboCx
         ivbWyP+NehYCvromOQcZOyszBUOxcUmY3MogfIe6eky5DkiZbZowE7lttitSGXtaigP+
         isUHSga0V/zBrzZAkXkq0N3uK3U5GI8u4bkjKddk6A/p1uEuTHm26gTZmV+XEyYpbWv2
         yxynm/SNsK71O9nfeg+7+K+t8+vGeaihkFryVOrVhxgm9I0zUxdWrlw0M4qFE4WzDWMS
         p8lQ==
X-Gm-Message-State: AOJu0YxCCToe2AJGV39ShsaGDttQLSPbyxNsi13tfOx/Bscx2hZG2ns0
	O4dmltP61z0s35HkwVRK8/Uv08AbTC6sdVvK1gLqyA65wsTSpwvm/c8LUGCjlmyaoILmx5IpFLg
	r+mZbFQ==
X-Gm-Gg: ASbGncuBiHtxg/JeNNX03tr2ZBBLDxOSLnyDGKaVmMhvsqSxh5GnXKVeGbH/KIWCJei
	TilkNSChNALviXesStWNptLItt7TZOmCF5bgPcC4o/+ILLN/baKRtQQ+RLX1I/+YNdMUqh+6iZq
	qMo15576MAuZ/itUs6vpVE7jc83tRxFLu5iP5UdyjlVOhSIPi/RqZFtdPyzOMgc6YT1YZ5/yIVi
	mnWES0XuyglG3YgE1gy8H9xicMmDZBqtbUimq5ssk110wAXS6H90A4519OnUSY1uJpBUH2q/G3q
	oOuQIuFEUXWvOLduWoJGWovfIZGRfXAysyjMjJoo37U=
X-Google-Smtp-Source: AGHT+IFxCwmddAKKJP6vQiifgSz/AR6B08uavdfP824ozEIhQpiBTtfxXj473EpS4DSFlv2RLz17+w==
X-Received: by 2002:a05:6000:188f:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3a08f7d4578mr1751351f8f.54.1746001236914;
        Wed, 30 Apr 2025 01:20:36 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-740398fa3e4sm1086008b3a.19.2025.04.30.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:36 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH stable 6.6 09/10] bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
Date: Wed, 30 Apr 2025 16:19:51 +0800
Message-ID: <20250430081955.49927-10-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit ac6542ad92759cda383ad62b4e4cbfc28136abc1 upstream.

bpf_prog_aux->func field might be NULL if program does not have
subprograms except for main sub-program. The fixed commit does
bpf_prog_aux->func access unconditionally, which might lead to null
pointer dereference.

The bug could be triggered by replacing the following BPF program:

    SEC("tc")
    int main_changes(struct __sk_buff *sk)
    {
        bpf_skb_pull_data(sk, 0);
        return 0;
    }

With the following BPF program:

    SEC("freplace")
    long changes_pkt_data(struct __sk_buff *sk)
    {
        return bpf_skb_pull_data(sk, 0);
    }

bpf_prog_aux instance itself represents the main sub-program,
use this property to fix the bug.

Fixes: 81f6d0530ba0 ("bpf: check changes_pkt_data property for extension programs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202412111822.qGw6tOyB-lkp@intel.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241212070711.427443-1-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9cf75b765f0..bf8696b96491 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19908,6 +19908,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	}
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
+		bool tgt_changes_pkt_data;
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
@@ -19936,8 +19937,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
-			if (prog->aux->changes_pkt_data &&
-			    !aux->func[subprog]->aux->changes_pkt_data) {
+			tgt_changes_pkt_data = aux->func
+					       ? aux->func[subprog]->aux->changes_pkt_data
+					       : aux->changes_pkt_data;
+			if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
 				bpf_log(log,
 					"Extension program changes packet data, while original does not\n");
 				return -EINVAL;
-- 
2.49.0


