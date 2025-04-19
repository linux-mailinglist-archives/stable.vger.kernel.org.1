Return-Path: <stable+bounces-134702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB846A94346
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EC217EB61
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478EF40BF5;
	Sat, 19 Apr 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7o2PRC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B971A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063440; cv=none; b=CGmDvDl65L6ty10kCRlC8CxBvP4YKSFhlFVWMWG2TjWY1wyYtRjl8iPrkiiO7TUIBhaZwmktwSaDJIep+ceRfB5qKlwz7O16JTajtGk8KOIXpLpF1CE7NPHttYMvSlmcQOtVNlJBPHuVj53Vrym055dIsygVjx3zz/oPlCxRWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063440; c=relaxed/simple;
	bh=V/Mweuv3DU+PVLHPtZl6WmlWT2gdt9pUMNT55zkcKKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYym29NZ1Gixplo8I2Mk42BAHHbJVWIPAWNLSfKRG5YpDUJjUs3+qYG/AKwgsiaFSIToJlIIjygLEQ6cQFs5wpr+5V7PmxU/B5Zej6v63LQhXbuv7r5KpU/7HrMy+69GA4uF/y+uxJPCpfY+CfZ9AB9yET4XgHpuDGmUJyVoTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7o2PRC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A46DC4CEE7;
	Sat, 19 Apr 2025 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063439;
	bh=V/Mweuv3DU+PVLHPtZl6WmlWT2gdt9pUMNT55zkcKKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7o2PRC0Xh6K3eQhIlLm+XgwaqZyxm/a4V1mQh64b8DRvlzJK/ECDdL4VOhoRqX+V
	 N+nhsIApc4G//dvS9aTheBtoQXifmWXQ/xqbx838rN1JLZdpX3EspRmfygnAaBx82J
	 tNHI1MRIsdEr4r/K7W+e7jqJ9yKdd2QZTQ3JpOehV0QYgNT/Wc6324XAjZ8SxrEqMh
	 Kp91t4gUK2DZjEXri+z7/DNg5TnCDGQa+2ahOd7NFvdnV8V/yzUVJtCXdm7++oDHb1
	 qU1KlNVlw9Xnr84cyiau8uPUCGcEYs9C/896nOmH/tqpJq2YSgpAT5gI7PjuJDqlXu
	 vUulsRG+Ij+ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/3] mptcp: fix NULL pointer in can_accept_new_subflow
Date: Sat, 19 Apr 2025 07:50:38 -0400
Message-Id: <20250418202945-31f6ff0fb3a1f4d9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418164556.3926588-6-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 443041deb5ef6a1289a99ed95015ec7442f141dc

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)"<matttbe@kernel.org>
Commit author: Gang Yan<yangang@kylinos.cn>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 4bf842c5219a)
6.13.y | Present (different SHA1: 17287762277c)
6.12.y | Present (different SHA1: 56a49eaa19a3)
6.6.y | Present (different SHA1: 1385117e486d)
6.1.y | Present (different SHA1: 820fc10033ea)
5.15.y | Present (different SHA1: 01cc5110710e)

Note: The patch differs from the upstream commit:
---
1:  443041deb5ef6 ! 1:  53310442b4043 mptcp: fix NULL pointer in can_accept_new_subflow
    @@ Metadata
      ## Commit message ##
         mptcp: fix NULL pointer in can_accept_new_subflow
     
    +    commit 443041deb5ef6a1289a99ed95015ec7442f141dc upstream.
    +
         When testing valkey benchmark tool with MPTCP, the kernel panics in
         'mptcp_can_accept_new_subflow' because subflow_req->msk is NULL.
     
    @@ Commit message
         Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
         Link: https://patch.msgid.link/20250328-net-mptcp-misc-fixes-6-15-v1-1-34161a482a7f@kernel.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Conflict in subflow.c because commit 74c7dfbee3e1 ("mptcp: consolidate
    +      in_opt sub-options fields in a bitmask") is not in this version. The
    +      conflict is in the context, and the modification can still be applied.
    +      Note that subflow_add_reset_reason() is not needed here, because the
    +      related feature is not supported in this version. ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/subflow.c ##
     @@ net/mptcp/subflow.c: static bool subflow_hmac_valid(const struct request_sock *req,
    @@ net/mptcp/subflow.c: static bool subflow_hmac_valid(const struct request_sock *r
     -	if (!msk)
     -		return false;
      
    - 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
    - 			      READ_ONCE(msk->local_key),
    + 	subflow_generate_hmac(msk->remote_key, msk->local_key,
    + 			      subflow_req->remote_nonce,
     @@ net/mptcp/subflow.c: static struct sock *subflow_syn_recv_sock(const struct sock *sk,
    - 
    + 			fallback = true;
      	} else if (subflow_req->mp_join) {
      		mptcp_get_options(skb, &mp_opt);
    --		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
    --		    !subflow_hmac_valid(req, &mp_opt) ||
    +-		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
     -		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
     -			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
    -+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
    ++		if (!mp_opt.mp_join)
      			fallback = true;
     -		}
      	}
      
      create_child:
     @@ net/mptcp/subflow.c: static struct sock *subflow_syn_recv_sock(const struct sock *sk,
    + 			if (!owner)
      				goto dispose_child;
    - 			}
      
     +			if (!subflow_hmac_valid(req, &mp_opt) ||
     +			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
     +				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
    -+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
     +				goto dispose_child;
     +			}
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

