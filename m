Return-Path: <stable+bounces-239578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJMjLN5l5mmJvwEAu9opvQ
	(envelope-from <stable+bounces-239578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08312431F12
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4A435C89F3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF119331A78;
	Mon, 20 Apr 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATUKXnRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131B329E44;
	Mon, 20 Apr 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700612; cv=none; b=pFOcXkkLyMgbAQEllfcyio5tto28g4GsHtGJd0lPlhvdUDH0nTcXYKNv93TlDApf9nYoV/9rD/EANsceLrB8JgqZlWj+kIZja7Zn5Vxpv4TbarMslCP3FP48Po3yy8TDQZcLxylShoboK2zLZB2qPcz/actIHh+tRpUtHp+M044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700612; c=relaxed/simple;
	bh=D8e9kQbfn1xBlSEgT4o3CxwCLnwbwNqWUimBbirUt8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZowomP9KPNQxwE2OM6fyu76/hX7B4cBo04hEgwZiB2NFuzDmQGaCq0ltnL5vdbFT8cdyc5dP8wsXUMzQEDtHZyXn2Hog1aTY00myyOqIGpxZlcSfw84kLdWIixFhGktMLo6E+E26RiwbkyHDT7nXy39WxtmodDn/FzUXJX6Nhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATUKXnRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E47C2BCB4;
	Mon, 20 Apr 2026 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700612;
	bh=D8e9kQbfn1xBlSEgT4o3CxwCLnwbwNqWUimBbirUt8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATUKXnRn8UANYI3NMhNaJXZd2O13tG8F8OLdrGsX/EeHeaAdLjw88LQPuQ847UV07
	 nIkO0bK0JBY+pBVJ2xblFe5bSCYPfuWCAs79t/qK5r36jHTeHQVCctbw4E2L/nJInZ
	 1EYCBid5Fr2iP1ZTgbOsgDMbryqf/C8K/0k16miI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 002/198] RDMA/irdma: Fix double free related to rereg_user_mr
Date: Mon, 20 Apr 2026 17:39:41 +0200
Message-ID: <20260420153935.698653744@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239578-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08312431F12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 29a3edd7004bb635d299fb9bc6f0ea4ef13ed5a2 ]

If IB_MR_REREG_TRANS is set during rereg_user_mr, the
umem will be released and a new one will be allocated
in irdma_rereg_mr_trans. If any step of irdma_rereg_mr_trans
fails after the new umem is allocated, it releases the umem,
but does not set iwmr->region to NULL. The problem is that
this failure is propagated to the user, who will then call
ibv_dereg_mr (as they should). Then, the dereg_mr path will
see a non-NULL umem and attempt to call ib_umem_release again.

Fix this by setting iwmr->region to NULL after ib_umem_release.

Fixed: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260227152743.1183388-1-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c77d6d0eafdec..c399aa07bcae8 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3714,6 +3714,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 
 err:
 	ib_umem_release(region);
+	iwmr->region = NULL;
 	return err;
 }
 
-- 
2.53.0




