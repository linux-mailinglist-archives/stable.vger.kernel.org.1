Return-Path: <stable+bounces-145089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B2FABD9C4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4F6169895
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159C24290C;
	Tue, 20 May 2025 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcZHfho8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845522D4E7
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748432; cv=none; b=qcGlbxvs3FjAL+C9n6bjIKu0he/rxs7cpFUZYhutajpGkZke2ipO+tR5ktCODVEhRdQHDe1HshOW3x+bkl4XmoGKucLGLVLbcFh4BkHTVUoZZGpWadDPZWsp7lIoLjJ+iatHd4C/dSSQsjP2WsGqHXCprVtAv1khvhHzcEsC1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748432; c=relaxed/simple;
	bh=QjyxyEgifafdRpks9Wy6aH0dJnk6ErboHw92UjqpYXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKSaHtpoBe7ozZQ5B7ogAbT4alBxPdWymVPGmH8s6dx0EFmUB+lEnZIpmyJzISqtbtpfxmmPn4ULOthT/yuO6zYx7wAqQgJz0W2Zgcp0EEppSO/1iG5w9J3Q5ZJXW0G66UgkfWCMh1y/2n/YitaF79uX23OzyMqe/EdULcAJQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcZHfho8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65A9C4CEE9;
	Tue, 20 May 2025 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748432;
	bh=QjyxyEgifafdRpks9Wy6aH0dJnk6ErboHw92UjqpYXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcZHfho8AJFoSd3sES7f2l3v3Ij1W1GFEE3PatHCc6jlxkLphuJIQTiudlnx1TlUE
	 GlwzOPZdFer73F5H1QZvEByCWR3s+8qHt5QrzIsJmbMm+/OCkwTmNz152rEAebqqrN
	 16oQy7ysKPFyXRbmK9pXFkpxbXRv3T1IKxstvMpaHH2XG1wu0aUk+KcsVXJEymmvkv
	 xFaC183qL8NQ90RD+brYdZbXIqj9C1y+SrCICvJWoj1bkD00fhwhNQaQLb9cjkQz1/
	 GXuBG6oJidLX/1jTqBqmwVNzccxaGssIGiM5QTSc+SucesEmR0J1Vy52LIewW68gPi
	 W25qSHQfRZTUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] sctp: add mutual exclusion in proc_sctp_do_udp_port()
Date: Tue, 20 May 2025 09:40:30 -0400
Message-Id: <20250520061719-b373a10c429dd18f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520081532.1955511-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 10206302af856791fbcc27a33ed3c3eb09b2793d

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Eric Dumazet<edumazet@google.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: d3d7675d7762)
6.12.y | Present (different SHA1: e5178bfc55b3)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  10206302af856 ! 1:  cb2e2bdb78b82 sctp: add mutual exclusion in proc_sctp_do_udp_port()
    @@ Metadata
      ## Commit message ##
         sctp: add mutual exclusion in proc_sctp_do_udp_port()
     
    +    [ Upstream commit 10206302af856791fbcc27a33ed3c3eb09b2793d ]
    +
         We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_start()
         or risk a crash as syzbot reported:
     
    @@ Commit message
         Acked-by: Xin Long <lucien.xin@gmail.com>
         Link: https://patch.msgid.link/20250331091532.224982-1-edumazet@google.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## net/sctp/sysctl.c ##
    -@@ net/sctp/sysctl.c: static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
    +@@ net/sctp/sysctl.c: static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
      	return ret;
      }
      
     +static DEFINE_MUTEX(sctp_sysctl_mutex);
     +
    - static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
    + static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
      				 void *buffer, size_t *lenp, loff_t *ppos)
      {
    -@@ net/sctp/sysctl.c: static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
    +@@ net/sctp/sysctl.c: static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
      		if (new_value > max || new_value < min)
      			return -EINVAL;
      
    @@ net/sctp/sysctl.c: static int proc_sctp_do_udp_port(const struct ctl_table *ctl,
      		net->sctp.udp_port = new_value;
      		sctp_udp_sock_stop(net);
      		if (new_value) {
    -@@ net/sctp/sysctl.c: static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
    +@@ net/sctp/sysctl.c: static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
      		lock_sock(sk);
      		sctp_sk(sk)->udp_port = htons(net->sctp.udp_port);
      		release_sock(sk);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

