Return-Path: <stable+bounces-69703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF4958302
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEC8285BE2
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858718C027;
	Tue, 20 Aug 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DL58zEpi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB518C004
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146889; cv=none; b=RzDy28Il9De68/XdAJDSi9bJNoYtLTMgwf5GAsrCHYwxUoHGEozb6NyX03MLBkeiWaU3y5ruQ9xJees8VRexDnUTh2p3oqf9D99y/yRJa+nuM5Pw0S/GjRmU3swo2Mf9tqObF+akgx0GaS5mAa1Ep6u5NYEYxi6pQSEF0yPb/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146889; c=relaxed/simple;
	bh=9g/KHnHJF7yG5Q8k/14N+81RO1cILvgvpPHqDnQN9zc=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=G39+ViRQpCs55AiFxHsPz/vlBjrJxBRx+uvha+ZZxe1ViSCan9RUs1HeD14Iz7pWEkm1HWQBk+lJooor16Uir/ScoRrC9BzHT1UXxBb7T8p4RHiPi3nHBAu4iYHLXKhHiavIBH0LzpQgnebNnxAx8s9rAq6ncPeGZhF8xB2AZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DL58zEpi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JN9BFR018330
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:to:from:cc:subject:content-type
	:content-transfer-encoding; s=pp1; bh=9g/KHnHJF7yG5Q8k/14N+81RO1
	cILvgvpPHqDnQN9zc=; b=DL58zEpijTUxf2qIKkxujBayWmriOE7j8a9OtTjbH5
	JuxgDrMAMEZxEkX0AYeIbgA4ybLth3S1wg6Tz7NQKeqww3gFwO2MtUB38Jo2kzzk
	cak4uGgn5MNr/9TBkvWJy+34eM0DJ7hRWn92emXCkAtSyfaSDe2+kOXqCHZ7eftw
	0V8PRPuBbMQNdGskRWzLWnmrBXD4WqCsFD4IwzHk8Hpe8/aQvQNo1uH+luLIuqB9
	F2uwCSMbUNzAJyCY2cIkv3p1eQI/LuJ4QRsrxtnA8oimEdQtgnU5EbZ6q4Z9up8M
	nKnZfpf4Sl6owq2FGHjNs8D9/mnG6K49l2LecYeYW2ag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5n0d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:41:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5UIZt013098
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:41:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u2fhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:41:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K9fJKT56164834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 09:41:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77F3920040;
	Tue, 20 Aug 2024 09:41:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A2220043;
	Tue, 20 Aug 2024 09:41:18 +0000 (GMT)
Received: from [9.171.72.146] (unknown [9.171.72.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 09:41:18 +0000 (GMT)
Message-ID: <dd70606a-8121-4631-a799-86400e9a3c8f@linux.ibm.com>
Date: Tue, 20 Aug 2024 11:41:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: stable@vger.kernel.org
From: =?UTF-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>
Cc: Stefan Haberland <sth@linux.ibm.com>
Subject: "s390/dasd: Remove DMA alignment" for stable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EKZ3f1a34CunPNoQ_Y_h6l-F_UBYbaic
X-Proofpoint-GUID: EKZ3f1a34CunPNoQ_Y_h6l-F_UBYbaic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=657 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200070

Hi,

the stable tag was missing for the following commit:
commit 2a07bb64d801 ("s390/dasd: Remove DMA alignment")

The change needs to be applied for kernel 6.0+ essentially reverting
bc792884b76f ("s390/dasd: Establish DMA alignment").

The patch fixes filesystem errors especially for XFS when DASD devices are formatted
with a blocksize smaller than 4096 bytes.

The commit 2a07bb64d801 ("s390/dasd: Remove DMA alignment") should apply cleanly for
kernel 6.9+. There was a refactoring happening at the time with the following two commits
(just for context, not required as prereqs!):
commit 0127a47f58c6 ("dasd: move queue setup to common code")
commit fde07a4d74e3 ("dasd: use the atomic queue limits API")

For everything before 6.9 a simple git revert for commit bc792884b76f
("s390/dasd: Establish DMA alignment") should work just fine.

If you run into any conflicts, need separate patches, or have any questions,
please let me know.

Thanks a lot and apologies for the inconvenience!

regards,
Jan

