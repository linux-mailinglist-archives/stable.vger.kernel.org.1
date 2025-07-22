Return-Path: <stable+bounces-164025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC5B0DC8D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4BF7AD3E2
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C51A2C25;
	Tue, 22 Jul 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2SL30xuv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9E2B9A5;
	Tue, 22 Jul 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192998; cv=none; b=aaJ/TY37kBvmB3aXM6kC8XbAEH5J87PAEtRlBbaHGd2Sl5m5Rf83Qd0vxt2y8YP2POVKU0kiYFRJVFbAcw7ZM7kTN1TWeS3/QzGZIXVf3XjZwTeo8wvnKxssbCw91KFQnNX6NfTpA9AlKMgpvZ5OQf85Sc9mPsm6GH+Xhcq5x0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192998; c=relaxed/simple;
	bh=c3aEsYWtS1YdMSGkzbre1CR3XHrlReWpFAobX8lA8ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE3bUgm+Q0rWZdK4ou86FFfxW98BL/7sxnb3qhFAwvGSowRLLmh24ISTp833j4DmWAhEPZN/dgeWrm8WjGswwm9CanZrfSl0hhgLVABJqUtCh+KwSFdeQOyRrnRF24U73Jg75xRf+rCxKhB0xNmdvQVxmXipttXxrU6OgcmdPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2SL30xuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2287C4CEEB;
	Tue, 22 Jul 2025 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192998;
	bh=c3aEsYWtS1YdMSGkzbre1CR3XHrlReWpFAobX8lA8ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2SL30xuvnipWfzVwN1nWHF3I6j7ynvc4Cy6TrLo5Pb2zgRXKg5Q5qx/OJFECINmXa
	 ymId2sENlVcgueO8ARflVgldwwTiNLiJTMoGd+i8DMBJ26h14dXl7IWeIZkF0mrYJL
	 eTOQxEfrQfyKh9zrebURG6eV/q0rcXBHd0dR5rFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Haibing <yuehaibing@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 120/158] ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
Date: Tue, 22 Jul 2025 15:45:04 +0200
Message-ID: <20250722134345.219185491@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit ae3264a25a4635531264728859dbe9c659fad554 ]

pmc->idev is still used in ip6_mc_clear_src(), so as mld_clear_delrec()
does, the reference should be put after ip6_mc_clear_src() return.

Fixes: 63ed8de4be81 ("mld: add mc_lock for protecting per-interface mld data")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Link: https://patch.msgid.link/20250714141957.3301871-1-yuehaibing@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/mcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b7b62e5a562e5..9949554e3211b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -804,8 +804,8 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 		} else {
 			im->mca_crcount = idev->mc_qrv;
 		}
-		in6_dev_put(pmc->idev);
 		ip6_mc_clear_src(pmc);
+		in6_dev_put(pmc->idev);
 		kfree_rcu(pmc, rcu);
 	}
 }
-- 
2.39.5




