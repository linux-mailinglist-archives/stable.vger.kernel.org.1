Return-Path: <stable+bounces-163768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0CB0DB6D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588DF563398
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F882E9ECF;
	Tue, 22 Jul 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NUMRFiK4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EC433A8;
	Tue, 22 Jul 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192144; cv=none; b=bN/byx5bhSR/EZemQ2tm1MlrDO9Ecakbh4veEaqwPxL4s12yZIaQ7z+4YTYzKEyfHSaTuV7DDopC9wB648CzI5pw5096uRimIDhGWohevX8aehajGnZZF0XMmJdoGGbeqUZKwTDEIb9I/xux9CP34o2uNviTTOL/dvgW3kvVCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192144; c=relaxed/simple;
	bh=VTjhfnb/YBmSxQ7UjIWxzDDZCiZTOWocZjKct29uQ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcfTFlUR409xC4TIF9hvBRpHhSeh9UwjDvT86kLUfiXY3/EAZVdh3UGEJqfKpeaw3sTVkNCP7gpR7rrXjRUhWVK+CNGuEECjWvseBU9bfrN0HoZF4Pca7ln3fjWpktkvI7yVncNIw3VrUMmuVybvMltBQ4xIZPfNrawYmLM6cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUMRFiK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9E4C4CEEB;
	Tue, 22 Jul 2025 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192144;
	bh=VTjhfnb/YBmSxQ7UjIWxzDDZCiZTOWocZjKct29uQ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUMRFiK4pOCDnd+5/6hc/qgSgt2ZNKPcgUvCh9fOA4oduAzQpAtSvZwWYLk+N59h7
	 rgvb3iw2zO4ppz3uClT8Eh16h2mzXlnclsHaGFGSMSAAzBdx64Djk/C3c5EcZWfHco
	 IjOGvU9Oc2/W1c/N+NN7u7TvaoWts+9y/+7G8n4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Haibing <yuehaibing@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 58/79] ipv6: mcast: Delay put pmc->idev in mld_del_delrec()
Date: Tue, 22 Jul 2025 15:44:54 +0200
Message-ID: <20250722134330.507274135@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index a1b3f3e7921fa..e9e59a83ba9b4 100644
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




