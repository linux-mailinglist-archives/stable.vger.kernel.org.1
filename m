Return-Path: <stable+bounces-85546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34499E7CA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0278E280D9D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8121EABCC;
	Tue, 15 Oct 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DuIa0shL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4931EABA8;
	Tue, 15 Oct 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993477; cv=none; b=m7gzGFwjGoHeI92FZvQMURlUfcqs1WhHuzK+wsFyDFx1BVOCmCFkz8CfLO+jDJcZq7mZj0KLi7tvlZXO1s4GDzujnm59sPk6vdlpfurjY1s45TPsIy24zw8MZjj5f6T+XrHt1Hm9Or8/+dgZCofny70icQYD6C0mPMrzxiRCZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993477; c=relaxed/simple;
	bh=Gej8DbtnNdAYDFIjerPjju/hvuLPTj7O5g4w0XrpTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdeOjdcLiZHWgclr13GKU8nb6M4IV2ZdP4y754l0rURnQvE9hA1RaZAcfTjq/mhuQKsf2TQXUP+keZ/8ggUROwqIPEuvrP+Ue9r9peLCKbzkGNE8VKAjJlgWqEXmvM8Mb6txN5TntY5Ei+RZeXaRlzBUlxwS4UCsOqdNd60rmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DuIa0shL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68946C4CECF;
	Tue, 15 Oct 2024 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993476;
	bh=Gej8DbtnNdAYDFIjerPjju/hvuLPTj7O5g4w0XrpTIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuIa0shLK0MTX8GNq+Ez8IBJDC2B1kcXesHFQ8Y8eMLtzk0Gy95q1NA/fFB3fqhI2
	 4Ubd2V5IEYUvTvJ49O4AOkfGUJF+NU2S5f5xFd14jOGYlYGakcM6TXcTg/uX67aTgP
	 KsNziosELgY+8pbsbzJXKDcPZ2enuVY9YZAqrOXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 424/691] tipc: guard against string buffer overrun
Date: Tue, 15 Oct 2024 13:26:12 +0200
Message-ID: <20241015112457.172743968@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Horman <horms@kernel.org>

[ Upstream commit 6555a2a9212be6983d2319d65276484f7c5f431a ]

Smatch reports that copying media_name and if_name to name_parts may
overwrite the destination.

 .../bearer.c:166 bearer_name_validate() error: strcpy() 'media_name' too large for 'name_parts->media_name' (32 vs 16)
 .../bearer.c:167 bearer_name_validate() error: strcpy() 'if_name' too large for 'name_parts->if_name' (1010102 vs 16)

This does seem to be the case so guard against this possibility by using
strscpy() and failing if truncation occurs.

Introduced by commit b97bf3fd8f6a ("[TIPC] Initial merge")

Compile tested only.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/bearer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 17e8e6e3670ab..8c2793181ee7b 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -163,8 +163,12 @@ static int bearer_name_validate(const char *name,
 
 	/* return bearer name components, if necessary */
 	if (name_parts) {
-		strcpy(name_parts->media_name, media_name);
-		strcpy(name_parts->if_name, if_name);
+		if (strscpy(name_parts->media_name, media_name,
+			    TIPC_MAX_MEDIA_NAME) < 0)
+			return 0;
+		if (strscpy(name_parts->if_name, if_name,
+			    TIPC_MAX_IF_NAME) < 0)
+			return 0;
 	}
 	return 1;
 }
-- 
2.43.0




