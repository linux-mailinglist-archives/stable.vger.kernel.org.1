Return-Path: <stable+bounces-145086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46AABD9B7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9857A5E0C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B522D4E7;
	Tue, 20 May 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9w14eTN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416051B0416
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748427; cv=none; b=f21wqEhMz37BAIB2DGFWiMyNpm38A7J5LmtsV86nLoi38XT7LLJrsUm6T0Z87umbZvQ4yBMhBKl8aKcLMprQ9T/CvngDUjIR7N8M6Giab8bbnZIhdzt6cMJnO9hqlsLAMFO7dMTWNXPVQPlBI01KdZ5EWLx5pAGKcCXIcOYehBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748427; c=relaxed/simple;
	bh=qn1DEtLJ4LRR9nBQDS1VyK62Wr7jF3fXo4T8OVLytkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfEREvdOu+WjrWUY8En56Idty61/aXNSRPn/vpBb2YFhV+BfRY59AsCUvt2B4fqPVEqQVMGym67Sc+ttKwRwt6yf32p/n916HZ1uCP7LrGPVyhVBeSVxOVf1oMwzRfr+aeTzSgdoMEOuPotOLiHAj56TRs9lj2X4dw45am6Dcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9w14eTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4002EC4CEE9;
	Tue, 20 May 2025 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748426;
	bh=qn1DEtLJ4LRR9nBQDS1VyK62Wr7jF3fXo4T8OVLytkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9w14eTNK/QszGXxvRHbWvQpb1EaB+BQXEjjk0Y/bk9s82VcHPRrRqzpaEiWEVwZs
	 Vj6CJeprm/4E2Mk5v2Uwg2DOnlqTHC4/lYWZV1+CvHx24L7qNkCBMpAmcxn57Gt4mE
	 PpJ1N77oWxs1aEg5FBCcsELAwZptOdsU15WxtaoC571cl7jcf2HXmfh5pyGWHmMXsy
	 hMLBfdY+VIW7dWFe3zHkzom611inOfMgzhyM66goET4XotOe5AdZ+iBazVbnOHoVFq
	 ONHCk4px9YzEx1VYmk/zYok37+HqXGwKYCOhqppbKOf8CrVitThXocyDIBISk6lJmp
	 oLE58AFqElezQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] sctp: add mutual exclusion in proc_sctp_do_udp_port()
Date: Tue, 20 May 2025 09:40:25 -0400
Message-Id: <20250520055608-cf835548563e53ce@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520081507.1955494-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  10206302af856 ! 1:  413154924c580 sctp: add mutual exclusion in proc_sctp_do_udp_port()
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
| stable/linux-6.6.y        |  Success    |  Success   |

