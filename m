Return-Path: <stable+bounces-46697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076B38D0ADF
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CF71C214EB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E73116131C;
	Mon, 27 May 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSQeFJc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A5D518;
	Mon, 27 May 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836621; cv=none; b=BUSRh1G7cWwE9BapjSeYddK+xDgnYxpGcFThCQNKLeTLpVIY+hlQrpTrryY4AldSPmJ7dKvLBA8vY68g9JNWcNBmOKUPlDquVWUBDzA0+RIjc+Cqwx+OYDAtFTad+R5hFXRwlERyFgL8pannEQfphPCcK6ZkInibEnkmKJjiaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836621; c=relaxed/simple;
	bh=zBCypz7kwDRQoNHb4mrvjGBnDN7Ir4OGKH2xHBm7BuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpDYp9+CdCxhBKChg6EmsLGw8mBvC03Ca9qkyhOysIs40PahVUSHot8gy5Hz11J8eEZhs7uGyzYuakhbGyJTEPjscPMxs9VE2ZRPTCVrBxTdu2Eew0nRyZ7SSV3+Lji9nR/pQ+mKT+b8AuFcbLabHb0fAF4kB8osIb8so3kR1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bSQeFJc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB75C2BBFC;
	Mon, 27 May 2024 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836620;
	bh=zBCypz7kwDRQoNHb4mrvjGBnDN7Ir4OGKH2xHBm7BuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSQeFJc3/8O+DQ6HziAPi4gKKu/lMm2PTAPRkTVJL5Iu5jAo4XZ+5ixpogcc9pgaQ
	 +sKOM/5/PJg36v3YvJvn86x4UhJt+exZE0cYjUZSWgo6b+i8Yi34qTUarmNLEeiUtv
	 gZymUoiCUTsZ8unSmFS3lv/6Rtn9UJtt0o9QoDoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 124/427] bpf: prevent r10 register from being marked as precise
Date: Mon, 27 May 2024 20:52:51 +0200
Message-ID: <20240527185613.493360385@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 1f2a74b41ea8b902687eb97c4e7e3f558801865b ]

r10 is a special register that is not under BPF program's control and is
always effectively precise. The rest of precision logic assumes that
only r0-r9 SCALAR registers are marked as precise, so prevent r10 from
being marked precise.

This can happen due to signed cast instruction allowing to do something
like `r0 = (s8)r10;`, which later, if r0 needs to be precise, would lead
to an attempt to mark r10 as precise.

Prevent this with an extra check during instruction backtracking.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Reported-by: syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240404214536.3551295-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb7ad1f795e18..f3faee45753e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3615,7 +3615,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * sreg needs precision before this insn
 				 */
 				bt_clear_reg(bt, dreg);
-				bt_set_reg(bt, sreg);
+				if (sreg != BPF_REG_FP)
+					bt_set_reg(bt, sreg);
 			} else {
 				/* dreg = K
 				 * dreg needs precision after this insn.
@@ -3631,7 +3632,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * both dreg and sreg need precision
 				 * before this insn
 				 */
-				bt_set_reg(bt, sreg);
+				if (sreg != BPF_REG_FP)
+					bt_set_reg(bt, sreg);
 			} /* else dreg += K
 			   * dreg still needs precision before this insn
 			   */
-- 
2.43.0




