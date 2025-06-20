Return-Path: <stable+bounces-154938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBFAE1503
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6482519E3524
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49D1F8756;
	Fri, 20 Jun 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EAtwj0t7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8B17583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404864; cv=none; b=eQ+3HqHNMjuVqemb5DV8aj3N+wtwcMflL/ukimWfk9AekgMT4b954xTrrW3s/0ObQEmjRtR3i4yr1eN7WTK8Otsv1CMFSCGflERLfCUBFrJXHOUYvKLqxD3v5E5EUZ4bDtwskmr5DNXDjuh3+M/FoS6C8ZNQ16Xf1f7eItIbaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404864; c=relaxed/simple;
	bh=4RTkLO3U+4GTb5lGYIRhuvHp+ici1scLvuswERWZ/aA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ONP2zZlBbH3AJj+NBX3UoickJVebm8dSpDGlm3xYO8gt40Apd7MyQl+HVqINk7u/9DMkprcmyCwxj6LB/CEJziIBTcQFPlQur7YJMTn6el20oZl9HVoNAOIc8jMVUdJMQw2vx9nt5erMLg+bK7IKNRvG8r5Op79ddeBHT0GuD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EAtwj0t7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A936C4CEE3;
	Fri, 20 Jun 2025 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750404863;
	bh=4RTkLO3U+4GTb5lGYIRhuvHp+ici1scLvuswERWZ/aA=;
	h=Subject:To:Cc:From:Date:From;
	b=EAtwj0t7L205kLynL9lTj5/yed4XZeVhYnr1vNChWf9RvUVVkRGTFV5yJWEaZVrJX
	 1cTIf7g1qU5/fc0trMDqmglNnBYfGyCJxUeu3soCKRrqyJlndrCDmX5mKak3iIMrz2
	 Oyt3BNNsWCbFOasZbAKJN98i9i2aE/bhWzkBSXvg=
Subject: FAILED: patch "[PATCH] net: qede: Initialize qede_ll_ops with designated initializer" failed to apply to 6.15-stable tree
To: nathan@kernel.org,kees@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:34:21 +0200
Message-ID: <2025062020-pumice-wad-3173@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 960013ec5b5e86c2c096e79ce6e08bce970650b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062020-pumice-wad-3173@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 960013ec5b5e86c2c096e79ce6e08bce970650b3 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 7 May 2025 21:47:45 +0100
Subject: [PATCH] net: qede: Initialize qede_ll_ops with designated initializer

After a recent change [1] in clang's randstruct implementation to
randomize structures that only contain function pointers, there is an
error because qede_ll_ops get randomized but does not use a designated
initializer for the first member:

  drivers/net/ethernet/qlogic/qede/qede_main.c:206:2: error: a randomized struct can only be initialized with a designated initializer
    206 |         {
        |         ^

Explicitly initialize the common member using a designated initializer
to fix the build.

Cc: stable@vger.kernel.org
Fixes: 035f7f87b729 ("randstruct: Enable Clang support")
Link: https://github.com/llvm/llvm-project/commit/04364fb888eea6db9811510607bed4b200bcb082 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250507-qede-fix-clang-randstruct-v1-1-5ccc15626fba@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 99df00c30b8c..b5d744d2586f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -203,7 +203,7 @@ static struct pci_driver qede_pci_driver = {
 };
 
 static struct qed_eth_cb_ops qede_ll_ops = {
-	{
+	.common = {
 #ifdef CONFIG_RFS_ACCEL
 		.arfs_filter_op = qede_arfs_filter_op,
 #endif


