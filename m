Return-Path: <stable+bounces-233751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBkLLJra1Wlo+gcAu9opvQ
	(envelope-from <stable+bounces-233751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:33:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 495683B6D97
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7FA0309DF11
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 04:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAEC351C18;
	Wed,  8 Apr 2026 04:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiCqsmQl"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86D351C04;
	Wed,  8 Apr 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622568; cv=none; b=VQt6OBmzQt8SdxF4mRrjf/Rz3J3x+d+BDxO/PwMQMjXFaKThSXS66UWZKAcqTBrlqz9uO5n26mKVoXCEQHw7hWMmjAt6R9MWiBvzM6UTT/d5WjVgeFOVzcAk3isOtID3U+/bwFjha+YuJzwBIuKj+J6jWKoZn6JGfLyCPeXJLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622568; c=relaxed/simple;
	bh=pXlEVnkBTmA5K7kvOLL+nmpCtnAEDv/XQ5ooCBWoxGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dk8oqm7OgqFb0UdxrVSW6VSyzrE0y2paDSlQ81G2+ONp0WkPYAyrKsHKlccD/9waBi3OR5KldQ164dXTvbttaImXnjluQt7wQGfOb+8sd46VdNJ45XFy1R4YqbdkLbKiHEjJ8tBqUVa4RJbzh061OfJ9Wzxzt6L2ICnIWE2q73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiCqsmQl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EHr9w2301624;
	Wed, 8 Apr 2026 04:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nFJHyo
	z9CXtW3KpITY9KgxOr/aRJZiT52yeFnJ2Ts8c=; b=DiCqsmQlx9KBQVDVPKQdxf
	TptWFU3KGbbjmurYf/yN+2iu+N8kwjf7w4C2+9X8aRJArWnlIURy6zfH76IG800k
	1HG6l1qATBE7Bxxk1KTaTpD3Z08K+DXbkbdpNTdcD4UA+Ql2Em7KM+CzRKerVZZC
	F0QeKbWHYenNLtdlP4kwe8mR9zNIQ8In2lpB41Gix0T10v+JRCRrrPwq2M9TVgdZ
	WlaKbwVlOn8WmeXJ5t3yTdgV7auuXzXwG7XQDXk3egHF8fH5uzLX8moeahceMgxq
	4IAtjAZcNSn7rnqzsnQb/kEcmHn0bqjVZDKCO+/X5LnpL58WlR92J+NMhsYi5uYg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe793-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63800NQk018877;
	Wed, 8 Apr 2026 04:29:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9e0ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384TFr146072204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E35A20043;
	Wed,  8 Apr 2026 04:29:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F07DE20040;
	Wed,  8 Apr 2026 04:29:12 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:12 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: chleroy@kernel.org, nysal@linux.ibm.com, mkchauras@linux.ibm.com,
        rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com,
        mkchauras@gmail.com, npiggin@gmail.com, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] cpuidle: powerpc: avoid double clear when breaking snooze
Date: Wed,  8 Apr 2026 09:59:12 +0530
Message-ID: <177562236430.1381144.27958537257316890.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311061709.1230440-1-sshegde@linux.ibm.com>
References: <20260311061709.1230440-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXwPg28izPWoLf
 bQYnD/oHMPaCXq9W5q/syIjFJKnrAwdh1jdzE0KzsFXLp+3llLN4HAARpeMrw/Fi756loQC0Oaf
 sB2mHHubp/UT9e9JYHpW8yqCJj3kAE7QGK03CQ57+/v/2e9xBnDYLdRQs3YFWrSprWUQYvvKU7V
 vM1RQ0qU/jdMrutyps8zFtdgipaPgDYNyZaqCTtCcn+i1E7LgWrPONS8fDzpud1pLihTYGdcUGf
 0twhdpsY9ii32vS1cf2Rs6nKnIZNOEOivuciEun/a7IdyaK3Y9mV3oTglb29q5fV55q0HhU9uE7
 R+ygwkN1FIJ2vQDWOdA/HbEjObI8vUXvnNmB0St7RxZ2lWQf/Qq96buP4M2bVlWsQ+Ej08va2cx
 sSlGg7dUlkd3i4o80LatV6kBA3ZMw7kuHOMW9lcC0f0PSfm0UHd8rFvZlojP3eTxgaCFKhU3mXy
 rUjLfdrBk/KnmDqOoTg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d9a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=38kH_jgIqBUk_XIBi1EA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: _8GFPxaJzMLUHB1nkZMtDe-oV4YzIzny
X-Proofpoint-GUID: pAJage6zwfLutYcgN_oN4WMQbrdJhRpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,arm.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233751-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 495683B6D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 11:47:09 +0530, Shrikanth Hegde wrote:
> snooze_loop is done often in any system which has fair bit of
> idle time. So it qualifies for even micro-optimizations.
> 
> When breaking the snooze due to timeout, TIF_POLLING_NRFLAG is cleared
> twice. Clearing the bit invokes atomics. Avoid double clear and thereby
> avoid one atomic write.
> 
> [...]

Applied to powerpc/next.

[1/1] cpuidle: powerpc: avoid double clear when breaking snooze
      https://git.kernel.org/powerpc/c/64ed1e3e728afb57ba9acb59e69de930ead847d9

cheers

