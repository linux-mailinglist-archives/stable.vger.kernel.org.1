Return-Path: <stable+bounces-180884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C5DB8F1E9
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF6D17A26A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E532441A0;
	Mon, 22 Sep 2025 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qxInE8uD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD7242938
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522137; cv=none; b=JkeLmdUnfKeHrTBzCRVAVAgkmjnY2IoWweoPVBGb9Km6CN0e6Y1mTEdAdQCUPp54TBpEZTiJzWe4wIgDaL876D2ar9pzSpK/1+gJVr8mSqvE+qQ+82DqhyNiGiJ7XOsyl1WQGlhUIFQ1ysgND0iXSEk+XyHyFExsjKuI6cC2zOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522137; c=relaxed/simple;
	bh=0bm+f1WSxzWfn/wCQJSel8ny/PQe+ST1oMkROWbrLTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Upj6MYblgFS384URXlCSRZX5rDWZXOMmTZ1jpyrHrYOyFtUKBYasD8XrJ0DhuCCNpNHoxzFNfavmvU8jpgL9xufM3Gc3By9puDsf4COj4gywXvR8Mgg4b+7tIU6j2fIOvJKLR8weO4hyYsDStkShmp1/F3wbMQnyDBqqtcrhPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qxInE8uD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso4722918f8f.1
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758522131; x=1759126931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uc6eTzZkXXgyCcWWDhbnFU5MdPrnO6H7v+FW7/g/zSM=;
        b=qxInE8uDt8Pd7W2CKV9qDKTqjom6rahPfW73avH+3/eZ/R+MLvFz8DrNxlXI54cLlX
         ekwYiRuaGYwXrRDJP6tEtG1W0Y2PsBUokmep/Est2ZPdajrN22iEjEUC3Kw5tqigJKEP
         xJNd7H/StKMH2eyBzWDadBWF9eEyXwLcdrg8UyAxuGgvmEBhqJ6ZvKjXO2lUTDKphBhP
         ep1uU/rq645CzvDLB4ELuFMp1NtJmd/mkzLwsEz+S05Xx+6HhBsUfDQkd3snymmHHE9N
         Zpak/TY3qJgS1ZQh9SPSGKYDXKfMxjMv760nvmzu93ry/LOJz9HKMOzviB363gPkPsVp
         L+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522131; x=1759126931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc6eTzZkXXgyCcWWDhbnFU5MdPrnO6H7v+FW7/g/zSM=;
        b=SUcS0ndJJRyorZ2ic9hbaB8TGN4y+2O3ChSDrDUvkD17Iilt/Luu06wJde6ReyjJgW
         i8nV0E9gQbODqehso+QfKr+1cblSF6dkYNzcd7Ai0BU93dNdJcNcC8SWC6UXyAZDm3Fe
         d7hXtuM5kZZSjRFW2aKfy2U/eMODchdf4WZnSDoj2W2ouz6EpKgOV6u0E9LbSWeu8D8V
         R75c1zPI9A2CFvqgqtN+Owbo8srm0JabRHwnrlAIdD9ztzvWJWxgXx6Td+8I/4snbShY
         wFyCMCXudSP5vyfTmwFdmAv4p6lifu9XSyokagInYPFFZrGk8SMr89Rj5qDJZeXQWHp1
         ZjZg==
X-Forwarded-Encrypted: i=1; AJvYcCVznEmgPnrFbJCUgCw1mZYHRdWeF6YFQPiz5xlnWwMQkQ0P+I8zKktZTbyHycBMOnki5QxQVp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTt/DDCryzV5ilyo03vNEeku7FqzRDuJJJjDvEEHkfnGjrt+z
	KGtdeR3U5CVuSEOBgXS8PFA1HKudQuJnLVui+tGg0wX6VVH43kQhuqwTD9ov+2KFU/VRGZ8sUHK
	6PewrRWM=
X-Gm-Gg: ASbGncvA64j+xCyL+Z9s3FNEayIPteiV2n8nYWAnSeCRaTJ7A5yVy7ZrwzJc/Rp3fQT
	1NnL7hMtl5cmBgIzeOUyy8C+64UcUht7ubc1evdzqoUhGNp5cfPYgNrmIXb1bsRwaGHIju5RybI
	J25zQJ4uzZbnII/OU4L4/E1xcNYNeS+0wQcZ/dvx6t2l0Jj50NlSbhSWJG4DwCiqYBpccIO/WRG
	wWIQsjIAenfYQPaDX0lBNAsjj16XPu+nJTHHWAEAxvdI3nSd8Pvmd9+ku3MdFVDGQda+PT7Y5TZ
	CjoAXpSnkDDeqPhxfTd6scbfDEgU8+SCUixYVjvPpbf8ZjfvEI9aPKLdCDkpOYraiO+BL6pG4in
	px+WTdCbOrhmH1ES7iIU3
X-Google-Smtp-Source: AGHT+IH4eX5bTOxcWYBSQXC/CIEwPwNNMy2VX4YvoQjeswtMwsZrzl/pHLFLCq9U5ClrMYRGZ1ISbg==
X-Received: by 2002:a05:6000:18a7:b0:3fd:bf1d:15ac with SMTP id ffacd0b85a97d-3fdbf1d1ac4mr1713547f8f.20.1758522131034;
        Sun, 21 Sep 2025 23:22:11 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f88de2d075sm6977946f8f.35.2025.09.21.23.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 23:22:10 -0700 (PDT)
Message-ID: <c4b98918-fb7d-4927-b750-0f1f5e28a0bc@kernel.dk>
Date: Mon, 22 Sep 2025 00:22:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.12-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: thaler@thaler.hu, stable@vger.kernel.org
References: <2025092127-synthetic-squash-4d57@gregkh>
 <bc33927c-a7ed-4518-92e6-e97fc5fde5e8@kernel.dk>
 <2025092206-identical-bonded-c86f@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025092206-identical-bonded-c86f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 11:59 PM, Greg KH wrote:
> On Sun, Sep 21, 2025 at 06:44:45AM -0600, Jens Axboe wrote:
>> On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.12-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092127-synthetic-squash-4d57@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>>>
>>> Possible dependencies:
>>
>> Here's this and the others marked for 6.12-stable, already prepared them
>> last week as I knew I'd be traveling.
> 
> As you have backported commit b6f58a3f4aa8 ("io_uring: move struct
> io_kiocb from task_struct to io_uring_task") does that mean we should
> also add commit 69a62e03f896 ("io_uring/msg_ring: don't leave
> potentially dangling ->tctx pointer") which claims to fix it?

No, the b6f58a3f4aa8 commit backport just backports the
io_should_terminate_tw() helper. That original commit should've likely
been split upstream, which is what made the backport only partial. It
doesn't backport the parts that moves from using task_struct to
io_uring_task.

-- 
Jens Axboe

