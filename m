Return-Path: <stable+bounces-220490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEyUM0Q9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:08:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E71C6A44
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E913250E10
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153753C6C97;
	Sat, 28 Feb 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3Vg6lnl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5713C6C8E;
	Sat, 28 Feb 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300375; cv=none; b=qZgUWD7tdap6vjYCIoU2JpbiG1WZXvM7cX6qu/jijWjGiONJBMvad0BakmvkHYKIIiCpIZRGq+ZY7jiGOG1eU+fv4HKz3uXDLcbUy1E9dRYhxDBTTSCLyy8jl3h5bvyHnH1kRiddeU7nfo9mcDytR3svgo/9MRwM/XQZ3I2LW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300375; c=relaxed/simple;
	bh=bxOlb7S2gEiTiRn/OHO4IMGNPo+NERVhy1Idt0tE1Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBjHqD4rU/Fx7xBV2KpTVlE31v/lDdzKS769PZMu1OW6TRbGJC9yUMpM3AjjD8h0bjjVTeJylFJT4A0/3evRZJkHOKiQozd47yLUGfyHERsDCi0WrUdGTErBukGmE7zcGqujepTABahqIWP71vU+g3ok5/DCZRoAZbBmmLyJArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3Vg6lnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B4C19423;
	Sat, 28 Feb 2026 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300375;
	bh=bxOlb7S2gEiTiRn/OHO4IMGNPo+NERVhy1Idt0tE1Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3Vg6lnliLo9MViDfZTfCvWXhrbuVao6f7hzp9aWLveFeVwjSqDwBal95igMV0Y5P
	 tqSI+k69pFoH8/YUaBzJ3xXAQAQlTCr2lx5lPV+uAQA/KzyzheLg01OadhSnBZ4JPj
	 TcD0s7fcR+c26qheYOWNIJAojFXV9TFxfcaf1RUFUXQJlywp/cuje1KwCVSAw+XW/e
	 J6Ndr3PB6wy9wUi/rdV5H6ACN9hf8+E1FtkgYxjRagGw33P9asLuu26WAhjZqRXjjy
	 co/b7/AFkg0BQjKAhCzEvapgMBsgAiRav3MUatn707jeKaZm10QFR2yA5dCgRmthnP
	 e/mf6XgQH+0hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 411/844] libceph: define and enforce CEPH_MAX_KEY_LEN
Date: Sat, 28 Feb 2026 12:25:24 -0500
Message-ID: <20260228173244.1509663-412-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220490-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 211E71C6A44
X-Rspamd-Action: no action

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit ac431d597a9bdfc2ba6b314813f29a6ef2b4a3bf ]

When decoding the key, verify that the key material would fit into
a fixed-size buffer in process_auth_done() and generally has a sane
length.

The new CEPH_MAX_KEY_LEN check replaces the existing check for a key
with no key material which is a) not universal since CEPH_CRYPTO_NONE
has to be excluded and b) doesn't provide much value since a smaller
than needed key is just as invalid as no key -- this has to be handled
elsewhere anyway.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/crypto.c       | 8 +++++---
 net/ceph/crypto.h       | 2 +-
 net/ceph/messenger_v2.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 01b2ce1e8fc06..5601732cf4faa 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -37,9 +37,6 @@ static int set_secret(struct ceph_crypto_key *key, void *buf)
 		return -ENOTSUPP;
 	}
 
-	if (!key->len)
-		return -EINVAL;
-
 	key->key = kmemdup(buf, key->len, GFP_NOIO);
 	if (!key->key) {
 		ret = -ENOMEM;
@@ -83,6 +80,11 @@ int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end)
 	ceph_decode_copy(p, &key->created, sizeof(key->created));
 	key->len = ceph_decode_16(p);
 	ceph_decode_need(p, end, key->len, bad);
+	if (key->len > CEPH_MAX_KEY_LEN) {
+		pr_err("secret too big %d\n", key->len);
+		return -EINVAL;
+	}
+
 	ret = set_secret(key, *p);
 	memzero_explicit(*p, key->len);
 	*p += key->len;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index 23de29fc613cf..a20bad6d1e964 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -5,7 +5,7 @@
 #include <linux/ceph/types.h>
 #include <linux/ceph/buffer.h>
 
-#define CEPH_KEY_LEN			16
+#define CEPH_MAX_KEY_LEN		16
 #define CEPH_MAX_CON_SECRET_LEN		64
 
 /*
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index c9d50c0dcd33a..31e042dc1b3f2 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2360,7 +2360,7 @@ static int process_auth_reply_more(struct ceph_connection *con,
  */
 static int process_auth_done(struct ceph_connection *con, void *p, void *end)
 {
-	u8 session_key_buf[CEPH_KEY_LEN + 16];
+	u8 session_key_buf[CEPH_MAX_KEY_LEN + 16];
 	u8 con_secret_buf[CEPH_MAX_CON_SECRET_LEN + 16];
 	u8 *session_key = PTR_ALIGN(&session_key_buf[0], 16);
 	u8 *con_secret = PTR_ALIGN(&con_secret_buf[0], 16);
-- 
2.51.0


