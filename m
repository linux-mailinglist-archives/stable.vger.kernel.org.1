Return-Path: <stable+bounces-106147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095EF9FCBEB
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFA16129D
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F398615A;
	Thu, 26 Dec 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmjtKV8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1728EC
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231465; cv=none; b=QNwrTrHPxWCIM/CvswySIEUZmgyjDyun6O+uUNsmFBiX63Ffi6ZmdRH5HJrNBo9xfo5ZzZn+hBJwCnoomQGWGv+jhkjSfQvza2TLuNnEhV0eFspTEcByyVLs2nmC8hBoE2XR+DmeccbRzMJlWP59CjVubICVuCDnOvLXCm2yUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231465; c=relaxed/simple;
	bh=4AuQEU3myYf4DrJnc1l3hrzAIqkrFu0k7fT5RsYEFQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjeLAuKmSvh8jaonFOS7pRcTucM5M0yy2Qt7wmGCp5F3VbF5I0/XtSaeS/9NuP9o3Ecs4eHFEuVFEAe1PJjiUfGTTIJbRXt2b3OPumqgeD0zssUPLxArDKR7ty7lCHUVZctk6VmtKqLW9aQrWJX1bmiqok3xl7zfLqeFL5rQRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmjtKV8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA3C4CED1;
	Thu, 26 Dec 2024 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735231465;
	bh=4AuQEU3myYf4DrJnc1l3hrzAIqkrFu0k7fT5RsYEFQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmjtKV8c16oCUuABgA+coebFMRLKKNiy+9kLLJt5RP0rzjfkJpeqw+T1LgScQo1/q
	 ez7m+OfPecgR1udcGLcTABWXUNNUciVTrEdpBj6QjLqXcta/HPclCQQlVUByWPbogn
	 F3j1YJW7FxGpj4qC9NgStGfpHQUDKsLFci4DHazTOP9k5fL0Py0H98zqg1gD99b4Yp
	 XfdehzgwnyhyUEMf0bTZNnTqsuQgQCt06InjlQN33xvTJHSre9njy0h21885Jol7Ze
	 CXO199ibcDH56eGatRYYT/be6EOVrQOgJiemzDTjMPkdn+55HBAnFe0BMq+UdO/yi9
	 eTacXU7JhqPAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y v2] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Thu, 26 Dec 2024 11:44:23 -0500
Message-Id: <20241226093321-4632481b072a01d6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241226111429.12499-1-jetlan9@163.com>
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
1:  900bbaae67e9 ! 1:  b90bb7104c43 epoll: Add synchronous wakeup support for ep_poll_callback
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

