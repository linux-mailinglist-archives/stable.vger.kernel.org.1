Return-Path: <stable+bounces-77380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B5985C85
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8F1F211CF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A951D049B;
	Wed, 25 Sep 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7gbMDn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4B1AD9E8;
	Wed, 25 Sep 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265582; cv=none; b=pmrgu5wTLkjJGjkquBdFeaBR2vWGpARCpfzxsYoUUDt7bqLHYFxTeOnoI3zbosCzZmhX1xH9mUn9DqtLV365a+ODdt9kVnf+eaX8rtsGQvG/+B3u+spTgin5XmtBt2xsl2eehuNS06IVXiWigcPprqdDhfGpv0rMNY1umvEIURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265582; c=relaxed/simple;
	bh=mtleRGQxpxz5aakz3BXw/SFcsgVUMQDfpikGYjuiYI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fce2U8iiJvX/PtJ57mkvKLo3cd3G+DEFHArYhCdJrh33VbqMVBiFWF7PXoOD3j8Xi6YY3Py5CXT8HUhwrdCFkslmC0lciNYMF62HksI2Up2G6ZgdlOIMGtj4jP/V2DTz7afznv8iMzOPW/48ba2j39FhOzNGdw6dmcnrHNHzS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7gbMDn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27810C4CEC3;
	Wed, 25 Sep 2024 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265582;
	bh=mtleRGQxpxz5aakz3BXw/SFcsgVUMQDfpikGYjuiYI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7gbMDn1SKyd8Qmly/7zhWAHA/3uh0BOgZo9BI3Q2VLcREUbsYdE1C3f4FH45gQbv
	 clzVBMVlONTOuHLc86v0c7aapIVembOEfdtQC3w9JRYzKrMIMTkvYIrmJJYN2KZH6W
	 YAkI9/wfFD6Ltl7pqyMKtRbneH54IFI5rBJgUpbJkuIQS7tzVmLgslJZsqbAENqHRZ
	 W48H4FLM0dRsEEwm4omP1w0dtDZ68/UZhmRboqEexYTN/+fpY9iTTGTc4U9KszIDjn
	 7DWJtW/FYcnyafUoVtnQSe1YDeLazqoSFZVuQ17R2HSQzAV0Af60EQ6etDC50KNWNX
	 KFjp7cLZPSSFg==
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
Subject: [PATCH AUTOSEL 6.10 035/197] tipc: guard against string buffer overrun
Date: Wed, 25 Sep 2024 07:50:54 -0400
Message-ID: <20240925115823.1303019-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


