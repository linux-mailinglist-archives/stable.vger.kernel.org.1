Return-Path: <stable+bounces-3943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41992803FB7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75FEB20C53
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D535EF7;
	Mon,  4 Dec 2023 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nduiCaTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB335EE5;
	Mon,  4 Dec 2023 20:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10E5C433CB;
	Mon,  4 Dec 2023 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722128;
	bh=TO2hUxIrwspLrE7wt4l04hI0iwBtQjvaC94e820uD9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nduiCaTBCRJzLDNFeng5kAS7IC4GVhubkf/0UcpXzoR2h2T+CyoSwb3IBXY+kzPFU
	 J54fcSffBUk3t5qwbBN1J0lQLfLzOEbwPozFkV0fv7xVw2LhX67VM0n7ZglARb95MW
	 mZ+eOagOlLLarhgZ+y8bHQwKdzMgQIjBuwd8HVgxeJmncQkRoGkp5bbhemj5MJi5mo
	 PhO2Ax8IGAjVII49HTzUnzyC7pRQnFeFiDaINyvf/S2SU9uihhLCrx7isbb1rtFxip
	 dLwbDagqGN8/x/kyrI/uvMbW9jmwLTQeoD13iwmQUfXbhXHmzA1POuw4jSQ1gxkyyT
	 D6W1qIw6pYyHQ==
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
Subject: [PATCH AUTOSEL 6.1 04/17] mptcp: fix uninit-value in mptcp_incoming_options
Date: Mon,  4 Dec 2023 15:34:49 -0500
Message-ID: <20231204203514.2093855-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
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
index 0c786ceda5ee6..74027bb5b4296 100644
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


