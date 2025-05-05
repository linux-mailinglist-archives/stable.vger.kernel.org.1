Return-Path: <stable+bounces-141544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9CAAB455
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA42169485
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718EF47799E;
	Tue,  6 May 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMBNl+W+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB242EFB80;
	Mon,  5 May 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486656; cv=none; b=RbmJhxBMK9PkiJea1SG4L2l0UbIWcN0Xf++d1/52MJRZDV2xdVoA3s0DES0OLebTmTtuY0v7oIdsKWp7TtVOgvBYOKiWGHWorO3X08GFG7Ub/OfGdTQvvroQLoJS4MD+AWTS4CU+fT+if0WSdkv8Js13fvLQLPSBCNXsY6+5F08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486656; c=relaxed/simple;
	bh=Pa7L28cijMi8iOzF4/ANZtkfnSuJCas+Gkv0hY5XP1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCZ88zA9jblEGGlOT128YG2UUnIM4kCJ9ehNrsCPD8qXXxiAd+8qN/SWWmgwp06zNtBetYOLI+BGqF7g8c1K0OMkZvjmZGh2kPULaoWf7qAeG6HEaH0SWAhpFEo/XQLKwlzUDoEcXoSvJouIPk21QzwUW/TlVJyInAlMV4Jh2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMBNl+W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516F3C4CEED;
	Mon,  5 May 2025 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486656;
	bh=Pa7L28cijMi8iOzF4/ANZtkfnSuJCas+Gkv0hY5XP1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMBNl+W+fTyfYuhJw/vjqaIvcgE99M1m363kh8tSrzF9r9yVTvM3OoIAAxRarvRyI
	 JEwaZ+kZnrIyAxM6MBF2WKAo6vSJ+9JWm4fx2Gd/9ZghMFQ+perTLNNkVPH6dUKfk/
	 7lBJcQEd6vlIaxtlFWp/digAobw7WW9HfPV+7jtyt/t2o6OLufOakw8HntRhoXYzWS
	 iu9MN5mcWyHtZOiDqqBfs7OHuhJ0OZSxdgqvc32tmqrUl+t73HCRsKuwQbdWMftP7c
	 ofepVELn1pzKhjNdO6U2SGDpmewh/7b91bYYBY/OfKh1ybomFlwUTrE6GCHrqBvFdN
	 HtkPhOTbbLO1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 140/212] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 19:05:12 -0400
Message-Id: <20250505230624.2692522-140-sashal@kernel.org>
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

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 425e64440ad0a2f03bdaf04be0ae53dededbaa77 ]

Honour the user given buffer size for the strn_len() calls (otherwise
strn_len() will access memory outside of the user given buffer).

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250219084527.20488-8-ps.report@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5917820f92c3d..a2838c15aa9da 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1877,8 +1877,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1908,7 +1908,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	if (!strcmp(name, "add_device")) {
 		char f[32];
 		memset(f, 0, 32);
-		len = strn_len(&user_buffer[i], sizeof(f) - 1);
+		max = min(sizeof(f) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
 		if (len < 0) {
 			ret = len;
 			goto out;
-- 
2.39.5


