Return-Path: <stable+bounces-252126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CK2FSX6DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-252126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:15:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E25595A42
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B390F308E1E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F53F20FA;
	Wed, 20 May 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0czACLpp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D717A309;
	Wed, 20 May 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299858; cv=none; b=ADSfTiruqz3Mq1IR9FrLsV4m6s2drdVdoU5W2rD2QE2Ff1Dm4EhZNVG9f1zmnPOuycNd60PZBX1gDlbC4V0PzbRB2PTmO4ywrOxM5mv7Ii/xbnhnvQrtLzK9LDF2cUxdLJcXB8plpEBI5tjtTPsdJKQGSo6UJz0oysdXO5I+XQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299858; c=relaxed/simple;
	bh=/skDmFZ1qWYFSxGbpI4I4nmi+sPkfvLtxf32CHLm4rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBCmjdczKdIEQXQDdsvXrJZRhiFK4AUBNKjyWS1NJ0T/C8FC/RUG4RpBH2i4VQ/u3wYMCWjLqRMbsDJPPbL+neXhK1NLLGkj+cCDr3rV0jP233OVgn1gvfh27PGlEQ4tgr6TVLOTkswN7yYC1dRd/9ZHH6xqUgBZFAxK/5IoNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0czACLpp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFBC1F000E9;
	Wed, 20 May 2026 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299857;
	bh=JFXH5jZeEgdwBR/oWhl8uXGJjFdlE9fUR+wxu5uwiF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0czACLppqF0DdzsLCT/sYXUUv1l+YI2oLHimUNXM7Zi9BYAgpuLOE4Xd6U8gBxvwF
	 LGC+Mip6L3qCDek4wsRv5hV6Dr/BibsYhoebLjOBym/DatV4rTYNh10Ddx2kt/kB3e
	 jHBuKr4es0pmyR9YE0tpTKmXihwvMOjwv/lp7G/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.18 886/957] cgroup/dmem: Return -ENOMEM on failed pool preallocation
Date: Wed, 20 May 2026 18:22:49 +0200
Message-ID: <20260520162153.783298544@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252126-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6E25595A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

commit 796ad622040f7f955ccc3973085e953415920496 upstream.

get_cg_pool_unlocked() handles allocation failures under dmemcg_lock by
dropping the lock, preallocating a pool with GFP_KERNEL, and retrying the
locked lookup and creation path.

If the fallback allocation fails too, pool remains NULL. Since the loop
condition is while (!pool), the function can keep retrying instead of
propagating the allocation failure to the caller.

Set pool to ERR_PTR(-ENOMEM) when the fallback allocation fails so the
loop exits through the existing common return path. The callers already
handle ERR_PTR() from get_cg_pool_unlocked(), so this restores the
expected error path.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Cc: stable@vger.kernel.org # v6.14+
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/dmem.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -602,6 +602,7 @@ get_cg_pool_unlocked(struct dmemcg_state
 				pool = NULL;
 				continue;
 			}
+			pool = ERR_PTR(-ENOMEM);
 		}
 	}
 



