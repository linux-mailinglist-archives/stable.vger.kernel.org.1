Return-Path: <stable+bounces-154939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F253AE1504
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0588519E3534
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9B41F8756;
	Fri, 20 Jun 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LSLvQtCe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C617583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404873; cv=none; b=Agg3DZUrfHk+7NiwR0sETvPt7vphgrrK5ZlQ5CsWtyceVZca6rX98MaHqBkZOaQFnqfP85msKIEPWXftVA6PKeGIj9bENN81/gQYEl/PTv1jZE2ADKGEG0rCg+fxWRC5rILaPbQIjpc1jzkZDZLtIY2IZHX+GRg+ONKxulz9Yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404873; c=relaxed/simple;
	bh=xOC4oKT8xKsttSxXBg/v5jVfROO/xcGB7rs7P9jo1Fo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mrqVbwrzctlR4thQ9EZwoTfD1M3/5bAUtxwIZF02ZHCkBElL7vZxGTpg1ICFURS6SKM1j9JKt7MM9mvWlnerq0Lc0smmiOTt2ttfb08ARGWkvn/E1dSOhg/zN5BkKonB5wd6zdYGVV4GKhWMRov73qRar9CimK7fM4XrdjEkNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LSLvQtCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2995EC4CEE3;
	Fri, 20 Jun 2025 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750404872;
	bh=xOC4oKT8xKsttSxXBg/v5jVfROO/xcGB7rs7P9jo1Fo=;
	h=Subject:To:Cc:From:Date:From;
	b=LSLvQtCeQ+CVgWQ5Yf5347GCTVl9MS9gjWRzUW/qDZmEjvIIPXNJnqIXMAYTUfcIy
	 rszv/bDOOJADGPBVZk3dBujHk8TfXc0BaaynmjYAPKEhUdQa2HiQTy9RyB83HnTUYQ
	 aUUPZ9BRY7NH08EGNoN0sTwFKKnBDNIg5hy/tXgE=
Subject: FAILED: patch "[PATCH] net: qede: Initialize qede_ll_ops with designated initializer" failed to apply to 6.12-stable tree
To: nathan@kernel.org,kees@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:34:21 +0200
Message-ID: <2025062021-jump-puppet-aa00@gregkh>
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
git cherry-pick -x 960013ec5b5e86c2c096e79ce6e08bce970650b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062021-jump-puppet-aa00@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


