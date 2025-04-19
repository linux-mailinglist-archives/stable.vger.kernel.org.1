Return-Path: <stable+bounces-134661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD0A940C8
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 03:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E821B600C5
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 01:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEDC1A270;
	Sat, 19 Apr 2025 01:18:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A02EAF1
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025538; cv=none; b=GOZ9vUpaAIo/7buuT01PxviVwS2IKIGTR0QysBTZGgN9QlnXdMWvDsSyi++a0a3tnHau6IA1qanlXXyKzZQK65v/rO3/Ln16qErP9rsFL+6dR+Q5KQhttmgUFzq9xD8msTOz+9Sdv/YAGLOMVCpwJh1WHtHyfrxZ+llwT6sMwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025538; c=relaxed/simple;
	bh=uXVZV7TNcFw0i4iaEZVR8KorucIFFOH5g3oxcd47yDc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kVuzR2LWOuNxxtbGteMjQN3ptfE87z9ji4QsCil/IhcIqbk/Olx7kXt43lv1MuMCagjR0d6ipYvMNMFTFEficyCMuAi7DTqxFUsTmOGi0Td7iaiPtxPJTlC1c8BcBmAo4TYcPP6c3ZwvzhHShFgfCCD/UZMd0UeW+WiUNAkad24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZfYfj65zpz4f3kFM
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 09:18:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A2BE11A018D
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 09:18:45 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB321_x+QJo6oGZJw--.38771S3;
	Sat, 19 Apr 2025 09:18:43 +0800 (CST)
Subject: Re: Please backport 8542870237c3 ("md: fix mddev uaf while iterating
 all_mddevs list") back down to 6.12.y (and question on older stable series
 back to 6.1.y)
To: Salvatore Bonaccorso <carnil@debian.org>, stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Guillaume Morin <guillaume@morinfr.org>,
 Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <aAIjPqdxqGRuTyrd@eldamar.lan>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b8c35502-4e83-e98f-f0ee-95ebd9452295@huaweicloud.com>
Date: Sat, 19 Apr 2025 09:18:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAIjPqdxqGRuTyrd@eldamar.lan>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB321_x+QJo6oGZJw--.38771S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr18Zw47ur48Jry3Xw13Jwb_yoWfZrb_Ka
	yUXF93X34kJa10qFWakas8CrZ8K3y5Aw4kGr1vvFWxWw17JFyxAFZ5Cas7Zw1fGFWrKFnx
	JrWjyr92939FvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/18 18:02, Salvatore Bonaccorso Ð´µÀ:
> Hi stable mantainers,
> 
> [note I'm CC'ing here Guillaume, Yu and Christoph]
> 
> In Debian we were affected for a while by
> https://bugs.debian.org/1086175 which we found to be reported by
> Guillaume as
> https://lore.kernel.org/all/Z7Y0SURoA8xwg7vn@bender.morinfr.org/ .
> 
> The issue went in fact back to 6.0. The fix was applied upstream and
> then backported to 6.14.2 already. Can you backport it please as well
> down to the other stable series, at least back to 6.12.y it goes with
> applying (and unless I miss something fixes the issue, we
> cherry-picked the commit for Debian trixie and our 6.12.y kernel in
> advance already).
> 
> For going back to 6.1.y it seems it won't apply cleanly, You,
> Christoph might you be available to look into it to make this
> possible?

No problem, will sen LTS version soon.

Thanks,
Kuai

> 
> Regards,
> Salvatore
> .
> 


