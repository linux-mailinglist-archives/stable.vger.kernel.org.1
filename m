Return-Path: <stable+bounces-77149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BBD98592D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9F828126E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E4198E86;
	Wed, 25 Sep 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udpaj2t+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116219AD6E;
	Wed, 25 Sep 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264308; cv=none; b=cEg/RQiR24Ru+WDto93Q5vBZA37dBZIIEjnAXKOz0P4iF39KY7hXElTTaS2Srd0/FiMlJn3awxn4XgIYf2FDoGev3YWL+lZEUzATKSt/X0YS0/HmB8TeHxvZUGcxHQDWmYSdRUYn4MFqvLS/ORyVo0BlYQYAXULcBHQHuw2N/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264308; c=relaxed/simple;
	bh=UVIPIC4hx7NiFCz9RvWE5LNSwYAU9jw1FoBRJHiPWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDdbfRsPywwR8accOd4pskYbfg6vo+HMJ8BvQYOkQIX+aVxpV9ljuXigVn/XpS+/Q3fW8UCkiRrEJxIrreyDMyepl2aTZUamooRFoGdoI/HJ4CqSKPP+CMrOtrywZs+7n3+aDeixwnJGOyaYSjdDqpzkSndVttUwLEPwIzj90qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udpaj2t+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6A6C4CEC3;
	Wed, 25 Sep 2024 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264308;
	bh=UVIPIC4hx7NiFCz9RvWE5LNSwYAU9jw1FoBRJHiPWT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udpaj2t+FoCVsuD5I3Uy/sSy11BGjOZS1gmSjq8GI5aN8JtjIsds5bjYPfh0GvegU
	 RlwpdJTnWSxUO5uhs7mw3JaOoZKJ9q3swoCYWw2T4d/wIenhMXn0bc4sUwaw3GVSGV
	 gsV4LiRgC3SvcpLNWuiK/1VuRlk8Du2h9Fr/LxwbKQ0T5YRFe1ie9heEcygWvzu8Rv
	 set5P+wRFmM4+P+psxRIYyBqjkkErPtykTfMLQbEGuOEXb9es5Dvpi3zCDBDl0amiP
	 zVkXSnXdlNJa4Sr2VgRL20T8gs8UjStGUJnm5vu7SYrjO9ZpA6vUnGc6xq0sh8MZu5
	 N++6A/WBWi0wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 051/244] nvme-keyring: restrict match length for version '1' identifiers
Date: Wed, 25 Sep 2024 07:24:32 -0400
Message-ID: <20240925113641.1297102-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


