Return-Path: <stable+bounces-156842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64FAE515D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98993441C29
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDA1DDC04;
	Mon, 23 Jun 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJaR7ki+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B947223DE5;
	Mon, 23 Jun 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714399; cv=none; b=OKHxKyFPlWBvaiZgrEKUdyx97LIuO6wrqDy9MQZhu0Q56k/Hts6t+WY3LLku0JxoqNTmOmgYkYok8dzOWvz675F+jl0DYZdVmoBuaa9uT2AK3YuZjOD2DpDF0gL1p5mtNQC95TjyKE7F72M5QzoBG2sQma50IcdKhINuKCsrrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714399; c=relaxed/simple;
	bh=ukJdL4S3hZ1QhniTjFZALP930kdsiAuyeM/FQNvy9L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpDRc6ihxgsSxz2GUqDQs5yUURXewGH/wUYJK8LAoUWm64V/u6AFCu35jIlY0VIrgt6MEUYryIy6sQXqeCDoqRUWslaBbMuo9cEKluD50NTB1AdjcMEC/WWazXJP9NBWHAmWuiUlRXpJH6jV9GVqKX7qUScfBL7TH1CX0UOQYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJaR7ki+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA8C4CEEA;
	Mon, 23 Jun 2025 21:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714399;
	bh=ukJdL4S3hZ1QhniTjFZALP930kdsiAuyeM/FQNvy9L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJaR7ki+yg02MOQV34umj5KCKO2JmGFIN7C9cFaaZIR6Qf2myq8i9tnaRO5vFm7c7
	 yujt9FIh7HyezaPjkoiXd7NpCZZ/tzsdtelXMdEkTry3B6lYqacvlo9I4VfhWiB98x
	 pPtdLXrXxjUUjGSIRg0H1x0mVp34aOLbPCqDyfs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 388/592] bpf: Use proper type to calculate bpf_raw_tp_null_args.mask index
Date: Mon, 23 Jun 2025 15:05:46 +0200
Message-ID: <20250623130709.671459333@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[ Upstream commit 53ebef53a657d7957d35dc2b953db64f1bb28065 ]

The calculation of the index used to access the mask field in 'struct
bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
the tracepoint being attached has more than 8 arguments.

While none of the tracepoints mentioned in raw_tp_null_args[] currently
have more than 8 arguments, there do exist tracepoints that had more
than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
type for calculation and avoid Smatch static checker warning.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20250418074946.35569-1-shung-hsi.yu@suse.com

Closes: https://lore.kernel.org/r/843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfab..656ee11aff676 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6829,10 +6829,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is this a func with potential NULL args? */
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
-			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
 				info->reg_type |= PTR_MAYBE_NULL;
 			/* Is the current arg IS_ERR? */
-			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
 			break;
 		}
-- 
2.39.5




