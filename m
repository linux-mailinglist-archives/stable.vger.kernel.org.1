Return-Path: <stable+bounces-50520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D6906B03
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667FB1C22079
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03255137C22;
	Thu, 13 Jun 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cIH3LYnS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813D82C76
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278308; cv=none; b=S7J+yB+kaikAg9ZF4IRuZDK//eTwNGIUIO842EtyyivLmuqA9gndlMghvA1W/7R2MuPxc/S5n0xmr1+pLFaAm/TFWs6J6eN3gVBM4gRDwC8vfJ5VKLaJyBdGOINo+F5yhdiAYEhHt0M5u/WnconHLgMyuSYJPRra5gGIqszDd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278308; c=relaxed/simple;
	bh=+Po1bceQjmR79RNhdr6mXFCji5Zpx5SttKnX4bqFajY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=O8eArH2khyC1rmx2fgLAlSF+Rh6lXOMW56EzyVj4Tx4dRbC2e3dNjLnmw+TznFthdOMtehldqjF4e0B78UOgwOj3sGildBugvoCn7Ui1mlKferZdw51ABWDsM+58mTCgdCAb+VBGNzHFQANQi0Jfx4H6yGKRhg4AzzHtwZ2SiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cIH3LYnS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBQcPh002199;
	Thu, 13 Jun 2024 11:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:reply-to:in-reply-to:references:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	7IIuIlgxbhmAnildwMxs9jyPNaowhQ9OqPw2wqhDKqA=; b=cIH3LYnSBDRnw3JZ
	v6e4mFs2g0Pc+vFEiOl4WFjAytwOfX0R2DfqPyYjytLuxjaQpx16aQl136rabZND
	Fxe6C6sopzULTbKBIKe4CbqR82U1NokClOo5oFWJG4ZrB2iDb5PRzqhlsxNrgjkc
	hR+FwRtP0JfmWpCGQKot4uVkOBqr5LpWO/t3yIRe3QRuVJZoHbkTOnHgjrT5AeyY
	sFcn4RGzJJWILrCLX3h60PsE/DePWsZ9lVcl3/16MBqNLL6jMhCIFbbp0tUhWvDC
	MweLq4vg+xiNla6WSbYJPaMWlL30A314gkVawdTl9HwcDnmegQKLnDaJ5UQ2yZ+U
	T9N72Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqr0vs7fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:31:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45D9idOZ020086;
	Thu, 13 Jun 2024 11:31:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34neuc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:31:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DBVehL56689144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 11:31:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEA925806B;
	Thu, 13 Jun 2024 11:31:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC4A5805A;
	Thu, 13 Jun 2024 11:31:40 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 11:31:40 +0000 (GMT)
Date: Thu, 13 Jun 2024 13:31:40 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: dengler@linux.ibm.com, hca@linux.ibm.com, jchrist@linux.ibm.com,
        nsg@linux.ibm.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] s390/cpacf: Split and rework cpacf query
 functions" failed to apply to 5.10-stable tree
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <2024061358-scanning-hacksaw-0540@gregkh>
References: <2024061358-scanning-hacksaw-0540@gregkh>
Message-ID: <32c44bf380d30f44021255c3e8369085@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SJrK1CWky60UuSBk9bWmEhyJqyCtMpXd
X-Proofpoint-ORIG-GUID: SJrK1CWky60UuSBk9bWmEhyJqyCtMpXd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_03,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130082

On 2024-06-13 12:09, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following 
> commands:
> 
> git fetch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 830999bd7e72f4128b9dfa37090d9fa8120ce323
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> '2024061358-scanning-hacksaw-0540@gregkh' --subject-prefix 'PATCH
> 5.10.y' HEAD^..
> 
> Possible dependencies:
> 
> 830999bd7e72 ("s390/cpacf: Split and rework cpacf query functions")
> b84d0c417a5a ("s390/cpacf: get rid of register asm")
> 
> thanks,
> 
> greg k-h
> 

...

Thanks Greg, but I think we don't need this patch for this stable 
kernel.

