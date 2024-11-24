Return-Path: <stable+bounces-95267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E339D7609
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6196B83707
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC3246579;
	Sun, 24 Nov 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmNe9fU6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0A246572;
	Sun, 24 Nov 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456525; cv=none; b=QviOKEdsOFXM50qRRGAWyZ0EnkBe15FtF91DHuAAYSu5Ak3OgbJZf0Rcb2FhTJeOqH5AWlOIMCRG0PpUdeQozkbZX6OLsx/tsBNLNxzK2ojX0vbpWJ1vPE4lS+nMRxsisx26q+oWYS6+d2lD0wL8oxP+2mV9NP3n4gnx0wu9Vrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456525; c=relaxed/simple;
	bh=NRCRnPJZYa7XiO92OzBOCZ9STJ6u9yR8yeOoVt8gWYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFHTohVVpXouwVHYzPDNWDj7MTNJJnYaq3jErfdNswQIlMmKETg8inDihqpcZkGRxWXIgEoCmki+zPDU9rHdm0OyRdq+lOQPDvhF9solJtdnWeeE8/RYgrmKljsSicU8GeHBJJjd6ehcnT8bEtKbldUaYJGDJYCytUg+dtVIq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmNe9fU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F1C4CED1;
	Sun, 24 Nov 2024 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456524;
	bh=NRCRnPJZYa7XiO92OzBOCZ9STJ6u9yR8yeOoVt8gWYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmNe9fU67uKqBmt9F/5PC3rD59iSk4l6im0UCSixGonuVIVwBdmJODoi2YnkQTMEC
	 dRAUcS0DU5Dxn3xT6JbyVxHcT2ECM2qiTJmiljWZpP9fR/dJWB2edH/1iA48MCx4A/
	 Y/Wo9FdWDJU3Xa6+0voHEB8oWU/PTGuFRkjVTQaTRnokAiKo93XA08mzCOhbLOXU7h
	 b0tYPjZTkK/8lmby4yF7Me5p3rMwJsIM0qwEPiq76gYvN4QWx7iCCJWTyqRjIgqwrU
	 TViHk8TMSrdwez2u57sT7ifHm3MRSH7dTYOo8j1tRXP12cfgaA8lMTkAq/MSRLjVdW
	 5+UtNsvuGbavA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	gnaaman@drivenets.com,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	lizetao1@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 32/33] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:53:44 -0500
Message-ID: <20241124135410.3349976-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0de6a472c3b38432b2f184bd64eb70d9ea36d107 ]

Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
data checking") added strict checking. The err variable is not cleared,
so if we find no table to dump we will return the validation error even
if user did not want strict checking.

I think the only way to hit this is to send an buggy request, and ask
for a table which doesn't exist, so there's no point treating this
as a real fix. I only noticed it because a syzbot repro depended on it
to trigger another bug.

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241115003221.733593-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 432e3a64dc4a5..c187eb951083b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2739,6 +2739,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0


