Return-Path: <stable+bounces-88771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A39B276D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1651C212F7
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC718D65C;
	Mon, 28 Oct 2024 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+AhvyN8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141562AF07;
	Mon, 28 Oct 2024 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098086; cv=none; b=gWOuEGBEkgehUCsSqCw4aJ9nmVWj6/63Of6hNxrFb88B54aGLRNuxkKwlXA+ucOw8wgJRzyJxRBlF9BlxaPIIj7uwOitcazAZ2SFyBc8/Kf3aWabP7ewcp5wbKg2PWv0cky2l6FeRagRwjIz1yN9Fo9n1Tz1AF3uxeK2mn+pwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098086; c=relaxed/simple;
	bh=c8m2xdBE71OMWCE/gzaK6znroAlsafQa2xwacAjbvB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbSDyzMAJ0JTHalHNA5eUKykeqkdQrARxGJtjOkf5VSsYAirpA9wqKMuu5tIC49omCbR6O2Vcd7o6U98ctghlf7a8e5xwq0C22SXAbFOduuYC3++WAN4//FzJoJTNSYVbeSQF3KsLRiT8D1dH5jm0Pi6+rpLymgjaPEgYgW+Mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+AhvyN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56B4C4CEC3;
	Mon, 28 Oct 2024 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098085;
	bh=c8m2xdBE71OMWCE/gzaK6znroAlsafQa2xwacAjbvB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+AhvyN86r0a0azuheWiKBp/1exGR4dBv3Rt8h9c3ZptG2eibnCQMMXAj71+ZxEVD
	 aGJIFMv6MwkPdRuh5BDlNDacK17ZwJXeEH6dBYax7/7RQ3EfoSAsthHcwxepvO4H7i
	 NHZZtcfDRhlNIhzmcDcVOLSOtNrTpnRPDhxZ3lzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Zac Ecob <zacecob@protonmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 071/261] bpf: Fix truncation bug in coerce_reg_to_size_sx()
Date: Mon, 28 Oct 2024 07:23:33 +0100
Message-ID: <20241028062313.810467407@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>

[ Upstream commit ae67b9fb8c4e981e929a665dcaa070f4b05ebdb4 ]

coerce_reg_to_size_sx() updates the register state after a sign-extension
operation. However, there's a bug in the assignment order of the unsigned
min/max values, leading to incorrect truncation:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
  1: (57) r0 &= 1                       ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  2: (07) r0 += 254                     ; R0_w=scalar(smin=umin=smin32=umin32=254,smax=umax=smax32=umax32=255,var_off=(0xfe; 0x1))
  3: (bf) r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-2,smax=smax32=-1,umin=umin32=0xfffffffe,umax=0xffffffff,var_off=(0xfffffffffffffffe; 0x1))

In the current implementation, the unsigned 32-bit min/max values
(u32_min_value and u32_max_value) are assigned directly from the 64-bit
signed min/max values (s64_min and s64_max):

  reg->umin_value = reg->u32_min_value = s64_min;
  reg->umax_value = reg->u32_max_value = s64_max;

Due to the chain assigmnent, this is equivalent to:

  reg->u32_min_value = s64_min;  // Unintended truncation
  reg->umin_value = reg->u32_min_value;
  reg->u32_max_value = s64_max;  // Unintended truncation
  reg->umax_value = reg->u32_max_value;

Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Reported-by: Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20241014121155.92887-2-dimitar.kanaliev@siteground.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a8d49b2b58e1e..42d6bc5392757 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6255,10 +6255,10 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 
 	/* both of s64_max/s64_min positive or negative */
 	if ((s64_max >= 0) == (s64_min >= 0)) {
-		reg->smin_value = reg->s32_min_value = s64_min;
-		reg->smax_value = reg->s32_max_value = s64_max;
-		reg->umin_value = reg->u32_min_value = s64_min;
-		reg->umax_value = reg->u32_max_value = s64_max;
+		reg->s32_min_value = reg->smin_value = s64_min;
+		reg->s32_max_value = reg->smax_value = s64_max;
+		reg->u32_min_value = reg->umin_value = s64_min;
+		reg->u32_max_value = reg->umax_value = s64_max;
 		reg->var_off = tnum_range(s64_min, s64_max);
 		return;
 	}
-- 
2.43.0




