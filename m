Return-Path: <stable+bounces-84431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4199D02A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA51C23536
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19A1ABEC1;
	Mon, 14 Oct 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rxi+dHqp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5B1A0BE7;
	Mon, 14 Oct 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917995; cv=none; b=XnRP9FX55ysH6RrAxk4/S1sNPWgln02jVncmhClYm2b2NMqxdldXxeT0fdcvAc8Gos4yOa+6dY1JwYt7GQKggquDUHvjywHsrnV6RplLxxj/CU5rgTlkytshB2Q9ZCfq0PVT6IR94q/mpjOCof3qFc+ok/+XRmz041Lutnj99ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917995; c=relaxed/simple;
	bh=keTwVkqG4QZaOXh0v3xrOWsG6+VgD3oegeQgQlUyS2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI8TKdwO1OEWNbbk9d1dy1OaYQSJrfRiq/Rg5Q6tAIFurnUNG2IBy+KHmqfXYZDgI/2k3waeFvHjOTFdeS7TAK8bCdwgO6SHiZtxA/O2LqayJ8DgaF4wP6N8lG+1ylK8cFvvWByMiHbk3oQUT+kep97cZl4LTwdkXkED5d0j+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rxi+dHqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CE1C4CEC3;
	Mon, 14 Oct 2024 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917994;
	bh=keTwVkqG4QZaOXh0v3xrOWsG6+VgD3oegeQgQlUyS2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rxi+dHqpJbugJwAdYgvQPqI1nwpkWo/UygCCfeTRL6CAXNGRYDq7/lBDNBeIrVdr3
	 fDwvTr1mXS/m9KAWjwNhQU3lY8hy0gHCkQC2gZJPIPFoUZjPysmZaUmOYtXbyPDfC3
	 kEw4/moev+YTOpFGZk8wF5iyqdEHhCt8SzChREiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu RuiTong <cnitlrt@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 161/798] bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
Date: Mon, 14 Oct 2024 16:11:55 +0200
Message-ID: <20241014141224.242545592@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 3d2786d65aaa954ebd3fcc033ada433e10da21c4 ]

In case of malformed relocation record of kind BPF_CORE_TYPE_ID_LOCAL
referencing a non-existing BTF type, function bpf_core_calc_relo_insn
would cause a null pointer deference.

Fix this by adding a proper check upper in call stack, as malformed
relocation records could be passed from user space.

Simplest reproducer is a program:

    r0 = 0
    exit

With a single relocation record:

    .insn_off = 0,          /* patch first instruction */
    .type_id = 100500,      /* this type id does not exist */
    .access_str_off = 6,    /* offset of string "0" */
    .kind = BPF_CORE_TYPE_ID_LOCAL,

See the link for original reproducer or next commit for a test case.

Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_by_id().")
Reported-by: Liu RuiTong <cnitlrt@gmail.com>
Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com/
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240822080124.2995724-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95a050446f271..8c684a0e1c4bc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7973,6 +7973,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	struct bpf_core_cand_list cands = {};
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
+	const struct btf_type *type;
 	int err;
 
 	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
@@ -7982,6 +7983,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (!specs)
 		return -ENOMEM;
 
+	type = btf_type_by_id(ctx->btf, relo->type_id);
+	if (!type) {
+		bpf_log(ctx->log, "relo #%u: bad type id %u\n",
+			relo_idx, relo->type_id);
+		return -EINVAL;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
-- 
2.43.0




