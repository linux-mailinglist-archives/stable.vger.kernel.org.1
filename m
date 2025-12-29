Return-Path: <stable+bounces-203640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B294CE71C8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F193017661
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414AD3246F2;
	Mon, 29 Dec 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPmrd+ry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DF3242C3
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019428; cv=none; b=Oa3r4jlf1fvle8YESoVvtKbaI1zijCFdQYZpNFWwBDlYOyhYJAd3RJm62fxtvGWXAbf/2kfdlskk+aVOLZEY0BngY90dxnBuS4EJiv1R6FYdkhji1+qgGNX1s7bFz9/D1GuYYfjbdpTs0CxmtkXGKUjOOwNq36ioCZNzZR74f1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019428; c=relaxed/simple;
	bh=mynKl1AMiYh09KKHp42GI2gTT993uYa4XwPAvDRbnHI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=USVqYNCJh2TzXlkpiUW0Jzd7Pi0M9Dm/anZg2uyx/Ec4gqafHfYVGGPLuVh70uxFhbUYlRASRvHr9+miOAkQlTxqlhfwyfpbwGABrBaB13k5GFY6zg4CJ1rhUdKvPi+cLaJK/TDpQ87KFzrFhlye7l7VdmTbPvnkOz1zmYvgNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPmrd+ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4071FC4CEF7;
	Mon, 29 Dec 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767019426;
	bh=mynKl1AMiYh09KKHp42GI2gTT993uYa4XwPAvDRbnHI=;
	h=Subject:To:Cc:From:Date:From;
	b=CPmrd+rytgzeygSRBQNp5lADO/dwLAZCy9clL3veSGD4ptCFyDyhdoGGKWl2vbvIO
	 pIqcagJI/pcEtoegqGY4tAsbHhVtp6vxcuyeIZI6QIXn5TktsTJzcnKc2ZSpjh/DGJ
	 J8SwzikwolS0t+MHP/z0V22Acw4/2KZNVIJ1GYkg=
Subject: FAILED: patch "[PATCH] svcrdma: bound check rq_pages index in inline path" failed to apply to 6.12-stable tree
To: linux@joshua.hu,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:43:44 +0100
Message-ID: <2025122943-program-skipper-de04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d1bea0ce35b6095544ee82bb54156fc62c067e58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122943-program-skipper-de04@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1bea0ce35b6095544ee82bb54156fc62c067e58 Mon Sep 17 00:00:00 2001
From: Joshua Rogers <linux@joshua.hu>
Date: Fri, 7 Nov 2025 10:09:49 -0500
Subject: [PATCH] svcrdma: bound check rq_pages index in inline path

svc_rdma_copy_inline_range indexed rqstp->rq_pages[rc_curpage] without
verifying rc_curpage stays within the allocated page array. Add guards
before the first use and after advancing to a new page.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e813e5463352..310de7a80be5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -841,6 +841,9 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (head->rc_curpage >= rqstp->rq_maxpages)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - head->rc_pageoff);
 


