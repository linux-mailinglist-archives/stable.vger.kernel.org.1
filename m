Return-Path: <stable+bounces-95003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9269D7231
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91D6162BBF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9721F668B;
	Sun, 24 Nov 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MatNEzkz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA51F6685;
	Sun, 24 Nov 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455543; cv=none; b=orsrUoJzgP10mECZgge1mh1fiU6s0xL4Wm5k37G2sOBX0B4USzE1l7nt9OZKLaOg37/RP2M4HR9BVfCp9Fr3ysSZsKl9VZouRf26sNaC6eydCk0+24HwmU7DNqMR/OYbvVmF4wpX38ymGlP75R4my+fEI2bBRfkHqgy2pDX2rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455543; c=relaxed/simple;
	bh=icEU9xDJi7D98XZ+fKp8tb3nCStikwSgjHKc7Irg7Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrkiKC6rmIYkCagMcJh2SbFwhn2W+MVwog27c1/Q/lbX7rgUSJYBvEcBSiyfJS4cLvC0Xv1YigdYMgmQBYn3ffPg00QAhoHOJ35G+vaoRYXraea0qrQ+uJLI6Z3sbyVxjbUpMIkJPOmmL+hLbtqo1VsZURr9/nws3DMok4RKIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MatNEzkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC922C4CED3;
	Sun, 24 Nov 2024 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455543;
	bh=icEU9xDJi7D98XZ+fKp8tb3nCStikwSgjHKc7Irg7Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MatNEzkzm+7bbnIjg0FHDOCFhZunu8r72544KPoRMaooIPDa6crNkgNwdkhC7aQ/F
	 F3NDAorpSxTde+U3IYS1Geyn9F7d4hOy/wFTqK6eaP+fWZn+0TIL/B4K7y9GUJb9MB
	 Fy3kL7oWXzSQCSpzkaHqxevMCpepELbBwLpoHxzq1oJMBxFwkxmL9XLWgI/sY6Nfbm
	 HDSnkLEDPccypxGwvFzOMdrIW+x5klB/3h0dQA2tv6YXBWqBEisXLseOn/ml2C65ff
	 u2URFxAY4jLvHF654S/ZDt8t2g4xlJ+jFzNw82EsGr6SSjppbWdwURmFS/znVUppMY
	 vVbqLxa8Sx2fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	viro@zeniv.linux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 107/107] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:30:07 -0500
Message-ID: <20241124133301.3341829-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit c69c5e10adb903ae2438d4f9c16eccf43d1fcbc1 ]

The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
accessed directly for a NULL check. While no RCU read lock is held in this
context, we should still use proper RCU primitives for consistency and
correctness.

Replace the direct NULL check with rcu_access_pointer(), which is the
appropriate primitive when only checking for NULL without dereferencing
the pointer. This function provides the necessary ordering guarantees
without requiring RCU read-side protection.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index aa49b92e9194b..45fb60bc48039 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,7 +626,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
-- 
2.43.0


