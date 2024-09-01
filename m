Return-Path: <stable+bounces-71893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A3C96783C
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F000C1C20FAB
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B24183CBD;
	Sun,  1 Sep 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WEWJYP+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C39183CA3;
	Sun,  1 Sep 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208164; cv=none; b=HPwJnz/Bk6E6jbWdGez90vprvvo/hvkLjOaarR/t7tMioHKBn8tji5QDKRF/DvzbuXRB3XE/CP7T2goeNW76Tr38iSHJWHsdjqXvt0VvY1yShcQAn1k+o39VWvHLebu0jTep1QjsCHjWvaG9MWPC+aqt2RjzEyFE/KLXFPkxBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208164; c=relaxed/simple;
	bh=lNdbe4P3ZNWoja0RmSC6khv3uy/YsGZTYNyEoHNlFXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmVmTQY7bTxWDyNAOMD/jE4HxA6xVevdIlNMvrpP3YNglIgU9xkEH5m62GX3cZLKyk1W16t7wm22kmAHLtAzDpjYjNO7AW9Mn30V27nqcAYuSA8WY1EHwS83BxiOd1T1MhFVV58mEYtqrDR6I1l4BlTIsQ+dqncEyH9ULSzjKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WEWJYP+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA0C4CEC3;
	Sun,  1 Sep 2024 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208164;
	bh=lNdbe4P3ZNWoja0RmSC6khv3uy/YsGZTYNyEoHNlFXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WEWJYP+Pc0B0hdnOsOyV94EXrH+g+nEtc0AXwjVcPqyKnw/izodUaKCZX9i3cZD0b
	 dm7eM6XYLRBlXshTTktKAS4/UTWUEQJ0BAGRuQu7OQ/73yy443vUxV4OiS8sv4ym4y
	 WOV3RXD8L22bnHrK3UzHhk+anUMhTwJief3JpYxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Schultz <aschultz@tpip.net>,
	Harald Welte <laforge@gnumonks.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 65/93] gtp: fix a potential NULL pointer dereference
Date: Sun,  1 Sep 2024 18:16:52 +0200
Message-ID: <20240901160809.810862328@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
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

From: Cong Wang <cong.wang@bytedance.com>

[ Upstream commit defd8b3c37b0f9cb3e0f60f47d3d78d459d57fda ]

When sockfd_lookup() fails, gtp_encap_enable_socket() returns a
NULL pointer, but its callers only check for error pointers thus miss
the NULL pointer case.

Fix it by returning an error pointer with the error code carried from
sockfd_lookup().

(I found this bug during code inspection.)

Fixes: 1e3a3abd8b28 ("gtp: make GTP sockets in gtp_newlink optional")
Cc: Andreas Schultz <aschultz@tpip.net>
Cc: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Link: https://patch.msgid.link/20240825191638.146748-1-xiyou.wangcong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 931b65591f4d1..9b0b22b65cb25 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1220,7 +1220,7 @@ static struct sock *gtp_encap_enable_socket(int fd, int type,
 	sock = sockfd_lookup(fd, &err);
 	if (!sock) {
 		pr_debug("gtp socket fd=%d not found\n", fd);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	sk = sock->sk;
-- 
2.43.0




