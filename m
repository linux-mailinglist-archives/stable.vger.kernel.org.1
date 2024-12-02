Return-Path: <stable+bounces-95986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11B9DFFAF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E7AB24959
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B71FC7E7;
	Mon,  2 Dec 2024 11:05:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C61F9407;
	Mon,  2 Dec 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137521; cv=none; b=fxfLl5+fxjYo3fpGqqOk5VMicy1YPU0Zf+zfUeJHrNp0oTHzzUKSjkO4LwaUdllKF1otUd3BdrBih1Rb+Y9qWXLkTWWEQEQkyxbmPbwjiMEUFmT6JrbiifbGTLYskHKSdv7hkJJvuk08W++zNOboc0Qnw227X50q7bd+PvXutF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137521; c=relaxed/simple;
	bh=7W7VXG1+XO5i6M7fwEKRpB73DH3p+m3ps/bAjiDH/60=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MqVF29BXCMrf0dbUGKck9mWH1E7ph3+zz/Wk1ptNAbx0Fu3Cq4mfPaFZHXKs2AmLls4cWrJjoGcXnQJU2K3aBmKyGZd+XgMjygx8yuZyGkCqllYzdnPXcqHVTuYnmL0f3EMSg/Zl/rVZQKsu+MNcAv5lTkgCYuYaE5i2FcICDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y218t6jftz1k13S;
	Mon,  2 Dec 2024 19:02:54 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 124481A016C;
	Mon,  2 Dec 2024 19:05:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Dec 2024 19:05:08 +0800
Subject: Re: [PATCH v2] mtd: ubi: Added a check for ubi_num
To: Denis Arefev <arefev@swemel.ru>, Richard Weinberger <richard@nod.at>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
References: <20241202093652.5911-1-arefev@swemel.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7701c695-4e83-fffa-1dde-51206c8e4081@huawei.com>
Date: Mon, 2 Dec 2024 19:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202093652.5911-1-arefev@swemel.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/2 17:36, Denis Arefev Ð´µÀ:
> Added a check for ubi_num for negative numbers
> If the variable ubi_num takes negative values then we get:
> 
> qemu-system-arm ... -append "ubi.mtd=0,0,0,-22222345" ...
> [    0.745065]  ubi_attach_mtd_dev from ubi_init+0x178/0x218
> [    0.745230]  ubi_init from do_one_initcall+0x70/0x1ac
> [    0.745344]  do_one_initcall from kernel_init_freeable+0x198/0x224
> [    0.745474]  kernel_init_freeable from kernel_init+0x18/0x134
> [    0.745600]  kernel_init from ret_from_fork+0x14/0x28
> [    0.745727] Exception stack(0x90015fb0 to 0x90015ff8)
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 83ff59a06663 ("UBI: support ubi_num on mtd.ubi command line")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
> V1 -> V2: changed the tag Fixes and moved the check to ubi_mtd_param_parse()
>   drivers/mtd/ubi/build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 30be4ed68fad..ef6a22f372f9 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1537,7 +1537,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
>   	if (token) {
>   		int err = kstrtoint(token, 10, &p->ubi_num);
>   
> -		if (err) {
> +		if (err || p->ubi_num < UBI_DEV_NUM_AUTO) {
>   			pr_err("UBI error: bad value for ubi_num parameter: %s\n",
>   			       token);
>   			return -EINVAL;
> 


