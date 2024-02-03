Return-Path: <stable+bounces-18167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E948481A5
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674801C24413
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA033CC9;
	Sat,  3 Feb 2024 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xj/9xFwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230533CC7;
	Sat,  3 Feb 2024 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933596; cv=none; b=mQTAeqkv21pxukRGa+DmJ73xbtGppiSmrnHuqkN4M1D2gun1oV+xS17gX5QK2/7HkIbcnfuXew3Sljd35tRj2av2XifaZWUIYc2N1W6XlLza99HPJHNZJIOU8B0VKwUjyxUok0F3WXFYztOxdo5HbR5ijg+72+zs8HyTbDWzYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933596; c=relaxed/simple;
	bh=0DHVAGkCPV1G7vf/7p5D9ScGzWxJLapNjkR8D0THBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYStveJc9Dy2eL+OhUBjQ2eQ2tdkynBHUu2ZDcBFMI8myRXSmOFjCGN4Ax0Ez1gB0iLdUWjjn3Oq4MtKkegE/dCecjCDiMAnOny7WvE+Za2rFELv17+z49zkDu9mg+Rjk0sLmpgL5j3cklpveyofE7GcTTG8FbqbdZxzRh9lgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xj/9xFwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D742C43390;
	Sat,  3 Feb 2024 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933596;
	bh=0DHVAGkCPV1G7vf/7p5D9ScGzWxJLapNjkR8D0THBlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xj/9xFwaFKZkLLU2DfuVmZARtCxf8StzghykZVgX+f0hoPnnlipNRy6Lgd0kEhSJT
	 0Mj7L3o8OKzg3PQ/dQ7FCtEKTd9Px4oz/JGeGgfEmiEezjRcOaUFGqkz71ojnZlCLF
	 zRlZwaHKo1GxL6Hwj9gPQc2ouflNumuoef5QURKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 155/322] net: kcm: fix direct access to bv_len
Date: Fri,  2 Feb 2024 20:04:12 -0800
Message-ID: <20240203035404.227729961@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mina Almasry <almasrymina@google.com>

[ Upstream commit b15a4cfe100b9acd097d3ae7052448bd1cdc2a3b ]

Minor fix for kcm: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Link: https://lore.kernel.org/r/20240102205959.794513-1-almasrymina@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index dd1d8ffd5f59..083376ea237e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -634,7 +634,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 
 		msize = 0;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			msize += skb_shinfo(skb)->frags[i].bv_len;
+			msize += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
 			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-- 
2.43.0




