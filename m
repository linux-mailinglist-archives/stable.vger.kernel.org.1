Return-Path: <stable+bounces-158921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F50AED925
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288D01896FB0
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D9248865;
	Mon, 30 Jun 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W18Voyq5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC01FF7D7
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277467; cv=none; b=GSocmkau4BrhGuaVKRju9Hqbb8dfulsT+Ltz7W6HiWJ7k57upvwjqs5UOIiM3o5HCZ2T7LoU2AmUflxVKQ0S8HCUrdNGG4hwVMDUyP8qyiGyFGzZd745i2YNWb1FGdUUWof2udrcqJOSCvqoy073JJC0p7RnLzuxi3FqfN01W4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277467; c=relaxed/simple;
	bh=5Os85b61YRWADHTXK040o31g0ipAXqDwlo4thq2RcOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqB17BfIuqOPj7awUXQD9q7B/cBHvP1jvnFT32k2FUFKW7ar9pgVSX8oPBo/YFTOKGo6zuQ/BG/D44M2bWJSFko3C301EHlLaukrwxCNjPl7y9zHb3CWTpu7wOt54Qq65DCU04a8/JbK6O6D5YNx0fLq5YX1vgYcb4fER85+P00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W18Voyq5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8TdTn016422;
	Mon, 30 Jun 2025 09:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7q5iNs
	1shjZ26YUj2S0S3FpjhxynxgNki7EaM3oB+Nc=; b=W18Voyq5uzCqZmeFnfNp/R
	Z3Ts79jOUeHWFnmdY7m3jQVvbfxho1R40Pt0CKIIJGi2+eiFeDYvRGGwpAJXKCAF
	+BQcxvsfBkEzf9EJ6/k153IzvI4gPvWK9ROXdZ04qFqe42u7wpb8skBp0YUrPM9x
	12LtX9WJuAbpMqPZ2hPYepXYWcFTI4cPXO7ucGn/WhRK1A/exjqPKwzLdwwqDq88
	5wptDx3Pnz5Qe/mcenJWSL1oH11MkOaRbyfjGl/ZjpMzIisyTihz+h630jUhli4o
	JY+Iqf2vXivQmlHTfwW6w49jyS6x9hAGG2wSFWJpY3gG+kCcwjjMnKuOYrib965w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt0wj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:57:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U61tPW011823;
	Mon, 30 Jun 2025 09:57:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7mn6ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:57:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U9vXSJ37487006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 09:57:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBA520043;
	Mon, 30 Jun 2025 09:57:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 995EE20040;
	Mon, 30 Jun 2025 09:57:33 +0000 (GMT)
Received: from [9.111.194.54] (unknown [9.111.194.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 09:57:33 +0000 (GMT)
Message-ID: <7ca9f56e-a999-4541-8e9d-93a9bb21c522@linux.ibm.com>
Date: Mon, 30 Jun 2025 11:57:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] s390/pkey: Prevent overflow in size
 calculation for" failed to apply to 5.4-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, pchelkin@ispras.ru, agordeev@linux.ibm.com,
        hca@linux.ibm.com
References: <2025062906-tightwad-overvalue-2006@gregkh>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <2025062906-tightwad-overvalue-2006@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nk9Ap1xLcyf73SaFdfR7vJaM4cu0z2w9
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68625f92 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=9-b66oxAR9C40QJQ:21 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8
 a=w46-cfdy0MOtRbFV-QQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: nk9Ap1xLcyf73SaFdfR7vJaM4cu0z2w9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4MSBTYWx0ZWRfX1Re/A3C0YdOJ psUKz05X9LE8tUH4PQO6VEg/ZjwOr7fV81iT8QuEP0apTbsKJamvlQ12JRtmKtRyU4A2OsojGwG 9ntKOtSehHb0OpqTizDL6E4DP5X2m/d+qLUirbaG35vOE8lvd1veAx0UtfxIFEMR7+Ag0XoGeSy
 hHPvzglSsVM5F61M6NXHsy7ZUIbfsGEmgv4UbqrnLL/vdluMR4roB60sUkjC22eshiZYup6Pm+g 07dk+kHwkCwUJDlEa3omlC4looY9km85Qk5wKuv7G0m9GmE35SGuMZSYm2LOw15J2D0PG7Aca39 LngreHmXVdp5rvdCQczD0iWHjh301+qobjp5qnbdz3PZg2a4EuYBMDJdEKvriB0zGNAFjLDAgKC
 DD0URRqEmH1im9Whgbia/lJ4sUTY+hApD17LFtpgPOftiKoYmDrSURttA0XNRWoh6JwuBIBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300081

Hi Greg,

On 29/06/2025 14:41, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7360ee47599af91a1d5f4e74d635d9408a54e489
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062906-tightwad-overvalue-2006@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Possible dependencies:

The main reason for the failure is, that the error-path implementation has changed after 5.4. But even if the patch is adopted accordingly, it will still require memdup_array_user(), which is currently missing in 5.4.y and 5.10.y (see my comment to the patch for 5.10.y). 

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com


