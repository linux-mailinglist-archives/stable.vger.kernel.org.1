Return-Path: <stable+bounces-77387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3C0985C9D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B011F24E4D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A291AE84F;
	Wed, 25 Sep 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXmn3nCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA911AE84E;
	Wed, 25 Sep 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265596; cv=none; b=D1U8sabZDBkc1RSrs60ELNsITzvWsucZG2Wd3uAubMZDJMCSVPQybFhOdHRr5/eTvlXdW4ozbZPutAZ/smbXgKKrq6utow5grwBE7QP1FzPQ5MMlfU9jWYwJqNBFbjfD/K2RK7RhDtIQb1r6lUOPzLUFV1lUbL+LQsqxzccxsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265596; c=relaxed/simple;
	bh=UVIPIC4hx7NiFCz9RvWE5LNSwYAU9jw1FoBRJHiPWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ont3u6XJoQK7cLepirAlb3fUEdFGnlmHlxITtXYumwfgB3P72Yj/z+VVkGus/NYM9XwXDnQRh+hPncFvMuoxo/YQUcJhUKyXr+AwDcqWw6R1ThaNes6GJt/jJeG75maUI2I0aqXyT4qaYe5czV3Igu0wyc0EXoQp8kUgPRmuoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXmn3nCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A77C4CEC7;
	Wed, 25 Sep 2024 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265596;
	bh=UVIPIC4hx7NiFCz9RvWE5LNSwYAU9jw1FoBRJHiPWT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXmn3nCn2kYkW/XBkagFK4lgMdp8Rx1c7S2Kp6D+zko96IZXzifB5rQoA9KH5SFbW
	 4I32IUCFbfR++eeGg8V2BAG0GlUp/XchlhCrToEvZ5BMKazBnuJntbngW9A8qW245O
	 82V1YguEFW+nHql3AKX3M/pBXkVR8rgSKJasZvoPx7EN1OaBTbxUGeVpcgaV/9wahy
	 hKXAqakYZRNZwx+SogFGE5a0XswMoxY6gfd5qujMQQwsovBx7KPLqT7Bh9tPbQLV6t
	 6aAVqWZZypDMqz8MOYG6VPvMHuHDIX+jghp0G2j3mUpH/LAqMyqbk9ZpkclReCRD4g
	 xnCHZj6BJKw4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 042/197] nvme-keyring: restrict match length for version '1' identifiers
Date: Wed, 25 Sep 2024 07:51:01 -0400
Message-ID: <20240925115823.1303019-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 79559c75332458985ab8a21f11b08bf7c9b833b0 ]

TP8018 introduced a new TLS PSK identifier version (version 1), which appended
a PSK hash value to the existing identifier (cf NVMe TCP specification v1.1,
section 3.6.1.3 'TLS PSK and PSK Identity Derivation').
An original (version 0) identifier has the form:

NVMe0<type><hmac> <hostnqn> <subsysnqn>

and a version 1 identifier has the form:

NVMe1<type><hmac> <hostnqn> <subsysnqn> <hash>

This patch modifies the lookup algorthm to compare only the first part
of the identifier (excluding the hash value) to handle both version 0 and
version 1 identifiers.
And the spec declares 'version 0' identifiers obsolete, so the lookup
algorithm is modified to prever v1 identifiers.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 6f7e7a8fa5ae4..05e89307c8aa3 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -36,14 +36,12 @@ static bool nvme_tls_psk_match(const struct key *key,
 		pr_debug("%s: no key description\n", __func__);
 		return false;
 	}
-	match_len = strlen(key->description);
-	pr_debug("%s: id %s len %zd\n", __func__, key->description, match_len);
-
 	if (!match_data->raw_data) {
 		pr_debug("%s: no match data\n", __func__);
 		return false;
 	}
 	match_id = match_data->raw_data;
+	match_len = strlen(match_id);
 	pr_debug("%s: match '%s' '%s' len %zd\n",
 		 __func__, match_id, key->description, match_len);
 	return !memcmp(key->description, match_id, match_len);
@@ -71,7 +69,7 @@ static struct key_type nvme_tls_psk_key_type = {
 
 static struct key *nvme_tls_psk_lookup(struct key *keyring,
 		const char *hostnqn, const char *subnqn,
-		int hmac, bool generated)
+		u8 hmac, u8 psk_ver, bool generated)
 {
 	char *identity;
 	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
@@ -82,8 +80,8 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	if (!identity)
 		return ERR_PTR(-ENOMEM);
 
-	snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
-		 generated ? 'G' : 'R', hmac, hostnqn, subnqn);
+	snprintf(identity, identity_len, "NVMe%u%c%02u %s %s",
+		 psk_ver, generated ? 'G' : 'R', hmac, hostnqn, subnqn);
 
 	if (!keyring)
 		keyring = nvme_keyring;
@@ -107,21 +105,38 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 /*
  * NVMe PSK priority list
  *
- * 'Retained' PSKs (ie 'generated == false')
- * should be preferred to 'generated' PSKs,
- * and SHA-384 should be preferred to SHA-256.
+ * 'Retained' PSKs (ie 'generated == false') should be preferred to 'generated'
+ * PSKs, PSKs with hash (psk_ver 1) should be preferred to PSKs without hash
+ * (psk_ver 0), and SHA-384 should be preferred to SHA-256.
  */
 static struct nvme_tls_psk_priority_list {
 	bool generated;
+	u8 psk_ver;
 	enum nvme_tcp_tls_cipher cipher;
 } nvme_tls_psk_prio[] = {
 	{ .generated = false,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = false,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = false,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
 	{ .generated = false,
+	  .psk_ver = 0,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = true,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = true,
+	  .psk_ver = 1,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
 	{ .generated = true,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
 	{ .generated = true,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
 };
 
@@ -137,10 +152,11 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
 	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
 		bool generated = nvme_tls_psk_prio[prio].generated;
+		u8 ver = nvme_tls_psk_prio[prio].psk_ver;
 		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
 
 		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
-					      cipher, generated);
+					      cipher, ver, generated);
 		if (!IS_ERR(tls_key)) {
 			tls_key_id = tls_key->serial;
 			key_put(tls_key);
-- 
2.43.0


