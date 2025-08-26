Return-Path: <stable+bounces-175762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC2B369D0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2366582B7D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69CB35083A;
	Tue, 26 Aug 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqQ8YnZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D9302CA6;
	Tue, 26 Aug 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217902; cv=none; b=AVJvjh+zw51MHsqZTm3/DvrQw7tqUi3rmKsVxJAoB9XSbMC1MQOpBao2Hs+GpXtQp3iD6RB7kM/nLFoq9HKDzxTCbSL33UKma7aez4htKO87q7J38QId+ptQlVMW/JvxT5GiojOekRPuho2CZX4P/cxL6PZGNhig5X/oEhfXyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217902; c=relaxed/simple;
	bh=CG7vYqKxdgONnrsWZxSkjC+7YC5w229FnOke+1WAAWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZJwk3Talu+3J4sBWa+fWlUT9of4u+ZnQtCTPeF2okrsLZ28R4Kmz/HNZIj65QIRCuJ6UjRPddfy9TjqxMJq5QW/M7UaQP4A7ZexC5LAuXrjlM6krd8Csic5+rsnfaFUWdLJgI1lGkXEkvwRvatf/u0sHLJm1ntFInXH0GL/4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqQ8YnZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C08C4CEF1;
	Tue, 26 Aug 2025 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217902;
	bh=CG7vYqKxdgONnrsWZxSkjC+7YC5w229FnOke+1WAAWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqQ8YnZVRM91FOodTf/0l5dDKi3kPUkavGWAraUKnDwMGdkcGsTt7rYLGiFQexnhv
	 bJzV9F0Ut4Tpx6RcSz5tnaYjWN9L+YJlJ/YYsss7lDBgqj3dxy5nWsJgu0fl5I3ITZ
	 hT0SB5gZQWOFrQbZjLKfNdOMf8Ev+qlhntMipCiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 319/523] dm-mpath: dont print the "loaded" message if registering fails
Date: Tue, 26 Aug 2025 13:08:49 +0200
Message-ID: <20250826110932.331929052@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 6e11952a6abc4641dc8ae63f01b318b31b44e8db ]

If dm_register_path_selector, don't print the "version X loaded" message.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-historical-service-time.c | 4 +++-
 drivers/md/dm-queue-length.c            | 4 +++-
 drivers/md/dm-round-robin.c             | 4 +++-
 drivers/md/dm-service-time.c            | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-historical-service-time.c b/drivers/md/dm-historical-service-time.c
index 06fe43c13ba3..2d23de6742fb 100644
--- a/drivers/md/dm-historical-service-time.c
+++ b/drivers/md/dm-historical-service-time.c
@@ -537,8 +537,10 @@ static int __init dm_hst_init(void)
 {
 	int r = dm_register_path_selector(&hst_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " HST_VERSION " loaded");
 
diff --git a/drivers/md/dm-queue-length.c b/drivers/md/dm-queue-length.c
index 5fd018d18418..cbb72039005a 100644
--- a/drivers/md/dm-queue-length.c
+++ b/drivers/md/dm-queue-length.c
@@ -256,8 +256,10 @@ static int __init dm_ql_init(void)
 {
 	int r = dm_register_path_selector(&ql_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " QL_VERSION " loaded");
 
diff --git a/drivers/md/dm-round-robin.c b/drivers/md/dm-round-robin.c
index bdbb7e6e8212..fa7205f8f0b4 100644
--- a/drivers/md/dm-round-robin.c
+++ b/drivers/md/dm-round-robin.c
@@ -212,8 +212,10 @@ static int __init dm_rr_init(void)
 {
 	int r = dm_register_path_selector(&rr_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " RR_VERSION " loaded");
 
diff --git a/drivers/md/dm-service-time.c b/drivers/md/dm-service-time.c
index 9cfda665e9eb..563bd9e4d16f 100644
--- a/drivers/md/dm-service-time.c
+++ b/drivers/md/dm-service-time.c
@@ -338,8 +338,10 @@ static int __init dm_st_init(void)
 {
 	int r = dm_register_path_selector(&st_ps);
 
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		return r;
+	}
 
 	DMINFO("version " ST_VERSION " loaded");
 
-- 
2.39.5




