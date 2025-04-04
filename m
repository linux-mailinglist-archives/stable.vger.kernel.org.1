Return-Path: <stable+bounces-128296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEAA7BCB0
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C434017A472
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A751D9324;
	Fri,  4 Apr 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvpaocFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0E1D47AD
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769868; cv=none; b=RPJztHQBTPyYDXay+BbWUfWL8IiJybENObAdtQcpTrVomXRQQbcYLNm2fmTdhpfNtw5scCxBOxAaYgHf59d729+dMHB6/YKQlSp3BXa5HHcwiRrDBDweQOke9ZciMoZyNGv5uegZ+3T6Pz0rFKqbGqfubCXQZ/aXlZFI0OykhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769868; c=relaxed/simple;
	bh=D8rnM99yQUt85WCIncaAVVa+iJbUOL/gYV4Hb6hm0cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9VS3l1LHZdjW1pIEG6Ohs23BQj56Vb4CVCDB/Uop2jZtKD6q9TXf4FCtiEiLWDsJHXdA86+F8/kt4wo9DtPybxhVGpBvuqqBXHNAICUTv7iP7/QwCPNkxrCuEaj5nRUdW6gFRI99HQTH2koAJcOTwyKFkEksUoh4FOboRFDJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvpaocFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E5C4CEDD;
	Fri,  4 Apr 2025 12:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743769867;
	bh=D8rnM99yQUt85WCIncaAVVa+iJbUOL/gYV4Hb6hm0cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvpaocFwXzXNHHKL2nwqWBDeu5aqoqPpLG7U1NPjL3exm8MQU756z0OHecumJRiM5
	 hSbwaPstZ7OnhZTg/5XAjnDU4D85si8gWIt3uAHgv2t8WYESSS01EoUr7TUytGP81r
	 ujHyLLtKyQeGlZP6T6nJHMpm/EmZXifYBqHiEp+1rHmqVrB8reaaIQ11ZQjqu3wPNu
	 RAxcmYV+oS9LglP+LdmbEIUdHJBnGk/BJubCrD3LK7OnHPtOs3ik5Fh3QWgtUFRaqw
	 UtPHfOxv4fky77leGTPRadeYtLFga/uJ+S/z2QNfue00LlGS1gfuLuvQdhLvRB7QDd
	 KeM77fgUiwTjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zcgao@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Fri,  4 Apr 2025 08:31:05 -0400
Message-Id: <20250403224210-249b8b680ba979d8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403172023.98206-1-zcgao@amazon.com>
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
Backport author: Nathan Gao<zcgao@amazon.com>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 997ae8da14f1)
6.1.y | Present (different SHA1: 5071beb59ee4)
5.15.y | Present (different SHA1: 8459d61fbf24)
5.10.y | Not found

Found fixes commits:
c31e72d021db tcp: Fix use-after-free of nreq in reqsk_timer_handler().

Note: The patch differs from the upstream commit:
---
1:  e8c526f2bdf18 ! 1:  a2faf327265e4 tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
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
    +    [Resolved conflicts due to context difference]
    +    Signed-off-by: Nathan Gao <zcgao@amazon.com>
     
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
| stable/linux-5.4.y        |  Success    |  Success   |

