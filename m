Return-Path: <stable+bounces-255666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCJQNAClGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FED5F8B0F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B026A3288CF8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCBA2D1303;
	Thu, 28 May 2026 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S55vp4Ba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622B2F8E83;
	Thu, 28 May 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999553; cv=none; b=CEWZnAlpx5tbUF+9/4wTd9eNFcInA20JDYi/M6+4QVKmcNDIovZqAfY1G5i+Ps5TjWDtI2gvDRTHfGNiE5GYUzE96uGmJfAVGY45Vw9jWqgiEqN0/Es/Mvthcke4thAB3AeaKAFWsmONBdeDMRQUN4mIQPHEtr6Y0uKVi8gwOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999553; c=relaxed/simple;
	bh=/NknHXXIMsUk5p6XNBz/q2Y4RZhzVnGtwagdOiHw6CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHayc/bS25AqbueHoDG3TwWp9/mu0yfC576ATfd0pa9eu0/DZFOj2Z1i+2p2zqlgRuOtWYGpVo5a1cVrvp+31YHmkdfFM5T+46+TL6E3Yy9SV35RxAdhPAY1OVlkEGEN9q2XspkS8sE5dlUI87OcA84EClJYL1TQcHb36NuQLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S55vp4Ba; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844271F00A3A;
	Thu, 28 May 2026 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999552;
	bh=/tz5S4EouP4gHcgp+68w7l9Ex8bUekrD1nDXKDJ8hrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S55vp4Bam7lcl4QWODoGOyT8ROrdhv2R60hoZ+WadqNcP5cSAxxFIbIvkBsm6UroA
	 ZO4F3RPVBp0CZQ+4W0aJv63XQl+sjLBP5regaG+SXZwx3TsTjeiaJ4/Tu8gzTePdzE
	 0N+le4aj8aT+V/VAKhX0LFNRonrt1ee6CbeNWoaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.18 106/377] arm64: probes: Handle probes on hinted conditional branch instructions
Date: Thu, 28 May 2026 21:45:44 +0200
Message-ID: <20260528194641.411152381@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255666-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 58FED5F8B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Murzin <vladimir.murzin@arm.com>

commit 2ccd8ff980b50e842481bae71102fa3883fc4377 upstream.

BC.cond instructions introduced by FEAT_HBC cannot be executed
out-of-line, like other branch instructions. However, they can be
simulated in the same way as B.cond instructions.

Extend the B.cond decoder mask to match BC.cond instructions as well,
and handle them using the existing B.cond simulation path.

Fixes: 7f86d128e437 ("arm64: add HWCAP for FEAT_HBC (hinted conditional branches)")
Cc: <stable@vger.kernel.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/insn.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -409,7 +409,7 @@ __AARCH64_INSN_FUNCS(cbz,	0x7F000000, 0x
 __AARCH64_INSN_FUNCS(cbnz,	0x7F000000, 0x35000000)
 __AARCH64_INSN_FUNCS(tbz,	0x7F000000, 0x36000000)
 __AARCH64_INSN_FUNCS(tbnz,	0x7F000000, 0x37000000)
-__AARCH64_INSN_FUNCS(bcond,	0xFF000010, 0x54000000)
+__AARCH64_INSN_FUNCS(bcond,	0xFF000000, 0x54000000)
 __AARCH64_INSN_FUNCS(svc,	0xFFE0001F, 0xD4000001)
 __AARCH64_INSN_FUNCS(hvc,	0xFFE0001F, 0xD4000002)
 __AARCH64_INSN_FUNCS(smc,	0xFFE0001F, 0xD4000003)



