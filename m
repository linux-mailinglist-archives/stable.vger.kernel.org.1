Return-Path: <stable+bounces-95234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527B9D7470
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A354281A2E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7923D676;
	Sun, 24 Nov 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYc5P8LC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C01E3DCD;
	Sun, 24 Nov 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456422; cv=none; b=QSBOdwCE+4pVYjZyv4XY0YK1uykXCmHHmtmSmsMD8D9I/JfIFRAZEhZsYcJyZxtm9+Do9fXX90dKFzurGpSM0dILdScjyv3m+rj3ngW3dtVka+Eu49NPU2coB/8RvJApQ/J+2e7zQdMShn/wCOYA+cFjUw/x4BHQpfEXb3VBIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456422; c=relaxed/simple;
	bh=xsImaJA2APsVtfOlgrgkrE0mAEbI4PKaOnhNzHdsd6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnyZqJ7ot5bKVa+dF9aPoOpaCy9cAx0v8jSB1tE5lrvRrfHs8Uf6BTwY3KGRBDB2R227jNzqeghH95AjYAnA2up4+4W1uOVOkLdP1DuvQk1ouQkHvNhpGiNz1bms86VTnmLfVTGMuR8jgbJ9l021ynUJmUpBVp797iIsL+V7Wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYc5P8LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84928C4CECC;
	Sun, 24 Nov 2024 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456422;
	bh=xsImaJA2APsVtfOlgrgkrE0mAEbI4PKaOnhNzHdsd6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYc5P8LCEPJg0DxZ2/o54YtI7yIlGv0u+jdKbXwNzA16uVgoTQMEMBsyxYlDPV18E
	 bzbCn7QNGJ1N7/2pVyTjB1aKEgqJw8G//FPsHPia7O0VDJ212NDHFf0FOTdT+KoKhY
	 BilYQ4aKQ0P6UADjHyy+LpIEK8wpmBEXdf9zicT/nKlZfr/oYvUOqSf4PYZ1XqzkEV
	 G7InmFvmS3EPcTVo2MrPvHgnMPXi9KTqz4CIjjPcUg9E+al6NocnuvKjWxH8tlb5Ov
	 p1JSuY0K3/FgbrukpYqO0gfFV9Av4tQ/UyBedvRWcYdkTgRnKq6CpjFsgbsiRa99Be
	 ebv6wq+mq99DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	gnaaman@drivenets.com,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	judyhsiao@chromium.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 35/36] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:51:49 -0500
Message-ID: <20241124135219.3349183-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0de6a472c3b38432b2f184bd64eb70d9ea36d107 ]

Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
data checking") added strict checking. The err variable is not cleared,
so if we find no table to dump we will return the validation error even
if user did not want strict checking.

I think the only way to hit this is to send an buggy request, and ask
for a table which doesn't exist, so there's no point treating this
as a real fix. I only noticed it because a syzbot repro depended on it
to trigger another bug.

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241115003221.733593-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5829477efbba5..6f3bd1a4ec8ca 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2738,6 +2738,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0


