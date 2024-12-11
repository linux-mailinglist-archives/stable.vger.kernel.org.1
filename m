Return-Path: <stable+bounces-100626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6299ECEF4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B32628359A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D662139CFF;
	Wed, 11 Dec 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fxi+UwF7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA1246342
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928478; cv=none; b=Q4A1pC/RrGUlMUX0WNVZiKGjJad3mE/uW58C3zDOE88cCgGv/7+6BMGCxL3mxnYarWwGm9o47gTg2mhYQO7ug40lkYTCxAl0fEU9Uypic3mPrmRGu4l7ncIiXYF82zTNpWdyjTY14+h2RSv6MeetEyMfmzwdSUHTyFlgw49Cpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928478; c=relaxed/simple;
	bh=A3crZhLhhwzuN53kYYd9PEpVGn/RikzNiCuJjWVxrCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EN7H+PHvyPIs/C20SA3BButCHsTWQDIGHckD+/2+ytVHP+oznqoYUJ921dzTIxciT4+iQlUywg9on1hsAq+qAjaf8TCGrmnH4dBurPAOxLVMn9jVOSFIl42exQb+m5LhrGHQMd6jRv8qCMtS9Zv4ni5SvTo6hEQjrMQNvmMMLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fxi+UwF7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBB5ixY008120;
	Wed, 11 Dec 2024 14:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mJjB24
	zeEIpnOeI/QQJ1ue33fP47khP9nsKVA5qz4o0=; b=fxi+UwF7Cca9aeIu2+0K+l
	GagAKeYq8PC8NcAZgZblAFspxIB7cA0vj9u2YICi3lRBzq2jjhB86FlKVuuTLGYj
	5s4AV0YFjHeWz9JyrHJRbKwGsSZo8Cj4yTpziXyHAlSOvCJXJRkzMDK2ynrn7tba
	lCFsAxQzO5qaKxqWHzfa6co5MtdV5lo8aBTSAN5WuO7Ce/4MHsf133SQkW0fbnIU
	vIAcmP1VuXdHDwL0kkEX3YKE01bbCeC6QAuKbhNVRjBg2psGri7L2LVOeC1+ZOM9
	tuSHl0BY7NB2ODGJfe6Qh9Xez0Im3OH8p6vi8v3kAEFYMTMvCJmbE8QdftVef8OA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8wxuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 14:47:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBCt0Xr016952;
	Wed, 11 Dec 2024 14:47:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12ya6f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 14:47:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBElnE131130336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 14:47:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3917658060;
	Wed, 11 Dec 2024 14:47:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B87E58056;
	Wed, 11 Dec 2024 14:47:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.76.243])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 14:47:48 +0000 (GMT)
Message-ID: <a87ec276519e7aa151dfef0cc5b9f4bfd3c52756.camel@linux.ibm.com>
Subject: Re: [PATCH 5.15.y] ima: Fix use-after-free on a dentry's dname.name
From: Mimi Zohar <zohar@linux.ibm.com>
To: libo.chen.cn@eng.windriver.com, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, stefanb@linux.ibm.com, sashal@kernel.org
Date: Wed, 11 Dec 2024 09:47:47 -0500
In-Reply-To: <20241211082824.228766-1-libo.chen.cn@eng.windriver.com>
References: <20241211082824.228766-1-libo.chen.cn@eng.windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: psaIgG6qEoG8MpfHhESSg22p5Z2LZggd
X-Proofpoint-ORIG-GUID: psaIgG6qEoG8MpfHhESSg22p5Z2LZggd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=715
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110105

On Wed, 2024-12-11 at 16:28 +0800, libo.chen.cn@eng.windriver.com wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>=20
> [ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]
>=20
> ->d_name.name can change on rename and the earlier value can be freed;
> there are conditions sufficient to stabilize it (->d_lock on dentry,
> ->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
> rename_lock), but none of those are met at any of the sites. Take a stabl=
e
> snapshot of the name instead.

Thanks, Libo.  The backport looks fine.

Mimi

