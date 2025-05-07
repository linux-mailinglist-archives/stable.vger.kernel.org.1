Return-Path: <stable+bounces-142759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0EAAECBC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AC5506907
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB21CAA87;
	Wed,  7 May 2025 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpN3QFBC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90614207A
	for <stable@vger.kernel.org>; Wed,  7 May 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648915; cv=none; b=E0HUyN0uNJeurIl8iQGBniiKXcMusZoldVmS+2kLtKUkqEM/3WsqApf9epwMKcEDBhsu9/xcgepiZxxfiQZpSLs/9c0e8AMP7/x32Y3Ajy3e7oDUF8V14gUX5sJfpY8gUtsUI6kcfaAJdYKCHMdBE0jnQ9/N/jVh/oTibngBoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648915; c=relaxed/simple;
	bh=5PXX+yJCizZQfEoLgdvazWRPp3WDM4BhZliaoCBpzOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p5OaJ03Uxmgx8F0A64C6wVSDBFj6mmCgAZOHXkTKds8HKILYn52V2YJZqcn1iV9GkLv6W/3lTBh5UWehq6hnpQnBwKR/wYulMDyiVz8aERvAgq/Mlr4Nf5nSVn7amaV0ZF90Soma8DV7OJYqujJze9lBa49XfEDIdKY7T1RQLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpN3QFBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA79FC4CEE2;
	Wed,  7 May 2025 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648914;
	bh=5PXX+yJCizZQfEoLgdvazWRPp3WDM4BhZliaoCBpzOU=;
	h=From:Date:Subject:To:Cc:From;
	b=kpN3QFBCniCzznMMIvpqGBEGbvLC/4h/Fr9JW5m9725UZK420//kRWfKtnCoNkSgC
	 dGH309hn2RuFIQi1D+Qh1KeI/baFAsLyZMEmErUhotwKwVP7/rrt6CvL7WvUxN4EEI
	 fB0BT/iOfP2A9Hl2K/cGozmPG+sdt+gbGAf6ovifSd/HKIerD/R0MOPeiVfe1aGzUs
	 gmQz63onwNy0Y4u2ubdOsYxnU6HJv8Djgo0UmftNJdfaEuUct2rtaVlFCWJ9AkG1uP
	 +acoUum1kKFBkgEMXR4dyQQV7eYdblN1IMgzxMeLteo9bjQEMvdI4yKrvABSPuRBJk
	 Q4CjUxhz46QeA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 May 2025 21:14:52 +0100
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
Message-Id: <20250507-qede-fix-clang-randstruct-v1-1-939a4ba09d94@kernel.org>
X-B4-Tracking: v=1; b=H4sIADu/G2gC/x2M0QqDMAxFf0XyvECj1DF/RfZQ2qiB0Wlax0D8d
 4OPh3vuOaCwChcYmgOUf1Lkmw3o0UBcQp4ZJRlD61rvvHvixolxkj/Gj82oIadSdY8VHVHoiF6
 TTz3Yf1U2726PkLnC+zwvQIVsj3AAAAA=
X-Change-ID: 20250507-qede-fix-clang-randstruct-011a3119f5d6
To: 
Cc: stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5PXX+yJCizZQfEoLgdvazWRPp3WDM4BhZliaoCBpzOU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnS+wM3+tfYXIvnatZYa7a1I6mGX97987Z9FSu9b55Zk
 Z5yVexGRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIi1SG/6kK59NYuGbmR28T
 WbV2ilUiz1/rWS9+5DUzf5Ozel9qkM3IcJdtrUwC6+pvjZJ/929s2ijc5WFSa3mIM+7u7CWT+u5
 +ZAUA
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
change-id: 20250507-qede-fix-clang-randstruct-011a3119f5d6

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


