Return-Path: <stable+bounces-255853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UImqCJumGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF45F8F32
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55FA230960E7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01F132AAD6;
	Thu, 28 May 2026 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSLyXENR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762919A288;
	Thu, 28 May 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000060; cv=none; b=hJ2etNvxwJxs3VN6/BvR6Rt5Mj/DLX5k/B3OU3cBfhAE9W41zWrc4bB7ADuEoeK0lpGfgC1xmteSyijc5LdwywOTDLZm0XCKEGHZQlKa+PXGULWcBP3+G/fFhWKV0ZYWr52Hj7je4Klv9qOlXT2yOxiMJntp74OtBIwyLGF2iZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000060; c=relaxed/simple;
	bh=3U8Fq3UqnrjUwmf4TQgJO8mbvY5lpBaEYr+mLPy6B54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JauvR05Ct+yEGLNN5Kbe5SrE80jYyhASKnk9Mh0A6ILcDhNAOgCh4g87QBeJ+zDbjcK5C8u2DKDFInW5D3Lx9faK9FyyWtGkSBEyGTQLv2uPTljmynzdTcfqVeCyO0VRgc+inFCvII5BIf3IMdx+28/MWTOFgKlHtlHT2zwqzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSLyXENR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215FD1F00A3C;
	Thu, 28 May 2026 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000059;
	bh=dvDD1tJiPwmRYiDarAAOV1nhP6mPBfcKxMQ+v+1zzVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PSLyXENRpatRiV/tDOlUi9SH1oDJNVSk7FMueJqPSmEumOBlLVaZH78FnevlBKPw5
	 IG/7mdgtY6W3lzVJ0YKUHjlmHcpf0a2yYm2chf/xJw7kcu229lo3Wo2+/WGl6vjl8i
	 5B9v8P4nBR8gGiaZUCyhaWFXFCgXURpnLiBOe0V8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 271/377] ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics
Date: Thu, 28 May 2026 21:48:29 +0200
Message-ID: <20260528194646.212669953@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255853-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,tor.lore.kernel.org:server fail,kylinos.cn:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 92AF45F8F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

[ Upstream commit 3d042592ebd4c7e44974d556de0b727cb7db4dab ]

ethnl_bitmap32_not_zero() should return true if some bit in [start, end)
is set:

- Fix inverted memchr_inv() sense: return true when the scan finds a
  non-zero byte, not when the middle words are all zero.
- Return false for an empty interval (end <= start).
- When end is 32-bit aligned, indices in [start, end) do not include any
  bits from map[end_word]; return false after earlier checks found no
  non-zero data.

Fixes: 10b518d4e6dd ("ethtool: netlink bitset handling")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/bitset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index f0883357d12e5..4691d6d0f2b75 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -91,7 +91,7 @@ static bool ethnl_bitmap32_not_zero(const u32 *map, unsigned int start,
 	u32 mask;
 
 	if (end <= start)
-		return true;
+		return false;
 
 	if (start % 32) {
 		mask = ethnl_upper_bits(start);
@@ -104,11 +104,11 @@ static bool ethnl_bitmap32_not_zero(const u32 *map, unsigned int start,
 		start_word++;
 	}
 
-	if (!memchr_inv(map + start_word, '\0',
-			(end_word - start_word) * sizeof(u32)))
+	if (memchr_inv(map + start_word, '\0',
+		       (end_word - start_word) * sizeof(u32)))
 		return true;
 	if (end % 32 == 0)
-		return true;
+		return false;
 	return map[end_word] & ethnl_lower_bits(end);
 }
 
-- 
2.53.0




