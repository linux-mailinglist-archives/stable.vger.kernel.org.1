Return-Path: <stable+bounces-93934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A739D21A0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DE7282AE7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95207158870;
	Tue, 19 Nov 2024 08:35:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D71531DB
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005318; cv=none; b=V2o5655cmFho7XL8nPEb0na0DExkgFPsO5DuhEDQoUhcs7JoVus1LUrvqknYdYEQpxFspRPxo7LHB5q1TL3cRPgTATDNn8HIzVH/hB6Mzi5Q4JQir+qMoScchp40niemW6g0AIbCmp1Cf7a29sB3mXRrDhbt+SB3veSs2XKPN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005318; c=relaxed/simple;
	bh=dAm1vh81c4LCoG7qtQ0qBV9JUO2v8pXlIyOyOmbHrT8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aQ9cJD3dITdWL31c3LonxCTf31MzVk3wFQ22E2wE2p6EIevKe3BtkC5voQY9r0AnxLi6pvn7vYq6sq8or61ouySTbGraCqbXcwiZgBZf6MbkX2M3yTu4MAJOCPHCQqNYow7Jp9FliZcOukw7a2nbsPoqm6FX45/8nBwXhFyZk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsyV52Z4Lz4f3jR1
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 16:34:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D02B71A058E
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 16:35:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4e8TTxn8XLfCA--.25394S3;
	Tue, 19 Nov 2024 16:35:10 +0800 (CST)
Subject: Re: [PATCH 6.1.y 0/2] Backport to fix CVE-2024-36478
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
 christophe.jaillet@wanadoo.fr
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241119082719.4034054-1-xiangyu.chen@eng.windriver.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6250e1f3-cdc7-b172-e9c2-4ac82db9c21f@huaweicloud.com>
Date: Tue, 19 Nov 2024 16:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119082719.4034054-1-xiangyu.chen@eng.windriver.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4e8TTxn8XLfCA--.25394S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurWxuw4ktF45CFWDKw17KFg_yoWDXFc_Ca
	4FvFy8JryDWF4jga4DKFy7ZrZ0ka1UXry8XF42gFZrJry3ZFy3Jw4xGrZ5ZF1DXa1xuFW5
	JF1fZa95ur1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/11/19 16:27, Xiangyu Chen Ð´µÀ:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
> 
> Backport to fix CVE-2024-36478
> 
> https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/
> 
> The CVE fix is "null_blk: fix null-ptr-dereference while configuring 'power'
> and 'submit_queues'"
> 
> This required 1 extra commit to make sure the picks are clean:
> null_blk: Remove usage of the deprecated ida_simple_xx() API
> 
> 
> Christophe JAILLET (1):
>    null_blk: Remove usage of the deprecated ida_simple_xx() API
> 
> Yu Kuai (1):
>    null_blk: fix null-ptr-dereference while configuring 'power' and
>      'submit_queues'

Thanks for backporing the patch, there is a follow up patch you should
pick together:

https://lore.kernel.org/all/20240527043445.235267-1-dlemoal@kernel.org/

Thanks,
Kuai

> 
>   drivers/block/null_blk/main.c | 44 ++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 16 deletions(-)
> 


