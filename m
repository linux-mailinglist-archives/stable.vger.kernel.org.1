Return-Path: <stable+bounces-194073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811DBC4ACD9
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760A21883EB6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A83081B8;
	Tue, 11 Nov 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y4SYIjDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042725C818;
	Tue, 11 Nov 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824743; cv=none; b=F4cpmfa7u/UfcS9vorcp6OGWkGcpfgXTa+TMx6Gq6vj+rdo01napSuAnq6JYKhzRzgyTYZAM6PxJEhcZKOu9qJ9y9TW3YHaSzKF0haQmv91CaUj/2RpS4EvOXMSyKZoMl5sUr3sNerEVl94BbXYgRvhlXgsSb3Ddnm+IrjWUHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824743; c=relaxed/simple;
	bh=p/DNvw9RD32dbU2ZEvon3hAyV1HJdfbLfY6O0E6Nyww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNv7UmDW3HgDlubRnhBzH+vpvjSjMUmrBPob5QnZEhzvdl1BxOoeLvgschafCrIActesn8zDyStFd9h4oMk2UpfHh61TNZxcaQmfqX5WjOUUXQ1F73n3yLBDgYwYs14syE2qEmlEsFCJSdwKpmcAR8snDGaWfRAiPG9GXAl0NK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y4SYIjDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A8C116B1;
	Tue, 11 Nov 2025 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824743;
	bh=p/DNvw9RD32dbU2ZEvon3hAyV1HJdfbLfY6O0E6Nyww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y4SYIjDeYDJvrH1qnoLcsxpzxyPhZldYuwaIaIal+5xikBKF2gx6XkS/qjdtS0VRz
	 vYS7s7xT+XCXPdJF2XB5TfcaSSgbbRo0g9NrKcZR1m0V5N6RqCmwp7aQyvIxgemldG
	 tOBigqSpfQqHgej1KqfDFkchb9dPWoyxtkm8vtWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 561/849] page_pool: always add GFP_NOWARN for ATOMIC allocations
Date: Tue, 11 Nov 2025 09:42:11 +0900
Message-ID: <20251111004549.976870465@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit f3b52167a0cb23b27414452fbc1278da2ee884fc ]

Driver authors often forget to add GFP_NOWARN for page allocation
from the datapath. This is annoying to users as OOMs are a fact
of life, and we pretty much expect network Rx to hit page allocation
failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
by default.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250912161703.361272-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 19c92aa04e549..e224d2145eed9 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -596,6 +596,12 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	netmem_ref netmem;
 	int i, nr_pages;
 
+	/* Unconditionally set NOWARN if allocating from NAPI.
+	 * Drivers forget to set it, and OOM reports on packet Rx are useless.
+	 */
+	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
+		gfp |= __GFP_NOWARN;
+
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
 		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
-- 
2.51.0




