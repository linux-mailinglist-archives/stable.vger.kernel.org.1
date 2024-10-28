Return-Path: <stable+bounces-88291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093C29B254E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE211F21D3C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511018E047;
	Mon, 28 Oct 2024 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IM5WO8EX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC618CC1F;
	Mon, 28 Oct 2024 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096866; cv=none; b=IcA02bivE+azn5Ak9PZyYTlMLs68tf+ozavBMp0Nk/ftM7pyLIkdqPvHQXoSE1/aXMkYcQJwJcLeuGv8VN0qM5MHzwJiTNpf5tMoA2j3W3KHiNKvJ1sGg6Qo9aEsc1p/mTffUPvWz4L5R7zkAnDXS2FeX3idHVkvLFiu1eaojfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096866; c=relaxed/simple;
	bh=rFQ0rYNEnc+eIfuNtLJMB8XrZCk+Gx9aACNwuIw47r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA38bC5YfNy/EgN/kSTOFyLMX68nUnQdKg9uVqtlpd1ySDRkLSgrjlwmCgxwo58bBrw/FliHaQBC9RRZP28nbpKxTsoqAQHn3yMD7I1eJTTrDXBeidNxkCk8GtuCEZB/FgQMqoY6trATNgvCLnIDhCVPqB2jOK8PnZ/umGgOSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IM5WO8EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81329C4CEC3;
	Mon, 28 Oct 2024 06:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730096865;
	bh=rFQ0rYNEnc+eIfuNtLJMB8XrZCk+Gx9aACNwuIw47r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IM5WO8EXXzi9ahGUQCzOofxROuZh27cEOq+VE5EXqT+N/zKH9BN7SFdDzTpTozIHf
	 1cpP1+jjNIZy2NIUKOlU+Sk5AoE6TdsxmefCZVTBP5gjSfUBWWX85iSeB82g/1LZSc
	 G6zpijHKZP5VB6d8OOgw3dQ++OgEa/zqesu+Jbvg=
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
Subject: [PATCH 5.15 20/80] net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid
Date: Mon, 28 Oct 2024 07:25:00 +0100
Message-ID: <20241028062253.185501350@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
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
index c9e4b37e65777..a895d13798014 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -743,7 +743,7 @@ static int smc_pnet_add_pnetid(struct net *net, u8 *pnetid)
 
 	write_lock(&sn->pnetids_ndev.lock);
 	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
-		if (smc_pnet_match(pnetid, pe->pnetid)) {
+		if (smc_pnet_match(pnetid, pi->pnetid)) {
 			refcount_inc(&pi->refcnt);
 			kfree(pe);
 			goto unlock;
-- 
2.43.0




