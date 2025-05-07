Return-Path: <stable+bounces-142278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587DAAE9F4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED964C4265
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57D2144CC;
	Wed,  7 May 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wt21hz+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0471DDC23;
	Wed,  7 May 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643763; cv=none; b=cOvP24Mi7spyyJ4dCT9HzuduTK2xNj3AVKaUB9QPznc2NY2EGVe2sLB26u6aBdQs4KwJ9+WUoKc+a3IkCwi6iEmZPYegvK2Isba/zrHpsLCiZFp175lVfNUCMDIHdQxHd6859K02/pP04dOZT6Cf4AdQnpiy6uB3PscrtQ98CvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643763; c=relaxed/simple;
	bh=lJ9S3oYh3v6h4NS1vrQ/rxXAhN9Epn+BKss9W/C9gbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo0rkSJ+eJgMS6gZFon9g9Lt+98h0itRFGFBHxiDpJKo9pTarApRCa0McT6ltmd+HYPPH2ZS8BX8ilEvpi8iUOgrqT6buTStHoDZl14IAbUxudnRWL4oNS6MwanWnBcKFoXZup88rc4nuX6BDVN3Ig8Kiya6+zePkhf5750VccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wt21hz+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982BFC4CEE2;
	Wed,  7 May 2025 18:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643763;
	bh=lJ9S3oYh3v6h4NS1vrQ/rxXAhN9Epn+BKss9W/C9gbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wt21hz+YqH42LOPKo8Hl7oW0UDRcsLdj55n7Mrji7y4OqRcShcoEb5Kl+oMEL6FE4
	 5vIGF5xp24nNh58V3b3m+I0BF11dEFLBgFa9ojtQ6SjBbVioQne3+XBaVSjhIrEv6q
	 4tMTrVzHZWRAA4hN6c6ajRb5MojtR8E4fTjozUmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.14 010/183] drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()
Date: Wed,  7 May 2025 20:37:35 +0200
Message-ID: <20250507183825.112259693@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Stanner <phasta@kernel.org>

commit bbe5679f30d7690a9b6838a583b9690ea73fe0e9 upstream.

Nouveau is mostly designed in a way that it's expected that fences only
ever get signaled through nouveau_fence_signal(). However, in at least
one other place, nouveau_fence_done(), can signal fences, too. If that
happens (race) a signaled fence remains in the pending list for a while,
until it gets removed by nouveau_fence_update().

Should nouveau_fence_context_kill() run in the meantime, this would be
a bug because the function would attempt to set an error code on an
already signaled fence.

Have nouveau_fence_context_kill() check for a fence being signaled.

Cc: stable@vger.kernel.org # v5.10+
Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://lore.kernel.org/r/20250415121900.55719-3-phasta@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -90,7 +90,7 @@ nouveau_fence_context_kill(struct nouvea
 	while (!list_empty(&fctx->pending)) {
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 
-		if (error)
+		if (error && !dma_fence_is_signaled_locked(&fence->base))
 			dma_fence_set_error(&fence->base, error);
 
 		if (nouveau_fence_signal(fence))



