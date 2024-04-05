Return-Path: <stable+bounces-36063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D68999BB
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F6D1F23FD2
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E1160794;
	Fri,  5 Apr 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQppCwfh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875F15FA9C
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309971; cv=none; b=lYNkvODHauXQt5UqRAzU1mbpsYHaVenuqhREk64qhVA/S5YR0F5HZrczuKwj36y0oOsoQk9adZE57/o76vLrHw42dVBfkVBLHIiPpNbZEtcIkAIVLitIFN2e1yTrTpVqQlRJmLnU+N3fb28OcBv7So69Z04VEyKsOOIfB7vngSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309971; c=relaxed/simple;
	bh=Wdv8FVjjs5gbPrafgx0JPvVtFBi35EoAmlRzaz1sjSA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r0mlpJKCUQe8yZ0UtkipEe6GN9K8FAMNinRCpF/r0XS2JqW8bMRoznR2ddw4i0un8rbR13bSyhkO3rNm7xsDLYe1UcJFgzzEiV/wT86jLk6pZ7oja4Ko9HbFUFwjiRGjhJpPMzO+5eFOCJfYLNrZJEXE3yQdqdmA+mlYJPtdozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQppCwfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE216C433F1;
	Fri,  5 Apr 2024 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309971;
	bh=Wdv8FVjjs5gbPrafgx0JPvVtFBi35EoAmlRzaz1sjSA=;
	h=Subject:To:Cc:From:Date:From;
	b=JQppCwfhST70iA+vvax0mswCb6fBnihWHrpC6xB0bcYqWo3Rps7StNirU/WR3wOLU
	 hbH4q5sXk7uv9KUg7iqyM2Yr1znTWHPq5YJCBElKXnV56m61VZhv+Pbb3JnKItUdsd
	 1yxM6O7bJkgOaSV7eNUosgiiyTmR0CFSEdlPQDNs=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: discard table flag update with pending" failed to apply to 5.10-stable tree
To: pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 11:39:15 +0200
Message-ID: <2024040515-chatroom-cathedral-e974@gregkh>
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
git cherry-pick -x 1bc83a019bbe268be3526406245ec28c2458a518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040515-chatroom-cathedral-e974@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


