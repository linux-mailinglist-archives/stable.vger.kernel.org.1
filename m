Return-Path: <stable+bounces-31947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0320D8899DE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D0929F5EA
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB573B3DF8;
	Mon, 25 Mar 2024 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdnD/51P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC75C612;
	Sun, 24 Mar 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323735; cv=none; b=DYSt9AjuyiUM5WcRj7mJ52M2c29r5ytwppC6vkHSWaqyugFEtVDK/kt/P7CMG6jMdobu4OFG2FBjIzbZ0f6IH/3WCKJ4zQH71II3yaYQGh3GleDxwKfbsNomh/b5r27vpNYLkbsA1KryXmpXhN2bX5jCj+TpK6uClRt5K+Vq8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323735; c=relaxed/simple;
	bh=b/wMywr+EGLN30fL09KtdBNQj6X+lx9C77tGafzwHN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvEBCjgF6FdAMy/GoXSa8+nANadheNsC4+iscOJ6jH96hHUIgbmSx3vnb8LL4rtGE/m0A8wx645rTrXOac2z31UkYIt8hApH5DfIClJblY5gnxXCpPUpg1uPwz/DeVZJC48LEuZDsaY6g7InxgFgeAGhiVuGOkRk4hMKZFHxJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdnD/51P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C3CC43394;
	Sun, 24 Mar 2024 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323735;
	bh=b/wMywr+EGLN30fL09KtdBNQj6X+lx9C77tGafzwHN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdnD/51P+w4MtdeO1ws9YnDqYwClXEDlI/a5ggIqLhig8feQwPA6KGZ/lbC0+vd12
	 x+axgdKVVerc+/t+qqBVuooBEx1Sc4UBEj0n6Fw+49THq9/KBJQCFHALgIHCbgxLE3
	 pku61c39wRD4xDJVnVvh1jKqaMs9AoFfNWDj+KpLigGKmGnRRvXQVrPXtEu4gz7SXv
	 dBeemMiSOeRG9cRQILef78WawyrBJLgNdAtigb3psPIlLi8w8N0B76hl89MnbyF+4A
	 srbqf4Op7qhPYg4QLBmehCdztR4JPXJezlHL0UDtFmUm6mg8mpGxiIF2ayqeK5+ZQk
	 xEDgxheJN0kmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 109/238] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
Date: Sun, 24 Mar 2024 19:38:17 -0400
Message-ID: <20240324234027.1354210-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit d6eb8de2015f0c24822e47356f839167ebde2945 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 161dc194e6342..a7ecf2956cdd6 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -470,12 +470,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		goto out;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	rc = -EINVAL;
 	if (len < 0)
 		goto out;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	rc = -EFAULT;
 	if (put_user(len, optlen))
 		goto out;
-- 
2.43.0


