Return-Path: <stable+bounces-103043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185AA9EF700
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A75117A5A8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC1223E84;
	Thu, 12 Dec 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEH7pzyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500EB223E75;
	Thu, 12 Dec 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023368; cv=none; b=a1ocoP0ghL1U8KRe4fYB0EveEXLNcbrupNNDSM4HkztMC3Y91pBBSm3ZnRkYFpGJyldfqeCetkiwtYJnsWxrvIfNNvqjiZvFLfyN6ORn9sFUrqB/uViotPylaywAwsh47LZGE6ZhAzqGWdvKnCOE9x0L1LCocOPTANQg+LKNDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023368; c=relaxed/simple;
	bh=yMUW/j0m6FQEt9oaTsTx3HmkFu3J+5ep59kmScUb2EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnEUY8T5VWMSF0SI8bAEAis1WJetKaSmHm/PSzIzisOeLe0hzonlWBOUnZzBRXWsK5BGDXAqgiofQvS14vnInyrtto9cTEw62NTAwp+CSNdWjvDwJmVv5x/NFiElBtC33PILiaOeYVBunCiXtQ4pE8vhKDSvYgcb8pDYKuXv0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEH7pzyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E632C4CEE1;
	Thu, 12 Dec 2024 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023368;
	bh=yMUW/j0m6FQEt9oaTsTx3HmkFu3J+5ep59kmScUb2EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEH7pzyCZLh8pNCD9uxJaJxvx+D3tE3KkftPnHnLYP7KzIxWMPDGBiGPUeviKJah2
	 0d+pUsmJH3aM5VERMt/2SL01ed3BkfWLDUk+iaZOy9AIEB0Rf7V11vIIQXp+7OFkZs
	 Xvw9We0vkcsPMQKCzCUp00DiKWcbFgnJ/lRgbbj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 510/565] net/neighbor: clear error in case strict check is not set
Date: Thu, 12 Dec 2024 16:01:45 +0100
Message-ID: <20241212144331.928530144@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 5829477efbba5..6f3bd1a4ec8ca 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2738,6 +2738,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0




