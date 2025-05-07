Return-Path: <stable+bounces-142763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60CAAED5A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 22:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EDB1BC41A1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5651628FAAB;
	Wed,  7 May 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmO5wMf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623B28FA9A;
	Wed,  7 May 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650876; cv=none; b=YQ64Pmbw9Ot1yAdoh+nsgnQrBOQTeg+acr+sbA1pXNt5ginPe8DSZRlij0bMwXZNDwoTThZuJ46BfWk9AWCNUBfBiPAkes8Ne5FOj74y4wxwub22Ca/iVlV4KX9WquOlzk/5/Tu1O4YCnHuX54AaGDo/iFa5aOPThGIYZF2hJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650876; c=relaxed/simple;
	bh=ErbIIg8tFdaFpJqMqrCwmVzq5QfpdM9matIuxyQO7IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HuslQsrBQnzxbUjoQ6TmF/siqeHJH+ijmU3rO0m0sD3egjJMuGUlhjtWSaTVAAT0msE38Ic2yKUiu9hNetpRsUuo3rTc8LhguBYOpTIRoJxKa6lVKZu19EnTiRQswd0HcsQ/VDfa+Bx8smKy3Db3zK7lmU2FgMt4hPynYDYItHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmO5wMf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF80AC4CEE7;
	Wed,  7 May 2025 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746650875;
	bh=ErbIIg8tFdaFpJqMqrCwmVzq5QfpdM9matIuxyQO7IU=;
	h=From:Date:Subject:To:Cc:From;
	b=SmO5wMf20L521OhV4fbfgBID3lGNlu/rTKRiN574Gcs4ADnbwRsoScZzUzZYPMSMp
	 AY2M2tfmSxIzFLr5qJywqkNxlDGFWVU4UG8/TUT/ucqH4JzP/1GUbVN5aGFewKXJh9
	 uVBbTlfopPuDuGz66M86xbGonMjd9qdKjk+A320+g49z98cIbNzH3gcp40Knkb0+dd
	 9XfmBdEvwJRqgYclSMLrG6SHpUh/dWoXlxlQeqwQ1Z52J60avek9xWn4ZTyTxuK9yK
	 +kBN/VfW6PDtD2Ep0CGKRAnY8bVlDXqCOSu9upGis0sm+5WuHl/QDASQjZoIfkmU+j
	 08uWc7+cI5+4Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 May 2025 21:47:45 +0100
Subject: [PATCH net] net: qede: Initialize qede_ll_ops with designated
 initializer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-qede-fix-clang-randstruct-v1-1-5ccc15626fba@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPDGG2gC/x2MQQqEMAxFryJZT6AqRcerDLPQNGpAOk5aRRDvb
 nD5+O+/ExKrcIKuOEF5lyS/aFC+CqC5jxOjBGOoXOWddw3+OTCOciAtNqP2MaSsG2Us69CSf9c
 0+Bbsvyqb97Q/EDnD97puhzeF7XAAAAA=
X-Change-ID: 20250507-qede-fix-clang-randstruct-13d8c593cb58
To: Manish Chopra <manishc@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ErbIIg8tFdaFpJqMqrCwmVzq5QfpdM9matIuxyQO7IU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnSx35cjmb/GXoui+vDpzDlY38mXClU/MsUuricIWrb5
 riFzVvfdZSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJGM9mZNjy6vqtDRNKinha
 dkvdOpSbkMEdV2X7RPZiWrb68YLp8XEM/1MWz7FdWPH987GdF9u33eAtTZVbVvrBeIbFI09WnZh
 n7/gB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

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
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

---
base-commit: 9540984da649d46f699c47f28c68bbd3c9d99e4c
change-id: 20250507-qede-fix-clang-randstruct-13d8c593cb58

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


