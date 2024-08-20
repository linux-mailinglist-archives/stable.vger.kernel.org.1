Return-Path: <stable+bounces-69698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2E958242
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C3DB21E94
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C87158A18;
	Tue, 20 Aug 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jqmqqkYo"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05818E372;
	Tue, 20 Aug 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146256; cv=none; b=UyqweZOAF6gBDzgaok0WFncOw6TdqZ2+dTv2JxwuAO3915zvSIiP4YDBIclZYiL4EePjPixIIv81FGieJqkqtnwz5aJGX5g7tu75WRNch3Z8dQKMid1SbgJlz1uNYm6zC4vOZ0Vlh5sWtWglZZjkdGpAVA4tHeXBSOs5SpCs0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146256; c=relaxed/simple;
	bh=6bp+iYpueMBdF700L9bS/lx+HmmUlKjsruFR4f+BAKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tUG0H8bl9GreQcipwK1fpceptw+PKNrN21FxS9WjZog6k5BckAYxoI7nyoZL352CaKhaijbWPftcyYZLQFq+x7JM7HcM8h5+0EKuCphsSq9qebYWV/bSbSL5oZm4nLQz2qPu7zv7hPAAnh++vXY/bncQJtoJjzoWZZmFsYK67Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jqmqqkYo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K9UZQg042341;
	Tue, 20 Aug 2024 04:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724146235;
	bh=8++oE0bsX868XtOLPImyjy0fi1D7M2jqIM4z6bE1vA8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jqmqqkYok6ZHjwnNTUEMGlSdstJppKgcFeIgsNLJoCmeeqqMzSLpddG9fiewrlHQ6
	 dLhO+I4czV0biKDGJAjb974QxUFxpQ5DG1ILiBAAmHvVuUD4+6/vxdMV4uqQ1Elxdq
	 FhO4r55/jgm9HkPTBuvRcwzo3ZCKVweiJ27n0JQg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K9UZZJ035373
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 04:30:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 04:30:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 04:30:35 -0500
Received: from [172.24.218.186] (ltpw0bk3z4.dhcp.ti.com [172.24.218.186])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K9UWXg040112;
	Tue, 20 Aug 2024 04:30:33 -0500
Message-ID: <3e6075a6-20a9-42ee-8f10-377ba9b0291b@ti.com>
Date: Tue, 20 Aug 2024 15:00:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix driver shutdown
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Apurva Nandan
	<a-nandan@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <bf2bd3df-902f-4cef-91fc-2e6438539a01@siemens.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <bf2bd3df-902f-4cef-91fc-2e6438539a01@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jan,

On 19-08-2024 22:17, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
> first. When core 0 should then be stopped before its removal, it will
> find core1->rproc as NULL already and crashes. Happens on rmmod e.g.


Did you check this on top of -next-20240820 tag? There was a series[0] 
which was merged recently which fixed this condition. I don't see this 
issue when trying on top of -next-20240820 tag.
[0]: https://lore.kernel.org/all/20240808074127.2688131-1-b-padhi@ti.com/

>
> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> There might be one more because I can still make this driver crash
> after an operator error. Were error scenarios tested at all?


Can you point out what is this issue more specifically, and I can take 
this up then.

>
>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index eb09d2e9b32a..9ebd7a34e638 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -646,7 +646,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>   		/* do not allow core 0 to stop before core 1 */
>   		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
>   					elem);
> -		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
> +		if (core != core1 && core1->rproc &&
> +		    core1->rproc->state != RPROC_OFFLINE) {
>   			dev_err(dev, "%s: can not stop core 0 before core 1\n",
>   				__func__);
>   			ret = -EPERM;

