Return-Path: <stable+bounces-104197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C09F1FCC
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC54166AD0
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BF19342F;
	Sat, 14 Dec 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Re6i2mb+"
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F82199FBB
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734191110; cv=none; b=OMaiYT73tS3XbrPzkFgcQJ/GYRY23t2epmLxWGpZiixiVNOOaYQJjyWpLp4hN+r9AqTxg+lu8+C2nfJ2UbmU9NEinbNoSn2DR6Vg/wPRdbkDPsMYCt7Xuaqz6wDrf6j/6/kvHvU/s8GsAD4WkZ2VCTRwa5IlivtBtC1APqHxCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734191110; c=relaxed/simple;
	bh=+o5BYVCssbAMi7hBNxBBN2JqNcHscI14nwE255bsBhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS/OmqC4aD1d2Y1gk+Vzbc5ZFzlzI2LM0ALKxVnwbxYG5VqV2A2QKF9sgdY/9gGKpaJcXAQNZglwvGsWY2kgt+ffMWvkxHql2JZJmhgqfvnmmy4Izq+KyZM51/N1AFzAaiJAEBM6eKsPTgh2SWE0wSZLHQfReP7emZzST0jqReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Re6i2mb+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734191103; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hgyzlj2j42/5VauO89Px6z/HVWmjD245RSFpHbLffxQ=;
	b=Re6i2mb+2VrMZCtjP0w+D8eS4CuWvX3SNB5UxvZ0HG9FpEeYtw4ITX89RYu0gD2IEz2l4ICeeJHIFhcz67ygnjkGe6fSLbLycRgla6/eNhkWH2lwT7IGaavDKncRpbQOoHsfGTmNJ6MYtyBU47pidNRU45vvh4PH9R8uBVKLL9k=
Received: from 30.120.185.40(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WLRypw2_1734191101 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 14 Dec 2024 23:45:02 +0800
Message-ID: <87b85294-6364-4424-882e-2737eca0a85d@linux.alibaba.com>
Date: Sat, 14 Dec 2024 23:45:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] ocfs2: Handle a symlink read error correctly
To: Matthew Wilcox <willy@infradead.org>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, Mark Tinguely <mark.tinguely@oracle.com>,
 stable@vger.kernel.org
References: <20241205171653.3179945-1-willy@infradead.org>
 <20241205171653.3179945-2-willy@infradead.org>
 <f0279f1a-936e-45c2-9f57-0b82c3fffcd9@linux.alibaba.com>
 <Z12iWZqMw8tiz7jE@casper.infradead.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <Z12iWZqMw8tiz7jE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/14 23:20, Matthew Wilcox wrote:
> On Sat, Dec 14, 2024 at 08:03:30PM +0800, Joseph Qi wrote:
>> On 2024/12/6 01:16, Matthew Wilcox (Oracle) wrote:
>>> If we can't read the buffer, be sure to unlock the page before
>>> returning.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  fs/ocfs2/symlink.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
>>> index d4c5fdcfa1e4..f5cf2255dc09 100644
>>> --- a/fs/ocfs2/symlink.c
>>> +++ b/fs/ocfs2/symlink.c
>>> @@ -65,7 +65,7 @@ static int ocfs2_fast_symlink_read_folio(struct file *f, struct folio *folio)
>>>  
>>
>> Better to move calling ocfs2_read_inode_block() here.
> 
> Hm?  This is a bugfix; it should be as small as reasonable.  If you want
> the code to be moved around, that should be left to a later patch.
>

Well, either way is fine to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

