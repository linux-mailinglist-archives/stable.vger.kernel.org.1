Return-Path: <stable+bounces-125659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21535A6A7D4
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6023E3B6F6A
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34623A6;
	Thu, 20 Mar 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBAJGt8D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC11EB1B7
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479181; cv=none; b=cIdT72O37aH3GM6m5wWAYfdEt3We3FB5OvSijpAkmnmhQkPN5+WjnAP0Uq7LL7Xfgd7/VvqkqF+1/rbNrVzq37Er0VIXGjXZ3MtoREqnAlNo77rMmkzZt/QiYhDxBNLnZflH3DLuKELC8vcqRBuLVSTDLKtMKWdiLU7Vse5Z/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479181; c=relaxed/simple;
	bh=CTSpCc3qzXoBLSc5aSnDueId8s+rrNwv6zPDRDgimpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dm/pmPc29jE4wUEGGg6wyWaxF+chAAWCY7Yi8t8NkdCroDCruQVAqlAr8jetsphThASTO7nzeUL5OWrfTyHGPW2HqyC3gCY22ZTCcPiD1k5A5Gc7DOfTPvnVJEAncHop07JBDACWI6E96Ugdqf2DMSoRufbSqivUycrEPmi0bgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBAJGt8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3DC4CEDD;
	Thu, 20 Mar 2025 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742479180;
	bh=CTSpCc3qzXoBLSc5aSnDueId8s+rrNwv6zPDRDgimpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBAJGt8DPKaxStirp5fF8MLbwH07fe2Z/McsQ86We0kgSuBKEl3gcoq5wliMf4BNw
	 8Ju4MO3HwOogv6bmeN/sRjbj7508Tzs/2PPirehtkSpYUu2xRy9jISYOE9tynpeUpr
	 MkEQe3aqDco8T85Y8sSIzh3SLCXDwTo7o65Ux4efSedohMZG5X5B50zivm+Opj5Ojg
	 bcBenFghXkkiyPhGJPhd7MrBEs2pu32iqYSM67WBPpMCrz8NUQKDfzHJxJZwTBvmVX
	 VAiWafQiSp+cmg0Psno2Ov48Zfj8tEG6/mdblBr7pzvTc8vmb+b3Pn0QjxZUVD8Gbx
	 B0hlkU84B7fRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Thu, 20 Mar 2025 09:59:28 -0400
Message-Id: <20250319230319-f7f0d5d4cfe35786@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250320012803.1740284-1-bin.lan.cn@windriver.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: e8c526f2bdf1845bedaf6a478816a3d06fa78b8f

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 997ae8da14f1)
6.1.y | Present (different SHA1: 5071beb59ee4)
5.15.y | Present (different SHA1: 8459d61fbf24)

Found fixes commits:
c31e72d021db tcp: Fix use-after-free of nreq in reqsk_timer_handler().

Note: The patch differs from the upstream commit:
---
1:  e8c526f2bdf18 ! 1:  a87888675b240 tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
    @@ Metadata
      ## Commit message ##
         tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
     
    +    [ Upstream commit e8c526f2bdf1845bedaf6a478816a3d06fa78b8f ]
    +
         Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
     
           """
    @@ Commit message
         Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
         Link: https://patch.msgid.link/20241014223312.4254-1-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## net/ipv4/inet_connection_sock.c ##
     @@ net/ipv4/inet_connection_sock.c: static bool reqsk_queue_unlink(struct request_sock *req)
    - 		found = __sk_nulls_del_node_init_rcu(sk);
    + 		found = __sk_nulls_del_node_init_rcu(req_to_sk(req));
      		spin_unlock(lock);
      	}
     -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
    @@ net/ipv4/inet_connection_sock.c: static bool reqsk_queue_unlink(struct request_s
      
      void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
     @@ net/ipv4/inet_connection_sock.c: static void reqsk_timer_handler(struct timer_list *t)
    - 
    - 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
    - 			/* delete timer */
    --			inet_csk_reqsk_queue_drop(sk_listener, nreq);
    -+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
    - 			goto no_ownership;
    - 		}
    - 
    -@@ net/ipv4/inet_connection_sock.c: static void reqsk_timer_handler(struct timer_list *t)
    + 		return;
      	}
    - 
      drop:
    --	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
    -+	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
    +-	inet_csk_reqsk_queue_drop_and_put(sk_listener, req);
    ++	__inet_csk_reqsk_queue_drop(sk_listener, req, true);
     +	reqsk_put(req);
      }
      
    - static bool reqsk_queue_hash_req(struct request_sock *req,
    + static void reqsk_queue_hash_req(struct request_sock *req,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

