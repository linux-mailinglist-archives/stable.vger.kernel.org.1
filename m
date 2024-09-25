Return-Path: <stable+bounces-77579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B8985F3D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC91B27A09
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFE215F72;
	Wed, 25 Sep 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQWxlOkj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004F215F64;
	Wed, 25 Sep 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266368; cv=none; b=OwgjNhn3Jw5DBWYiOQrvzF9qoVfTTdvqdiVGRIt3b/s7rGGHxbvJ362jdUOkD8Ex+bF6rlAnU6prWY6clDbZ2N7GPXD93y3GsZzeP/IcAitYfjkmyLCNBJfNWdwJEAHfwH6Lkw4YUXiDaBlchJdZZmpG8b1w4nHVHCOPpLihmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266368; c=relaxed/simple;
	bh=qH+35EJtY/CJZO2ZhXddPaWDqfoduAQDG3OYBQ9fNOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVgM1AKbOhUliUQTnQOPNeJwmeoONFL8Vr/lAfvNZ+rnFwsZJEIIzt8QyeS1CWQXxtrX5U/rzbQt7WEhBNfnnfqCKU+o2Y2CZ7xiDHh/gW5GOBJ92/4pYOTtM1Me8fmRKpvZ85C4X8+rQ3CabFwaiFYkhJdLsL9QAM7Cbqc1uGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQWxlOkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28343C4CEC3;
	Wed, 25 Sep 2024 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266368;
	bh=qH+35EJtY/CJZO2ZhXddPaWDqfoduAQDG3OYBQ9fNOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQWxlOkjTdPF+qBsyvfqHG2zipeVLksK+CJgJ4yGH5Gga++phmyXtvq+1ReR3KYeJ
	 7MCKmrzTqoOxWBPPP069hqGZYX9ooMmYVfPGzhog+uagUn5SCX8z9tmQ+MFZz5S/LW
	 l2aJUegrGTldATJZPjUG/25GxQcUN1yyxRXVGyAFpioEGy4he/8YxqbrTCLF5WnmtB
	 SvUoyMghAZWSCZSC7KvjEn4g0sADc6tG45g88sp/M5cKQF8ANI7eIEBc+fSi+Z0rZX
	 dnaGbA27JpeDeOe9Ktb8901dd4GE2Rbu2A+ixMD84bueCMEFSXc//DHzYw7NASjHuW
	 Fuv0smjZPNGuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 033/139] tipc: guard against string buffer overrun
Date: Wed, 25 Sep 2024 08:07:33 -0400
Message-ID: <20240925121137.1307574-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

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
index 878415c435276..fec638e494c9d 100644
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


