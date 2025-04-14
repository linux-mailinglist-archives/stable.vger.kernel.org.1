Return-Path: <stable+bounces-132564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BBA88362
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F260B188F52B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A232C259B;
	Mon, 14 Apr 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sncKg9e3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468072C2590;
	Mon, 14 Apr 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637420; cv=none; b=nmVK8qHA5FSSJ0oLt8o2ywt+rd/ekGYE4oKtSBF44YIFOf7M0T/1wWtMbN7a9mVLPRkpwHpAhIPA/xdLilA+CNeOepFTcSVtYpu3msrlHQqMwnySOv5CK3uHXUjYvfwnxX7R5vcSXGpeBXnDZVYW40GaDc9gHqfDNgQAHsuISVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637420; c=relaxed/simple;
	bh=NAmXP6hkqc7M65jevgVkQZLlEo8nyQbY85BB8DmywSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKxt+ecbDlRvIPy/Qmz25QELy90WbcCOOYr2DXa8yMgGVm+oonvp8td6dE+2ONyIHQ3kSdj+Grf2zhFp77+by63IDv0usp8e3rXu2Log/6AKC7dhcH8aaIC0IzmFoouEsjiS33r+G8Ubl1eQr0Hj1JPHSqneoMxFnIYLv6+zWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sncKg9e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F58C4CEEC;
	Mon, 14 Apr 2025 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637420;
	bh=NAmXP6hkqc7M65jevgVkQZLlEo8nyQbY85BB8DmywSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sncKg9e3w5Trt0nMWNC/jUH1KS7+WvLOEhAU/WXitGGrrbdbYoPeZmFvGqnuHd7K6
	 X3+PmLBVUri8WIaNWjaD64QAkv5l1JLuP0HmtIV9IoHoEP5MgY28TEg594j7GC4TsV
	 t0SZB5sWd5m/NDkNhcyt86gg0V7+wwmoOU08R2k5QaiRBPh4z8Ui+6TiQTzjDHuoQ3
	 GUmEJJWeNdt3xcWkkoPBIxO9Gp+ClkTQ5OdHEmhx2aH9tczM+hNLm4mJ3sJBaXE1tg
	 TL0Tg3PNGT+d4ilceaNJt2UXkTOCp/FljR0aqWN6bLhtDERkXjt8bYxIw9P8kMx7q8
	 t2eVfl2HfgRHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/24] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:29:44 -0400
Message-Id: <20250414132957.680250-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit e3105f54a51554fb1bbf19dcaf93c4411d2d6c8a ]

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 32283301199f0..119afdfe4b91e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -426,7 +426,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


