Return-Path: <stable+bounces-36060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C938999B5
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FCC1F23BAE
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBC1607B0;
	Fri,  5 Apr 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZe7j3GX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE5160784
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309957; cv=none; b=rnGk/linhBoJPk10RInv0dzqafp2T0eFRYINHaMXyf+8Wvdr3eR6PcMT7ihSHV9HnTc4wRgLq04AZOz5pgEj0vjL8gBDiWfX4WKZhhNrCmQDtaJ/uIM1TWjZK+8Y7OTNvwsLp2pWkgVflGR/UzMPptnvBTVEMzaavqqWxpRudcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309957; c=relaxed/simple;
	bh=3rwBhQkPjfx/WCPrKUlUYBM6IXXbba0G236hTBbtd+8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E3Rme0LVU71GrV4ASETvCfPIESOj3C3qHNSEAmUkYFaqe7V0s9riclQ8KyWxiTsP+CH1f4T0qFAo+zTr31aMC5SgXuZCfuxzNUgR0HRs2bI3/TZEK5jZBxJD5zuaBqDLguI1NkrZebeVBRUsYqUIJOdhZopxmqlIcCUqzScoHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZe7j3GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB99C433C7;
	Fri,  5 Apr 2024 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309956;
	bh=3rwBhQkPjfx/WCPrKUlUYBM6IXXbba0G236hTBbtd+8=;
	h=Subject:To:Cc:From:Date:From;
	b=bZe7j3GXcUxzgLeHHsW3elEM1L9cssZGBWnZWOHRh3gV5RZEqjEpj0Y5IYs7j3Tf6
	 xXjQHNAIQV5QqIoysM3gzH0AYxGSVx1vhDGAORXF8aMkAWVLji7Sy+zQIE4ltkGUn3
	 GBP6IYqjjbKjP22tOt7UrJQxB6GB7AgBvY5DqTJ0=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: discard table flag update with pending" failed to apply to 6.1-stable tree
To: pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 11:39:13 +0200
Message-ID: <2024040513-slimness-statistic-1bd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1bc83a019bbe268be3526406245ec28c2458a518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040513-slimness-statistic-1bd4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bc83a019bbe268be3526406245ec28c2458a518 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Wed, 3 Apr 2024 19:35:30 +0200
Subject: [PATCH] netfilter: nf_tables: discard table flag update with pending
 basechain deletion

Hook unregistration is deferred to the commit phase, same occurs with
hook updates triggered by the table dormant flag. When both commands are
combined, this results in deleting a basechain while leaving its hook
still registered in the core.

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e02d0ae4f436..d89d77946719 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1209,10 +1209,11 @@ static bool nft_table_pending_update(const struct nft_ctx *ctx)
 		return true;
 
 	list_for_each_entry(trans, &nft_net->commit_list, list) {
-		if ((trans->msg_type == NFT_MSG_NEWCHAIN ||
-		     trans->msg_type == NFT_MSG_DELCHAIN) &&
-		    trans->ctx.table == ctx->table &&
-		    nft_trans_chain_update(trans))
+		if (trans->ctx.table == ctx->table &&
+		    ((trans->msg_type == NFT_MSG_NEWCHAIN &&
+		      nft_trans_chain_update(trans)) ||
+		     (trans->msg_type == NFT_MSG_DELCHAIN &&
+		      nft_is_base_chain(trans->ctx.chain))))
 			return true;
 	}
 


