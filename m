Return-Path: <stable+bounces-192079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49CCC2959A
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 20:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623F63ADB78
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8523BCE3;
	Sun,  2 Nov 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc0csNOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44F23C8A1
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110011; cv=none; b=h1ejRotTEe2tPc1dRX2cVYkmr1CxiUqFu7RjTzwkIGMd4Hgz8Lf8FZv1cJDxvHwsuD+8JAQFEHpeH/XwfHQeHqIK+FmHmpzJhybwQX++ONaIYaKhqd1L2MT/9uskv8HrPXgr+r9or04sCvCafzNcV0N1tUJ9S06+7A+n4MWeuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110011; c=relaxed/simple;
	bh=NZw8xr+3Pldh04mf7I2f1xKH8695FoVZXLOvSA5Y0ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg/uyBeJ3so/kWPh4mHrEkoeh8rBcNbuYIRMPFITMxdX5qbplt1WKhevxO/nDHbB+M4mM12MLsl/EGu9RdrrB+9IrBbCkrdkjdWTuQkcoBjJddYD1yKup0hiznP/gscXHGiyb63nzWUApZmZqA/79ekzRphp9hyvCpRdw+q2vOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc0csNOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E757EC116B1;
	Sun,  2 Nov 2025 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762110010;
	bh=NZw8xr+3Pldh04mf7I2f1xKH8695FoVZXLOvSA5Y0ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc0csNOeiNl84+s02azZy27rnvuQRYeF9cJ90qEd6iXqYyhLzv23pnTmCi2AskMik
	 cf/Lbmgt2kUL1KFGBkLsLK0yjUhQqGGUmADI9Wl8uZvCbp2fmxYD+mHD+87hbtrVDB
	 CJ1Q7Vh0xRG/qC06Hp3/DCKcu03TERasqjFMIG3tw1h8GqdX8uGbo2W9F7415eQ6qF
	 OMUlDPv0LY7i/QZ6F2YTjVOHUSel0qaxvPFj75MmcyTUwvFsp2urw14tXCUxPfA2dj
	 blyecTiWn74qA+DQt+ZQNqmP98gIHf/2V3PYqboe4kXBIANgyvMZP8DNuujUAykYaH
	 kz3WdZefWjILg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mptcp: drop bogus optimization in __mptcp_check_push()
Date: Sun,  2 Nov 2025 14:00:03 -0500
Message-ID: <20251102190003.3553215-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102190003.3553215-1-sashal@kernel.org>
References: <2025110239-gender-concise-c9df@gregkh>
 <20251102190003.3553215-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 27b0e701d3872ba59c5b579a9e8a02ea49ad3d3b ]

Accessing the transmit queue without owning the msk socket lock is
inherently racy, hence __mptcp_check_push() could actually quit early
even when there is pending data.

That in turn could cause unexpected tx lock and timeout.

Dropping the early check avoids the race, implicitly relaying on later
tests under the relevant lock. With such change, all the other
mptcp_send_head() call sites are now under the msk socket lock and we
can additionally drop the now unneeded annotation on the transmit head
pointer accesses.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251028-net-mptcp-send-timeout-v1-1-38ffff5a9ec8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ split upstream __subflow_push_pending change across __mptcp_push_pending and __mptcp_subflow_push_pending ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 13 +++++--------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cfbc7ef3b211d..87a17216737ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1101,7 +1101,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			if (WARN_ON_ONCE(!msk->recovery))
 				break;
 
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			msk->first_pending = mptcp_send_next(sk);
 		}
 
 		dfrag_clear(sk, dfrag);
@@ -1686,7 +1686,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1742,7 +1742,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 	}
 
 out:
@@ -1912,7 +1912,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
-				WRITE_ONCE(msk->first_pending, dfrag);
+				msk->first_pending = dfrag;
 		}
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
@@ -2910,7 +2910,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 
-	WRITE_ONCE(msk->first_pending, NULL);
+	msk->first_pending = NULL;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
 }
@@ -3491,9 +3491,6 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
-	if (!mptcp_send_head(sk))
-		return;
-
 	if (!sock_owned_by_user(sk))
 		__mptcp_subflow_push_pending(sk, ssk, false);
 	else
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 81507419c465e..6b1d86fd3a8e7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -360,7 +360,7 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return READ_ONCE(msk->first_pending);
+	return msk->first_pending;
 }
 
 static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
-- 
2.51.0


