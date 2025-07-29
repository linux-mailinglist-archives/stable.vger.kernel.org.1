Return-Path: <stable+bounces-165128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE7B153B0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0974E6ED8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3E29AAF3;
	Tue, 29 Jul 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKDPvUWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4529A9FA
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817860; cv=none; b=lHqBph7qBA00Rrp3GgcnaMhAOi1SN4WSR/7B0Za+MLxbw8Qx5cpQGsxB/7y1+Sk2BH795b2UpznhBMfvEgk2hpINGY4HMcDnd3oFNoqvXJDdvgmuCGpGhNZ/RiQ63X5xV0OGj8T1kPrGLlCGX4BsGhCp3zf2zmnSSOd1qNQROP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817860; c=relaxed/simple;
	bh=NYwZ0IKuwtNmLbm+ttI2dEgFdSYtLDktVOsXYBFXFbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmF8TZdqUdGN8KGbnzI4BOf0i+xHECyFC0Gskb7uw+ZZ2W++kjFzWRcHfLPaI1yW0gdR53qls0gleraPFTEltDTGkHPLR8Mh9HAwbV4ILLZfgqDydvLjWqZUu7tl86xTH9C4hGXiLAeeqGmMTx7inOej18LREPusimGpJhcWRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKDPvUWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D38C4CEF7;
	Tue, 29 Jul 2025 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817860;
	bh=NYwZ0IKuwtNmLbm+ttI2dEgFdSYtLDktVOsXYBFXFbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKDPvUWojj7Noc44AQNKUaZnYRO1xrfSj5w9oNmI2+5zALeksTKVSlubPV0YWSlhM
	 7dlZMcYyTr9B8sBCdilLf0Ia7Yw8PU5rcPz8FJga/88V8IUAFv50IRjZSYcqDz8Dpr
	 jhI57XY3sgH64CkqZmktzX8rAqcNtmAJ1NIwzZWYMbqMcV11aEapVKNR23oZFM/2pr
	 +XFRtOjRXm2X+n50I2IwBqkN5xbxUuqbL6F/e1GiOqI3d1OrrZ63qU5LHAnwn1jLkM
	 ZLytF2oHC/JnhdfG/Ums0V74YSx9lPE0X8VQ7lzfK+Ao6fnbNNFjI9eVwGlWxL6PJ9
	 1Fq21sZAUP/gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/3] mptcp: make fallback action and fallback decision atomic
Date: Tue, 29 Jul 2025 15:37:37 -0400
Message-Id: <1753816507-dc78ebea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728132919.3904847-6-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: f8a1d9b18c5efc76784f5a326e905f641f839894

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f8a1d9b18c5e ! 1:  7a5c4c08bc0b mptcp: make fallback action and fallback decision atomic
    @@ Metadata
      ## Commit message ##
         mptcp: make fallback action and fallback decision atomic
     
    +    commit f8a1d9b18c5efc76784f5a326e905f641f839894 upstream.
    +
         Syzkaller reported the following splat:
     
           WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 __mptcp_do_fallback net/mptcp/protocol.h:1223 [inline]
    @@ Commit message
         Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
         Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-1-391aff963322@kernel.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Conflicts in protocol.h, because commit 6ebf6f90ab4a ("mptcp: add
    +      mptcpi_subflows_total counter") is not in this version, and this
    +      causes conflicts in the context. Commit 65b02260a0e0 ("mptcp: export
    +      mptcp_subflow_early_fallback()") is also not in this version, and
    +      moves code from protocol.c to protocol.h, but the modification can
    +      still apply there. Conflicts in protocol.c because commit ee2708aedad0
    +      ("mptcp: use get_retrans wrapper") is not in this version and refactor
    +      the code in __mptcp_retrans(), but the modification can still be
    +      applied, just not at the same indentation level. There were other
    +      conflicts in the context due to commit 8005184fd1ca ("mptcp: refactor
    +      sndbuf auto-tuning"), commit b3ea6b272d79 ("mptcp: consolidate initial
    +      ack seq generation"), and commit 013e3179dbd2 ("mptcp: fix rcv space
    +      initialization") that are not in this version. ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/options.c ##
     @@ net/mptcp/options.c: static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
    @@ net/mptcp/protocol.c: static bool __mptcp_finish_join(struct mptcp_sock *msk, st
      	 * at close time
      	 */
     @@ net/mptcp/protocol.c: static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
    + 		mptcp_sock_graft(ssk, sk->sk_socket);
      
    - 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
      	mptcp_sockopt_sync_locked(msk, ssk);
     -	mptcp_subflow_joined(msk, ssk);
      	mptcp_stop_tout_timer(sk);
    - 	__mptcp_propagate_sndbuf(sk, ssk);
      	return true;
    + }
     @@ net/mptcp/protocol.c: static void mptcp_update_infinite_map(struct mptcp_sock *msk,
      	mpext->infinite_map = 1;
      	mpext->data_len = 0;
    @@ net/mptcp/protocol.c: static void mptcp_check_fastclose(struct mptcp_sock *msk)
      {
     +	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
      	struct mptcp_sock *msk = mptcp_sk(sk);
    - 	struct mptcp_subflow_context *subflow;
     -	struct mptcp_sendmsg_info info = {};
      	struct mptcp_data_frag *dfrag;
    + 	size_t copied = 0;
      	struct sock *ssk;
    - 	int ret, err;
     @@ net/mptcp/protocol.c: static void __mptcp_retrans(struct sock *sk)
    - 			info.sent = 0;
    - 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
    - 								    dfrag->already_sent;
    + 	/* limit retransmission to the bytes already sent on some subflows */
    + 	info.sent = 0;
    + 	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
     +
    -+			/*
    -+			 * make the whole retrans decision, xmit, disallow
    -+			 * fallback atomic
    -+			 */
    -+			spin_lock_bh(&msk->fallback_lock);
    -+			if (__mptcp_check_fallback(msk)) {
    -+				spin_unlock_bh(&msk->fallback_lock);
    -+				release_sock(ssk);
    -+				return;
    -+			}
    ++	/* make the whole retrans decision, xmit, disallow fallback atomic */
    ++	spin_lock_bh(&msk->fallback_lock);
    ++	if (__mptcp_check_fallback(msk)) {
    ++		spin_unlock_bh(&msk->fallback_lock);
    ++		release_sock(ssk);
    ++		return;
    ++	}
     +
    - 			while (info.sent < info.limit) {
    - 				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
    - 				if (ret <= 0)
    + 	while (info.sent < info.limit) {
    + 		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
    + 		if (ret <= 0)
     @@ net/mptcp/protocol.c: static void __mptcp_retrans(struct sock *sk)
    - 					 info.size_goal);
    - 				WRITE_ONCE(msk->allow_infinite_fallback, false);
    - 			}
    -+			spin_unlock_bh(&msk->fallback_lock);
    + 			 info.size_goal);
    + 		WRITE_ONCE(msk->allow_infinite_fallback, false);
    + 	}
    ++	spin_unlock_bh(&msk->fallback_lock);
      
    - 			release_sock(ssk);
    - 		}
    -@@ net/mptcp/protocol.c: static void __mptcp_init_sock(struct sock *sk)
    - 	msk->last_ack_recv = tcp_jiffies32;
    + 	release_sock(ssk);
    + 
    +@@ net/mptcp/protocol.c: static int __mptcp_init_sock(struct sock *sk)
    + 	msk->recovery = false;
      
      	mptcp_pm_data_init(msk);
     +	spin_lock_init(&msk->fallback_lock);
    @@ net/mptcp/protocol.c: bool mptcp_finish_join(struct sock *ssk)
     +		}
      		mptcp_subflow_joined(msk, ssk);
     +		spin_unlock_bh(&msk->fallback_lock);
    - 		mptcp_propagate_sndbuf(parent, ssk);
      		return true;
      	}
    + 
    +@@ net/mptcp/protocol.c: static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
    + 					 struct mptcp_subflow_context *subflow)
    + {
    + 	subflow->request_mptcp = 0;
    +-	__mptcp_do_fallback(msk);
    ++	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
    + }
    + 
    + static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
     
      ## net/mptcp/protocol.h ##
     @@ net/mptcp/protocol.h: struct mptcp_sock {
    - 	u32		subflow_id;
    - 	u32		setsockopt_seq;
    + 
    + 	u32 setsockopt_seq;
      	char		ca_name[TCP_CA_NAME_MAX];
     +
     +	spinlock_t	fallback_lock;	/* protects fallback and
    @@ net/mptcp/protocol.h: static inline bool mptcp_check_fallback(const struct sock
     -static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
     +static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
      {
    - 	if (__mptcp_check_fallback(msk)) {
    + 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
      		pr_debug("TCP fallback already done (msk=%p)\n", msk);
     -		return;
     +		return true;
    @@ net/mptcp/protocol.h: static inline bool mptcp_check_fallback(const struct sock
     +	return true;
      }
      
    - static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
    -@@ net/mptcp/protocol.h: static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
    - 			TCPF_SYN_RECV | TCPF_LISTEN));
    - }
    - 
     -static inline void mptcp_do_fallback(struct sock *ssk)
     +static inline bool mptcp_try_fallback(struct sock *ssk)
      {
    @@ net/mptcp/protocol.h: static inline void mptcp_do_fallback(struct sock *ssk)
      }
      
      #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
    -@@ net/mptcp/protocol.h: static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
    - {
    - 	pr_fallback(msk);
    - 	subflow->request_mptcp = 0;
    --	__mptcp_do_fallback(msk);
    -+	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
    - }
    - 
    - static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
     
      ## net/mptcp/subflow.c ##
     @@ net/mptcp/subflow.c: static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
    @@ net/mptcp/subflow.c: static void subflow_finish_connect(struct sock *sk, const s
      			MPTCP_INC_STATS(sock_net(sk),
      					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
     -			mptcp_do_fallback(sk);
    - 			pr_fallback(msk);
    + 			pr_fallback(mptcp_sk(subflow->conn));
      			goto fallback;
      		}
     @@ net/mptcp/subflow.c: static bool subflow_check_data_avail(struct sock *ssk)
    @@ net/mptcp/subflow.c: static bool subflow_check_data_avail(struct sock *ssk)
      			 * subflow_error_report() will introduce the appropriate barriers
      			 */
     @@ net/mptcp/subflow.c: static bool subflow_check_data_avail(struct sock *ssk)
    - 			WRITE_ONCE(subflow->data_avail, false);
    + 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
      			return false;
      		}
     -
    @@ net/mptcp/subflow.c: static bool subflow_check_data_avail(struct sock *ssk)
      	}
      
      	skb = skb_peek(&ssk->sk_receive_queue);
    -@@ net/mptcp/subflow.c: int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
    +@@ net/mptcp/subflow.c: int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
      	/* discard the subflow socket */
      	mptcp_sock_graft(ssk, sk->sk_socket);
      	iput(SOCK_INODE(sf));
    @@ net/mptcp/subflow.c: int __mptcp_subflow_connect(struct sock *sk, const struct m
      	return 0;
      
     @@ net/mptcp/subflow.c: static void subflow_state_change(struct sock *sk)
    - 
      	msk = mptcp_sk(parent);
      	if (subflow_simultaneous_connect(sk)) {
    + 		mptcp_propagate_sndbuf(parent, sk);
     -		mptcp_do_fallback(sk);
     +		WARN_ON_ONCE(!mptcp_try_fallback(sk));
    + 		mptcp_rcv_space_init(msk, sk);
      		pr_fallback(msk);
      		subflow->conn_finished = 1;
    - 		mptcp_propagate_state(parent, sk, subflow, NULL);

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

