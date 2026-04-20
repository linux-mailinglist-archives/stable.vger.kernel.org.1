Return-Path: <stable+bounces-238922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HeiHkcw5ml6tAEAu9opvQ
	(envelope-from <stable+bounces-238922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:55:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0524142C6B3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E94ED33017E4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F643DCD9B;
	Mon, 20 Apr 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odxFO6um"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE93DCD9C;
	Mon, 20 Apr 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691453; cv=none; b=jy/1X0J5wz4VSlD0lsYe1AiJz7R0xH1MTpX3ZyUwgJ9atHNb3Pd9Y4WXMI0RAgiqnkCxjubrEktd6Fh7TCt3R0ZpdV+BzJnSgV6rtBWk32kq5cKMjxZrYGED8lAixgZ2DGdWZvofhRvWMhVt5V0a+bUNXjTz/xOgbEXz6tUkSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691453; c=relaxed/simple;
	bh=+4e+6F2NNf6TQiP1np+xPDzM8JxXveOsna63XC6iui8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9prklHmYNJd2ynIJ5kEfTrwcaCBVn2pyMy9xIYGAG1yriPxc6mIWXHPbNL6XjBz7vUfFmLAGlh3LRm4qgdd5plXAbwd7q6VCWrcbTJvd4iZmYjOcDa6nRrUwpTrN/dwdr8/p/727Njc9CilUyQAiEaSnqS1563nkByvh4ncQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odxFO6um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BBFC19425;
	Mon, 20 Apr 2026 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691452;
	bh=+4e+6F2NNf6TQiP1np+xPDzM8JxXveOsna63XC6iui8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odxFO6umDob2VrtlnXY38trB5FYCZl51i97BAWOQXKUoYtHJrTGaRiXIYLsHxgUKR
	 DcYeIM6lh7kjgqtzLpx3D2B8tF8MkfPt5aNsqfKKiHsF53qeYD1BrZ4UJ13fWaF7/Z
	 5SdS1jcOeCvnaOnfQLTRlm+1wIGBGFPLKks9ivYlH6L5dhntJolBFUe0lx3T1G/mxY
	 suZxZCjjgxqlF5/Jjyz8CE8NkFJ9jDohn3u8gtlSMeaLieoAJ0MPveKDGI45t4YMyS
	 j6CXN0QAFNa+v8Sz3Fs7BzFyB74hAogsEc7kxlhPQPmH5VULprcODNnBe48vlYcce2
	 FfsuGMR2EVsQw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com,
	Daniel Pouzzner <douzzer@mega.nu>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	smueller@chronox.de,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] crypto: algif_aead - Fix minimum RX size check for decryption
Date: Mon, 20 Apr 2026 09:17:11 -0400
Message-ID: <20260420132314.1023554-37-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238922-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,aa11561819dc42ebbc7c];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mega.nu:email,apana.org.au:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 0524142C6B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 3d14bd48e3a77091cbce637a12c2ae31b4a1687c ]

The check for the minimum receive buffer size did not take the
tag size into account during decryption.  Fix this by adding the
required extra length.

Reported-by: syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com
Reported-by: Daniel Pouzzner <douzzer@mega.nu>
Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 crypto/algif_aead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index dda15bb05e892..f8bd45f7dc839 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -144,7 +144,7 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (usedpages < outlen) {
 		size_t less = outlen - usedpages;
 
-		if (used < less) {
+		if (used < less + (ctx->enc ? 0 : as)) {
 			err = -EINVAL;
 			goto free;
 		}
-- 
2.53.0


