Return-Path: <stable+bounces-164964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A8B13D06
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DEC165F0B
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDED26D4CF;
	Mon, 28 Jul 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUfGjEk1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4B26D4CD
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712432; cv=none; b=swC6FTBl1Q7ogtCLycA6ZeOv8N32qWJ4oKwG+Gwh9kj+UUd4CjcfpwKtAeC55ueWCB3QDyQOKHHs4zLZrvrtOZRWkpww5w8CjlM5XJ6qX0Go4tVihzhbziS01FVFuBUeWvuU8/rd3iueDTn0wRbN0yOLdUcFW8ws4172doGvsE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712432; c=relaxed/simple;
	bh=DJ9hz+da0Z/t2ADFl/uylITjVLM0R08RiFIEugJ4D/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXUlCOQM2NvYL8RtiDKYL/HG/47s9hGHTLM13DXG46RLIMlvdaKyU2qhZ+CwanAL/g7jtujDnKObryzjZPoWI5gTIoHMt6zJRM998IK9G4Ij+HxxRvZ0EpP1FiI9WdeMc2IYMV+rwV0npfUGpQw2PQauBGfm1G74hqnncxcDmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUfGjEk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB830C4CEE7;
	Mon, 28 Jul 2025 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712432;
	bh=DJ9hz+da0Z/t2ADFl/uylITjVLM0R08RiFIEugJ4D/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUfGjEk1zkLSm7WbcrVLj6w/DW7akBr02hd0Y9ZLrqHhz71IBIlsrPOmrTJibnmSq
	 7aPo3RL9y+dqFVebc23ZmjEREC4oJzn6H29J7o8ihGuu23/nfkXU2YYLaKvJXyhIp3
	 0M/fxqsNj1XRpG5O5HXuyJcPhBasnolOrUxw2jKlKG1O5iu+e078LaogEfDQlEmkcM
	 MsPr0ti0THCfpMezsA4Q8Y2WGVfaCkN4v7VJCX1maCjkywitH7pT7cYC70r44AHaCF
	 zcsDOWsrQrJsk4zdboKVLxIekDxMw4zePqquyzd9ADxRcD5kt67nzgwBXxCrkgQWJ4
	 S9fi093BRF95A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/3] mptcp: make fallback action and fallback decision atomic
Date: Mon, 28 Jul 2025 10:20:29 -0400
Message-Id: <1753710242-29a4cacf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728091448.3494479-6-matttbe@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  f8a1d9b18c5e ! 1:  6ccd3bb7c647 mptcp: make fallback action and fallback decision atomic
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
    +      still apply there. ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/options.c ##
     @@ net/mptcp/options.c: static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
    @@ net/mptcp/protocol.c: static void __mptcp_retrans(struct sock *sk)
      			release_sock(ssk);
      		}
     @@ net/mptcp/protocol.c: static void __mptcp_init_sock(struct sock *sk)
    - 	msk->last_ack_recv = tcp_jiffies32;
    + 	msk->subflow_id = 1;
      
      	mptcp_pm_data_init(msk);
     +	spin_lock_init(&msk->fallback_lock);
    @@ net/mptcp/protocol.c: bool mptcp_finish_join(struct sock *ssk)
      		mptcp_propagate_sndbuf(parent, ssk);
      		return true;
      	}
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

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

