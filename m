Return-Path: <stable+bounces-139111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3CAA4517
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5679A0237
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B52144DE;
	Wed, 30 Apr 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W/fzGUM9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB497FBA2
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001221; cv=none; b=sd+aQAGQsu7skrLi91Kb1949Eux6nzt/8NRThvAUCZCyg7lYP8U+9URoVgUTkw3XelVtSU/3FSlAxuvkHD5rVRQZ/Q1aM/dhLKelTX230UC102lzY0FkHuOESiXc7k15HbkgXAFi4SWD9a87xYoVVqvzrurX8nOlUafSqUxK2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001221; c=relaxed/simple;
	bh=4yXdHXSyOoPZeOHOcGnQ9/rK4DlwnktUL47tvWW1aIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nikDLTqpLiGHUa4rTDqDhGAhwV5Ay0eRTcLsl9ld5AIVePtPYtFWhFKFdNJnrVLvb8Qu5WJ3unh5Ap0yEyM5RS9scS/J4Drix6Y9BBfMIc9Mm9PNjtWA8Xsg0Yj4bbjPpuQcc6rDtP7Bk83ZDgF9rPsD/nDSqkaAOEM5t24gSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W/fzGUM9; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39ac9aea656so7971447f8f.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001217; x=1746606017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALcJdiww4WhC8fWfEOZv2bWsgQyahkHcoe/b7y8Tpz4=;
        b=W/fzGUM9qjjD46OvBvScdUJPTtgfVzJL6mUaLOiJwc0MpybavIp2Gz9y10hFr7MNDi
         qhxuQDBnhnG1oUHMNHJL5j0p+08pwX/sveShsbt6s7d5DMkxYyJgrCTY3G/oQ315rGIX
         KeiRGre+/kaLNeVMhLre2fY0lB8/7ldOf18wD8y1kucMZqt9RTunRX6/6G8Qk6x67o/4
         b1sdtxg+ORs7gFeb3aulCMkZGuaH3I65bCn/q2SZLvYg6k/BCzYkZXxUBl3GUMc6CJPu
         MwpY0fUsIl8rp1PJ/NWDkyW1inZTR5YQXE19xA6gA3H+HGzn7t4OfHC/gK2JwfxlqxDX
         TIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001217; x=1746606017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALcJdiww4WhC8fWfEOZv2bWsgQyahkHcoe/b7y8Tpz4=;
        b=YtijHqcHPslTCF3ddQ1/OJp6qzAVpHMEyzCCd4ypXCJzaaC12PnXmEfCtfRhy+u5TN
         cyHwT7qrGqfg4OEB3HToQIqKAwihVjq5lJf23UtEkksIs8rhn3tAB12P3Q7xVanv4bjG
         Up0Meez13yzQEo+k1YJsEvL1WjSpcvuSicL+WrZyFdKfR1gQarWVjP64g+GUz4Lbrkda
         iukXV4hE1Ka27uRrX4krEzoPI7JQicuNe7drXFlKrl5rzy9Qjfs+1UiwdYF84JmQd9v/
         0Gif9rUN2JJ2oUjjHh9AYaYcFUuFP5G/GtFuoxLRm9vPTBKZFqOLVsLibT4eP8qjm9o8
         3ywQ==
X-Gm-Message-State: AOJu0YweHwwbMNpUsxAEyBAeD2okFJORCUIg/h2R3YZR47cR116WCFVo
	TmN+zL0M1xtQgKuyiG2z6Ca8lEYTQnjzI1TtjCL10WAqh+JFUkeiV3Dy1IhW1pvxB36HLXSECGh
	Vvo7boQ==
X-Gm-Gg: ASbGnct9jc0dkgByVn3BJmsu8CCi4/RETiMevBuDVkCFuFwxdxK4qxyaHBI9MReRjTY
	rY0AR7JyRhsp/uAga/IL6mHAZTT1iDcbAB+gsKlO5PZgUN1Zm8P7e30gwZPshWUjoKxSoGidjrp
	MNbNDqeqDZdJPs8ejlhmHVrwm/mJMMnlElwR6nAfUkXkF09XWjjbU/rAj/nh6xNZKsZcaVCmy1x
	yD4znqrIpM0SBg0XvcJDTA5e7L5TaN36oJvuSrPsleQB4XEYGTdLXoKa1cpieW2sk+F4rqdk3zm
	1vMem92Tl+WhkeLXcYbb+1c127p7cujFaEF15bUG7aA=
X-Google-Smtp-Source: AGHT+IEGtASRCzt4gA54lKCr8aLWNlPPXRzrkyDQW0Oh2K5CGentsM2FQZ3s6tq1qJGgy1cmGtIRDg==
X-Received: by 2002:a5d:5f4e:0:b0:39f:91:43fd with SMTP id ffacd0b85a97d-3a08f764d88mr1662925f8f.22.1746001217555;
        Wed, 30 Apr 2025 01:20:17 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74039a62dbfsm1050045b3a.150.2025.04.30.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:17 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 04/10] selftests/bpf: test for changing packet data from global functions
Date: Wed, 30 Apr 2025 16:19:46 +0800
Message-ID: <20250430081955.49927-5-shung-hsi.yu@suse.com>
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

commit 3f23ee5590d9605dbde9a5e1d4b97637a4803329 upstream.

Check if verifier is aware of packet pointers invalidation done in
global functions. Based on a test shared by Nick Zavaritsky in [0].

[0] https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/

Suggested-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-5-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..e85f0f1deac7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -977,4 +977,32 @@ l1_%=:	r0 = *(u8*)(r7 + 0);				\
 	: __clobber_all);
 }
 
+__noinline
+long skb_pull_data2(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+__noinline
+long skb_pull_data1(struct __sk_buff *sk, __u32 len)
+{
+	return skb_pull_data2(sk, len);
+}
+
+/* global function calls bpf_skb_pull_data(), which invalidates packet
+ * pointers established before global function call.
+ */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	skb_pull_data1(sk, 0);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


