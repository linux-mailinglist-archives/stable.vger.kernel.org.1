Return-Path: <stable+bounces-145080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE3ABD997
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D330318887F5
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E296F23496B;
	Tue, 20 May 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQgsmJcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD722D794
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748206; cv=none; b=UJA7qI2gKSa9vG4AA6YpF1PaqfIf+wt4p5LEqQk2fuG6IVC8J3Vru79XW9ZgC25a575Hkb4eq0wxSP7fp/hZIjbR9phyVbugOHhH+GD5iwfxBRGKFbVcOayN4EfCoUL7msmnujgjF3eDKEnrSOhXxmaylD514tVCTp3B4Y+y0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748206; c=relaxed/simple;
	bh=2jjryLIYg6Ui0lNmD0O2nV6IT5iwyBFLEIC8k8HkEwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWRQn4GgkfvslgsQrEhr8fn1sJgRdBNTmvYl+YEFQNPkfz4AZOx81htLSlHyE40e5BT0uShrJLeokT5CaRf7k+UjK8wy4LM9XDbc9EV/iLG5me072Tvd3Tc0TefIlaoZe09EvBwSu/ljBHyznOIKsSsEAqy7/kpVzqRA+i8Wj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQgsmJcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2EC4CEE9;
	Tue, 20 May 2025 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748206;
	bh=2jjryLIYg6Ui0lNmD0O2nV6IT5iwyBFLEIC8k8HkEwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQgsmJcnRITIH7Y0Vcxa+rs8vgPs0ro9y3XgL/9aJTRdFx5l426zgdxETWULASuow
	 4yUQSv1kB42+tR0903plqmvBxofFrIHEZ555CkqM0K7CNpSChBW7xp5lKraxluNXty
	 xNEo+6lZBuXAgd6o/lmKUdR8q2nvbwXsk3gBSgz+LPg0oOEiiaJGTNoZSWr9lVL2sE
	 B5ADDw0Z0N/YQL93vKAnwUJ5NsvKkgZyo4o76Ko4fu91UAFYGJOcjYXJNhe1Tp7KP0
	 2D6uqMyonX3q812B6guN/vxTBv05M/ERFEnUjUhkOtgWS6INv4mwkNIyvt8j+314A6
	 R1/rtUbxvnUXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] sctp: add mutual exclusion in proc_sctp_do_udp_port()
Date: Tue, 20 May 2025 09:36:44 -0400
Message-Id: <20250520052806-6d79c53124d4d909@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520081548.1955523-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  10206302af856 ! 1:  0ac13fbad61fe sctp: add mutual exclusion in proc_sctp_do_udp_port()
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
| stable/linux-6.1.y        |  Success    |  Success   |

