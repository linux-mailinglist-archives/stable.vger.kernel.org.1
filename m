Return-Path: <stable+bounces-3960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D94803FE2
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9394F1C20BB8
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC6535EFC;
	Mon,  4 Dec 2023 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGFqefgP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7935EF6;
	Mon,  4 Dec 2023 20:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74FC433CB;
	Mon,  4 Dec 2023 20:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722193;
	bh=5aaVddaxnZ8/nE7jtW/8lqmeta3wu189jxHfWgQbNzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGFqefgP9MKZ83rtRL0dtF64fgNPtHm1OGFbVwUkkNbUFRN46SBMYbov1210SZOuQ
	 1X5s1sOLq3ZWa708xJjlSEGBs/jGasijqdIBRvX7RPVKZJMnANND8zzUxLOkrVuOhE
	 he9aFlKBa/gRfjus0Iks048ex3V9+XejS+rAjIDYVMzGQBu3NmLZrpKPbYvhMjcq6/
	 2NFs1zbJiS/l6dJwRtN7RhR7V/CatSqG9CTwihSHEfP8w9Tz6bZkZkzUeRi0q+r9yO
	 ohigYDBABLy1R6Z+AKBec5UkFYm3qG2SceduVH6oM2OxF+DTc2Y88ffzJtaxWVjTcc
	 /Q6kB4tGCSbhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	matttbe@kernel.org,
	martineau@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 04/10] mptcp: fix uninit-value in mptcp_incoming_options
Date: Mon,  4 Dec 2023 15:36:01 -0500
Message-ID: <20231204203616.2094529-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 237ff253f2d4f6307b7b20434d7cbcc67693298b ]

Added initialization use_ack to mptcp_parse_option().

Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index aa4b0cf7c6380..012e0e352276f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -103,6 +103,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-- 
2.42.0


