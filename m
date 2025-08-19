Return-Path: <stable+bounces-171724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00EB2B6D1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3874E3565
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2312D2480;
	Tue, 19 Aug 2025 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8aBNCeE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4B286D64
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569771; cv=none; b=nRNPoOxt7wAm1AxZ2Qhx4fNqjmatPpIj7x9vV0FDsbuw3nhqE7TOBSC2YskKl947YLhZKQ3jHg12UsH1HwZmCY4uvaJz/yFn51zN0yktUUkI7VKnTX3EKQkqQdaZG1xBSgRb7EPy0rpE3o72BAeDR+n4BJlItExS5gF4kawEFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569771; c=relaxed/simple;
	bh=C4brGI4fHokSdaJJsJRbXCrxdCTAEvPmsxMp7zcq4Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooEBFclG/w8iXRYBM9dstyM5f+ck2Uwghann4o85fKIB+UMFBsMSvyGT7k2+ad4HcGF0dX6Cm202O3Ah2DVzGY057xfgKPRW3iQzINpOTM5WjOdD4grWttppogU/Xjr8W5Bh58pvxyGt2zRBlJTE2ItffM5Ee+5aXY+9r1MHvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8aBNCeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B021C116B1;
	Tue, 19 Aug 2025 02:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569770;
	bh=C4brGI4fHokSdaJJsJRbXCrxdCTAEvPmsxMp7zcq4Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8aBNCeEgRKtuhgI8nLTJzj2cjX4BpMgBRqBUgRXSShmmaIZAmJHdK5VxY/dWXxg4
	 vSqqctg4AxorscvXpVluMO66CS8PR7LeAdT2WngUVNg5LLcjC5/D8Js1fMILYqjxSC
	 n3/PG16wDx6M8Y8ftKiHYnaJiPcJwbRniSWZ79nD4aY1NF6fIZWlgcdU3MgXZ9COqc
	 JyJreL5VnwOSraEfnSqy3XRBe9uQ+zY7rDO9JOmEmP56Rv7yFNUs4NAbAxG0rvCj6e
	 EqXXpOiEFfSPxMdImnLlQ7rHrGf5MozEpb24+KgAH+H6P/0R7o6Leq7qK9vsEAtkE3
	 oZxjHXemgvaKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/7] btrfs: send: make fs_path_len() inline and constify its argument
Date: Mon, 18 Aug 2025 22:16:01 -0400
Message-ID: <20250819021601.274993-7-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819021601.274993-1-sashal@kernel.org>
References: <2025081827-washed-yelp-3c3e@gregkh>
 <20250819021601.274993-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 920e8ee2bfcaf886fd8c0ad9df097a7dddfeb2d8 ]

The helper function fs_path_len() is trivial and doesn't need to change
its path argument, so make it inline and constify the argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 361880e81dc3..41b7cbd07025 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -478,7 +478,7 @@ static void fs_path_free(struct fs_path *p)
 	kfree(p);
 }
 
-static int fs_path_len(struct fs_path *p)
+static inline int fs_path_len(const struct fs_path *p)
 {
 	return p->end - p->start;
 }
-- 
2.50.1


