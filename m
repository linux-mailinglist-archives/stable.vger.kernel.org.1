Return-Path: <stable+bounces-36040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35989965C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD76B21F60
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864926AFD;
	Fri,  5 Apr 2024 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvyO2mNI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228322F0C
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301328; cv=none; b=b7JZguOywF6zt/eT0svxpo9lPOZ46oK8g3m+fyjjShqrGWwJNBFs6Q+qV+Xeyp9TJHBdxp72a8Ri1R2qBtbyntbGCvtHrhUfppT07OdnuR0rokS4y2x4cUlxSWbT6TtRpfgBwzLzHgl/mxoRjbnBZLmbJFN/xy2UcS08G5COQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301328; c=relaxed/simple;
	bh=CCE4C0OlwBPz/orn6aY3usJBbNVsMQTLxL3VS4ljhDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AVOiVHK9Aur0wJBjdw4Cf9LXY3y2QQs09IxXSFbIlMHB5S5aOy/si4ePKMW8Qq7TovH1opQ9OLsnuNbuYkfxVn5jWmcFH7DIL4x0ec7CJM8wingkJqckSNvVojJErBxH0mGv42H1a5ePMHvAPE7jyHA956+NX567NXPxSBog5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvyO2mNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF3C433F1;
	Fri,  5 Apr 2024 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712301328;
	bh=CCE4C0OlwBPz/orn6aY3usJBbNVsMQTLxL3VS4ljhDo=;
	h=Subject:To:Cc:From:Date:From;
	b=gvyO2mNI6W/2lbmt7YcMZn7n2PIk+8bmxbPST1OAgYhRoJO82UAMSFFBbUCiVXtrl
	 bZhP5aDmyhMYpcIc98VXj39cv8hTnre3gCtvYo5tLq5vrP6qmAu//k2lmaP5zYWGBJ
	 mw40Ju2uiAsEdPTlyJ3xcvf+eP8CHkYkJfpFA9uc=
Subject: FAILED: patch "[PATCH] xen-netfront: Add missing skb_mark_for_recycle" failed to apply to 5.10-stable tree
To: hawk@kernel.org,artafinde@archlinux.com,arthurborsboom@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 09:15:25 +0200
Message-ID: <2024040525-mousy-reclining-38e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 037965402a010898d34f4e35327d22c0a95cd51f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040525-mousy-reclining-38e6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 037965402a010898d34f4e35327d22c0a95cd51f Mon Sep 17 00:00:00 2001
From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Wed, 27 Mar 2024 13:14:56 +0100
Subject: [PATCH] xen-netfront: Add missing skb_mark_for_recycle

Notice that skb_mark_for_recycle() is introduced later than fixes tag in
commit 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").

It is believed that fixes tag were missing a call to page_pool_release_page()
between v5.9 to v5.14, after which is should have used skb_mark_for_recycle().
Since v6.6 the call page_pool_release_page() were removed (in
commit 535b9c61bdef ("net: page_pool: hide page_pool_release_page()")
and remaining callers converted (in commit 6bfef2ec0172 ("Merge branch
'net-page_pool-remove-page_pool_release_page'")).

This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool: catch
page_pool memory leaks").

Cc: stable@vger.kernel.org
Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Reported-by: Leonidas Spyropoulos <artafinde@archlinux.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218654
Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/r/171154167446.2671062.9127105384591237363.stgit@firesoul
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index ad29f370034e..8d2aee88526c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
 		return NULL;
 	}
 	skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
+	skb_mark_for_recycle(skb);
 
 	/* Align ip header to a 16 bytes boundary */
 	skb_reserve(skb, NET_IP_ALIGN);


