Return-Path: <stable+bounces-192097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E9C29A11
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5578634720C
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CD91D5174;
	Sun,  2 Nov 2025 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li5IjKU3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830EF34D380
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762126060; cv=none; b=qImc7RrVlFQKQGeJO40Ih8TXc2SRapJh441t/h7Gvv5DdISnsslsu3M5cJAofA8yf1AkBJ4az9lz4gvOfLY9Xv62Cf0F25YfCnawS8iM25tHgoSIgFI5ix3dFs+tjpatOmHaDi5EsXisEtCMdrzW2jRGKCBeoPawmLLMgLTGJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762126060; c=relaxed/simple;
	bh=C9aRCFRgNw7rY3VbsMWR+TrA4M4ux1IrW0WKa+3HgUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMgTaSt9SuUXx//CbfqRC6UmHyJMoGGbBUWcQRxi51ttsAZsZ8R6oSASnzSEhqHUK7YcPk4fK/m60Pd6okX3PmP2HcNnPXnOEk1zs0GG7wr5Jn+6Rz1GDaxeFxyfdwVgThKAiUNlDZCFTytCupQkNeFylDdWzylRqIubUJpVC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li5IjKU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670F4C116C6;
	Sun,  2 Nov 2025 23:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762126060;
	bh=C9aRCFRgNw7rY3VbsMWR+TrA4M4ux1IrW0WKa+3HgUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li5IjKU38HCEpO77KfZCCJOCN9zPX6Im5a0RD0avoAFrlVuZFbkBA5KBXbRoxDkVB
	 7jUHHLFgiNrZocTAxcamJ9RDz/gf0olOQsKVLHQL1XJEQ+3lysR8h30c6xA38sEU3W
	 1mXCC9cpHU3jJUK56yz1XNHXSSVyO0+3tGFtS7EntNI+T4r8Fsm4xUgpcN+GVpvLI1
	 VB+AkBUAa+hwUr1EIa97G7GsOXguYkxTxT8H+Xh+v/gdpwvyDCnpNFPY8qzznzFR+H
	 avWhhUEzVmvV6HV+Cbigq6cfWdBOGf9LRZ6Rgkmcl3+W0NDiLrja03D32T/gIDI5De
	 EUajQeqNJ8Y+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mptcp: leverage skb deferral free
Date: Sun,  2 Nov 2025 18:27:34 -0500
Message-ID: <20251102232735.3652847-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102232735.3652847-1-sashal@kernel.org>
References: <2025110208-pond-pouring-512d@gregkh>
 <20251102232735.3652847-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9aa59323f2709370cb4f01acbba599a9167f317b ]

Usage of the skb deferral API is straight-forward; with multiple
subflows actives this allow moving part of the received application
load into multiple CPUs.

Also fix a typo in the related comment.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250927-net-next-mptcp-rcv-path-imp-v1-1-5da266aa9c1a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 85a6ea13a44db..4baa3fe842c92 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1944,12 +1944,13 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
+			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
+			skb->sk = NULL;
 			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			skb_attempt_defer_free(skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.51.0


