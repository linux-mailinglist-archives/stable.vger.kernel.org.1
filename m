Return-Path: <stable+bounces-203433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD7CDF412
	for <lists+stable@lfdr.de>; Sat, 27 Dec 2025 05:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004F3301E1AF
	for <lists+stable@lfdr.de>; Sat, 27 Dec 2025 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427D26ED52;
	Sat, 27 Dec 2025 04:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o53IPqlG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE5246BA8;
	Sat, 27 Dec 2025 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766809463; cv=none; b=LiQr2cRiugQGlox+ycpQYe81AVwOMsq1S0FJxBKMFPfguP+peQ7nilCCcmcwXyfRVReZpzNFY/0ShizbxbkWLok/+Ql+oI4vzJIqm1d2MHE84fuPMTpCsFZSBE9g+wMIg/lBjr5MeWgbUryLts/VV7KebZemSFdrnoVGMwOUmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766809463; c=relaxed/simple;
	bh=E+gB2eTbxOZj6zhtKZSaj7CASl1gmS6IzTrRkG0SSXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr4w+Xcrgaj5xq1aUtR9MyuDRg6WnkROnHdttLUERq2cRLaluMzJGAU1Tlb+ewBdXsPRnfuvWeZyZvmNO1j6kBnYBQ0aY6RTq2qJhnisySFXNgNGRp+Fp43QSJuxaFjkLy51BAD5noYWBwYSQm3vPX/MOIDb9GENccMRZmqomHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o53IPqlG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BR3H236020943;
	Sat, 27 Dec 2025 04:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T4SjjN
	iM3QrHUXvGqwS/8fjEUNdNG98kgkLuHsi/dGc=; b=o53IPqlGV8tVO/fUx2Gjej
	9tEFGVez1QoqhkpsnHbDhkRJRFYMqBcWrcl/9LLZAt3Ixetuo902zmCw1Mu+OVec
	B+aQWDkxVgn3BsGhAxq5jC6yD4ErxdlVM1aAbYyLhFSuE9erF/cEszErPPIIRpiM
	lpHaWLgrbfQVUtq8xYme0XpHmmRd+SpOMirsIpt5VNlNytky+ez7pcwTM7jS76zd
	uPL4/J+kSWiVscbm3f5bSiDwW1/GgisdnRcjSBAxZ0gsS18PC5t23253Xnrv/731
	dWl26aad7bcLKVmWnGUDm8QNyZRRwngQdSV+1rH6LLi/zU0aowqkJs/duZvJMjWw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba764g4sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 04:24:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BR4JsqF029278;
	Sat, 27 Dec 2025 04:24:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba764g4sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 04:24:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BQNqTeT032307;
	Sat, 27 Dec 2025 04:24:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u1j9d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 04:23:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BR4NwCM30409202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Dec 2025 04:23:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5569020043;
	Sat, 27 Dec 2025 04:23:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88C3320040;
	Sat, 27 Dec 2025 04:23:55 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.124.212.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 27 Dec 2025 04:23:55 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc: Cedar Maxwell <cedarmaxwell@mac.com>, Stan Johnson <userm57@yahoo.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: Add reloc_offset() to font bitmap pointer used for bootx_printf()
Date: Sat, 27 Dec 2025 09:53:54 +0530
Message-ID: <176680916368.22434.818943585854783800.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
References: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI3MDAzNSBTYWx0ZWRfX7YD+772Jl7hL
 gv2DTJTqI5rKea2XNqxU33v24SBIdmG3g7QiQx6/aMIuHh6WMDqSdi251W3ffGzYTNjyLrfz4kt
 LtlfBkbcOp0K3BnwneYs+UvCggOfqkK594/2jVRpSL3JXsW5IYV+7Az9EqRZtLjvB9tIAmQlUe4
 JoknniGGkOC7IHf2BXH1psKKXj8qOEcTa+aHa6ktJ07+KcXIxgC98OXZfb3B+jeVtFbxV0QJ71F
 WBfkCleJX+DyB3hLtBTJI5hbM8xJvNMgQQMDd1qU6DFFPZDVvshlbeFLNb1D8GiiQxwl+BOkOx6
 g1kAzD11xmZgbMROKZAN16CLhH0ra0TLMhGlDWCo/6hhO4/HG0YtNpZcUFFwXW8wI5ZD2ZPaS/Z
 KwbfJeV3WkfxXWVams8YXhCCjTsluXkoAgZz8pMSu14PNJ7yJuOl1bfMfBBt9cxEOeN6TRl4Ri4
 62NoHTneu7btBVAcixw==
X-Proofpoint-GUID: 7W8Z8S-viCpKr8bXbvNZem5mZaqEfon8
X-Authority-Analysis: v=2.4 cv=B4+0EetM c=1 sm=1 tr=0 ts=694f5f61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gOFnQ4ukdvCLGlC3dh8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hPqcJbTMXXTVhr5jiATGI2hbu7Y8nAZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512270035

On Mon, 10 Nov 2025 10:30:22 +1100, Finn Thain wrote:
> Since Linux v6.7, booting using BootX on an Old World PowerMac produces
> an early crash. Stan Johnson writes, "the symptoms are that the screen
> goes blank and the backlight stays on, and the system freezes (Linux
> doesn't boot)."
> 
> Further testing revealed that the failure can be avoided by disabling
> CONFIG_BOOTX_TEXT. Bisection revealed that the regression was caused by
> a change to the font bitmap pointer that's used when btext_init() begins
> painting characters on the display, early in the boot process.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Add reloc_offset() to font bitmap pointer used for bootx_printf()
      https://git.kernel.org/powerpc/c/b94b73567561642323617155bf4ee24ef0d258fe

cheers

