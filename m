Return-Path: <stable+bounces-140494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36505AAADE2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352F6164FAE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377F629CB3B;
	Mon,  5 May 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tagauJDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3A359DF9;
	Mon,  5 May 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484977; cv=none; b=O/rB0lDxU31slPtIsXZuqOH9vZ2zVQ/9b1bqB9BN0coo4Ef+Y0YvFdfIYbH673q9kRzr7d/Lw9VLGj9gNvw/q+Wqn9F/AjWu8XXoRZ2pBI8qTL1IkCv2+5CHdDQ7vF3CvOMG9n/H7LGjF/npAW9ZxxKgvD8mUdKJoM6U3SfExQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484977; c=relaxed/simple;
	bh=YQ75bINvl/uiYyqnZhLyfguZ9F0UaUz2ZRP/bkRD+kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5h9y55JJYN6vRhyJbVsrRnIkYsvPYU61TyyuozhfbwanJ7raShILG2d0/uPKr5FiwtNy4S2tt/9p2Q3d0lvXDBx23eqnB5wCxceRSuodoQ8WYI7ZD+fYFb+i2fKi4eewPMJC+x46IpbFxJH76AkkPCeM4psIiH5sBfQBtSt94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tagauJDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5636FC4CEE4;
	Mon,  5 May 2025 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484976;
	bh=YQ75bINvl/uiYyqnZhLyfguZ9F0UaUz2ZRP/bkRD+kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tagauJDcT/9+ybLUVOchFKqbADIq6YI6zha5Mevau/atT2qhB49Ty9OsKwWF1HffS
	 BUCpbUkVofuzhh1wnM+j7/ZGrbkO4G3HS6chssYgo787Sv9AEGwzmT72anoYe+X6Xx
	 I6xrDgNgeoBmJx/GebWjyisowG5KmgAAnyC4ObJO77lrA+DeM5+aH1r2ovDScUPNUg
	 fFy4WO6CNrskUvw0OVe/rC2KAFigmr/sKkttKLsNkuG7ThHFQtJJ4M66yVaN0MWWH1
	 LWOo/bxq490RKzR26IYnaL9eEBCUmE+4yO8LxfUo0diNh3MeTCURp5OBc7n6pB+MuB
	 j95fJXqWHppYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 106/486] thunderbolt: Do not add non-active NVM if NVM upgrade is disabled for retimer
Date: Mon,  5 May 2025 18:33:02 -0400
Message-Id: <20250505223922.2682012-106-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit ad79c278e478ca8c1a3bf8e7a0afba8f862a48a1 ]

This is only used to write a new NVM in order to upgrade the retimer
firmware. It does not make sense to expose it if upgrade is disabled.
This also makes it consistent with the router NVM upgrade.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/retimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index eeb64433ebbca..3488be7620674 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -93,9 +93,11 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 	if (ret)
 		goto err_nvm;
 
-	ret = tb_nvm_add_non_active(nvm, nvm_write);
-	if (ret)
-		goto err_nvm;
+	if (!rt->no_nvm_upgrade) {
+		ret = tb_nvm_add_non_active(nvm, nvm_write);
+		if (ret)
+			goto err_nvm;
+	}
 
 	rt->nvm = nvm;
 	dev_dbg(&rt->dev, "NVM version %x.%x\n", nvm->major, nvm->minor);
-- 
2.39.5


