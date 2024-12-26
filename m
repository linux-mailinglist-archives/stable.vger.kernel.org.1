Return-Path: <stable+bounces-106148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBA39FCBEC
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7921617ED
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DB13AD26;
	Thu, 26 Dec 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN9bVtEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21728EC
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231467; cv=none; b=IpuV41z9UZxtFDccvlOPt134y2NoSzfIMkDcPUYggGd7J8UrciSaos8sAZD6qmmcC2P0jaOJjtmUbVvHZokoEB1ubyJr6pM4mBJn9nLgEd12nVSA2P2GnRMqASbP6CvhO0oQ4LuU0zQS5n6deVynxLwJVPfV0ujUXJlNkS8JeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231467; c=relaxed/simple;
	bh=AFz2MiKf9ROw6DdM2EmylXGlX+MpdHzYgqgWY6KoRlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4eFOjiAcsnONnb5jkBF8kUeiF+KUPvvXX2OmUNQc/PG0/oBxTkNszHiOA+BgBWstUrpLE5DX9QhcX1FfAW+V/NMBI4F+mGbSfnYmA7xl36dcQnHKpLeyyfA5wkIBlubO0tZLEQlRx4999CKPreRQ5sIa02fvx0hVc7im+n7540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN9bVtEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A8C4CED1;
	Thu, 26 Dec 2024 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735231467;
	bh=AFz2MiKf9ROw6DdM2EmylXGlX+MpdHzYgqgWY6KoRlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QN9bVtEU1nTGZBFInlYAfusqomtaqg2JMavKQn5sqay+bOzTCNyKRUqBmA9YYvfvr
	 UvNEbZ4Ox3n/sWxSgQUxfLXQnJWkEDTR3DyM9TJmcQFbfz8pVvFF0+fmeGQucaQgBT
	 5d228oT5vdRY7jVnkjfXiNMyayihAKQBhS+hzrDVXhoJqSmY4+UFi8RH2kNcxQHl1N
	 i0Ao4FYrWcpNpBhYUOfBo4M+D7rn3Ht9xK/4YfKjfNfQmBeBUukLgNpprhPOXPlZZB
	 bPDkXzBckKojgyxDFv9rHU3QJjZsot51lWKYa+35YiL+aiP5AtinoQa2uB+hVGSQPb
	 /w3TmXzav/HeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Thu, 26 Dec 2024 11:44:25 -0500
Message-Id: <20241226092706-2239e6ad50474d96@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241226083553.1283297-1-jetlan9@163.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 900bbaae67e980945dec74d36f8afe0de7556d5a

WARNING: Author mismatch between patch and found commit:
Backport author: Wenshan Lan <jetlan9@163.com>
Commit author: Xuewen Yan <xuewen.yan@unisoc.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  900bbaae67e9 ! 1:  90c173fa699e epoll: Add synchronous wakeup support for ep_poll_callback
    @@ Commit message
         Reviewed-by: Brian Geffon <bgeffon@google.com>
         Reported-by: Benoit Lize <lizeb@google.com>
         Signed-off-by: Christian Brauner <brauner@kernel.org>
    +    (cherry picked from commit 900bbaae67e980945dec74d36f8afe0de7556d5a)
    +    [ Redefine wake_up_sync(x) as __wake_up_sync(x, TASK_NORMAL, 1) to
    +      make it work on 5.4.y ]
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
      ## fs/eventpoll.c ##
     @@ fs/eventpoll.c: static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
    @@ include/linux/wait.h: void __wake_up_pollfree(struct wait_queue_head *wq_head);
      #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
      #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
      #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
    -+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
    ++#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL, 1)
      
      #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
      #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

