Return-Path: <stable+bounces-101688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBA9EEE1A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633511886D5B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8380215774;
	Thu, 12 Dec 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dt8jD82u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679F6F2FE;
	Thu, 12 Dec 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018441; cv=none; b=bixG34VJ0ahWdPihTX/c8Of1Ugk0ZFI37lp921uGgmIZBE1Itxsu8jzPJ1bDPe1Jyy3fQOLuD2sCdtZd9Vy5g0xJ8CjX7HFWZX9Wqb5P513xWyvRGfqTmXzOcozY6IGIHSuNxbOOm/kLrIOMkoltbvJu+AbYFHZY9Dc7I4YVZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018441; c=relaxed/simple;
	bh=ODBGa5lUSD8askmEbMRMQ1USuQpMSi+8pivpIx5/Kl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdf1JSdIoT4wytCpiNm4C5i3JSAu6LTmg5OniMgujBYTXr4zEVeD22WIx9HcdURpfJluORZYOVl4EHfttRaJad+fZzhGL1K5ml21or8Ds25tPWBdJ3LkUrCla4gniUUcyc0n+rgiD0JfNfL4I6LQwUvuiSH4JKCJS0TxcicSI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dt8jD82u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930CBC4CECE;
	Thu, 12 Dec 2024 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018441;
	bh=ODBGa5lUSD8askmEbMRMQ1USuQpMSi+8pivpIx5/Kl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt8jD82uReZhCsRxhvUxQtsYMjhi5nnfCzHgk9GH1jY+SfxiiE2U2E1nsDgX/R9Ff
	 SQ0nXEa9uM94kgp0e7mvWlKSkzUSNPtU86/MH4iVnFNIHiQEDWVb/n1owdocsgz15W
	 KfUnwgfQS65bSx9BnnYlQnak/R2zCHBx4ciGYg+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 263/356] net/neighbor: clear error in case strict check is not set
Date: Thu, 12 Dec 2024 15:59:42 +0100
Message-ID: <20241212144254.986577284@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
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
index 552719c3bbc3d..cb0c233e83962 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2875,6 +2875,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0




