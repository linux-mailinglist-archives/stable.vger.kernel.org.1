Return-Path: <stable+bounces-77151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A7985933
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00032816D9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982719C541;
	Wed, 25 Sep 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAURDJkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5A19B580;
	Wed, 25 Sep 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264312; cv=none; b=jb/eOY76eG9yQHJwig1KeC8vwX9l7a/OddJjKQ/oJmBKae7iSJShgYrCRIF3up8N7z68GVJ4+QN6psmelmt3bADSGrBqokMOUIPMv42Wcqng86crSskwrSTx86fYOtIMkVrRnrc/H6dC4NwEs+BXwvhv7cFlPWYdgpwW309HUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264312; c=relaxed/simple;
	bh=vK3lmOrXiq/YYa7DiGqflGevr35quYkpRFV2If/dytE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNb4MriwPSvEax6LHNnGnR6LMxE4dMgqvii0az+iHvOddpTApl3LAA4PppgDYPZPjYD1Zij7w+CwHk5xG6N32GIftI4hpKSDifHwDWrpfKUKLb+AJuChFm1eDGp3mGUEyd/hmiHG6i4n+I4OUU+QIbK/sDVdTe7RyXssdrT+asI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAURDJkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2662C4CEC3;
	Wed, 25 Sep 2024 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264311;
	bh=vK3lmOrXiq/YYa7DiGqflGevr35quYkpRFV2If/dytE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAURDJkAz1SpDsiReSpo6JR9gln/HkGpqf/F5v5Z7oSom8MoeoImFAFyWhpd6T+ok
	 D5fYgnyM1t/RCHeyVvRye8DNVr5w+9L3puseHhAW87/RrTMe+EzS8fxb8kiQ1qF/8f
	 BL4qKqjeIU38rvhv7G1iaJS2CZKOidDzspt6XVw6N55AHqGWgVD591ozxEEHARRdtw
	 eHD2DxG3AcDyjblNPlKTuk3QCD43mfNjL2O2iHW+K+IwaFs7C4mQZgmuNQiNqPagBl
	 22D65ZQTLHyk1LNBvxGIRxOCyKyryPcxPesY++SFvGyoTipR4arZOo9X7A1HV5zGVD
	 +JcMHLYT425rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 053/244] nvme-tcp: check for invalidated or revoked key
Date: Wed, 25 Sep 2024 07:24:34 -0400
Message-ID: <20240925113641.1297102-53-sashal@kernel.org>
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

[ Upstream commit 5bc46b49c828a6dfaab80b71ecb63fe76a1096d2 ]

key_lookup() will always return a key, even if that key is revoked
or invalidated. So check for invalid keys before continuing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/common/keyring.c | 22 ++++++++++++++++++++++
 drivers/nvme/host/Kconfig     |  1 +
 drivers/nvme/host/fabrics.c   |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 include/linux/nvme-keyring.h  |  6 +++++-
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 05e89307c8aa3..ed5167f942d89 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -20,6 +20,28 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
+static bool nvme_tls_psk_revoked(struct key *psk)
+{
+	return test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
+		test_bit(KEY_FLAG_INVALIDATED, &psk->flags);
+}
+
+struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	struct key *key = key_lookup(key_id);
+
+	if (IS_ERR(key)) {
+		pr_err("key id %08x not found\n", key_id);
+		return key;
+	}
+	if (nvme_tls_psk_revoked(key)) {
+		pr_err("key id %08x revoked\n", key_id);
+		return ERR_PTR(-EKEYREVOKED);
+	}
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_key_lookup);
+
 static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
 {
 	seq_puts(m, key->description);
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index a3caef75aa0a8..883aaab2d83e3 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -109,6 +109,7 @@ config NVME_HOST_AUTH
 	bool "NVMe over Fabrics In-Band Authentication in host side"
 	depends on NVME_CORE
 	select NVME_AUTH
+	select NVME_KEYRING if NVME_TCP_TLS
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication in
 	  host side.
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f5f545fa01035..432efcbf9e2f5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -665,7 +665,7 @@ static struct key *nvmf_parse_key(int key_id)
 		return ERR_PTR(-EINVAL);
 	}
 
-	key = key_lookup(key_id);
+	key = nvme_tls_key_lookup(key_id);
 	if (IS_ERR(key))
 		pr_err("key id %08x not found\n", key_id);
 	else
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b305873e588e6..e3d82e91151af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1596,7 +1596,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		goto out_complete;
 	}
 
-	tls_key = key_lookup(pskid);
+	tls_key = nvme_tls_key_lookup(pskid);
 	if (IS_ERR(tls_key)) {
 		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
 			 qid, pskid);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index e10333d78dbbe..19d2b256180fd 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -12,7 +12,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-
+struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
@@ -24,5 +24,9 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
+static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
-- 
2.43.0


