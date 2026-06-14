Return-Path: <stable+bounces-263088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R96CI8MgL2pQ8AQAu9opvQ
	(envelope-from <stable+bounces-263088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 23:44:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB9682579
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 23:44:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sina.com header.s=201208 header.b=ZU1qocWC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263088-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263088-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=sina.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413C03008786
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C33112B2;
	Sun, 14 Jun 2026 21:44:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0266179A3
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 21:44:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473471; cv=none; b=n8fO93Qt4eA/WHxggUT7pSI3uR4ZuFIZmrGElM6AIIFKcORVkpMTtKzYiY4pDvwJh4ah1lcP/z4XjUrKcAZv4aLlJJQj5Fv4k2qGXw4U1dfr8Nw9OrkEKhopJ+DgXb962VOQArfVhk43uZwS9G1aVpU3xJgkFQJCXe6TLuRI0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473471; c=relaxed/simple;
	bh=navlVoBp1kQky6qKHwqTrj7fZXVVpB0aQ4+B0v/QQL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAJBj4A4EfrdkxKhIK0UNqkZnoezopLf5UzOAHe3Pb2uf1g5t3UUug/o3t2kF9dvAFA3U5lXJ/brHVW+49QVB3iJp77USnBEAtkFVHlL3HlBosg+t8Bq+ED5nVuOeqFaydmKWXWFhF4L3R38cXfyRPU+u/KFqPWd7SCR+VysfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ZU1qocWC; arc=none smtp.client-ip=202.108.3.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1781473467;
	bh=MxEzgnVaJJNN8RKQtn+yY2RRWYcWvNqZBHZWDQPhb4o=;
	h=From:Subject:Date:Message-ID;
	b=ZU1qocWCzjeFmg1KejxMtJd5WSAvvMZ4q04Stxw8HID5FH9jjayqAns15y4JALRnV
	 4ySHPRVk9412N9YRvtmQiqHoi1qARLm6Ygk9FrIXAYqW2OF2U8Wn/zHn5a8T5Dj7++
	 kmZ61bqJegcCKH+h5p68mNtrrDzwyAwc0wjM9ygo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A2F2026000049F1; Sun, 15 Jun 2026 05:41:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 6070456685379
X-SMAIL-UIID: 9BEF5C9187CE499A8DE2736CA6569A98-20260615-054159-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com>
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	dhowells@redhat.com,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: avoid filesystem reclaim while holding keyring->sem
Date: Mon, 15 Jun 2026 05:41:49 +0800
Message-ID: <20260614214150.1791-1-hdanton@sina.com>
In-Reply-To: <20260614150041.21172-1-med08elkadiri@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263088-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com,m:med08elkadiri@gmail.com,m:dhowells@redhat.com,m:keyrings@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:stable@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hdanton@sina.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,googlegroups.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[sina.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable,f55b043dacf43776b50c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6BB9682579

> On Sun, 14 Jun 2026 16:00:41 +0100 Mohammed EL Kadiri wrote:
>
#syz test upstream master

__key_link_begin() runs with keyring->sem held and calls
assoc_array_insert(), which does GFP_KERNEL allocations.  Those
allocations may enter filesystem reclaim, evict an fscrypt-protected
inode, and reach keyring_clear() via fscrypt_put_master_key() --
taking a keyring semaphore of the same lockdep class and closing a
keyring->sem -> fs_reclaim -> keyring->sem cycle reported by syzbot.

Wrap the assoc_array_insert() call with memalloc_nofs_save() /
memalloc_nofs_restore() so reclaim cannot recurse into the keys
subsystem while keyring->sem is held.

Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5a9887d6b7be..21bb2e7e7cca 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/sched/mm.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
 #include <keys/keyring-type.h>
@@ -1298,6 +1299,7 @@ int __key_link_begin(struct key *keyring,
 		     struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	unsigned int nofs_flags;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1315,10 +1317,12 @@ int __key_link_begin(struct key *keyring,
 	/* Create an edit script that will insert/replace the key in the
 	 * keyring tree.
 	 */
+	nofs_flags = memalloc_nofs_save();
 	edit = assoc_array_insert(&keyring->keys,
 				  &keyring_assoc_array_ops,
 				  index_key,
 				  NULL);
+	memalloc_nofs_restore(nofs_flags);
 	if (IS_ERR(edit)) {
 		ret = PTR_ERR(edit);
 		goto error;
-- 
2.43.0

