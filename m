Return-Path: <stable+bounces-138779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8BAA19A3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B894E33F0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E725334E;
	Tue, 29 Apr 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fXYWM2Wf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2919F424;
	Tue, 29 Apr 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950324; cv=none; b=bCRy6xchbHQykEInxtuR7z1h6xIVc3udeYbPAKIdKa8du8BuFoQw7Jz45PtQ4hSz3ITEX9XMLLnLYCJRyiQH8uJpV4PmghiI1wSDmwoiYuBtbHz79uBkA9tYMYid1aWikLLmC82QSUGBJoWnoEXj7aQ3YWbXcFnrRKYzJ/ioWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950324; c=relaxed/simple;
	bh=x4GCasmyFpfjncNNmfQ5G+IcbH8WtAAAH66dRaXEunU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0dpSWeTw5a1W2nkLevOI1mZ/bZXx7ttyp1XoTDd9meAoqhnnep+ccb5JrB6aidi8TA9fdjCpTNBWEjnHy9jSblq1/s+tRf0IJK5lLgAy2CPCWrRuBpNswyogYPWS2N1o8MWOOB8kSUujHS93ziPtS+N9eVoDrJk0wu8gI+/7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fXYWM2Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80324C4CEE3;
	Tue, 29 Apr 2025 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950323;
	bh=x4GCasmyFpfjncNNmfQ5G+IcbH8WtAAAH66dRaXEunU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXYWM2WfOMTFLHAjKlgVGikSHbSz0Ze/2yyUM/K7kP3fAHspUmCYuH6DZ8ReSfnVM
	 2mapx07OFL6Bsw2/SQNG1WcJcZnG/AJ860gFIbhaTEs5rV1pnsfNcFH11GjkvuCNVl
	 XOIb4OxqLBS8bBncHel2ajMip53VkVKeQccRJ9OU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 059/204] net_sched: hfsc: Fix a UAF vulnerability in class handling
Date: Tue, 29 Apr 2025 18:42:27 +0200
Message-ID: <20250429161101.847551724@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 3df275ef0a6ae181e8428a6589ef5d5231e58b5c ]

This patch fixes a Use-After-Free vulnerability in the HFSC qdisc class
handling. The issue occurs due to a time-of-check/time-of-use condition
in hfsc_change_class() when working with certain child qdiscs like netem
or codel.

The vulnerability works as follows:
1. hfsc_change_class() checks if a class has packets (q.qlen != 0)
2. It then calls qdisc_peek_len(), which for certain qdiscs (e.g.,
   codel, netem) might drop packets and empty the queue
3. The code continues assuming the queue is still non-empty, adding
   the class to vttree
4. This breaks HFSC scheduler assumptions that only non-empty classes
   are in vttree
5. Later, when the class is destroyed, this can lead to a Use-After-Free

The fix adds a second queue length check after qdisc_peek_len() to verify
the queue wasn't emptied.

Fixes: 21f4d5cc25ec ("net_sched/hfsc: fix curve activation in hfsc_change_class()")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Reviewed-by: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20250417184732.943057-2-xiyou.wangcong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_hfsc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 880c5f16b29cc..90801b6fe2b08 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -958,6 +958,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (cl != NULL) {
 		int old_flags;
+		int len = 0;
 
 		if (parentid) {
 			if (cl->cl_parent &&
@@ -988,9 +989,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (usc != NULL)
 			hfsc_change_usc(cl, usc, cur_time);
 
+		if (cl->qdisc->q.qlen != 0)
+			len = qdisc_peek_len(cl->qdisc);
+		/* Check queue length again since some qdisc implementations
+		 * (e.g., netem/codel) might empty the queue during the peek
+		 * operation.
+		 */
 		if (cl->qdisc->q.qlen != 0) {
-			int len = qdisc_peek_len(cl->qdisc);
-
 			if (cl->cl_flags & HFSC_RSC) {
 				if (old_flags & HFSC_RSC)
 					update_ed(cl, len);
-- 
2.39.5




