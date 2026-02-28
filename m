Return-Path: <stable+bounces-220801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIJgBZhXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:01:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC41C8B21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 222DB3206E14
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34940E97C;
	Sat, 28 Feb 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq0pWXuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27240E977;
	Sat, 28 Feb 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300686; cv=none; b=Juny5XgRd7ve0TKm9RvDJxGtfwFNnOKIZR/svBgnV+9MIJ5dL94VRcsuZQjuuEeyHZ/893g+ZVYCTnCJfx8+LePVg/eg0WqDZcKArcirVtqpWv7jirAM2mEW7w+7DPdqpi8P/O2CGi7DUPMcHAacyjK9OxuuY/sZwReLvm/lccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300686; c=relaxed/simple;
	bh=rjXJLCBeCGvltKD9acB4is1H3g18LgE0Z3h2wPRvfwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGOLA0h8Z/LKAYIqjXmuBTjaB4zYBt6VHEpwt+f3OVUap/35o6PGTrTDUj0yFTerJH0lMYubSUtLNU168UeGCaPv5ueKnMrE1xpuJ9qHq/IYIPKKVwTS3Vu3B6WmxKYaMYCqVQMVaeGKUCl2oBaJ9A+7CZYIz+b5lkV4I2ZLgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq0pWXuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DD3C116D0;
	Sat, 28 Feb 2026 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300686;
	bh=rjXJLCBeCGvltKD9acB4is1H3g18LgE0Z3h2wPRvfwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rq0pWXuGA2yZvc/GivoDBc13ocgCQv8HONqYXrc+8EXHXQHnG0NNVwa3/CWaow/Vq
	 6AA8bHpbf+JBQIJihpp70hylSCfZqS90RhksfwCx3iyBAHF2X9iFCtpGHvTCN610/0
	 5Lf7kIc8mgW1UEGila3T9358ED0Gvg6IXbZDzSLHGXtI+wkcPwhLHuLThDF+d0Hs54
	 1IKG9/qzsMr4wHtXWfALyfoA3L2+5GLht76lGBcnAmA/5gFbwWWd0ehqdnp6MqZsA7
	 mDMWkWfkrFetAkfXnPFJYabVwwcoHNv6lQhNg/lR3vLRu5+3fU8NdSOhsGCxooxGWs
	 VNiN+dkTlbQRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Coiby Xu <coxu@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 722/844] crash_dump: fix dm_crypt keys locking and ref leak
Date: Sat, 28 Feb 2026 12:30:35 -0500
Message-ID: <20260228173244.1509663-723-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220801-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 1EEC41C8B21
X-Rspamd-Action: no action

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 96a54b8ffc8c4567c32fe0b6996669f1132b026d ]

crash_load_dm_crypt_keys() reads dm-crypt volume keys from the user
keyring.  It uses user_key_payload_locked() without holding key->sem,
which makes lockdep complain when kexec_file_load() assembles the crash
image:

  =============================
  WARNING: suspicious RCU usage
  -----------------------------
  ./include/keys/user-type.h:53 suspicious rcu_dereference_protected() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  no locks held by kexec/4875.

  stack backtrace:
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   lockdep_rcu_suspicious.cold+0x4e/0x96
   crash_load_dm_crypt_keys+0x314/0x390
   bzImage64_load+0x116/0x9a0
   ? __lock_acquire+0x464/0x1ba0
   __do_sys_kexec_file_load+0x26a/0x4f0
   do_syscall_64+0xbd/0x430
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

In addition, the key returned by request_key() is never key_put()'d,
leaking a key reference on each load attempt.

Take key->sem while copying the payload and drop the key reference
afterwards.

Link: https://lkml.kernel.org/r/patch.git-2d4d76083a5c.your-ad-here.call-01769426386-ext-2560@work.hours
Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/crash_dump_dm_crypt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 401423ba477da..abb307a23de33 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -143,6 +143,7 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 {
 	const struct user_key_payload *ukp;
 	struct key *key;
+	int ret = 0;
 
 	kexec_dprintk("Requesting logon key %s", dm_key->key_desc);
 	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
@@ -152,20 +153,28 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 		return PTR_ERR(key);
 	}
 
+	down_read(&key->sem);
 	ukp = user_key_payload_locked(key);
-	if (!ukp)
-		return -EKEYREVOKED;
+	if (!ukp) {
+		ret = -EKEYREVOKED;
+		goto out;
+	}
 
 	if (ukp->datalen > KEY_SIZE_MAX) {
 		pr_err("Key size %u exceeds maximum (%u)\n", ukp->datalen, KEY_SIZE_MAX);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	memcpy(dm_key->data, ukp->data, ukp->datalen);
 	dm_key->key_size = ukp->datalen;
 	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
 		      dm_key->key_desc, dm_key->data);
-	return 0;
+
+out:
+	up_read(&key->sem);
+	key_put(key);
+	return ret;
 }
 
 struct config_key {
-- 
2.51.0


