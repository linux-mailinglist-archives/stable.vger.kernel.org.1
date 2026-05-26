Return-Path: <stable+bounces-254294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJFEBmV1FWrCVAcAu9opvQ
	(envelope-from <stable+bounces-254294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:26:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 749855D4280
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861D13066185
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4643DCDBA;
	Tue, 26 May 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZjko+nJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154C231829
	for <stable@vger.kernel.org>; Tue, 26 May 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790873; cv=none; b=tIqQqG387xiSUatibYIjqkNkbQw6pHIm3haBGm6TjpUtJIzDkaw5WqW72CUjfeLHg1XViM5S40xc7VQWKekuJbMhaFJcwMyxNJxkEXbwrYfWAZeUxOfnqdoEaEcSLnVreQd1bSp1eFndxgQZyUoytD83p0RB6gcNdagyfunaI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790873; c=relaxed/simple;
	bh=oEJO360iapbBc5meXV2DNGdaVd007NnnwBqTRcBjoBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA6+0pw+r3W53wTAU9oIFziiZi07Wplr1BHS2uciiJ9x2W91Yh9xFLJ4o+DpndNu/qZcU7H/SDk5Pr5XoFwsEOAhUC8XqGHdDwmx8+0r77YE03ik6jE+PIOyxA/ZIffpxvNnl2elfMtdM/zLaRd5f+D1dNpBSSrf9+1M3zwySzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DZjko+nJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PFPMtS1701412;
	Tue, 26 May 2026 10:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Z9PhV
	P4fdRgThYzKmRoqPXgwTSTA5E7NsBT4riHzu4=; b=DZjko+nJC1TJhPNPYJILpj
	eDRPgoyLkcj+ISLE16zx0ZVcZGZ4GfZZUMAtIkMqkRiBXU71mAXOD69lieqr1fDL
	ZHQJjeCuqJFqneBbLwt2fVjskszuxbJD/v/0Tf1xRghhNSLI8JLgz6luHVa6Otz5
	wHx0ynQDqGXRrNkvwaPJVQdGu+3wNkzw2157I8mE/JHhDlcoP7zGZ0qElsBZImw3
	2Nw7aw42f5/zVdhDKDPIPuxqvm6xsEyOqhAERhcfDAxO2QTMWpFWxYcjjlIOYRII
	VMeCehcd5yvogvGSv6aSH15+F0XsvT/mSx4d3lHPp0SnlnpKZScU1gH6ZSmYBRrA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2bgyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:21:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QA977K001248;
	Tue, 26 May 2026 10:21:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg8ngr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:21:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QAL2pO31195484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 10:21:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D7C220043;
	Tue, 26 May 2026 10:21:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0503520040;
	Tue, 26 May 2026 10:21:02 +0000 (GMT)
Received: from [9.111.69.223] (unknown [9.111.69.223])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 10:21:01 +0000 (GMT)
Message-ID: <f8621d4c-d428-4c3b-bffc-2930cefeaae4@linux.ibm.com>
Date: Tue, 26 May 2026 12:21:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] Revert "s390/cio: Fix device lifecycle handling in
 css_alloc_subchannel()"
To: Ben Hutchings <benh@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>, Salah Triki <salah.triki@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <ahVuMv5SLjHVUbkt@decadent.org.uk>
Content-Language: en-US
From: Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <ahVuMv5SLjHVUbkt@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -TCrAo-bFs-lByuV593hQFoY13KaPfkn
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a157411 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xNf9USuDAAAA:8 a=08Ht63noldzhsuHC9XQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4OCBTYWx0ZWRfX3lNqx2Ea+Thj
 t4bSiW0V7FcBbayX3WgkhptRPVT3CLhXAgGwAB4+xqOyRE7TjDLJMH51aeMyNwTroEWTOPO+y2A
 yIO3bvoSNR7okw9dTYvyVRHOTP9lhR+DOsWB6lieXKftLNsC1zcGV8hevLu05feOe258c8dEHM6
 1JNu91t0Eu+DURas1hQc7oak66J6f2g+gGOin7LaBikGbcvAwjlGtme82UPH9EtU/hoN6XIAnCF
 7yFyKBOmB4hD9GwjJBTf2n6O3kROyamFhy8QljZRrTcD+4RZcqoaBv1Qx/WjA8hs5sWBDwQIhP4
 nuJYyPaiCW+n1To9SZCwnqd4VgQSAL6gFIdqvL90qETI29IspOI5e778178AtAuvDsLWvBJIoFV
 zCR/fGh7e9p8xTh+fqLrkJqFnGOi1BN025ajKOsM8csqutZ6cUBxb/ZlNrn+oy3ABRxGlhbJZ97
 RUcktdlMnNX1fnoiyAA==
X-Proofpoint-ORIG-GUID: 72_3DhK9arN20jyWnQeBtgjRVJZY9e_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260088
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254294-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.ibm.com];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vneethv@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 749855D4280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 11:56, Ben Hutchings wrote:
> This reverts commit 2b2ad7ad4a28ffdb9f94e6d979b88a5b12b71681, which
> was commit f65c75b0b9b5a390bc3beadcde0a6fbc3ad118f7 upstream.  The
> order of initialisation and error paths in this function are
> substantially different in 5.10 and this backport did not take that
> into account.
> 
Hi Ben,

Thank you for pointing it out.
I overlooked that part. The goto err was all before device_initialize().

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>   drivers/s390/cio/css.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index e5e20ea850aa..cf2c3c4c590f 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -241,7 +241,7 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>   	return sch;
>   
>   err:
> -	put_device(&sch->dev);
> +	kfree(sch);
>   	return ERR_PTR(ret);
>   }
>   


