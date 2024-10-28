Return-Path: <stable+bounces-88549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6AF9B2676
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790B12823D1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867118E348;
	Mon, 28 Oct 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSxZVkPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3418DF68;
	Mon, 28 Oct 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097584; cv=none; b=tum0IME9GDH1xwfi6Z2O78Iow5ls6I8U+HVBfdgDYy3lYJehmDzeuNYSrB15WShX4ULSwh5Luz9/+e3/RelBqc0iq0q7gpZ9Xh02RG2A8STQeTNoeQlU8ow4255xlKB5RwB8YjIjCNsasW/f8RNc0EfCwAJIYCBseD82A7SZV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097584; c=relaxed/simple;
	bh=YTvnA/KGTRHrt1TvdW509eL91DR0qVk420HbxMWvAbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnLPuIsIApkqKDq55477fCf7jiU8/tGQ0OEd13SLny82Ud+tQnBgLDpRK7ad3wusggAlooHvlzvkChoDNDP7093J5wcPlvt97KpX14Ua3r5rmLoCeqP89yCTCXVJKJjipPMjsRgSPY47O8KkWou7WJeQKvC1XgAIEpoexqOq0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bSxZVkPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB545C4CEC3;
	Mon, 28 Oct 2024 06:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097584;
	bh=YTvnA/KGTRHrt1TvdW509eL91DR0qVk420HbxMWvAbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSxZVkPtKSnXiE3JjvigmkgU2BvVClI5xUMYHxsL+48R+fKrJWdjxTnBW9wsPRvIq
	 n74V0PNnDrdjnM1Exz+MjMIZg2g+SCS20M+882i3EEQN9pTxHYvAxpLLqtiRWLeOFg
	 e0rDAud9vtb+1bbPL3JFkAUvRllL4ttC50DppsRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Simon Horman <horms@kernel.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 056/208] net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid
Date: Mon, 28 Oct 2024 07:23:56 +0100
Message-ID: <20241028062308.035457297@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 82ac39ebd6db0c9f7a97a934bda1e3e101a9d201 ]

pnetid of pi (not newly allocated pe) should be compared

Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for Ethernet devices")
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Link: https://patch.msgid.link/20241014115321.33234-1-lirongqing@baidu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 306b536fa89e9..284cec1e20ec1 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -753,7 +753,7 @@ static int smc_pnet_add_pnetid(struct net *net, u8 *pnetid)
 
 	write_lock(&sn->pnetids_ndev.lock);
 	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
-		if (smc_pnet_match(pnetid, pe->pnetid)) {
+		if (smc_pnet_match(pnetid, pi->pnetid)) {
 			refcount_inc(&pi->refcnt);
 			kfree(pe);
 			goto unlock;
-- 
2.43.0




