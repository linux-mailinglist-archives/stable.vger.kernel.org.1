Return-Path: <stable+bounces-252228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL1QLYUEDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E359787A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2273C30E106F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0BF3F6619;
	Wed, 20 May 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSv0INQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A434DCE4;
	Wed, 20 May 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300128; cv=none; b=BHkIm/UtbUqURMtRYCZhJirHDbgHN+7Iid0826OR3tS0Lf+4bRR03VsXID5eL1bQ752B9b1A1elL08dku+Xd2mxA3LhGNx/hj+7i/j7hvf5FMG4fZbaZkB25FjHDI4o7NdtOgxWqMA5Mr/HhufZ/iHBG2q7moRm3k7ebZTwJcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300128; c=relaxed/simple;
	bh=cfvKK2nZz0L1pNta94cOU+nPQiis6kEvMYyoV7sqobM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Oky8MsoSU2p/nWXcqsKOsZKM4rUOrU4zUGS4AgNmSR0W8Mwp8J6Q+kdbXyl84ApfjDKv4fZxQdEyRoaHpbM2brI9QMalh1T3qro3QGvzb8KcsIuxZFNIMgobBxsjWrdRz7mYU1NmErypFZ1Es+MCMF59c4oxZwiM1vhYr2pxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSv0INQ5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782891F000E9;
	Wed, 20 May 2026 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300127;
	bh=k4K2NIPvosKXDpmMZuu7bk7nVl+GwXlGQ4gft2kAJ+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSv0INQ5GlO6wvJspsrRndB13MGoq+b0PJyc4cZDV4MlIyjW7Zed8ukAJYbY9tOZn
	 ox8khDeXa5lHHQLYlMKm1+pVe1MA1htumWAomYsgqen5vSFuomtdYYl2eL3AdNml8A
	 aiEQpcOCw8jFtJoz9GiJtTgozI4P9FbT78qwa7yk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"haoyu.lu" <hechushiguitu666@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 057/666] bpf,arc_jit: Fix missing newline in pr_err messages
Date: Wed, 20 May 2026 18:14:28 +0200
Message-ID: <20260520162112.471411821@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252228-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,haoyu.lu:url]
X-Rspamd-Queue-Id: C17E359787A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: haoyu.lu <hechushiguitu666@gmail.com>

[ Upstream commit b6b5e0ebd429d66ce37ae5af649a74ea1f041d92 ]

Add missing newline to pr_err messages in ARC JIT.

Fixes: f122668ddcce ("ARC: Add eBPF JIT support")
Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
Link: https://lore.kernel.org/r/20260324122703.641-1-hechushiguitu666@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/net/bpf_jit_arcv2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
index 6d989b6d88c69..7ee50aeae5a45 100644
--- a/arch/arc/net/bpf_jit_arcv2.c
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -2427,7 +2427,7 @@ u8 arc_prologue(u8 *buf, u32 usage, u16 frame_size)
 
 #ifdef ARC_BPF_JIT_DEBUG
 	if ((usage & BIT(ARC_R_FP)) && frame_size == 0) {
-		pr_err("FP is being saved while there is no frame.");
+		pr_err("FP is being saved while there is no frame.\n");
 		BUG();
 	}
 #endif
@@ -2454,7 +2454,7 @@ u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size)
 
 #ifdef ARC_BPF_JIT_DEBUG
 	if ((usage & BIT(ARC_R_FP)) && frame_size == 0) {
-		pr_err("FP is being saved while there is no frame.");
+		pr_err("FP is being saved while there is no frame.\n");
 		BUG();
 	}
 #endif
@@ -2868,7 +2868,7 @@ u8 gen_jmp_64(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
 		break;
 	default:
 #ifdef ARC_BPF_JIT_DEBUG
-		pr_err("64-bit jump condition is not known.");
+		pr_err("64-bit jump condition is not known.\n");
 		BUG();
 #endif
 	}
@@ -2948,7 +2948,7 @@ u8 gen_jmp_32(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
 	 */
 	if (cond >= ARC_CC_LAST) {
 #ifdef ARC_BPF_JIT_DEBUG
-		pr_err("32-bit jump condition is not known.");
+		pr_err("32-bit jump condition is not known.\n");
 		BUG();
 #endif
 		return 0;
-- 
2.53.0




