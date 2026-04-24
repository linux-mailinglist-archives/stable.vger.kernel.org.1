Return-Path: <stable+bounces-240793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A9VME9y62nmMwAAu9opvQ
	(envelope-from <stable+bounces-240793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D468E45F45E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7E35300D556
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F53D75C6;
	Fri, 24 Apr 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BAuq7uMG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9B3D6CA9;
	Fri, 24 Apr 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037854; cv=none; b=H5VW4Kup4h0CE+ix0jOKuJo0wCy1m3yfW7rs79w5GGkEGq8zAL6t+8kiGySKeKvHG7qA5u3t7CGWv5xW5ERgveLrmVxDtZB7Ir58oTBwIovfmYKwxsultcyVzNUhEscCgFc2HIcp/R3Y4k6EhopKpXkq/N3zdcET8YFDtAgkCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037854; c=relaxed/simple;
	bh=5E586SAgiKAnWcG6tYUnUwosjJG1rMyPlf7y1JmEkD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+vIDGZV8xMK2ZoOSOssVrJUOhWEpDXejY8HD5kByLxllyCcglhXUMtynTLuOEnIA8L/IaSkhfusYGDM36t5YfWchh9toM2h5Bx1RJldFpOWfO9DrZ11c3u+HR57jLrXYTIqxcjD+cBYqFjzE5cjBNpaxX21SBlhsyvHjzrVYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BAuq7uMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A06C19425;
	Fri, 24 Apr 2026 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037854;
	bh=5E586SAgiKAnWcG6tYUnUwosjJG1rMyPlf7y1JmEkD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAuq7uMGiRpFFiefnc8ZDtG+4kiOqImJ4L3e5GiO017Nwx9A7WVqfnFEgyitTwHDL
	 FRT+PMGUhTcoY5mPmqSjDdFvmiigsT+qcX79L6MO6AgwW8mK4hDznMeBrICVESaiET
	 +aXyThqKNWV2hPdAVLYRDJlSsZUyjlvn0i1t9Il0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Yang Erkun <yangerkun@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 096/166] dcache: Limit the minimal number of bucket to two
Date: Fri, 24 Apr 2026 15:30:10 +0200
Message-ID: <20260424132552.786451080@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D468E45F45E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240793-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3296,7 +3296,7 @@ static void __init dcache_init_early(voi
 					HASH_EARLY | HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 }
@@ -3324,7 +3324,7 @@ static void __init dcache_init(void)
 					HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 }



