Return-Path: <stable+bounces-189007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879ABFCD78
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D83A5B02
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380D347FCA;
	Wed, 22 Oct 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nUYhlJ87"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A76288C24;
	Wed, 22 Oct 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146420; cv=none; b=b82Mf2lyAWESNXmD9rGfbfM9kEm7PRdqj467qJ4xeGbYQo3O7DG6/xjzPrHt4WRYlX6/xJOJUlIGCDPm/rVgFiVtlvHofRn0A0BkOnV4P2cRAs10Fb/461bJhEAIRYLqpb0tNTIpqRzLWT6LJqc9zFXqAWxJg5ty15obNsq9W68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146420; c=relaxed/simple;
	bh=ob7+BK3oEacNlg1U/hf5vbi3KqMuHzECNgTNAubqYNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F24HLoQ4XqT9QfPc9ig5O9hjIFLzxJgGzI6P/o6wtqAiReQIjSquBK73Uf7pom7dZfnyYVTklMXuUXkS8OGIq19WjSRqz5rDGbfZ7ENwqC7PYFhOOlFRmgjSJs358AJ2dEAkgxfspoTs4gQtF0X1iMrM1Fr4OdrtWumEQqrlSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nUYhlJ87; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MDRkRg013472;
	Wed, 22 Oct 2025 15:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hL23E/
	YFJ+U67QSfPWPzmm84uqTo8dhfgfwH5JZ8wfg=; b=nUYhlJ871Tx2SA5NIUVhSM
	UAw2JmM9gFrhWKGLuytY+t8NLaOI/82h9DJyU5KdtucBt2xcmoY9zna8RJfzwEa+
	n/m6occOVbu1J54NcDe5nj9ApRY/EbHhwIv7MPd5Q+iWEDghCwCA9fIEW/5vMp1/
	hEjugYWaZWFeUyv6USrZjiJE6obFKvk3mrtXi+WNLWzM97UXAzcVHZfO29lte4wQ
	cjT7H3iRy7z+x0rWwSYtBdnwjs9h0Tfl6XbKUH/uTX5f/FqrbBkz9kj+f5LyXYhY
	a9yxr/y7e9yIhDVf1kg3yP0vaw/MbakGok40wZQ98gKWUDPkei7r17H9MpIMt4Aw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hm17h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:19:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCnii5014658;
	Wed, 22 Oct 2025 15:19:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s992a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:19:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MFJw0T24576760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:19:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 533045805A;
	Wed, 22 Oct 2025 15:19:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A3C158056;
	Wed, 22 Oct 2025 15:19:58 +0000 (GMT)
Received: from [9.61.102.157] (unknown [9.61.102.157])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 15:19:58 +0000 (GMT)
Message-ID: <1abbb7e6-da53-40f3-928a-7ec3725634c5@linux.ibm.com>
Date: Wed, 22 Oct 2025 10:19:57 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] fsi/core: fix error handling in fsi_slave_init()
To: Ma Ke <make24@iscas.ac.cn>, ninad@linux.ibm.com, joel@jms.id.au,
        jk@ozlabs.org
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251022091807.3300-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20251022091807.3300-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyRdl8OXoNCJs
 Dh7OWfKYlLb3fbZRFzeN1KSAEjiehDKKBATqerTV5kbHzXX3UpzBeLTZB/XrCFrksn5ss83PBdT
 MMnQT6OQ9EYT7crPwYg1x0nk7tVMxwKfZ8sUkuNKX9vQb0suV64gjYxFMfY0Xd6DeU0GoOx+VmN
 L9XDKsiVEK1PRIevLFPVCrN77WFcgt22Baq6VlqNZ/qRL8mFKBZFB1j+o3WUNhsX4C/EPx9DsDU
 nCkdrmWkc6vNPzffzm4DwGsrnuY4VSfOlXTaMrhXurTBCWoepCb9OG9TVXihkssjjF49kPQ1aeO
 kDl/erhr1/yBNEBPaRudZws6v4i6NFhglHcXK15ofIAgzUnUGSTOUk+FgH7Szy1rVJMsTyjVDH9
 zL/5ynlsP3VZG6KGBaM3QOwwJCxPaA==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f8f61f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=nEmp-HSdmSgX220XGH4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ZsasBFy1g4M9Oe6g_E18s_3n9bFtwmqN
X-Proofpoint-ORIG-GUID: ZsasBFy1g4M9Oe6g_E18s_3n9bFtwmqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 10/22/25 4:18 AM, Ma Ke wrote:
> Once cdev_device_add() failed, we should use put_device() to decrement
> reference count for cleanup. Or it could cause memory leak. Although
> operations in err_free_ida are similar to the operations in callback
> function fsi_slave_release(), put_device() is a correct handling
> operation as comments require when cdev_device_add() fails.
>
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
>
> Found by code review.


Thanks,


Reviewed-by: Eddie James <eajames@linux.ibm.com>

Tested-by: Eddie James <eajames@linux.ibm.com>


>
> Cc: stable@vger.kernel.org
> Fixes: 371975b0b075 ("fsi/core: Fix error paths on CFAM init")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/fsi/fsi-core.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index c6c115993ebc..444878ab9fb1 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1084,7 +1084,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
>   	rc = cdev_device_add(&slave->cdev, &slave->dev);
>   	if (rc) {
>   		dev_err(&slave->dev, "Error %d creating slave device\n", rc);
> -		goto err_free_ida;
> +		put_device(&slave->dev);
> +		return rc;
>   	}
>   
>   	/* Now that we have the cdev registered with the core, any fatal
> @@ -1110,8 +1111,6 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
>   
>   	return 0;
>   
> -err_free_ida:
> -	fsi_free_minor(slave->dev.devt);
>   err_free:
>   	of_node_put(slave->dev.of_node);
>   	kfree(slave);

