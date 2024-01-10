Return-Path: <stable+bounces-10003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B30826E10
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8268C28300F
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E71C44C9C;
	Mon,  8 Jan 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQep2QIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1044C97;
	Mon,  8 Jan 2024 12:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C07C433A9;
	Mon,  8 Jan 2024 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716935;
	bh=0pMd2NkwNypVAaJM69uyrT+5T8QfS6QQ5RO+ZUtRpXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQep2QIxQnkNOwduR2ZOD8jLRpKQ6Fy+7LpEVHLVsZJBUW8N+gbPfZ10lsFAhRL4Q
	 3S6coIsvQ/mUQs/OG7oXCkZAw3+3hbPKu5W//EWJkhY4XdYOW3KoZkx42kC5Xi/fAq
	 KtyIH4iIRi5qt/VG74LpVcUCUKL6tFEISp3OOwPlhn73jSgwklvb+LCdQh+fIQj3z6
	 d5UWsHAitC4bizaGvJCRavHqg3qq/MoIedfZ91cfKt2+rN30CdreYB0P7RdCf+RoMJ
	 8lzkq/ofm/QG9WJOFAgwD+aut2YFUu1zernUBmq31CghRR7ipuAgrDG8fuoBG0ZP7H
	 s82uC9qM76NAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sarannya S <quic_sarannya@quicinc.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/3] net: qrtr: ns: Return 0 if server port is not present
Date: Mon,  8 Jan 2024 07:28:45 -0500
Message-ID: <20240108122849.2090674-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122849.2090674-1-sashal@kernel.org>
References: <20240108122849.2090674-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.146
Content-Transfer-Encoding: 8bit

From: Sarannya S <quic_sarannya@quicinc.com>

[ Upstream commit 9bf2e9165f90dc9f416af53c902be7e33930f728 ]

When a 'DEL_CLIENT' message is received from the remote, the corresponding
server port gets deleted. A DEL_SERVER message is then announced for this
server. As part of handling the subsequent DEL_SERVER message, the name-
server attempts to delete the server port which results in a '-ENOENT' error.
The return value from server_del() is then propagated back to qrtr_ns_worker,
causing excessive error prints.
To address this, return 0 from control_cmd_del_server() without checking the
return value of server_del(), since the above scenario is not an error case
and hence server_del() doesn't have any other error return value.

Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3e40a1ba48f79..4a13b9f7abb44 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -569,7 +569,9 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 	if (!node)
 		return -ENOENT;
 
-	return server_del(node, port, true);
+	server_del(node, port, true);
+
+	return 0;
 }
 
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
-- 
2.43.0


