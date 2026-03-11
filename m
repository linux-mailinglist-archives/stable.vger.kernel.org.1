Return-Path: <stable+bounces-224631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G9MGjPQsGmLnQIAu9opvQ
	(envelope-from <stable+bounces-224631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:15:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339125AD09
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6101B306B3A7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A433E368;
	Wed, 11 Mar 2026 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tiJiX0x6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D634678C;
	Wed, 11 Mar 2026 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195293; cv=none; b=nX2mDiboiLFH5y8k3ANgAO+hGOzWSYpAY8t3NQimKQHf+iTxWmYGI9oIzBFZ5rwDQ1Wjj6Dytl4fsLOKZ1dJJNuvynUHckOkYq8dJRvjoZZMZnGR6w5e9llvbVpUoenFTXR7t7BgU0geXdSK8qkU/PL51/r/MYjGl6TGmASOk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195293; c=relaxed/simple;
	bh=jxd65I2ZWJMqH5CI7QZteHcF0fDlhB/fPBn5KcQ5inY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aP912d3CGmGO8ypUHXRAMYafyutgo2Pn3I6Ay0DVgdhHch+T3k9OrWOMgWS0K9WcX05vmUW/UW3fzxbUVm9/lrrlG/Un3baVCa43MTiN+KyhCaFCaMRZn/GXA2AOjIWjAqdqT5O/b468REs7wOouuziYbfdeW1JSGcliLZuGV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tiJiX0x6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AGlAF9370491;
	Wed, 11 Mar 2026 02:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HsQuhb
	4PDqGzYmjeDA4A7LQyti7aVQTEOByyf1irGk8=; b=tiJiX0x6jNHWUcXGF/ubZ/
	XOBXuIQ1EH7IJHyeuR9dFOxXfKOwvqUpUvRxsCHXGKhVNMWrASa78EH7Gzbqr2tU
	afgZsZhb+xnbsUAZAZhLaXQVKul2WBqI0X7nedwfK842gULwmxSAZTe/dAX2kPge
	Eq2mfAti8eiNt8Rys5XRcUy5WI39hXJ4r7F1V8aaedrKqwlXsWsMIBUQmtBFMX6T
	RQWn3PVTJ9fCSPZDXqajRMwgGqUOS1YYUpIRIb3l53PsngCIXu2smgAFqaO26/sj
	F2KFjnrrdeb/X1tb9QUbOqfBYD57xCZP5c3W6u90d/NU1W9TWBc2YNcJkm01PCKQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mnasv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B1NJP9023013;
	Wed, 11 Mar 2026 02:14:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng4kqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2ENgC42139942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7E0C2006C;
	Wed, 11 Mar 2026 02:14:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B94E2006A;
	Wed, 11 Mar 2026 02:14:21 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: Correct MSI allocation tracking
Date: Wed, 11 Mar 2026 07:44:20 +0530
Message-ID: <177319508349.269267.9488718055542693297.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302003948.1452016-1-namcao@linutronix.de>
References: <20260302003948.1452016-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b0d002 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=NCz27aoiHFB_FWDnMMMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX8xQR/MhxUl8X
 cRO+I9wq+AgL6iGttPEcXW/VYWjeW+Qcty2v0nnXfLVvRyQthrs6P+23TwhJMw4xSOs09a5UYsZ
 16f2UMUTPPg40hZ6NycN4TnWKXflNSk0eFpiFdhwK+e8+deE5kwykZhMn01e72F9eclyOMN77FX
 6Su2nIg0y/uJ7vKkg7G4mEVUGRT5U7cHYtjNN5dGQ05ety3Bx46SNMRfBVRBpv9dRzH8vExfpZS
 0WenaZ/9XoAzaWuzwaDKFANEOH1UOlNpr2R5S8zfFVIgqiK0D4+6jSPN7LxYjPTPPzalxTC2QO7
 hmOIEVrN2iRJDooiCnjFXTLMEnGu2JIR+drsuClSDJI3SiBcpCxNh46RD2e0dm3Mv/7dDVOFHtx
 w3ursakx99uzt8TEiVT3rowYQR0d/3k+0lFhXqsSES2HWBPk+uyq2uAb5n6q7JANRweC+qKazpI
 mq1IQDgMvkEH7k1dJYw==
X-Proofpoint-GUID: WH0uVrNZ4EaGxjvD2lL8qIfBzZt8ePXc
X-Proofpoint-ORIG-GUID: IKf5F4qSJQ-HRdcUSgYITaCLRcz1NFo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016
X-Rspamd-Queue-Id: 1339125AD09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224631-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,lists.ozlabs.org,vger.kernel.org,linutronix.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Mon, 02 Mar 2026 01:39:48 +0100, Nam Cao wrote:
> The per-device MSI allocation calculation in pseries_irq_domain_alloc()
> is clearly wrong. It can still happen to work when nr_irqs is 1.
> 
> Correct it.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Correct MSI allocation tracking
      https://git.kernel.org/powerpc/c/35e4f2a17eb40288f9bcdb09549fa04a63a96279

cheers

