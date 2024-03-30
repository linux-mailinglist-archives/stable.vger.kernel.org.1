Return-Path: <stable+bounces-33784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29A8928C2
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96041283842
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078C310FF;
	Sat, 30 Mar 2024 01:31:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310715A8
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711762263; cv=none; b=kwp3ZvgU4ITwM/NlqzyRJJPLS+bNBToTYWLlRAh/2FKoVpGP8q9IN5sO7TCE0nuzFr4JVd1DJW2C0Su4+8pMXZ1AZABMG1k1cXEiDbPoNSfgXP+qgcI/w0GT5bR71jrqld/QSWEiuYnopOrwXDqHMp80s9KXPs8i9IDeq6kNY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711762263; c=relaxed/simple;
	bh=82YjZMyi8YTVzHKYOJsrZUjHAUjh73cqKcj9vY2Ry1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fRDYKPHPM7LdHUrwI7Y1hQT5XicMTYp56PMS/TzSbtk4il+ZpLHki8WWcu5/IQPkMftMpqxwFQRSXT0jXxvb7KDE6MRkE802M8KdRqBXJO05FksF5gACkLd5oXP01uScYTWsid8p/ILfc+ahkcRxnQi0VkZwrHgapY3oUSIScC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V606Z2c6wzNmmt;
	Sat, 30 Mar 2024 09:28:54 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CA0918007A;
	Sat, 30 Mar 2024 09:30:58 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 30 Mar 2024 09:30:57 +0800
Message-ID: <8b1a93be-0d1f-f67d-0a28-9f4eb7d9e9fe@huawei.com>
Date: Sat, 30 Mar 2024 09:30:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 5.10] nvme: use nvme_cid to generate command_id in trace
 event
To: Greg KH <gregkh@linuxfoundation.org>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
CC: <stable@vger.kernel.org>, <jsperbeck@google.com>, <beanhuo@micron.com>,
	<hch@lst.de>, <axboe@kernel.dk>, <sashal@kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
References: <20240306112506.1699133-1-lilingfeng@huaweicloud.com>
 <2024032924-cadet-purely-06a9@gregkh>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <2024032924-cadet-purely-06a9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100001.china.huawei.com (7.185.36.94)


在 2024/3/29 19:59, Greg KH 写道:
> On Wed, Mar 06, 2024 at 07:25:06PM +0800, Li Lingfeng wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> A null-ptr-deref problem may occur since commit 706960d328f5 ("nvme: use
>> command_id instead of req->tag in trace_nvme_complete_rq()") tries to get
>> command_id by nvme_req(req)->cmd while nvme_req(req)->cmd is NULL.
>> The problem has been sloved since the patch has been reverted by commit
>> 929ba86476b3. However, cmd->common.command_id is set to req->tag again
>> which should be ((genctl & 0xf)< 12 | req->tag).
>> Generating command_id by nvme_cid() in trace event instead of
>> nvme_req(req)->cmd->common.command_id to set it to
>> ((genctl & 0xf)< 12 | req->tag) without trigging the null-ptr-deref
>> problem.
>>
>> Fixes: commit 706960d328f5 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
> This committ is reverted in the 5.10.208 release, so is this change
> still needed?
>
> thanks,
>
> greg k-h
As described by commit 706960d328f5 ("nvme: use command_id instead of 
req->tag in trace_nvme_complete_rq()"), we should use command_id instead 
of req->tag in trace_nvme_complete_rq(). So I don't think it's 
appropriate to just revert it.

Replacing req->tag with nvme_cid(req) can solve the problem described by 
commit 706960d328f5 without causing issues mentioned in commit 
929ba86476b3 ("Revert "nvme: use command_id instead of req->tag in 
trace_nvme_complete_rq()"").

Maybe fix tag should be changed to "Fixes: commit 929ba86476b3 ("Revert 
"nvme: use command_id instead of req->tag in trace_nvme_complete_rq()"")"?

Thanks.

