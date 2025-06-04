Return-Path: <stable+bounces-151000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCCDACD2C6
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBD3176744
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19731F03DE;
	Wed,  4 Jun 2025 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8plPQpE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FD1EF391;
	Wed,  4 Jun 2025 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998764; cv=none; b=aTXUSPSn2BRFooWuOLRoHXoceuwyVdgsIqBTeYkc2PyWNSbJ8h7antPlZWbftIbMFqAriJdMZQfn6y0M5k3jFKzi2E/m4V/qD0X1Cyq/eGTs2LbryH/md23jCVYI6aIgGwkV875ES4fr9S3N4CKVOJBcU7Bt/hsyE/J7xj5GEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998764; c=relaxed/simple;
	bh=UPtTtLXwTrsMITJJ7Sh2sN9H9RliQwy2nPG/QkBaUxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REuvCKmwCL/umCJaFJFsSXQ9F+ok/DWQHHLXMLhj+MQxspT4iAOEdO9igsD6gx0N9OWuYEsqwMTNml2anEqd3WJcTvQM5PIcIzz71LAJ9xzEajIzi07iDN6d4lHcxIV8TcwrIqeJgdXf0BFbQ4zQ3JE0wCU7YDwraynANMcFYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8plPQpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE02C4CEEF;
	Wed,  4 Jun 2025 00:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998764;
	bh=UPtTtLXwTrsMITJJ7Sh2sN9H9RliQwy2nPG/QkBaUxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8plPQpEyVQoD93tW4YBXUIZ+a/MXHKkMlbx6crk74jM+CffmsV1wVSmhMRsXX27o
	 wzPpvSAqfMt0A3Kr+hCSVcsIJxYLhBoDQRmIsEXLy/voi1ft/SNOnRRnCexCv6uTj2
	 sTMRu73Kw7/np+5ScaUWp+oeMJ4IdW8UN3rWapSrbS5+YNpZBJihv8xKRbPeQtt1ae
	 601mO3RvP81417wzYHYJ0nO/q/u/2h1TT6X6RPjvTzgNLeiXWNAJOxZL8iqVvkiDH4
	 K0kMeqvRzFd3to1+8FGNwko424irs5jN7gDaZEi72Nf0kiE3QTkkHE2NvAmyj39gma
	 gdL9yOPpGCaxA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zilin Guan <zilin@seu.edu.cn>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jmaloy@redhat.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 03/93] tipc: use kfree_sensitive() for aead cleanup
Date: Tue,  3 Jun 2025 20:57:49 -0400
Message-Id: <20250604005919.4191884-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Transfer-Encoding: 8bit

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit c8ef20fe7274c5766a317f9193b70bed717b6b3d ]

The tipc_aead_free() function currently uses kfree() to release the aead
structure. However, this structure contains sensitive information, such
as key's SALT value, which should be securely erased from memory to
prevent potential leakage.

To enhance security, replace kfree() with kfree_sensitive() when freeing
the aead structure. This change ensures that sensitive data is explicitly
cleared before memory deallocation, aligning with the approach used in
tipc_aead_init() and adhering to best practices for handling confidential
information.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20250523114717.4021518-1-zilin@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Security Justification The commit addresses a
clear security vulnerability by replacing `kfree()` with
`kfree_sensitive()` for the `tipc_aead` structure in `tipc_aead_free()`.
This is a critical security improvement because: 1. **Sensitive Data
Content**: The `tipc_aead` structure contains highly sensitive
cryptographic information: - `salt` field: Cryptographic salt used in
key derivation - `key` pointer: References actual cryptographic key
material - `hint` field: Contains key identification information 2.
**Memory Security Risk**: Using regular `kfree()` leaves sensitive
cryptographic data in freed memory, creating a potential information
leakage vector where: - Attackers could potentially recover salt values
and key hints from freed memory - Subsequent memory allocations might
access residual cryptographic data - This violates cryptographic
security best practices ## Code Change Analysis The specific change from
`kfree(aead)` to `kfree_sensitive(aead)` on line 428 of
`net/tipc/crypto.c` is: ```c - kfree(aead); + kfree_sensitive(aead); ```
This change is: - **Minimal and contained**: Single line change with no
functional impact - **Low risk**: `kfree_sensitive()` performs the same
deallocation as `kfree()` but adds explicit memory zeroing -
**Consistent**: The same file already uses `kfree_sensitive(aead->key)`
on line 427, showing this practice is established ## Alignment with
Similar Commits This commit closely parallels the "YES" backport
examples: 1. **Similar Commit #1**: Used `aead_request_free()` instead
of `kfree()` for proper crypto data handling 2. **Similar Commit #2**:
Applied `kfree_sensitive()` to crypto buffers containing key material 3.
**Similar Commit #5**: Fixed TIPC crypto security issue (preemption
problem) The pattern of replacing standard memory deallocation with
secure alternatives for cryptographic structures is well-established and
consistently approved for backporting. ## Stable Tree Criteria
Compliance This commit meets all stable tree requirements: - **Important
bugfix**: Fixes potential cryptographic information leakage - **Minimal
risk**: Single line change with no behavioral modifications - **No
architectural changes**: Uses existing kernel API - **Contained scope**:
Limited to TIPC crypto subsystem cleanup ## Security Impact Given TIPC's
history of security vulnerabilities (including heap overflows and use-
after-free issues), this defensive security measure is particularly
valuable for preventing information disclosure attacks targeting
cryptographic material. The commit represents a clear security hardening
improvement with negligible risk, making it an excellent candidate for
stable kernel backporting.

 net/tipc/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 8584893b47851..f4cfe88670f55 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -425,7 +425,7 @@ static void tipc_aead_free(struct rcu_head *rp)
 	}
 	free_percpu(aead->tfm_entry);
 	kfree_sensitive(aead->key);
-	kfree(aead);
+	kfree_sensitive(aead);
 }
 
 static int tipc_aead_users(struct tipc_aead __rcu *aead)
-- 
2.39.5


