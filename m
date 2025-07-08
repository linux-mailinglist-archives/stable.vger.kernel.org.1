Return-Path: <stable+bounces-160605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD478AFD0E9
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4257A73F8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31932E0910;
	Tue,  8 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCd1xtZu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B42367CE;
	Tue,  8 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992145; cv=none; b=K/oFt215mIpN0hJjxvVATYolOlIboA9PJXwM3b64CNkZSUpVDlBA9OStHXu1e/elN/rOuSvaYLAhjPNMg/FLyvXJQKtgztoA0nKs5IX0C9i7xlrH09dypCTzc3pz3L/CVYVmHCykmUu5B/EE9xUXYpPlr1uESMqnQ7EC9kCaemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992145; c=relaxed/simple;
	bh=GiJoZJQeyZcb8COJvylYABlSjqtX65B83yaXQ6kFPkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXwsWBSJPNVbbO71h0OF1+/JQgUStJSopAUlCzPtv92y1Z0rQwV5cQlDHHVuO70DXUcWTaRpYLh96qLXOzW15D5GvheuwB0cwT3WZp4Tl0N84XZqWySpnxLpLUVc3X1Lh6xStkLNyr5OdBqOgK12KLq3l+wYbfY5izG2hlRdUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCd1xtZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA52CC4CEED;
	Tue,  8 Jul 2025 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992145;
	bh=GiJoZJQeyZcb8COJvylYABlSjqtX65B83yaXQ6kFPkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wCd1xtZuT4REzmRg6U0jelbVN3K4RQoTZfw6puQf6oFtm0/apZJhxjRTZ8E+ajx6H
	 9HtEqtlolv0XoZLboFW+DdxE5ERoRVuuxCyraKCLDxZ80TSd2XOpeNmPT4u9d/F3B7
	 1cWTeJ31XhBVZZPWk5oVVIY3dCPY3CdAuXIGteyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.1 72/81] dma-buf: fix timeout handling in dma_resv_wait_timeout v2
Date: Tue,  8 Jul 2025 18:24:04 +0200
Message-ID: <20250708162227.236971544@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 2b95a7db6e0f75587bffddbb490399cbb87e4985 upstream.

Even the kerneldoc says that with a zero timeout the function should not
wait for anything, but still return 1 to indicate that the fences are
signaled now.

Unfortunately that isn't what was implemented, instead of only returning
1 we also waited for at least one jiffies.

Fix that by adjusting the handling to what the function is actually
documented to do.

v2: improve code readability

Reported-by: Marek Olšák <marek.olsak@amd.com>
Reported-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20250129105841.1806-1-christian.koenig@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma-buf/dma-resv.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -673,11 +673,13 @@ long dma_resv_wait_timeout(struct dma_re
 	dma_resv_iter_begin(&cursor, obj, usage);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
 
-		ret = dma_fence_wait_timeout(fence, intr, ret);
-		if (ret <= 0) {
-			dma_resv_iter_end(&cursor);
-			return ret;
-		}
+		ret = dma_fence_wait_timeout(fence, intr, timeout);
+		if (ret <= 0)
+			break;
+
+		/* Even for zero timeout the return value is 1 */
+		if (timeout)
+			timeout = ret;
 	}
 	dma_resv_iter_end(&cursor);
 



