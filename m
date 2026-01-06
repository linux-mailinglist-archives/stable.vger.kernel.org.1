Return-Path: <stable+bounces-205576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE16CFA699
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CEC531D4EF1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC22C15B5;
	Tue,  6 Jan 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kloxzKeA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7FF224B04;
	Tue,  6 Jan 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721152; cv=none; b=TNcRv1I1ZkQvq7rZsea5TY3U2A85pF4VBCF+OW0JlnTCs/eV1CKcoMV/Pmk7RYMdHJ5yVS3ULYsSVjdPz3MxI3IJxWgDGfnbjSqha9GfHHoOsgFjLGkxNtjvYZFV0qMpYWDImZzN+Uss8UKozHJ0orQUoeukNRZ4SVSczX0kbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721152; c=relaxed/simple;
	bh=MGRzVbACR7xmkHKrJUxmjr2W7maboVW2ChvM6POK6pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH/ieQ9tXRd5WKyjDeFWA4yCTRqnKAeUfvFAf+7vTDoKRwLx2EG4Zjrdm688We5jSWIazHpSienbcGK5Xihz+Hfsh5YH6KrdhTIIVkKFEBawMCuZG5TsXgsNpwG9tcHWPSfU66seQb6bxqVjeCmk+v9kCI/TYerZeXf7GtmDqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kloxzKeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D564C116C6;
	Tue,  6 Jan 2026 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721152;
	bh=MGRzVbACR7xmkHKrJUxmjr2W7maboVW2ChvM6POK6pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kloxzKeAtfLTA8LnVlkMREs+rbyHi+6nP+pNXrpwGnjVkjaDOD0A1MP3gpOH7WaJy
	 YviWEgCbcjJR2TmbViMisET/Lg30cO8A2WGvMnHP+VfcCgUrtUxumLbFnZY4IeycOZ
	 jDASp6GIuc9Mdxvx31Tbqd0sNpbTD3t2U5apPWcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 450/567] LoongArch: BPF: Zero-extend bpf_tail_call() index
Date: Tue,  6 Jan 2026 18:03:52 +0100
Message-ID: <20260106170507.994477672@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Hengqi Chen <hengqi.chen@gmail.com>

commit eb71f5c433e1c6dff089b315881dec40a88a7baf upstream.

The bpf_tail_call() index should be treated as a u32 value. Let's
zero-extend it to avoid calling wrong BPF progs. See similar fixes
for x86 [1]) and arm64 ([2]) for more details.

  [1]: https://github.com/torvalds/linux/commit/90caccdd8cc0215705f18b92771b449b01e2474a
  [2]: https://github.com/torvalds/linux/commit/16338a9b3ac30740d49f5dfed81bac0ffa53b9c7

Cc: stable@vger.kernel.org
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/net/bpf_jit.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -231,6 +231,8 @@ static int emit_bpf_tail_call(struct jit
 	 *	 goto out;
 	 */
 	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];
+	emit_zext_32(ctx, a2, true);
+
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */



