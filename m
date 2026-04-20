Return-Path: <stable+bounces-239301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJEhDhhj5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:32:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A14634315EA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7082C34F8348
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789733C532;
	Mon, 20 Apr 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fscFNvs4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B226337699;
	Mon, 20 Apr 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699898; cv=none; b=K6nBDm4nf41f16RP/KnSNcmEbv7eknTvoYqX2oBbsMHUhp92tj0XhoybnwKgLm1m9DJgAHqQMoChOzG0YwD53IKTXvcz+S8/yZG/fjrUL/pZyGTpGYFQ6jkcY+UVT7Z/4NjpiHOR6V+PTj/C3znbar+LsRNcQrhY4DvBa5sUo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699898; c=relaxed/simple;
	bh=ntAkQS5/+gWhrEvPX8V6cAgaMFz7+luX9hXGQNcgRZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg63Ze6w/V+XdekDp2jt9FV7BhlepMcxrqgWZaU35bMV0YJKYxK5Er458pWb8oJjlG5IT+DkJYC4YuEdyZ4gOYDGx4WCw3Soa0z9/0YD1wSTfrqBVgkc/a5lEOjz/NfhTETJ8oPJkTFew38mnbQ4G9OxBotnKqACWM+Wn36buQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fscFNvs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31926C2BCB6;
	Mon, 20 Apr 2026 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699898;
	bh=ntAkQS5/+gWhrEvPX8V6cAgaMFz7+luX9hXGQNcgRZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fscFNvs4Lq+ngatAnnfAxUCRGRQqi0vE/v24QfucpzbUpcvz0um36tWKwAG61tcms
	 FS8plDFVH1p7R+DQ6zs7XITJ4FN3nQBvBktU7Pm/+iQ8laEgwTL9hIH2NfSH5skWVR
	 9VK6VxFMrhEqYtDpHx8j0AkrF1dJvpU4eEpafuv8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Yang Erkun <yangerkun@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 7.0 41/76] dcache: Limit the minimal number of bucket to two
Date: Mon, 20 Apr 2026 17:41:52 +0200
Message-ID: <20260420153912.322425193@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239301-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: A14634315EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit f08fe8891c3eeb63b73f9f1f6d97aa629c821579 upstream.

There is an OOB read problem on dentry_hashtable when user sets
'dhash_entries=1':
  BUG: unable to handle page fault for address: ffff888b30b774b0
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP PTI
  RIP: 0010:__d_lookup+0x56/0x120
   Call Trace:
    d_lookup.cold+0x16/0x5d
    lookup_dcache+0x27/0xf0
    lookup_one_qstr_excl+0x2a/0x180
    start_dirop+0x55/0xa0
    simple_start_creating+0x8d/0xa0
    debugfs_start_creating+0x8c/0x180
    debugfs_create_dir+0x1d/0x1c0
    pinctrl_init+0x6d/0x140
    do_one_initcall+0x6d/0x3d0
    kernel_init_freeable+0x39f/0x460
    kernel_init+0x2a/0x260

There will be only one bucket in dentry_hashtable when dhash_entries is
set as one, and d_hash_shift is calculated as 32 by dcache_init(). Then,
following process will access more than one buckets(which memory region
is not allocated) in dentry_hashtable:
 d_lookup
  b = d_hash(hash)
    dentry_hashtable + ((u32)hashlen >> d_hash_shift)
    // The C standard defines the behavior of right shift amounts
    // exceeding the bit width of the operand as undefined. The
    // result of '(u32)hashlen >> d_hash_shift' becomes 'hashlen',
    // so 'b' will point to an unallocated memory region.
  hlist_bl_for_each_entry_rcu(b)
   hlist_bl_first_rcu(head)
    h->first  // read OOB!

Fix it by limiting the minimal number of dentry_hashtable bucket to two,
so that 'd_hash_shift' won't exceeds the bit width of type u32.

Cc: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Link: https://patch.msgid.link/20260130034853.215819-1-chengzhihao1@huawei.com
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dcache.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3257,7 +3257,7 @@ static void __init dcache_init_early(voi
 					HASH_EARLY | HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 
@@ -3289,7 +3289,7 @@ static void __init dcache_init(void)
 					HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 



