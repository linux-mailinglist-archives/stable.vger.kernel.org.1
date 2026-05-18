Return-Path: <stable+bounces-249186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFOwD0enCmpy4wQAu9opvQ
	(envelope-from <stable+bounces-249186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:44:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB02566698
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB94301BA7A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C083DA5D6;
	Mon, 18 May 2026 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pr4rn+Rv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D03D75D2;
	Mon, 18 May 2026 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779083053; cv=none; b=lvt0z6T2UiLBF5MA7Z6bQCFXJcCKruERJl8aPwbFmrPjnuRFbkiZPqP5ta7+N5wnH0FuTRO0BfbhprZCcjUPwW5fyQ9jsv1+jyuyhSeOts8dteXfwQq6s4CQTP6gsao/zFQime3FqV8YUQVXB3yNyRQUwu1QU2OlcwLtunwGozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779083053; c=relaxed/simple;
	bh=MWVZh93SX2090NJwWwTf27ANqalqElOvXJvA7w/3mis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3w4hnfRmvhqPZleB9u9I2gcGbFKWenkqx7Hs2dxWWN6eld6qXx+Jd93sjDcCHzuhBXYQr4GEaNk6TeUvMiLTb0h+H7yHV7AnmN/O+uo79yJfjsw+34tpbhJAg75V4MyA8xybg8skHSvsyHEl1+WgaMxZsVY1lCM+xdAlSIHEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pr4rn+Rv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HMHmqn982643;
	Mon, 18 May 2026 05:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/d+b9k
	oYYJ383tPUUP0AcYDRjFx6C12hgmW5OIErYV4=; b=pr4rn+RvoWjNY+nsJ1dyY2
	Lk4xDETRtgC7TeurnKY4Cf58GljRoPDqNALkXl4PHgtgimN90TipQh9Uf8tPg7he
	G4hFMGAlIiIm/LralVHSHWH7ykzoEljm9zoJJBnmxOVdeHHon8VyvAZhOKORwGFF
	kUAuAJ8Us/JQ1V7kFVoBF/W/aj3F0Eede7KwQ8Aa7004VPdx89gmlyN8CaRLl/U6
	F5HBDsTP3W3gi8P49xZ+kj667w8m0w3WYQwXGRrPpeMPYBgUEEwnSCtobrLKE5kI
	YEihd/BW55f81ksXfUYZRziYqkQIve4nYjuvM3QlMy/VMfglS5jmYC3f8626OV/A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mebqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5d3J9024830;
	Mon, 18 May 2026 05:43:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxv3kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hhZa31588776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62E520040;
	Mon, 18 May 2026 05:43:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B2A720049;
	Mon, 18 May 2026 05:43:40 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, benh@kernel.crashing.org,
        smaclennan@pikatech.com, Christophe Leroy <chleroy@kernel.org>,
        Ma Ke <make24@iscas.ac.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/warp: Fix error handling in pika_dtm_thread
Date: Mon, 18 May 2026 11:13:38 +0530
Message-ID: <177908291160.287704.16294849296370164231.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20251116024411.21968-1-make24@iscas.ac.cn>
References: <20251116024411.21968-1-make24@iscas.ac.cn>
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
X-Proofpoint-GUID: osToTChQ8jajGyfxbqhQBOL5SDs6aD6B
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0aa712 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=-GyfqmGyNljL1kGGE3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UuZO23Y2vWK2vyeQJg-z0FiQ39VNilDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfXyHaHLqYTU1Vz
 N4BcCIQVyVx5BrJXcBs/Cc51xPVb6A1PfLQBUUmCErwa8w+mNrTguHZfFVZgcWb9e2ef/XVxXLJ
 3x2pRQYIchCso8FuABFNmOFx5kc7EYXmTk1fFd19LQe6qrCpoHhhYavUtdE76vj68/Qg3Jrsl5s
 DSi5QTW3zQCqTyiZ4ZvjsC6OsVnMeELvxU5jj99hF4RDJWy540eluF3nKQo963hzRBrcpVm6ONU
 oizlYb4pHN3CgsYu5rdUai05Otg0bhBiuHr1FYR2rUly8Jh/UPUMFI7Ro9ZcS5bivXHh054N3P4
 thCm7rOpkh2N7mpzAJUC3D5T0/anfg6WYpFfWV1pt8LR2vjaHmzo/NQYOiVGQDCA9h0yn+Ch1oK
 tS1wkgj0vg5IX0fH0Utg2gEGXgqgqF2Wg+DtsFZsdPLcoADMfH20H4yKdoXacbJnQMRue+9KD+G
 3lDl840Yt692R7XdfsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051
X-Rspamd-Queue-Id: 9CB02566698
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
	TAGGED_FROM(0.00)[bounces-249186-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[ellerman.id.au,gmail.com,kernel.crashing.org,pikatech.com,kernel.org,iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Sun, 16 Nov 2025 10:44:11 +0800, Ma Ke wrote:
> pika_dtm_thread() acquires client through of_find_i2c_device_by_node()
> but fails to release it in error handling path. This could result in a
> reference count leak, preventing proper cleanup and potentially
> leading to resource exhaustion. Add put_device() to release the
> reference in the error handling path.
> 
> Found by code review.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/warp: Fix error handling in pika_dtm_thread
      https://git.kernel.org/powerpc/c/108d7f951271cbd36ca36efc5e5d106966f5180c

cheers

