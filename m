Return-Path: <stable+bounces-254276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOCpJVBbFWp7UgcAu9opvQ
	(envelope-from <stable+bounces-254276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:35:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822F5D2841
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC7A03039C43
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D8B3CC32C;
	Tue, 26 May 2026 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CU8XWO37";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1sr6HMR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3353CC7E4
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784475; cv=none; b=fS7+nagrmDvz2CB3UlA+l2+VNGvMRfsDN1CA+F+4no+yDcOSvPUYkosAU8t72WRoJLFAifOVO3sUrVmTc1AfqEejKVnuppbMg3x6lZPB6xv+L+9bIBQcyc6KF8ngAW/fFAgZsq0Bwcz/Z1aTQPVSwKyVvjb53+t4Mf5qn3Mtsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784475; c=relaxed/simple;
	bh=zyVZvYVS2YZPcpeVOAZ62uG+LGw0phivDVfxaxXtNrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNIo9rUr7kwCb2VATnEKcshfVUJG7SCterKehn3y1eGKL4beULTX4ZQKvaUiGgJipOCxDmwqqrEGyXm8sHrJ9P4gEpgpg7nNmdnR3AX1vS3RveGIGcyF0LLhW59Kn7JVQZyYqYo7DWU65wpc9CqaeCJJRwGjy08DUnsTZdOY95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CU8XWO37; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1sr6HMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q8VNP64117526
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4T3+ldKSNTWpMoc+vUyfnMAuek/rUUbqDMUHalnfifI=; b=CU8XWO37pHWJkv7s
	izd5ODBQYcQBzpd2L2xtoLpFgRf6Vgmv5E1gGhqo7Y5Y5+J2AIppM/nNUvaFWP0z
	xx+HE3NOddDYYDEbNN/tqFEH4sWFreN2flu1tbFIHwBPG8x/e+67zSWIPFGQxmBn
	adpYk2p1Ba7EzgvsQVfhRJ0TWc76rvdy1p4K0DCIy00KxurFoQVCdXAiM4z76XPz
	rl8iXMoyvNVlsqLQa/RJ940/ccs2GqIqQ4QdTVKLbeyUgZyPOn/dOPPRUx8Fw/uE
	LVTzaefWP/QB7NHBI4AOIFBbgWHaQFYQtSFF7yMJFLEdFjScc3vDDErUXI6+Pz+L
	mhR+pg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecquday7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:34:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5165d10e036so178099091cf.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779784471; x=1780389271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T3+ldKSNTWpMoc+vUyfnMAuek/rUUbqDMUHalnfifI=;
        b=d1sr6HMR0D2+eBXjd5ZXEFZLoCT3/lKYr6Oh4mLncNCN+1rwIcuaJyB84MKetbpf4e
         eBWb4XeQjMo3tDW2a7eqdUJGr//9zw8+T8acQxL69EL3XEoTSEG5Hz7LK5v+bVChnVmd
         ZcifjKaDlFmGizmwpM0YvGv2+ZndkrDKZxhQBr7T0HFQm8UlhCaNAZbNdrsQqPwns2B1
         lGwZRhW+5nTmsDlQzLe8QTSJOmBximIGJfZbm3bY1ASbhVVRpeL9yQ0snmfHCOHoFwRM
         0DKeN4cpZvMx8N85BbzRQ3JphMNNAD3javVd0upCBoDGIUQq+DR1emOUBedkADPdSP+/
         O7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784471; x=1780389271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4T3+ldKSNTWpMoc+vUyfnMAuek/rUUbqDMUHalnfifI=;
        b=Q8XyyV406OizQDoXsaMWyIuBBPFc4jL3UkdtV/VPaa43FBZeXXrheUuG8i5Xu+WHmK
         kQjpbQQ/g+rw2aSMvycU7rkCib823/au7vY5UjCO2dXnTGVBC4pzLwkoTLjxcHWzEUT2
         BEvfPoAwZutYccwj/LF3RFaTIfQaawmzUBq6/ZHLigj6WrZUUbYEqU6BS2ZZ1RnxXVtD
         JqjtD8/W8vZefXj3QfdylMqRqs6arfW9ZnPeyzYiwvcDeAXfYGo+5GMM5FCtgAsmkd9a
         Z9aOlBOc9FGfWHghSRpGCSGmAnQYvVLNCHmQLJDPGrjyh762J4AnTQCjQ2k8fWfmPFK7
         pg6A==
X-Forwarded-Encrypted: i=1; AFNElJ8R10pyX86KidXmqFWUoefz41jryxPCDod/XBS8Fp9uCz9cXOej8c6GI39p2vRDqxHO9PaTXy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqbbx56yVir7/vPvnaaJ5Bp2ILI/CaINKxnTHgekudLBLmM47g
	gMKHxDLm9TRrBqyq/g6SZV3kx9MtdgQvhMfbIMFcEsaOEzHEonN9Wf2h0mu6eUjuk0YFbeZJGnY
	5A0rCnsZONWnsXvj9cbj30AKonSLjPzyrcNG46qAc4cS1meHoT3OojIOPY9k=
X-Gm-Gg: Acq92OGjhOwDi1TKNFGZAG2kcPg+sbzYvFq84CBbrtaaN3s9tN1vqeFHUBfosLyuk3a
	mzs7eTe8r25uSHUiAy2g8EOvjddcMuNfg4dfF7FJW6RLdn5fhCJ1T9oDST1SJKhqBFRSEt/jGLY
	wIRBxtmro5EptvuIiIB5mSvmr1P5iD9juaQ5HDr90aqb+X/lRSv4C1GU30t72pJRUL3JHOx34w2
	6VIq0Og+RmgR7B84/R/Ux2tFaeeWHPFqePNkIuG+FlXaB4+ruym+zo3XPyRXg+OYHZel/N6rs50
	swx06NSQ1T+TUEOQTgk+t6M9sEfIVgtqY4Saj9uYthMAtWT1/KTP+en9caPuNpdw7Pml5nIBogW
	ICiZoxmks+nbf2X8wYztNAD9ng/RMMn22qLP43nkoAfsBPmTjbw==
X-Received: by 2002:a05:622a:1452:b0:50e:60d7:b286 with SMTP id d75a77b69052e-516d42856demr248985401cf.1.1779784471361;
        Tue, 26 May 2026 01:34:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1452:b0:50e:60d7:b286 with SMTP id d75a77b69052e-516d42856demr248985151cf.1.1779784470892;
        Tue, 26 May 2026 01:34:30 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:77fb:9b68:d26a:48e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49048c6acf8sm92904325e9.10.2026.05.26.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 01:34:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/2] gpio: shared: fix locking issues in remove path
Date: Tue, 26 May 2026 10:34:20 +0200
Message-ID: <177978444194.19212.4138855292775439477.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
References: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h0k22V5vLIuH9TWUACi2bodwUoFS-0Ww
X-Proofpoint-GUID: h0k22V5vLIuH9TWUACi2bodwUoFS-0Ww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3MyBTYWx0ZWRfX4PaaM2SgyQ9H
 f+Hm2mOpDx9JnDaveZ61TquCokCZ8ekt9fQl3KBi7HMGXYWiWfyfkNQapSv+g+a4Vl1q94lBDDi
 4+7DwXPuzGLbBl+QUvp6i4Z7DsDD7NPWNHAQQOcfKolBEpk0ES+l8J9lol2Csfs1cpJ0wvxmLVU
 +/7J8zncDTA4hmPOKKHdtuGAvuLI+XSVoWD2tmwmIk3UhsgWMFu+XyDwYxL5jWx2/7oSwRqDK5F
 LY2y1OR6FetWpQs8bDuKnSW1XguZ3yMGWtrhkd2l66z3fymQsCX/1rf+IfrmCZfmugUBBg4tDbb
 3jOmqf1mCjjlfjkdajgDARHfliopnyafjnNxYxT1vhA+RRJ+ad10OBEk7ekc3OoTbfqQ5RkQDYb
 UjfpSLdwbdjh5WLzi5EWl+ABpyjVUfr4Ay9nDpMYBHTlmDJrlGqgWtmFkOa9qrCy+6tQLiDunGH
 2jEe6TBvwrumFtYmYJA==
X-Authority-Analysis: v=2.4 cv=C9jZDwP+ c=1 sm=1 tr=0 ts=6a155b17 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TSCg4LgC_SF7kFt2K2AA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1822F5D2841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 22 May 2026 11:12:35 +0200, Bartosz Golaszewski wrote:
> This fixes two issues observed with shared GPIO management enabled.
> 
> 

Applied, thanks!

[1/2] gpio: shared: fix deadlock on shared proxy's parent removal
      https://git.kernel.org/brgl/c/755825b2ed6f3384a7f5d9cfcb2c8225df568796
[2/2] gpio: shared: fix lockdep false positive by removing unneeded lock
      https://git.kernel.org/brgl/c/8eaf57f93f1a43776c8a0036921bda9089ab72b7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

