Return-Path: <stable+bounces-166945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5EB1F774
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606BA3AFFA4
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AC2FC0B;
	Sun, 10 Aug 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSzlO6RX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A089EC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786534; cv=none; b=JepKQnNtJNyjFAmx4f1WLSh4w1TPdM5U+q6iagOZ7dMV0w11g2r87rWDVupNqzrSqxQyxnsmwCBVwNoyCXxDlA69kk6bPxeJXEXG7/OuswDfaaWeY25zieGG2xfNG4m+IJ9nkR3hrMF25f+Kwr3nDdqimzoOsZcNbGthb/47qWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786534; c=relaxed/simple;
	bh=1yARjQg8vD8DL3MLG+2CfTvFSB1kDBi/j2HOS0XoPjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7l0NJpRYlc+PtBQpjWRLPLYPt2E2cC8AmqM5jCaKglYqLUV6LmPo1oS6qjybu1XQyKa3Sr4nU0rpfX2iYwLYYVoWpwDG1xjcLuULTxd6ITiFoqIoA5ijzzQZDy6S2pPwScpd8tbBT3ZleRbTm+caQ4M8tq3iIu4LIIvQi6mok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSzlO6RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCC1C4CEE7;
	Sun, 10 Aug 2025 00:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786534;
	bh=1yARjQg8vD8DL3MLG+2CfTvFSB1kDBi/j2HOS0XoPjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSzlO6RXt2omwGAWdpl7dtcZjH00InrdrVyPlT59PZnAH3TLzFjN/OyOj2xl+frtS
	 dtppaa06Zr8hEZy6G0puPuzypDjw5/qQhJN+NERGBVUoijR5VoX8PuMSVHm4WOOgQS
	 biIGX4ahLYcC6cItnaeG0tbcpkuro0l1Brw6OpTmKualXLGjGbg0eYulvh5X+WKdT3
	 tUaMZKHtqXZkR7OunrJTpXJdholVk7+ikoHGG/Adulo2sBLPB56zjSTseo2KwY1rUJ
	 8oJnI/km8eSlVtqYGDmnEGtzwdapfPYFHi7yjPiX3K4mNw6r4Wdh8NgofqX2WZSKhh
	 BDEbhifyxvVug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15, 5.10 2/6] sch_drr: make drr_qlen_notify() idempotent
Date: Sat,  9 Aug 2025 20:42:11 -0400
Message-Id: <1754784993-86b36c1f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <bcf9c70e9cf750363782816c21c69792f6c81cd9.1754751592.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: df008598b3a00be02a8051fde89ca0fbc416bd55

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Cong Wang <xiyou.wangcong@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  df008598b3a0 ! 1:  b15952e73fd2 sch_drr: make drr_qlen_notify() idempotent
    @@ Commit message
         Link: https://patch.msgid.link/20250403211033.166059-3-xiyou.wangcong@gmail.com
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit df008598b3a00be02a8051fde89ca0fbc416bd55)
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## net/sched/sch_drr.c ##
     @@ net/sched/sch_drr.c: static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
    + 	if (cl == NULL)
      		return -ENOBUFS;
      
    - 	gnet_stats_basic_sync_init(&cl->bstats);
     +	INIT_LIST_HEAD(&cl->alist);
      	cl->common.classid = classid;
      	cl->quantum	   = quantum;

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |
| 5.10                      | Success     | Success    |

