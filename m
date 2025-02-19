Return-Path: <stable+bounces-118338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68DDA3CAED
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B362189C0A0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDAB253F3E;
	Wed, 19 Feb 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XY+ozlaA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8622D7B0
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999077; cv=none; b=tAzPSKPklNAMqO03DmEaiYudSxeqRBa7yIshxPPnfIC2gQYZ1XOBg4aG6limn0wZYmOTnr/DS35IIV3dZpqbsr2/SpXmLferBoouMblyx1hT44InVbhoELCe0xXmGpPW+hsS2P7+aOFA5FqMNmJlKjYb6iXIo8jEeb91nZhaO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999077; c=relaxed/simple;
	bh=uD03XlhNF3fkpZs/0ltwmNKsy9/qVYby/OQhjjVax4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvlahS5XgniGJrQSn+5u4TSfr8V0fkwAZzk2hdZ7g0cL8oq6l1gW6n18QnSYvBr0snk0Zl9InQtzTzxJ4gq4LePCJjKnxhcA4XoKUbNuKMcVHKf3s8C+uflAdDclIIfXCTXmGm1BTfur0zcuUanZdfAv4gqOATREHWvTelgmx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XY+ozlaA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGN8r6002930;
	Wed, 19 Feb 2025 21:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wR+RDk
	Nr0tvxfneVb3YO8MTjKLBLSXsczSqdN3VDIHA=; b=XY+ozlaA7aTesl6AD5uLXM
	WBOzZyF5wsjn6vHIk38BRTpoEN2Ku75geVBBVq/w1YekNv0Edym/VqkvMrFcRcIs
	ZzR/x+I5TFiU9k9KfmTEUdnhMNzY431lRb1vi2IBKdB+Txbxp4GmW+xm2R78cETe
	xt6W7u1nqjT+3efOwfQ/Cuhr/JA+NCzSKs3jhGd0E5Zu0Ww7qMBrfb8nS6aKa/+I
	seC8frJJFdDwDZu3Hafzh/9SoZBQ1jVKzbc5FF62HV7kLOjvduW9FOChH9RgHw81
	TiGb+2aRTgliuRGshIKaVQxInoQKNkPN+kn9Nod8hrCneVX1lrbiihwARs0Ux3KA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0nux9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:04:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKSUEO030262;
	Wed, 19 Feb 2025 21:04:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x69sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:04:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JL4V3P52756738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:04:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9154020043;
	Wed, 19 Feb 2025 21:04:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E60320040;
	Wed, 19 Feb 2025 21:04:31 +0000 (GMT)
Received: from [9.179.1.61] (unknown [9.179.1.61])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:04:31 +0000 (GMT)
Message-ID: <07552482-ae2e-4c9a-8d32-9f1c2fe5c6fe@linux.ibm.com>
Date: Wed, 19 Feb 2025 22:04:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] WIP
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <2023061111-tracing-shakiness-9054@gregkh>
 <20250219161049.119877-1-hoeppner@linux.ibm.com>
 <2025021935-driven-disaster-3542@gregkh>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>
In-Reply-To: <2025021935-driven-disaster-3542@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GvdmK9crSIMBb3FEJTQXhVXTlaPsBhWA
X-Proofpoint-GUID: GvdmK9crSIMBb3FEJTQXhVXTlaPsBhWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=406
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190158

On 19/02/2025 19:30, Greg KH wrote:
> On Wed, Feb 19, 2025 at 05:10:49PM +0100, Jan Höppner wrote:
>> ---
>>  arch/s390/include/asm/idals.h  |  51 ++++
>>  drivers/s390/char/tape.h       |   9 +-
>>  drivers/s390/char/tape_34xx.c  |  10 +
>>  drivers/s390/char/tape_char.c  | 436 +++++++++++++++++++++++++++++----
>>  drivers/s390/char/tape_class.c |   2 +-
>>  drivers/s390/char/tape_core.c  |   5 +-
>>  drivers/s390/char/tape_std.c   | 146 +++++------
>>  drivers/s390/char/tape_std.h   |   1 +
>>  8 files changed, 512 insertions(+), 148 deletions(-)
> 
> I'm confused, is this a patch submission of a backport?
> 

Hi Greg,

I'm very sorry, please ignore this completely. I was clearly
to dumb to use my bash backward search correctly. I accidentally
ran an old command that send this WIP patch, which is not
meant to be for the outside world at all yet.

I already put a safety net in place so this won't happen again!
My apologies for the inconvenience.

regards,
Jan

