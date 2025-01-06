Return-Path: <stable+bounces-106916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AA7A02943
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232C51642E1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881BA149C7B;
	Mon,  6 Jan 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUbRbwc4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D12146D40;
	Mon,  6 Jan 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176899; cv=none; b=lW+px+H57VxQwblIyikEhIahiDwyjSXq7goOGylYn2aIJh1kMzi+a9AquLqplqp+y51qhm7pfaKFiCAKppfW9rqa8/bs/EcNf4OWPrABfKHEr8l9s+Lmhpi1WOEVIPuq1vyzvRxgjEAKHSjRJENfnSGhzIwDgrIfTK2NQFySi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176899; c=relaxed/simple;
	bh=ga/veYLxd3CwwbjV9eRYE2G8jUynrWQJN8gu/kSaFOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+wZYj9ntSwmd2E1qrP99zT1BA4SSGowPeKQQcc0CnW/YQ/0qDayqMzUE1NxVtJZgrHCHOjnJUd/2EsvQGXzJjGqbNnTJAO+XghotuSsBSKRxW9xvP64Aduk1wg8S4zFWJ9SDnQyV0HR3nVrlWZUMWiKKeDDzTnSFbVTQeLz9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUbRbwc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6926FC4CED2;
	Mon,  6 Jan 2025 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176898;
	bh=ga/veYLxd3CwwbjV9eRYE2G8jUynrWQJN8gu/kSaFOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zUbRbwc44UDhh7T6/l6SWeTeMFK4m6Bb5tq3Yt7/Hkj9MPF3hGh8BO7v6sohGdNRR
	 VV8lpMh/fuai90m9+QhvZ0LxOxlRR/70LJDyo9TFYjRGv1l7ShSQh4K7mrcgsdpKhk
	 Z3SBLYoLh9Ix+I0fZMPXCkSHnufFJpsHgEmAHYKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 67/81] modpost: fix the missed iteration for the max bit in do_input()
Date: Mon,  6 Jan 2025 16:16:39 +0100
Message-ID: <20250106151131.960989685@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit bf36b4bf1b9a7a0015610e2f038ee84ddb085de2 ]

This loop should iterate over the range from 'min' to 'max' inclusively.
The last interation is missed.

Fixes: 1d8f430c15b3 ("[PATCH] Input: add modalias support")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/file2alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e7d69c9f6341..ba09484ef910 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -741,7 +741,7 @@ static void do_input(char *alias,
 
 	for (i = min / BITS_PER_LONG; i < max / BITS_PER_LONG + 1; i++)
 		arr[i] = TO_NATIVE(arr[i]);
-	for (i = min; i < max; i++)
+	for (i = min; i <= max; i++)
 		if (arr[i / BITS_PER_LONG] & (1ULL << (i%BITS_PER_LONG)))
 			sprintf(alias + strlen(alias), "%X,*", i);
 }
-- 
2.39.5




