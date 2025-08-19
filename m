Return-Path: <stable+bounces-171826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF7CB2CA88
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28E85A6718
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC742304BBF;
	Tue, 19 Aug 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuLLVTwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C72522B1;
	Tue, 19 Aug 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624440; cv=none; b=uNbzKkJoc1tJ9JmnWWrA3CBHtbSrD+2cRvmfQAX2lM0VDeEsgZMEAQCH5aFcndMBAyaMF2CZPWxZjX1vV30+CROKbYdXVBl4scUvH2zKq5KNZ5JUG08s42WVIcHRMRe5rRqKHTSzKxXBrYuNeDcpefWt29jMWsgRkeRrTdZDMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624440; c=relaxed/simple;
	bh=DjIQbLXoKGxiqstdZOoWp4F16Bie/DPqbH9msKl3kas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBEA77+3Gi7EQJt5VSCYLnzX6l2UzKnq15oS1N04fNTzYlHFHCstl0BoA0PoobkANgUV1+E7iERsueLDN3gZ1w4unbrSXXeRAfI0qASc1S+0c1NxJUdFjeHaVxd/g1Y9xErFiwUyZtcruKdLNGRppcHHLVndVqXa4uYIc0tnsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuLLVTwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB5CC4CEF4;
	Tue, 19 Aug 2025 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755624440;
	bh=DjIQbLXoKGxiqstdZOoWp4F16Bie/DPqbH9msKl3kas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuLLVTwu117bVswIvtLMVifZHzBGRg0dfVcOzvrAveGB5/wDCpk37VGrRXrkEb3rg
	 0i7vaLugi+fBalb/L8f8dP84O19OqP0YCJzaFgeFdPy+nyJIiouJo21g+GMG2AJqH1
	 pevxjkcoRc6f2/mI38dnwjSVocie9jTpSTyxbIoiw4CwrjPF2fetNchMfK0yHBCwXL
	 fSs/pakl0RgT9SCaYDxBTSRXCin2dqa3kEluL9RbhWQOUebDykmIy8rE86AmJuFA2e
	 chA1gb0nkg+nGGwLz0MCLK79/ZPMDB3/NS2S+VbRxScgDI6wFgDdtZVNvo20yuyUCC
	 817i5C1zTSzdA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Tue, 19 Aug 2025 10:27:18 -0700
Message-Id: <20250819172718.44530-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819150123.1532458-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> include/linux/jiffies.h
> 
> /*
>  * Have the 32 bit jiffies value wrap 5 minutes after boot
>  * so jiffies wrap bugs show up earlier.
>  */
>  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> And they cast unsigned value to signed to cover wraparound

"they" sounds bit vague.  I think "jiffies comparison helper functions" would
be better.

> 
>  #define time_after_eq(a,b) \
>   (typecheck(unsigned long, a) && \
>   typecheck(unsigned long, b) && \
>   ((long)((a) - (b)) >= 0))
> 
> In 64bit system, these might not be a problem because wrapround occurs
> 300 million years after the boot, assuming HZ value is 1000.
> 
> With same assuming, In 32bit system, wraparound occurs 5 minutues after
> the initial boot and every 49 days after the first wraparound. And about
> 25 days after first wraparound, it continues quota charging window up to
> next 25 days.

It would be nice if you can further explain what real user impacts that could
make.  To my understanding the impact is that, when the unexpected extension of
the charging window is happened, the scheme will work until the quota is full,
but then stops working until the unexpectedly extended window is over.

The after-boot issue is really bad since there is no way to work around other
than reboot the machine.

> 
> Example 1: initial boot
> jiffies=0xFFFB6C20, charged_from+interval=0x000003E8
> time_after_eq(jiffies, charged_from+interval)=(long)0xFFFB6838; In
> signed values, it is considered negative so it is false.

The above part is using hex numbers and look like psuedo-code.  This is
unnecessarily difficult to read.  To me, this feels like your personal note
rather than a nice commit message that written for others.  I think you could
write this in a much better way.

> 
> Example 2: after about 25 days first wraparound
> jiffies=0x800004E8, charged_from+interval=0x000003E8
> time_after_eq(jiffies, charged_from+interval)=(long)0x80000100; In
> signed values, it is considered negative so it is false

Ditto.

> 
> So, change quota->charged_from to jiffies at damos_adjust_quota() when
> it is consider first charge window.
> 
> In theory; but almost impossible; quota->total_charged_sz and
> qutoa->charged_from should be both zero even if it is not in first

s/should/could/ ?

Also, explaining when that "could" happen will be nice.

> charge window. But It will only delay one reset_interval, So it is not
> big problem.
> 
> Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

I think the commit message could be much be improved, but the code change seems
right.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> Changes from v1 [1]
> - not change current default value of quota->charged_from
> - set quota->charged_from when it is consider first charge below
> - add more description of jiffies and wraparound example to commit
>   messages
> 
> SeongJae, please re-check Fixes commit is valid. Thank you.

I think it is valid.  Thank you for addressing my comments!


Thanks,
SJ

[...]

