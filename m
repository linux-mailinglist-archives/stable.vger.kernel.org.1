Return-Path: <stable+bounces-170233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBBB2A370
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D82316F7A1
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE426F283;
	Mon, 18 Aug 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWIJtZwq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80431E51FE;
	Mon, 18 Aug 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521968; cv=none; b=ruIOMjkn57IKHuNm7VRtmQ6Kz0I0N+yZxoDS64n/rGTAbOshn1ycNg2fyJCur4SNjG0SCuznH+LZVx70dxbTVQjs16jPhBX1Ma2pXR2fihHbZtrYYgxpSW73SzA4kMYtMb6V3WaXpHQ5cborWIuPZnpj078oJYQYtI0FYF7Ptt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521968; c=relaxed/simple;
	bh=jgkYcCgqLPq/KJFooc/Dvxv2kXPuqCo9HyjqGT36W1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D59cjaAvl4ktIxVZFF8PEOJmwAOzdiJHwg2TnTaYrduoaX6p57DFeBULQVTzqs1daIZSI59S07Y3QlGeFaZg+LMrJaP63mbE0SZDcKDJ1Pej6or8C55ZLabF0QnjprBq3MITxNyQISozp1GP++zkPbyu36DysDvMAn8CbRVcTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWIJtZwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127AFC4CEEB;
	Mon, 18 Aug 2025 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521967;
	bh=jgkYcCgqLPq/KJFooc/Dvxv2kXPuqCo9HyjqGT36W1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWIJtZwqlVeEwZtHXYN11/2sTZB3lqVpoSU4fFFmgKzBqXWa7SF1DsQhZiPPgKsSA
	 9uEjGQyeZ1Msq3fQn2PgM8294jdq4+uaUiIwqH2MtFWSkT3omuk1eQRpGaYwj/4ghN
	 Ay7pMZuA/zrb1SGfdGWFhNwft1AfAPK26GOfzSgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 175/444] libbpf: Verify that arena map exists when adding arena relocations
Date: Mon, 18 Aug 2025 14:43:21 +0200
Message-ID: <20250818124455.443794877@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 42be23e8f2dcb100cb9944b2b54b6bf41aff943d ]

Fuzzer reported a memory access error in bpf_program__record_reloc()
that happens when:
- ".addr_space.1" section exists
- there is a relocation referencing this section
- there are no arena maps defined in BTF.

Sanity checks for maps existence are already present in
bpf_program__record_reloc(), hence this commit adds another one.

[1] https://github.com/libbpf/libbpf/actions/runs/16375110681/job/46272998064

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250718222059.281526-1-eddyz87@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 747cef47e685..e33cf3caf8b6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4546,6 +4546,11 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 
 	/* arena data relocation */
 	if (shdr_idx == obj->efile.arena_data_shndx) {
+		if (obj->arena_map_idx < 0) {
+			pr_warn("prog '%s': bad arena data relocation at insn %u, no arena maps defined\n",
+				prog->name, insn_idx);
+			return -LIBBPF_ERRNO__RELOC;
+		}
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
-- 
2.39.5




