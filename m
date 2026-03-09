Return-Path: <stable+bounces-223507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLZgFit3rmliFAIAu9opvQ
	(envelope-from <stable+bounces-223507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 08:30:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9926234C95
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 08:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 654DC300C824
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C381243964;
	Mon,  9 Mar 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RSFBYzch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6/1Gvy7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE51474CC
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041448; cv=pass; b=H2RNzonRZBXEz/PM7fgmzxhfrv3KzcBzmykB+pAigWSoj8EvNgl5xLlhmfYcpN3b//jmLKDpnpigJQUa+6aLUgwHU7/ROTV8TE0YNtujXk+56nnTlp9O0W6wPObKj2Xo8R3NeknbukpWt8mX29Pq8sXsWQ+YRKIonLsbW2VMraY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041448; c=relaxed/simple;
	bh=Kd8qJEQ1MJLL0QfvPt72Ua3hnI5RJ/rb/CwYYMsza9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q19vIlZduTG0Q0ro2WwgzS6dx0koNBuMstp1Jjd/0fheLkWidWvJsP7Y6BoDc10xUjL165M79Y9yEdaqzeVCh2QwqucghcAa4GYSocCEsHX8rENSKVF4d1700fWKWQNBFK9Q8iF2EcoVD2ukCKNI9Oc+qbWeWB0izs4fLUiD3aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RSFBYzch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q6/1Gvy7; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628KLbOi4080713
	for <stable@vger.kernel.org>; Mon, 9 Mar 2026 07:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=; b=RSFBYzchkx1FJOkU
	MSQihrtqCbBriUU/UThW3/sACa3gwCpnDJS1F1MHLzbZtwHgEVzzg9YU/BB9FeyM
	FqqlvLcdZiu2627KnFin5jCxRKRPi60KfPfyOYUODjjIhxfgAUDzvSYp7U0ZTVEp
	W/8/cN+vX1RMI/0S9mBb3aak1m5bJPygWcUvtjLLFq665QEJYOPBW792BvxO9k68
	RLO6O6k2OjGks3/8L7wu+G7J/p1DwGktcmm9Y8mkqHAzp8HTzYtflJAmDQpWt1P9
	jkAJdC6fDxbnRmNQYywgjl88sdUCYq/D9ficpnRqvVlYp0uXhdaHZWvVUqNrLgTe
	kRCbWw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3vcaes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Mar 2026 07:30:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso12583452eec.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 00:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041444; cv=none;
        d=google.com; s=arc-20240605;
        b=OHRa/nf37QwhLym+Zo5Kccw0nPRaX5Y6KZVFfBqh72DyoonBCPAM1+aNgzoBhoXryD
         ymdeXXJN/yaCMz8Iflh9qXAINBw6w7OQ7wuxd1lm4PuUtTt+rxyjb2KwwfexSfXvRlD+
         TYboHZXkjR34eBcF4vpxetf4kHh3JFM4J29EXMS3l+qOOXg999x0z9A9HTFcWEwb62ZU
         KAxUap0yL7gcT8/W1NtPcmHqOxWhlGwBBQWRG44DDgeHPNuX7SLzHKw9D5zwe4p92Pif
         BUVZce5fmYXt7YZY1D3oVLfrJGLjQ5s42BdbQJD3aDxxub0fnV9tyKdNgUjdROO1/0iG
         1Eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=;
        fh=Kh7Kwy50jzQVXL4eEDq1je29eh4sUe1ZvNbcmpPBLIg=;
        b=T6CAu2AhDwZq9uCgsJbcljnkCsS6ZHXKPhi7fbtn0lzbvs7hIDGtP8S0cT3i2sWM89
         up8ldg+le46H7L6SfIFhrtd4fVaqcUjT/p+r/yifQL3gFXnI6E7ABYWPxVfyAYb8ILPI
         bb3hxvvHV2eDi2zMgZy0ipDW6lJ7qVKSD03uS2/ULguS8yUrK7aj3kIELgo9aUwNZwX4
         TLGRaiqhnAXyaLDK9pU104RE46lSci8tY7LwSsm8G9ablNLcecrgxWefrJ00vg8mTbtm
         a9PmGdoRKbZSFnAcDTuyk31uINKG4eFeTbgzo3QXNgnUz1U/hgvtYyxSWWUsWw3yNiAa
         n6fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773041444; x=1773646244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=;
        b=Q6/1Gvy7mh+NwQGngFQ8eA3klw/zVldQh2efbXiJz0NGl7rhU4RtbdlS3hkvYwnlDj
         F4xikf9sTyhzsU88WtU5Ai0mw5IrGcRQeM8qQ2kuUgs0ItwctiMNUzxg4ZO0G/vPex58
         IRXHTWjqrrSEbSNvFAv0cnv0e2j5gNz0Fb8X3ieyTaxYCcUkXePxDmfEsBKysnMzfEE4
         /fFC855a+oXXKQeXIcnpTr6g7Q3UrLr/FjFzfR+tOwtclyZtQY8zBe6WJizw0RKCXZxr
         f+uuqBhhzI/fsvWqjPvJZJRYOD2o1YLQpE//1ocacq9kqr4R4CidnSOmpcw7wKPeOuvL
         EfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041444; x=1773646244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vgyV+Kwyk8s5UKBM6CVvq8A5daBL1eUe5rh4Kx2894=;
        b=aVOafpqA/7A60i8EbnqIxR0hRJkYtAv8rAVYDngWA/kARA17okbuNt8jcxTIy81XSD
         2moJe2FRRXAcp3Qj4ssVNYyQ739hYa0Y+v4/fgvU5aWuF5589OhlE1wF41+g7Ky0Y/fY
         txkGSfXrvsWh99jKLHJ/VeRD0ynEpRJFCCrVa8UY7BMtP4jTL40+yrpV20qBdHEwk8st
         bWgDdooVz1lLkNKwnJXMaFTx1YgD7cZBZxC4wMprcVDUTGQ+KhE3ZhXLklwi9Nr7eEbE
         0St1KyCoTyfG81/soYAiL+TdPqJPPa9j2BBerFZ7g4NB/0B5vs2k0Vm3YW6AOxqMDHyZ
         YMKw==
X-Forwarded-Encrypted: i=1; AJvYcCXq+nI88YWXq2DaawxUdHZ3qcSjPMf4RScFEP9onXe5wAONuhmuZT5aHNH6Y9F5lzMXelI4un4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsXhgtvnKbdBudhISsI+o0Fx3XXG1ajDaqVjXh7dvsPebi41P
	cu0oj4YpcOAMcjQ9aX9C+MpxNS6Av+cZFcHp0/KdjwTld/Drk9RNYJKEnf0HSMakSghVt53qs+c
	H0hGcdcxP0akHmJeZKUOLvXrbljWaac0VMhNdhpl89bxWnzadTc9DDuEpGqLpLKDur7Zi+zAGXk
	whifViV+qoA0FVTyBIm4kHtJFcJ5JfO5gMrQ==
X-Gm-Gg: ATEYQzwH41lye5/MKK3/Ks4nPr3SEKSPrdUfGoFJo+suxnLh+LiObZAa4b6w5hKM/C0
	wQWyZv3PIAzBYjchHsgin0vOilF1ns1FyX4b09FVjq3eQQ5o0+jG3tWPDxLLwOJDGTETdV3nJV5
	08zTcmUDvFPher3DODHZE28NekPMWI4EzHmGG2RPL+9JSLfP0ZdFPnvvdDRoSkIECF2C9Rt0ARu
	RTOPyk=
X-Received: by 2002:a05:7300:80cb:b0:2bd:cbc7:16e2 with SMTP id 5a478bee46e88-2be4deaee17mr4001089eec.13.1773041444354;
        Mon, 09 Mar 2026 00:30:44 -0700 (PDT)
X-Received: by 2002:a05:7300:80cb:b0:2bd:cbc7:16e2 with SMTP id
 5a478bee46e88-2be4deaee17mr4001080eec.13.1773041443825; Mon, 09 Mar 2026
 00:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-qcom-ice-fix-v6-0-4dd3347df530@oss.qualcomm.com>
In-Reply-To: <20260309-qcom-ice-fix-v6-0-4dd3347df530@oss.qualcomm.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 13:00:31 +0530
X-Gm-Features: AaiRm52VPpypDsuJ5PtJbOzCheET4KyzNoAC9-1s0jjopDFrH_S9Z9ZnkapMfGE
Message-ID: <CAGptzHP7g3frxtF2UKfUj=TJaJQobX3FrTb+eqRE6p8JPDZjEA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] soc: qcom: ice: Fix race between qcom_ice_probe()
 and of_qcom_ice_get()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: DJRsK-vl17poG3iidIbBO4-hJIV-awWv
X-Proofpoint-GUID: DJRsK-vl17poG3iidIbBO4-hJIV-awWv
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69ae7725 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=D8yADozZ_YwZBmLQuGgA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2OCBTYWx0ZWRfX45ljH+ejr0z8
 1r4UE2lxExaRDdvMs1iJZgGm+iByalBYB1uZZm/LRzf63t5qxbKr5jFgQInp+i1SiwEPniQAt7Z
 4T4sBeasILX+cTnYRERQ+gmM/PVnIgIr6nVuNsvSjHkXWWEssj8x+HZZscoAz/61CHYiE9DmJFG
 go/tQH5jjJAoIZYxPCahw4+7FB/92nNyFkvf8x5Q7fGeCxT2ZX/PXgEaNxB0VFjK8GH0ED6Tku1
 nCjm9SPu3SEhLeGM3NjN3Gi9pWeBDV9ZVSfaN86PtjVLIFBWTA/6jQzkY+uZVkt/dqVoZTXlDhm
 rTzzMahczuWrHO9M+uY2cs4HBPdWm9oUsc/o0YrQYd6iPtL5UNoQMuTWD3pg0lUzvAIWdke0Gcj
 GvM0zF3ERidMX/3q8HxE4YIMuRx5Ob0WAxxrC/c/QxBcUMgd74z3ROjEa5wUvvpS7XXXbFPtLVo
 XKB268iiLxuZSEL8fBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090068
X-Rspamd-Queue-Id: C9926234C95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223507-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.944];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 12:28=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series fixes the race betwen qcom_ice_probe() and of_qcom_ice_get()
> but synchronizing the two APIs and properly propagating the error codes t=
o
> clients.
>
> Merge Strategy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Due to dependency, all patches should go through Qcom SoC tree.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
> Changes in v6:
> - Fixed sparse warnings
> - Link to v5: https://lore.kernel.org/r/20260308-qcom-ice-fix-v5-0-e47e8a=
44b6c4@oss.qualcomm.com
>
> Changes in v5:
> - Used Xarray instead of platform drvdata for passing the pointer since d=
river
>   core frees drvdata on probe failure.
> - Link to v4: https://lore.kernel.org/r/20260302-qcom-ice-fix-v4-0-0e6574=
0a5dcc@oss.qualcomm.com

Thanks Mani for taking care of my inputs, this patch-set works for me. FWIW=
:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com> # OP-TEE as TZ

-Sumit

>
> Changes in v4:
> - For supporting multi-ice instances in a SoC, stored the err ptr in plat=
form
>   drvdata instead of in a global pointer.
> - Link to v3: https://lore.kernel.org/r/20260223-qcom-ice-fix-v3-0-6ca584=
6329f7@oss.qualcomm.com
>
> Changes in v3:
> - Dropped the platform driver removal patch and used the ice_handle to pa=
ss
>   error codes. This was done as I learned that we need to have the platfo=
rm
>   driver design going forward and also removing it introduces other issue=
s.
> - Link to v2: https://lore.kernel.org/r/20260210-qcom-ice-fix-v2-0-9c1ab5=
d6502c@oss.qualcomm.com
>
> Changes in v2:
>
> - Added MODULE_* macros back
> - Removed spurious platform_device_put()
> - Added patches to remove NULL return
>
> ---
> Manivannan Sadhasivam (5):
>       soc: qcom: ice: Fix race between qcom_ice_probe() and of_qcom_ice_g=
et()
>       soc: qcom: ice: Return -ENODEV if the ICE platform device is not fo=
und
>       soc: qcom: ice: Return proper error codes from devm_of_qcom_ice_get=
() instead of NULL
>       mmc: sdhci-msm: Remove NULL check from devm_of_qcom_ice_get()
>       scsi: ufs: ufs-qcom: Remove NULL check from devm_of_qcom_ice_get()
>
>  drivers/mmc/host/sdhci-msm.c | 10 ++++-----
>  drivers/soc/qcom/ice.c       | 49 ++++++++++++++++++++++++++++++++------=
------
>  drivers/ufs/host/ufs-qcom.c  | 10 ++++-----
>  3 files changed, 46 insertions(+), 23 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260210-qcom-ice-fix-d2a3a045b32d
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>

