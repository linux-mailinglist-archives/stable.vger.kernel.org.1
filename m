Return-Path: <stable+bounces-44775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14B38C545B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463291F23319
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC785936;
	Tue, 14 May 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dzy/oMfu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260F2D60A;
	Tue, 14 May 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687142; cv=none; b=qMzpNEQShtLQ/dKiTqicdjwGUyP0jz/HYZoQOExTFbCd06eo/zUSibpZGUu08ZTe6jECNGn8p3Akz8je7KtCr11cwo5o8N48p9TQM8U0a691yhcfRbEH0kxoSnzyTZLbF8vqYppH2G2ceoSFeMmR4rQg8TYXLvBHcerQQQ/7hZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687142; c=relaxed/simple;
	bh=xf5lhVBlD8yavVTWwpJAAj+q4rQd19W2JdPF95E+6E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mee816aeyE/aSndjKhSZ560Ap41DmSNsDbv9k6ZgrCaLFfwPIS0KX1Tre0mCxt0O/xBD+qQoellWYxofCCeQ9LjQSnN7+NAUvT4KSNHl6BkD1bOcPJKY7qCfqE3TD6kx3qvlCNLLDGcIgPDVNQhBD2ptcswg8rBQ5QYi2MatCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dzy/oMfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53754C2BD10;
	Tue, 14 May 2024 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687140;
	bh=xf5lhVBlD8yavVTWwpJAAj+q4rQd19W2JdPF95E+6E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzy/oMfuxN6c8ymwpO2jOqsCgcwe+Cw7/B3KUxmzc5lvOye56A/cZe613jv41nClw
	 D4FGR+GaJfddn9ttyeIsXbdHV8hwsS9ZMso/AKXNV7p4uIF55uNYXRLrIHR0vjwxK9
	 nAza59wtbvuWSj0jgoBXhEEZWP7U/xBgW8i4NT0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.4 79/84] net: fix out-of-bounds access in ops_init
Date: Tue, 14 May 2024 12:20:30 +0200
Message-ID: <20240514100954.655053349@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit a26ff37e624d12e28077e5b24d2b264f62764ad6 upstream.

net_alloc_generic is called by net_alloc, which is called without any
locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
is read twice, first to allocate an array, then to set s.len, which is
later used to limit the bounds of the array access.

It is possible that the array is allocated and another thread is
registering a new pernet ops, increments max_gen_ptrs, which is then used
to set s.len with a larger than allocated length for the variable array.

Fix it by reading max_gen_ptrs only once in net_alloc_generic. If
max_gen_ptrs is later incremented, it will be caught in net_assign_generic.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240502132006.3430840-1-cascardo@igalia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net_namespace.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -71,12 +71,15 @@ static unsigned int max_gen_ptrs = INITI
 
 static struct net_generic *net_alloc_generic(void)
 {
+	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
+	unsigned int generic_size;
 	struct net_generic *ng;
-	unsigned int generic_size = offsetof(struct net_generic, ptr[max_gen_ptrs]);
+
+	generic_size = offsetof(struct net_generic, ptr[gen_ptrs]);
 
 	ng = kzalloc(generic_size, GFP_KERNEL);
 	if (ng)
-		ng->s.len = max_gen_ptrs;
+		ng->s.len = gen_ptrs;
 
 	return ng;
 }
@@ -1231,7 +1234,11 @@ static int register_pernet_operations(st
 		if (error < 0)
 			return error;
 		*ops->id = error;
-		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
+		/* This does not require READ_ONCE as writers already hold
+		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
+		 * net_alloc_generic.
+		 */
+		WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1));
 	}
 	error = __register_pernet_operations(list, ops);
 	if (error) {



