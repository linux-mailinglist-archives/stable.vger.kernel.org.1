Return-Path: <stable+bounces-163872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD17B0DC24
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD92AAC1821
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43A2EA15A;
	Tue, 22 Jul 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yPa79fZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E468836;
	Tue, 22 Jul 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192492; cv=none; b=k5Zn+3I9x1yNu7QEHPz6DSjHYmmX8JB2Et4ek03PUXqbVwVV8GNTiqaXHPG5uiluMNWMWDxb+1n5x+hFXeNZamqNSn2iMHMDoVjt3zYrS8BeN3xR14lZxkgOcn34PoZnG8ptdn+T6+6B0SxCMhkh7kfhU17yydpahTSLV+lCVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192492; c=relaxed/simple;
	bh=+6odMhY8iFV28kfU82yylfWLjp4OdNFE6t4pBX5tTEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtV2sgSI1+DRURObHV/HODM3LM8/b/ixz4qJ8FcD1zsildZOfq78HAOTtcL7JW5QuFnG4y57w1kRux+SpKIaGbM15Xe26ETuRuKfZHIA1R6k8PiJKmlS97hVPAJHXLvmcs9bJtizXkCEXkvOpRuUpcHR8fMYrqvdWH+mdktH7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yPa79fZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D235C4CEF1;
	Tue, 22 Jul 2025 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192492;
	bh=+6odMhY8iFV28kfU82yylfWLjp4OdNFE6t4pBX5tTEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPa79fZ8K1gMtTcX/uo4ANSArAWEJeBU5UQJiOF9YqzrCcC6T+X2yFu8jd9CVueXD
	 hvtQnRbYSSnIMAJsJZKrbFmFgBI2097FbhmBX1lLY1+lWY9EWi4lspI2gnXZ+G7+Q3
	 9cQtIEa2Ryjfwqtk2ZcSIcFIosvgaBnPsr1Uz0UY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Haibing <yuehaibing@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 082/111] ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
Date: Tue, 22 Jul 2025 15:44:57 +0200
Message-ID: <20250722134336.457925991@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 9bb246c09fcee..e153dac47a530 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -803,8 +803,8 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
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




