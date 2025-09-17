Return-Path: <stable+bounces-180042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FFB7E62A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52608188D5B5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103E308F18;
	Wed, 17 Sep 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oj+E7BoA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE92E7BA0;
	Wed, 17 Sep 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113195; cv=none; b=LL8xxJq1mfukiMKP2vGStjci0j7SR3Tqfkte+DGyFFCx/5XGgwhifjjCWgteKQCOqTs9UUnnLazpgSy2Dmpd/R2bdaYl2TGGaU9tIPFtesJyDln5Gq9+TYkdiOu9e9gZf/CA1pJ67vwweKF0207i53ISO1OlU8eDkLgmzFlXB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113195; c=relaxed/simple;
	bh=OF4vfwVZEUTY6kjOsqXgkmXOA60Q6kNkIlWCu/0s4c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFX28YoWbahGDlb8fVWCM+i9FreefrpfHxbknw3O7p9BAbcd4EPEo5w9Ppr3V86OAnmQLmrISmJFJHnv1qp4iFYfvD/2aLqR8frA0GamHw7G39BIjKrnzctHFBkgiqkLSLG6hqN0ItR3w7ng0PKiG0NVKjDXQnfDOXMkB9HoQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oj+E7BoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65A3C4CEF0;
	Wed, 17 Sep 2025 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113195;
	bh=OF4vfwVZEUTY6kjOsqXgkmXOA60Q6kNkIlWCu/0s4c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oj+E7BoAb3mo0FLUOlSVuQ87dRvvqWPC6kKl2wX0vIAWaWsvM7Oc2VvcQv2oK6CaA
	 F92CkohBklJkZiEIahmAwch2vmyy7T2x0p20zbzHgMCAqv4p7oqGTX8EB9Sj9SdBBy
	 MF3al7l0g4mzl0E3vtq8dgwy2HtJ/2GUvFXPgc60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 012/140] nvme-pci: skip nvme_write_sq_db on empty rqlist
Date: Wed, 17 Sep 2025 14:33:04 +0200
Message-ID: <20250917123344.615052063@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 288ff0d10beb069355036355d5f7612579dc869c ]

nvme_submit_cmds() should check the rqlist before calling
nvme_write_sq_db(); if the list is empty, it must return immediately.

Fixes: beadf0088501 ("nvme-pci: reverse request order in nvme_queue_rqs")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2bddc9f60fecc..fdc9f1df0578b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,6 +989,9 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 {
 	struct request *req;
 
+	if (rq_list_empty(rqlist))
+		return;
+
 	spin_lock(&nvmeq->sq_lock);
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
2.51.0




