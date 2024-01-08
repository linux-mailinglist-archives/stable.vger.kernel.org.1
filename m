Return-Path: <stable+bounces-10275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA66827428
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CB6286F27
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F1537ED;
	Mon,  8 Jan 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aluCKgW3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD020537F0;
	Mon,  8 Jan 2024 15:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C73C433CA;
	Mon,  8 Jan 2024 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728538;
	bh=bwS1Ri0TKCa/Z6MqRXq8QBFS0tydzkiHxAM4oFZxSEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aluCKgW32hPGYHT3SsKXnN86lJJXEAg+tONdGVuteEOt5A7zNpnqOtQiT1PGFlgJ8
	 afAzHZ6vvLAL0HrMfYdoXdwLxTj9OSc+fzd9OhmUYJHFDaCbgyNLT8++/UuSCrzK9b
	 O5yCmwju13P5cuZiejXzUtJbjgig5XLhwpO4EEeI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/150] ethtool: dont propagate EOPNOTSUPP from dumps
Date: Mon,  8 Jan 2024 16:35:59 +0100
Message-ID: <20240108153516.155894628@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit cbeb989e41f4094f54bec2cecce993f26f547bea ]

The default dump handler needs to clear ret before returning.
Otherwise if the last interface returns an inconsequential
error this error will propagate to user space.

This may confuse user space (ethtool CLI seems to ignore it,
but YNL doesn't). It will also terminate the dump early
for mutli-skb dump, because netlink core treats EOPNOTSUPP
as a real error.

Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231126225806.2143528-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 1a4c11356c96c..fc4ccecf9495c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -509,7 +509,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 cont:
 			idx++;
 		}
-
+		ret = 0;
 	}
 	rtnl_unlock();
 
-- 
2.43.0




