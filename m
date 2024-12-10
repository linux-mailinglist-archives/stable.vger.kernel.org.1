Return-Path: <stable+bounces-100496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F282F9EBF44
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE71188B0A5
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226C1A3056;
	Tue, 10 Dec 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bjb3HzIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489231A9B46
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873411; cv=none; b=l+BpwITS87HOj/h0mITwzyo4I6hDM4EJKEgcBpnCt1j+R0DBb95sLPiyXgnJpXohLFqVfvLLcT+Sa6lp1loAk141o0FJlH5zll8rRTkzUGAcTdzb0F/pFWdX8H0eVztb7rPykrcs0mHYzbIAgTZLzvJ32nKtmuN2Jk7R0BK1S+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873411; c=relaxed/simple;
	bh=xrmZ5sIezSAHLi1oUllKgnFQc6m6O82r/Rtn8Oi+/1Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=F90fDi+SONWv8E573gTx8JJWTjj8JKLJiHhSZKSao1sDHpjA5+j69ahwxXJ4PdV2/s350Mu4VKG+W7y+gJzI93CjAGClESFSIrjdcJPpV9YNUtvH1EbEDM1yl8ZmOucxP1I7fEEXWSpxS6YjkwQrEHamNg8aoPzryeUoffHH2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bjb3HzIy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163dc5155fso26917715ad.0
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733873408; x=1734478208; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVPsgSTemUzukg9E619CwHnFUeZfQvr0zWgl6blSlvM=;
        b=Bjb3HzIynZbZTVrxOzgwK91EuxfAUueuWRK6djOz0QWq28gfXFT/+QQcY27N1E2ed8
         +x9Hl3QLjWkmkZxgm8miCs9RgAcJUEKF8b+uSsmwUmdjnQc1eRz26MblVfbxGyhQ9FMY
         rvRuxHiQ5GpJup7QSerMSc6i3pZNA+TZqCrSufsFguuz94Dl9qf3NHN7eXY3Blxez6Ls
         VqJphtjpofSno5ZsHDjDqO9HLJG+vX4hdG7SaBBhN5WdSe6f0Dvz+cc4yIPW5SeTG5CR
         bEpRvbw1CpMK6yjTvTD29KPdWBt03TR0BOLnHE+ljNeJ0J9xCtc/7rePS0stgcD9xyo/
         Dvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733873408; x=1734478208;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVPsgSTemUzukg9E619CwHnFUeZfQvr0zWgl6blSlvM=;
        b=mfFiSuZrj21Jq7fW2IKNAM3aaLSKk/Hpmg6krPRSJgilEEq3izbJitbTIvHXcy1m+6
         TgDvWV60gos3th5ODH+bU607zVjeceDQW71lqsMPSCd0uOp+3cVyYymHlHdyFrg1BeXM
         fY9wQJSMHlI0Lb7Gj22saLkRQcbDk8PBma1MaTCDCMZoLDPadi5lCHq3XZ8Mu+jDAvgA
         U9yW9Z9PlFMxek8RLcpLCTkR9NgWsUnZxLmgWPVHwrV+kcmiBTeJaFVmdOZe8e7PvHZ+
         SE2VPuRs7dEr8KegBUXi29PW1TxBaUXtXl1xBSed4zOXTKigyzrePW/+H14UeR2qt6qX
         0lvw==
X-Gm-Message-State: AOJu0YwX1u3t/hJL8fPzJZ5d7xqdIyEU8A/5GxL4Oe8Or64fCTHgbH/u
	PP+aiZI1XRD3EQGsvQxxdUys4SqnNf6FPtP9Q1Ao5YXaoclQOTsysYRo9LLvJQ/I6dTHmlVuA5Q
	T
X-Gm-Gg: ASbGncsAAiNglcFYlfPr2NNGD+JpDFY6llt23VJLY7wr1KniLwiMQl9wmQBu8nsgrTe
	t8ITwttFGXfKF+Kbf4gMj4kqVVzUW+XGgy0Ps1WWN8xPr0HfIhRqV4Go5c5W54t9Zo4y8OA1Dr+
	vC2//KvR8GDxectW40Qevth+NUch6mH1qevCQn5rsocCQ5kLsz0hVN9gduwxCkiACflh6Kc8ILI
	bp2XVH+IwqWJIRPMoLXMhf0ZTCTJ4H4AqoVbAzp58FG2e7V9HY=
X-Google-Smtp-Source: AGHT+IGOJfga47ncT4LY1s69AZdSZljDBvbQYGIh68l8m5x83sOBKkfIS0tTC+y0se6366eY/4YKIA==
X-Received: by 2002:a17:903:2448:b0:215:7b06:90ca with SMTP id d9443c01a7336-217783ab1f5mr13345345ad.17.1733873407237;
        Tue, 10 Dec 2024 15:30:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161fd39ddcsm73683015ad.86.2024.12.10.15.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 15:30:06 -0800 (PST)
Message-ID: <57b048be-31d4-4380-8296-56afc886299a@kernel.dk>
Date: Tue, 10 Dec 2024 16:30:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: Stable inclusion
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Can you add the below to 6.1-stable? Thanks!

commit 3181e22fb79910c7071e84a43af93ac89e8a7106
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Mon Jan 9 14:46:10 2023 +0000

    io_uring: wake up optimisations

    Commit 3181e22fb79910c7071e84a43af93ac89e8a7106 upstream.
    
    Flush completions is done either from the submit syscall or by the
    task_work, both are in the context of the submitter task, and when it
    goes for a single threaded rings like implied by ->task_complete, there
    won't be any waiters on ->cq_wait but the master task. That means that
    there can be no tasks sleeping on cq_wait while we run
    __io_submit_flush_completions() and so waking up can be skipped.
    
    Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
    Link: https://lore.kernel.org/r/60ad9768ec74435a0ddaa6eec0ffa7729474f69f.1673274244.git.asml.silence@gmail.com
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4f0ae938b146..0b1361663267 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -582,6 +582,16 @@ static inline void __io_cq_unlock_post(struct io_ring_ctx *ctx)
 	io_cqring_ev_posted(ctx);
 }
 
+static inline void __io_cq_unlock_post_flush(struct io_ring_ctx *ctx)
+	__releases(ctx->completion_lock)
+{
+	io_commit_cqring(ctx);
+	spin_unlock(&ctx->completion_lock);
+	io_commit_cqring_flush(ctx);
+	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
+		__io_cqring_wake(ctx);
+}
+
 void io_cq_unlock_post(struct io_ring_ctx *ctx)
 {
 	__io_cq_unlock_post(ctx);
@@ -1339,7 +1349,7 @@ static void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 		if (!(req->flags & REQ_F_CQE_SKIP))
 			__io_fill_cqe_req(ctx, req);
 	}
-	__io_cq_unlock_post(ctx);
+	__io_cq_unlock_post_flush(ctx);
 
 	io_free_batch_list(ctx, state->compl_reqs.first);
 	INIT_WQ_LIST(&state->compl_reqs);

-- 
Jens Axboe


