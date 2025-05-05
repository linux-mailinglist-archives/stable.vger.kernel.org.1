Return-Path: <stable+bounces-139857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC28AAA10B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314083B7E0A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893A299502;
	Mon,  5 May 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGHRl+aG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11059298CDA;
	Mon,  5 May 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483550; cv=none; b=VF1GjF6SMX5b6JsaPxYUtRQWk2ZfWdqU9e34Db8+IfzFdWfqwZWLQUrxYKYQlHMEQo9032VfOeSOKmL9IQiBF3LDjUKEMZHTb6+jvwmuPdR3CQ7cUC5o4zGTZIHXeMsY8NTYsSDBqKpvT6LZMdPiV5xjBj6TErxTOSUN5Y8o9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483550; c=relaxed/simple;
	bh=ri3vHl44v+qUaWlRB5k/svOUy4VXXHY88mDHYL1MBkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzKdIZqJmTTR6ro9gXMhpghfgNWVpNl2lCIoXvtgvYkwpQKr6yaVQZ+QWqE0nEzXHFpTK9AINqghAqAtRWc6NEnKu7alMulktmmITsgnJXvKLti/X1BB22cIjeSQgoyNBN0d0288YBDf7/amLJdRV7cY9tC8+4LE9nrb8Y/4xGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGHRl+aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E3DC4CEED;
	Mon,  5 May 2025 22:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483549;
	bh=ri3vHl44v+qUaWlRB5k/svOUy4VXXHY88mDHYL1MBkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGHRl+aGe8gctbUZMf26YT0XA+Fsznp5ZGNu0O0Az9hooLLUQg10gI8yekfyjla9z
	 OxS6cK2PsUBzUmFRcgBO0C6OHQW0oYGHhhyCfuKCEUKo/IZ2P04/fVhz4pUsdL2Bam
	 p4eHSxPZqv0Fr8UwkWvgDkaeUzgANFrtKqAK+0OVoJQDNd7ghFwTU9HwwNGH9kmFF0
	 wXrdCC5cUwgws5VMgrq2o9mQ1M0GQXcsMnnZW5PIfDQhqCThVbnKTlognZ4i5z2UoE
	 wGqfPsBB+yP61Iugkzey14K6L/lFLVRyXAYvaJGNeIw+i0gPTt6Gvln4FIDMupI8cq
	 XAGDE/Pyjz4ZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 110/642] dlm: make tcp still work in multi-link env
Date: Mon,  5 May 2025 18:05:26 -0400
Message-Id: <20250505221419.2672473-110-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Heming Zhao <heming.zhao@suse.com>

[ Upstream commit 03d2b62208a336a3bb984b9465ef6d89a046ea22 ]

This patch bypasses multi-link errors in TCP mode, allowing dlm
to operate on the first tcp link.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index d28141829c051..70abd4da17a63 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1826,8 +1826,8 @@ static int dlm_tcp_listen_validate(void)
 {
 	/* We don't support multi-homed hosts */
 	if (dlm_local_count > 1) {
-		log_print("TCP protocol can't handle multi-homed hosts, try SCTP");
-		return -EINVAL;
+		log_print("Detect multi-homed hosts but use only the first IP address.");
+		log_print("Try SCTP, if you want to enable multi-link.");
 	}
 
 	return 0;
-- 
2.39.5


