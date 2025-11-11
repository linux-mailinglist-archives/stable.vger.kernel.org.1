Return-Path: <stable+bounces-193608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2511C4A7E8
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BB3B3E62
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429F3446A9;
	Tue, 11 Nov 2025 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gvmvj2M9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4120343D67;
	Tue, 11 Nov 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823586; cv=none; b=K2cRcwPoRJdWr9tMbbShQidx2ChDvRchA3mY20VXmdF/dnMqcC+Z/IaSxaL7AqAiekW+Z/bXidhZj3DxSRvT0qUcH2xzUnnihP8mMqAfOKuUxaUg+Zrmb9e2k/UqiPlal3M8nNXNQCeKRXut+TjmEo7fvV8S3ci4vY2oOa8c/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823586; c=relaxed/simple;
	bh=RGSDBrhNJTsvggl0TW86jP5DkpVnndit6lxhf9pfsQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moqbsaZ/2fvOhYQxZyEq/jcDIUVfuCfs/3t7hldPK8WlF4XMAKcV+bpM1F7VH/gTJWgkumTcq3V29DLkmx6s2YVA5qnFlljfnyuR9ek4HisUbk4AZ/puyoctmtwo15RoyTlT3QopfTEkprUzdl224Hn7Xmbs1HokSPxglrAMgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gvmvj2M9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850A3C4CEFB;
	Tue, 11 Nov 2025 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823585;
	bh=RGSDBrhNJTsvggl0TW86jP5DkpVnndit6lxhf9pfsQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gvmvj2M9+vwVUU141M52UcwAsNHD+ms4eQdBWikOxHj8sGuPrwbRc9Qvv78E4NkYg
	 vbdEWAkiOe/aUC5eYIToNbI+/IBH+3rTkfOje6oJsfYwSJ8cHdmbRkCJLh49L+k7rO
	 RHL6s9BiSY5qaDnwWoyxBWBlw6o/ZOpD3zYRqYWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 330/849] dm error: mark as DM_TARGET_PASSES_INTEGRITY
Date: Tue, 11 Nov 2025 09:38:20 +0900
Message-ID: <20251111004544.396606497@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 499cbe0f2fb0641cf07a1a8ac9f7317674295fea ]

Mark dm error as DM_TARGET_PASSES_INTEGRITY so that it can be stacked on
top of PI capable devices.  The claim is strictly speaking as lie as dm
error fails all I/O and doesn't pass anything on, but doing the same for
integrity I/O work just fine :)

This helps to make about two dozen xfstests test cases pass on PI capable
devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 2af5a9514c05e..8fede41adec00 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -263,7 +263,8 @@ static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 static struct target_type error_target = {
 	.name = "error",
 	.version = {1, 7, 0},
-	.features = DM_TARGET_WILDCARD | DM_TARGET_ZONED_HM,
+	.features = DM_TARGET_WILDCARD | DM_TARGET_ZONED_HM |
+		DM_TARGET_PASSES_INTEGRITY,
 	.ctr  = io_err_ctr,
 	.dtr  = io_err_dtr,
 	.map  = io_err_map,
-- 
2.51.0




