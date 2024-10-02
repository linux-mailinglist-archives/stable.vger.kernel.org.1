Return-Path: <stable+bounces-80388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCA98DD41
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE41B256FA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7F1D174E;
	Wed,  2 Oct 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flVikb/E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F021EA80;
	Wed,  2 Oct 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880229; cv=none; b=rWihprYWyRDoz9+8BqsDGA6nm/RKQtPXGvu5jieOgYER5EGMHGnB8Sl3UU3ApKdCtjvudg55opZjFL5nIYAvpFsTub/S96gMwLrmaUL49o9OCvjger8PSgwq5MZATLsuvx00/ELgP9hV/Hlm4Y9Mr10XbbLM7IZCcm3yhYCE5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880229; c=relaxed/simple;
	bh=UJKzMlut2T3knkrXvh69WzYhDSsQ4kJqYFrklnEs20Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDpCFbKEa7cx0AZb3iUwP1aGhHmvVPbT03EZtGoERJ40gz3DoAYBaSqtB91UFwDJXrVWmmK4H9f3QG/xJbJ/Lle6tGAeALKk4AEgq6RyxwMxvC9h4Q19oN8xkSyRkRkxJfyEschyo4wCVhC8JnoTOktcnQTBYiSrfsqBT22+98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=flVikb/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C94DC4CEC2;
	Wed,  2 Oct 2024 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880228;
	bh=UJKzMlut2T3knkrXvh69WzYhDSsQ4kJqYFrklnEs20Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flVikb/E/ojMRKK5DkmE6wKxW8eHRIIv5P3NlM86/zvrD+xCBTgRdK6gMcqLz2ge1
	 MlGKJtMQ0vzpOpkA0lraRbwhQdtZnwvYyn6pfFtZHOBpolavEv+c71cnR0SIqLNSj7
	 FwSsTOW08g4c0jC78JUDZNVzQ/4HgYJ7KemRHYeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH 6.6 387/538] [PATCH net] Revert "net: libwx: fix alloc msix vectors failed"
Date: Wed,  2 Oct 2024 15:00:26 +0200
Message-ID: <20241002125807.707245884@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Duanqiang Wen <duanqiangwen@net-swift.com>

This reverts commit 69197dfc64007b5292cc960581548f41ccd44828.
commit 937d46ecc5f9 ("net: wangxun: add ethtool_ops for
channel number") changed NIC misc irq from most significant
bit to least significant bit, the former condition is not
required to apply this patch, because we only need to set
irq affinity for NIC queue irq vectors.
this patch is required after commit 937d46ecc5f9 ("net: wangxun:
add ethtool_ops for channel number") was applied, so this is only
relevant to 6.6.y branch.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1585,7 +1585,7 @@ static void wx_set_num_queues(struct wx
  */
 static int wx_acquire_msix_vectors(struct wx *wx)
 {
-	struct irq_affinity affd = { .pre_vectors = 1 };
+	struct irq_affinity affd = {0, };
 	int nvecs, i;
 
 	nvecs = min_t(int, num_online_cpus(), wx->mac.max_msix_vectors);



