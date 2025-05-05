Return-Path: <stable+bounces-141492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B15AAB72B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC651BC789D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1A833FD66;
	Tue,  6 May 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLkCqDBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043A2EC884;
	Mon,  5 May 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486464; cv=none; b=hxoUoIassuuHm9L/v2LlEVEPlaV5Y9lWj4GXoyGERsmB3zjG0SigCzq23EGLVqypCKKpMLwRhDcW99qdGc3P/H3I2LPwBgdtu6t6LkQ1/P6fU4bRp/68GH14z4GSMAbybGoEbmvv6Vs/FpzsZq6vOGtTzHw/Y3+gC9+VhfZf1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486464; c=relaxed/simple;
	bh=psd+1PmLx+7zLujSCIXwT2ZX+zUKu2xcXeApCRMrGqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8CIxidMdN84cVzNEczClTUbFPeTBKdw+HDpH9ppd4FlalWhGosmM7nhaOw3x2YoF0PmKA1+1SJ9s4iv6/mJlaYO4MZ33fjM1GGI02Iup3IHTBwX2+o6MAxjcbVDuY2dMvgGzngLa8p6lpJ0fKcZGzrPahuvD5WGyjXOnf49Hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLkCqDBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F83FC4CEEE;
	Mon,  5 May 2025 23:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486463;
	bh=psd+1PmLx+7zLujSCIXwT2ZX+zUKu2xcXeApCRMrGqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLkCqDBqEaFvGHIUQ7hjWhZG1MD246Xhs3b8rKmb+TPJhxQiug3yZrIca2b/uMEYI
	 mthBNLvBFKqbUrMBiao7JlDj2+KoRtsQ54Q6VjEx0fjFAmd1vT4oLGJB9RygZLm5A4
	 URnbZWudG29xVNysKjxlMT8hKvEIq3RqN6dqqgYyUp+csYcbodz5M475YzywlS1i/d
	 0yu/+wO0VrNMqBlq8eox9aWdfTJ7Di4ugBRtrzep1QDWvE812gB2tka0t3MVCzJFMz
	 F4T0zIdGCjQvjGcccOaWhmhUKBqm7Km87vJRxdvDY8mU3JD2N9augJmvP0z+c4inKy
	 Wg7OLzIYQxzlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 043/212] dlm: make tcp still work in multi-link env
Date: Mon,  5 May 2025 19:03:35 -0400
Message-Id: <20250505230624.2692522-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 2c797eb519da9..51a641822d6c4 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1863,8 +1863,8 @@ static int dlm_tcp_listen_validate(void)
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


