Return-Path: <stable+bounces-109913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC5A18475
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8A16B3A7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A661F55F3;
	Tue, 21 Jan 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rfbpKxXS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A811F472D;
	Tue, 21 Jan 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482806; cv=none; b=lA1703QRr5ceazZ5fjnwgCV27Y2JtgA0Efwte9oYlSOJ5o0KTo0Jn42UFdgn9NrFlGkgIFSKj+u2aIrGZjc/QSgN99BSrYKk4+Xb6WU+jkQL42hQznjkCZwvPgnJD7+rtbi3ggtR2rfM54hrS3YUNb4Bqa4RFCtfqFUbOn+jMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482806; c=relaxed/simple;
	bh=iSWaF/BrCf1lOKtu2FHv0fR9qW9rzWhENiXaYuBBFWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuFsqFFL+Jx0aE9Ofqbj2VKNJOg0hRCNiinXJH4fyfXrTwhVaJf1ASm5alKqRgCf6PSRFjsskNCxrXDGRqfSC4GhK7kTsMgiSSloOEVx7A0v9SQiBjt6KnTc8ODYvwfNl8H0H3iELlx4ez4ZkO55wJAZ+9bcQQBBcURHh6J0MGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rfbpKxXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1B8C4CEDF;
	Tue, 21 Jan 2025 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482806;
	bh=iSWaF/BrCf1lOKtu2FHv0fR9qW9rzWhENiXaYuBBFWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfbpKxXSnaJqPI9buWXD8rLb1c4pNf8vop33RpemXiNXwTZ8LcVDZDYarhuFKws2i
	 EXVSUOsrPSnDlyz8b0hXTg4AN3LzkFy5qQOQuqiUrNldthza8v9ls4c6CFBJpo6+3X
	 1g3GhMYKKRi0k4nh+4aRZs2YTWZPqYKdUaYq1v4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 015/127] cxgb4: Avoid removal of uninserted tid
Date: Tue, 21 Jan 2025 18:51:27 +0100
Message-ID: <20250121174530.260014374@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anumula Murali Mohan Reddy <anumula@chelsio.com>

[ Upstream commit 4c1224501e9d6c5fd12d83752f1c1b444e0e3418 ]

During ARP failure, tid is not inserted but _c4iw_free_ep()
attempts to remove tid which results in error.
This patch fixes the issue by avoiding removal of uninserted tid.

Fixes: 59437d78f088 ("cxgb4/chtls: fix ULD connection failures due to wrong TID base")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Link: https://patch.msgid.link/20250103092327.1011925-1-anumula@chelsio.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 21afaa81697e..47529c77654c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1800,7 +1800,10 @@ void cxgb4_remove_tid(struct tid_info *t, unsigned int chan, unsigned int tid,
 	struct adapter *adap = container_of(t, struct adapter, tids);
 	struct sk_buff *skb;
 
-	WARN_ON(tid_out_of_range(&adap->tids, tid));
+	if (tid_out_of_range(&adap->tids, tid)) {
+		dev_err(adap->pdev_dev, "tid %d out of range\n", tid);
+		return;
+	}
 
 	if (t->tid_tab[tid - adap->tids.tid_base]) {
 		t->tid_tab[tid - adap->tids.tid_base] = NULL;
-- 
2.39.5




