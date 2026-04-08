Return-Path: <stable+bounces-234734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJpSHt2m1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:05:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A623C25A6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B89D31DC2C1
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A003D4134;
	Wed,  8 Apr 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hv8JNUtd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEAB67E;
	Wed,  8 Apr 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673624; cv=none; b=c0/dbc/s1YAcwH2K1sgnkjkbjP32R7Ep254f86rZfHNwfMPfAG96g8OXXJiD5zf40irHqXGaBZse2zH2fflndvbeM2G9DxQC7Dn3XuzaWPN7w3vmxg7agULctFx46ZcAHZjEnI27xf1bZFD4z77ivLmeynpoqYDUW36joWplhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673624; c=relaxed/simple;
	bh=33RFgtVgxq7D71LqVXymWeNy6eNicyx/eNgfTZasb0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtWYD5ZWTQePjdZDEkXX4E4iMkcpsSVT31mVa1liwGpz+2Z5bgNLwrR9ZP20IcxR9cvtp2oDWUC9saKFY3nXMPRd9b/Li7V1jPXAqIQoPsQ8kS/QB9o8OGRzbwYsq/8HEn8q3nz7z/SpySeYBiKKUBjaltcsaKMocQeTrf1w0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hv8JNUtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F13C19421;
	Wed,  8 Apr 2026 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673624;
	bh=33RFgtVgxq7D71LqVXymWeNy6eNicyx/eNgfTZasb0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hv8JNUtd28+ftWHARgIQEOsvH5t3h2h8E+nW55MZ+N0M6SNGTuMAwrs3K1eUFxatG
	 JnEzxe/3xKXhU37cPZboJI/FcRug01u6mbBj+7Usz8CU23CA+po9ng1Add73y2WmWP
	 o2wBDWCcuJM8lkuqUAZ1lchUSQta1hzjkx8IIps8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pepper Gray <hello@peppergray.xyz>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 026/242] arm64/scs: Fix handling of advance_loc4
Date: Wed,  8 Apr 2026 20:01:06 +0200
Message-ID: <20260408175928.048933515@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234734-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D8A623C25A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pepper Gray <hello@peppergray.xyz>

[ Upstream commit d499e9627d70b1269020d59b95ed3e18bee6b8cd ]

DW_CFA_advance_loc4 is defined but no handler is implemented. Its
CFA opcode defaults to EDYNSCS_INVALID_CFA_OPCODE triggering an
error which wrongfully prevents modules from loading.

Link: https://bugs.gentoo.org/971060
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/pi/patch-scs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/pi/patch-scs.c b/arch/arm64/kernel/pi/patch-scs.c
index 49d8b40e61bc0..be7050fdfbba0 100644
--- a/arch/arm64/kernel/pi/patch-scs.c
+++ b/arch/arm64/kernel/pi/patch-scs.c
@@ -174,6 +174,14 @@ static int scs_handle_fde_frame(const struct eh_frame *frame,
 			size -= 2;
 			break;
 
+		case DW_CFA_advance_loc4:
+			loc += *opcode++ * code_alignment_factor;
+			loc += (*opcode++ << 8) * code_alignment_factor;
+			loc += (*opcode++ << 16) * code_alignment_factor;
+			loc += (*opcode++ << 24) * code_alignment_factor;
+			size -= 4;
+		break;
+
 		case DW_CFA_def_cfa:
 		case DW_CFA_offset_extended:
 			size = skip_xleb128(&opcode, size);
-- 
2.53.0




