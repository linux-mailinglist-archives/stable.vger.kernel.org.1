Return-Path: <stable+bounces-182018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE3BAB29A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 05:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00411C591F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F721222560;
	Tue, 30 Sep 2025 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YVZth7JN"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4F18859B
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203732; cv=none; b=UXFhiBrXbyn0XfZ66V9KAbE0Mba7hbS9E5wBaiRUhMYvQ6UmaZxTRfOSgIyBpfxYDgYQ3udrKsE6xxgK7MH7PnD9evoq/Pfbi61o4YRwgf3MFI/iTkZ3tgLfrWSMa2FhWltj6V0evYEav+XAwkEtIkw0I0lmtbQRWjnALHf7yF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203732; c=relaxed/simple;
	bh=4FNZCkmNSzV6fzVROGklT/wUou4Sk7hw9ERd4ZhoCiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jtF2WveaVBNoNn4g7alqQ1hIuC65ZzdIGEJ5hAdCfnmIMFFipCvbqCZ3vGyB7quBniBqkF/Jnvpw7Hlo/oNxxcBD23hmaTKUY6aTklV5xfLFgyUUOEzE6eYEVXMk9qeJKBorn6YLOL73Jef7QspIT2hmRxne5MgZmLuArn+noIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YVZth7JN; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RtaxDL77jXpWZumxJPR8FhUR8TAunUcnK6sSf87g2+Q=;
	b=YVZth7JNjWljl5AuNp1NCOGlck5nWy8MRb41K7/HZiGVASp+djXYQ5ybED0fWKQlbWGV+GoTQ
	WJipNiFz2fSlkNRL5xofS/DuF5icEKthVy5qH6KCp45a8pK4Mec9cfoi5k6wFNzyKD5lMqFBFxQ
	ytseyM3yBd4mRuRcDR9HkqM=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cbP4g25BnzLlTW;
	Tue, 30 Sep 2025 11:41:55 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E798140279;
	Tue, 30 Sep 2025 11:42:06 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 11:42:05 +0800
Message-ID: <d3e36c49-89b8-0af8-82cb-8db970fb5539@huawei.com>
Date: Tue, 30 Sep 2025 11:42:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [BUG REPORT] Incorrect adaptation of 7e49538288e5 ("loop: Avoid
 updating block size under exclusive owner") for stable 6.6
To: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, zhengqixing <zhengqixing@huawei.com>
References: <7f6f5d7d-385d-ea47-43b8-bbd6341e2ec6@huawei.com>
 <2025092911-grappling-tutor-8f40@gregkh>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <2025092911-grappling-tutor-8f40@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/9/29 21:28, Greg KH 写道:
> On Wed, Sep 24, 2025 at 10:36:19AM +0800, yangerkun wrote:
>> Error path for blk_validate_block_size is wrong, we should goto unlock, or
>> lo_mutex won't be release, and bdev will keep claimed.
> 
> Can you provide a working patch we can apply?

My colleague Zheng Qixing has already made the correct adaptation, and
she might release it in a week (we are about to start the National Day
holiday).

> 
> thanks,
> 
> greg k-h
> 

