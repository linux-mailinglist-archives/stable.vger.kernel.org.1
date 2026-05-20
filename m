Return-Path: <stable+bounces-252745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJv/GkP+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:32:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F215F5967FE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E0B7317E4A2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF13FBEDF;
	Wed, 20 May 2026 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1s08Qcm1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F4332EBD;
	Wed, 20 May 2026 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301479; cv=none; b=gccXMSXTc5GPbW9vKuJFhYoibxET/oaioz5aKlxLDEFgRxmtMd2WcQ0Y0ixDY7NPK0NkMojlhhAftb6KDD9eaGAiVxBreMiV+TRRppvOFfePSzRYkcYjavRu/LCRmjW+0a2tdcC36Z+yWYONXxAb3tQpgG7iLIWgK04wOLw7daM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301479; c=relaxed/simple;
	bh=ldJ1FpPlQ2jgw7OpnkFhr+SEqGfhPBoW1KAm/6+Ghl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBD3ZNvcA9+EiqIfnYfmnwN1AhzpBrXah43+37PzRAc7FFFlD+G6coRYVLQ6KxRFzyrawmlnqTjFgXl2gwhvlEnWYA9mDYf/NXVd5f2GyAgeJGcRSXxJePz1Xzmfzs5yqxwtzCYb7wRharZjqlLroZFF8xTl8gqGZ1OSxvMcllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1s08Qcm1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B021F00893;
	Wed, 20 May 2026 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301478;
	bh=HtHDJ2Ws93g4Lb5oElUAlBH+yozdDYmSZfYA0JdRQLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1s08Qcm1p4qclbrrpEubnqaGMeq4f+qzyozKmqddhEmpPJIOzChNwpRNMAIA6nzwA
	 h6/TPFrsY79GSdmT73pBK85djMUcXZmbbLVXzO3l4A8cI8I4bOa4yzBBvURQZISa3p
	 8euNnb4AQbjlPP4wrh6Wc3fLakSprgdW9PFA77l8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Guan <guanwentao@uniontech.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 528/666] arm64/scs: Fix potential sign extension issue of advance_loc4
Date: Wed, 20 May 2026 18:22:19 +0200
Message-ID: <20260520162122.713591085@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252745-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,godbolt.org:url]
X-Rspamd-Queue-Id: F215F5967FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit 4023b7424ecd5d38cc75b650d6c1bf630ef8cb40 ]

The expression (*opcode++ << 24) and exp * code_alignment_factor
may overflow signed int and becomes negative.

Fix this by casting each byte to u64 before shifting. Also fix
the misaligned break statement while we are here.

Example of the result can be seen here:
Link: https://godbolt.org/z/zhY8d3595

It maybe not a real problem, but could be a issue in future.

Fixes: d499e9627d70 ("arm64/scs: Fix handling of advance_loc4")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/pi/patch-scs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/pi/patch-scs.c b/arch/arm64/kernel/pi/patch-scs.c
index be7050fdfbba0..76e69df0085d1 100644
--- a/arch/arm64/kernel/pi/patch-scs.c
+++ b/arch/arm64/kernel/pi/patch-scs.c
@@ -178,9 +178,9 @@ static int scs_handle_fde_frame(const struct eh_frame *frame,
 			loc += *opcode++ * code_alignment_factor;
 			loc += (*opcode++ << 8) * code_alignment_factor;
 			loc += (*opcode++ << 16) * code_alignment_factor;
-			loc += (*opcode++ << 24) * code_alignment_factor;
+			loc += ((u64)*opcode++ << 24) * code_alignment_factor;
 			size -= 4;
-		break;
+			break;
 
 		case DW_CFA_def_cfa:
 		case DW_CFA_offset_extended:
-- 
2.53.0




