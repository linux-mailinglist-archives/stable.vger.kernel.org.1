Return-Path: <stable+bounces-3917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE0803F6E
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBE22812B3
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A033418F;
	Mon,  4 Dec 2023 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4aWd4t4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEF35EF5;
	Mon,  4 Dec 2023 20:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8A2C433C7;
	Mon,  4 Dec 2023 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722024;
	bh=40ewDILkJWQcO31G58cjJ0L3RCQpKqcx73H5B5VDZvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4aWd4t4td4C0EqD9IrW+Q8FLRpJM0p+/OHXF9zHEOMDNXpOZ6I5f2/3zURvtRGpc
	 PqssrxAf+PFRYr9R9VZLZ+NpRiR9u/hCrXYqYEMW5w7e293sDURoHvT6cZTbl01RcM
	 ykZ8jfo/HZQFl0viMRnMNFmwDaniGpcfOdjxlkkB3u3UX7LLUOIzkCOwaR9nr+Q9cD
	 V6tjOX5OcrzzMrc38CNXnKec5tQezZKQNKap8uhIwnl17wicgppTXZ5sc7m0sEg2/p
	 Nmhx4e7cRVyqDFYE4F/wCYRwHWhUdFIPt2YSVO4WKqgWaBt5piPj4xHmo0Zokue6eR
	 kS0GYyoI5Uvdw==
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
Subject: [PATCH AUTOSEL 6.6 10/32] mptcp: fix uninit-value in mptcp_incoming_options
Date: Mon,  4 Dec 2023 15:32:30 -0500
Message-ID: <20231204203317.2092321-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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
index cd15ec73073e0..c53914012d01d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-- 
2.42.0


