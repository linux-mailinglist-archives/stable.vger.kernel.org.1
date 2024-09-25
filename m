Return-Path: <stable+bounces-77140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B358C9858E0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739BD28128F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B3192B96;
	Wed, 25 Sep 2024 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqm8tSMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7619259B;
	Wed, 25 Sep 2024 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264290; cv=none; b=BzRKjM0y2eaaugIl+gnOBTRBCAAfCTQgTinoGyq5Zs4rg6iVW5MJ9Tn8VF23+mHh28Stvv7pf+auDcejBSJFaySN5hbqaaR6YS1w7tXDEsYz7jpSZgGW659jkUFScNS8d2gfe6rXmm8ZiAFiv6hl5uhtxD3RIEDWtiyCZ9e3Kl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264290; c=relaxed/simple;
	bh=mtleRGQxpxz5aakz3BXw/SFcsgVUMQDfpikGYjuiYI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4LBzJ1oPZhDaZ8ahYzr5grMdcugtBLp1hL5nh02W6/kvAEZyXuAZWTTZyyjaKe2CuaFTQY1Na3Fyj53zaGob+tXBtyKgkMeQO+xGzo6HHMVbXShW6Yh5LN9RLb30zNpQuxshBHqEVg/ck8TGadb84TU2jCqEMcJdljvL3H/nQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqm8tSMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD70EC4CECD;
	Wed, 25 Sep 2024 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264290;
	bh=mtleRGQxpxz5aakz3BXw/SFcsgVUMQDfpikGYjuiYI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jqm8tSMwXVd6h0ZLEoTBTHcKpqf6Ap31fL9nAH5J2PmqPL7hI05euce9Evn5BBMZQ
	 9iyFU4FqnQr23SnsE7PUmBb3fwKrqrEteP3a4t3gR8gif0dr9SddvKZG63iFKG3tEu
	 WuaFAw/yVY9Laz/vyjqbOkMcJv/Y52uJwrkxRb8ayDBgWfECzltIYSdsZMgEIU/BUh
	 he8YygdXHa7/u9QyGbuMD7yDjnSOqMtg+jgkSX1JmxSg9Ai5XKmP0Tjee5j4PUvRby
	 O/sufu8RyD0CvpEPIipGsAKRNE47AVHI9mkHgsdpi88MzbHF6wU4AGIh1YY1lGc9Fu
	 MaxiMgkwibLhA==
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
Subject: [PATCH AUTOSEL 6.11 042/244] tipc: guard against string buffer overrun
Date: Wed, 25 Sep 2024 07:24:23 -0400
Message-ID: <20240925113641.1297102-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 5a526ebafeb4b..3c9e25f6a1d22 100644
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


