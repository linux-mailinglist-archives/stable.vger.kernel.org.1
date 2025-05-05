Return-Path: <stable+bounces-141606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3608AAB4CD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63FC463A26
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1006484A0C;
	Tue,  6 May 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reDdE633"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4159289831;
	Mon,  5 May 2025 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486858; cv=none; b=aFvQeQtPgPyvCS0840y9yQROYN7ryq0G1BFL4mv/0ttIxi3P651caLijPGkz518oX2bh2VtPvx6cQ4pl8H++sNj2zb4He292Ktv5h/d7DxzSnmgfLs2HZHUuBOEq+4dpHOzWrLh2/u/13PVddmuB4Q/Y0Pw8q1uY0K8O3pSzheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486858; c=relaxed/simple;
	bh=G8XYU08ab28Jth1wKyUaQmKifvz8CZU/774EsqhpmTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8XZZO/LbFw1wWTe7/3h2LmT2Srx03LtSdKf8Z89jy2N2JnlPqConAbUH5A6vnG241gs9hfarT1FQKtUmgLm7irkEewc5NxETBib1FXUwJk9Lghe0sB9KOaehXpy2HUQFoIOptBL1F2e5DvABRIQzqwFRGtRL4dPCw8e8SWCU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reDdE633; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE31FC4CEEE;
	Mon,  5 May 2025 23:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486858;
	bh=G8XYU08ab28Jth1wKyUaQmKifvz8CZU/774EsqhpmTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reDdE633A+xN745mPPppe/HfqDCw+TKKmPlV/FgxcZXUeJjb6Uslogf53NNVVPy22
	 P8fZ/QorE/LFqDcW6FJ7hw5PVIiSewgcCC0NIeg++OLdvDU4nToy/5iEJNi7jUfED+
	 JqJzi2DC1O7xyrgV9rJtbHZ/Ojxk0SgX3TiKDwyy+8IV6XUWEN79dVBDkPGQA4SD7F
	 UMweBP7g7lVDWbsGg2BzRvNSvz72hBZISLs/fe/Qmo2sv+L80YDheIr+itq4QCeBek
	 IxmhdPgxPUEPeN73ah4WGpadJ+aNpP/S+eiJwfn9umvTTEw8StIjJkhrz1p39SgJDV
	 3sG7J3jkC8Cdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 029/153] dlm: make tcp still work in multi-link env
Date: Mon,  5 May 2025 19:11:16 -0400
Message-Id: <20250505231320.2695319-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 1eb95ba7e7772..5b53425554077 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1852,8 +1852,8 @@ static int dlm_tcp_listen_validate(void)
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


