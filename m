Return-Path: <stable+bounces-233515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLSmMom91GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:17:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5AA3AB315
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99E5A301175C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6443988EB;
	Tue,  7 Apr 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWsUjMDg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLxAjpYR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B538C418
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549813; cv=pass; b=bO5sDXfAvfF6Bc8V9KOnVOh4STSnzVEUm8dflaxuIua0+D9ghs8e+BnPqmw+vzklBDaJBQhiMh/SXyj06ZxX/OzaK/bWl8OglLgYZqCue69WhSnfYp8jX21/m+lL5wr0KaPiZM3bwnx5Vl7iKDEl/UgM6gefLytfcZVd1EtuPaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549813; c=relaxed/simple;
	bh=DUS80N1TkNrchRW550dN0fYwEfuhD9eOewhPt46405w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxU4ik9C+tD2iOuilfsnyYmKnUz13IXI7Jy3v1aQYJNCOUiogIYcDLukP2XLjfrg1ocZlPofcG0/DCw1caJo6u3ugDct+tnadFbxMnDBAm6jY7r7m6y2Z/gJFU9KK2+k4ba2WbXlE1xMKesVe6V9U+JoCC2gVmi1HtFGsqG7A14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWsUjMDg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NLxAjpYR; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376gbgg3815288
	for <stable@vger.kernel.org>; Tue, 7 Apr 2026 08:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DUS80N1TkNrchRW550dN0fYwEfuhD9eOewhPt46405w=; b=AWsUjMDgUCzLy/G3
	EwUhErl8AUhxX/EAlSB6cDdLyinbChRX/OIB+ybql7C/X9/vQM/+Rj0la47xplr9
	dNrnYG/08cal5QPo33Ym1VT8PKpXGJ+Nmsdd87SkZatpznndEmVluIRtqngD3BsD
	T7d2iGP/QyasNa04uqKCxnpapOH+UjmsB3u5PqWvLlehjcT0rq2vVfa3XwNYpNM8
	WAMPqPT/rj+969MTtBH6kUPwuaS0jnq2OADouUyCKIENBu4UhO/BX6OMYQhkCGPO
	iFA9JRqSF6oNor91vH+1huACkhrX9QBG0r3xL7Gq/2+RjQ9nrZc11so7X4NK5qyS
	0jVA4A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4sryv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Apr 2026 08:16:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89ebd9e1ee4so279076656d6.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775549810; cv=none;
        d=google.com; s=arc-20240605;
        b=kDn+GOPhmvYyqdD4NHgrSrCbNuwqkTiVOAKKXoESqNPXccpLVOto5HOcjXAVUftPvg
         hup92G2fCyx3Vlg9GbXDrGHB1O/09vTp1Prp2J+cx0a/ex4d7ngsghErCbRaQqt/52WE
         vt/Gqc97W9TDkCiDASxKLGf4TnEuFPsYRb+4+SUSOVr/5lLM4gdVEAklgQZBLDcsc/TY
         EwHi8uFd+w70F3DjpsI337hJkLO0n6suFZSP6ikceQyCFJZIGxy0SEY0wqKvMTYBZy21
         2V0SxSMR9z/A3210cuOFJLnWgfOLCQAdZBocUbQD8UjCy9IjZBpZLyw83YPz40cCdPYn
         5InA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DUS80N1TkNrchRW550dN0fYwEfuhD9eOewhPt46405w=;
        fh=Oh5JV8w5Mmr9wu9m/J+lS9s0XWLqf3hNe8oiFn6BMrk=;
        b=LEcT2TtxMSrC5z658r03//TlQ99V8pWrCgzasfVBWISBpN/zDAyBExqzUMtfAD7weS
         MBSq7SLGvKZtgooLBIAwX2plKG9ndBmdTqQe/07Xv8PWfacLhJwwojdzrhxAWYcfNglm
         r+c3iorPxJ+jIrJ0faoomv5LsG4R2mCfZJLus1nHNeeaUt/rRszlFMS+Z9yel8HW6hTg
         jdYbg2GS0b7pweSw4a4RjmI+CpJ7axec/antaNIA+J1Aju4iqSEXr/X56sF1NR7x4TwL
         KHRC6qHCjxRt4YSN+m9aFsYP9K8VJt2wq77STlJKQarPN3rzh/QUoCm9C4NIj1X7BTcU
         CAJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775549810; x=1776154610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUS80N1TkNrchRW550dN0fYwEfuhD9eOewhPt46405w=;
        b=NLxAjpYRauSHPAcUDF1uqz0h5qPIS8uNpJ/mwSYTyh1kJ4A8mpKNeW2qlF2SWaTk7/
         3D1hdCrkteDkVnRUonxSySMguJcJfV3ceGQ6+BhgTWhXPwEDDtyfbAJdU6aq4VDJBJ5M
         tqFcJRR8D4jzHt3J2IjWfsNxWDG5TDgSwVPoH9d5fucesTnN38Eu2VnLQnqWqKDj0wQu
         38ZYM0JEsoGmoiSP7VS5cqoRpCwjXSLi780E6ELl28Thh+cZKGhVZZZhdfntwfmvlK9j
         aZS7TTM1Bjq+XAUz08djLdlEHJ7K7I278B2kwJpw3a2atC/rMQW04GMRzBC7+9JNXi6r
         0IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549810; x=1776154610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DUS80N1TkNrchRW550dN0fYwEfuhD9eOewhPt46405w=;
        b=sfA5U5+LqSFsxxPmc7VOGVtysHytv2AwUGZlaxCv6+cIpzbtjRTokhJIB+WEcEm5fa
         ey6nEWmJpECYS24e2EwPnnDHBPaTPsCiNmuBOGFFBl5RxUdSLo5FQ+/ookdDhdbyH+nN
         8tYh4UD4s/mC9FmypexNAnl8/TZufWRii6LDjW7lBiTg9yMscvBLXkjabqr2NkTpMAWA
         Q9TJJFo2FQq9nEPzRKk7d8W4bHCV2Kx7M8D08hWvZ3ibpAbJZGQO1W2XbbOzG6y0hX+k
         5ANg/9bDH4HUJ3z/ZpYbwVVP+2i5uMNbJKWHsPr6T1rj4wrpcmUROQ0juTQm5Jr84WCi
         mKjA==
X-Forwarded-Encrypted: i=1; AJvYcCUVzJa471ZeludPoHP+SQYaEEi2vcXeEnt0dn3RlZYzTqHFw+v/Gk6xOEcmFN3baKe/zlgpAak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fIjrIxDQcR5c4sbnzyzHXmL3/TEvmhuH15+AqGv8Vwkk/vMp
	YOFH2huZG6DLjTJp/tyXfmd18SdzW1jISSAfosOYRgnRp0+kdr8Cs+tTjGXBHKGHvCwGBI89e/4
	0V5SjyS11fPOyNZLJfTnOMWvWV6wuy2VRPMHAqTWuk20srqGU4HU/NhdmCf3ZjTXoexRelEN7f+
	cPWHh1L663qJ43mj2dJCVyWDu4W30t7BgOqQ==
X-Gm-Gg: AeBDievWrNlJ7KDBn0E0dbhP7za2zpM/KVAS+fsRF2g/1hP7NOiJT/qc+hm72i5QaNP
	1pQhvnXPeANiR+6Plq1zzuww2CAf684lDcKFCYEWVp7mlTia7+6Ze+SIti6A+xx+fV7/tFqVt9R
	q9RvEl6qpRF/Y8Vt7JbP+geICH6eSkscCwwVoQrwHOMhQHPX6y1YBKVnEsJ8LR92gfPBoeW5TU6
	ULHL8A1EzOxhEq1Eunuuy6fGN8H7uRoEHad/gw=
X-Received: by 2002:a05:6214:29e1:b0:89c:8671:10a with SMTP id 6a1803df08f44-8a6ff6b30a7mr256054886d6.0.1775549810506;
        Tue, 07 Apr 2026 01:16:50 -0700 (PDT)
X-Received: by 2002:a05:6214:29e1:b0:89c:8671:10a with SMTP id
 6a1803df08f44-8a6ff6b30a7mr256054546d6.0.1775549810106; Tue, 07 Apr 2026
 01:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-camss-rdi-fix-v1-0-d3f8b12473d0@kernel.org>
In-Reply-To: <20260406-camss-rdi-fix-v1-0-d3f8b12473d0@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:16:38 +0200
X-Gm-Features: AQROBzB9jXN5WQuzdqwIuJDQQdxBWeKtibXoNReRFTql_Ig6jSb_XVxokroni2g
Message-ID: <CAFEp6-2BMaT+u0cAJnZNCaxbiNGCayYs5uMr13AEe2iWWZZxzQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] media: qcom: camss: Fix RDI streaming for various CSIDs
To: bod@kernel.org
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
        Milen Mitkov <quic_mmitkov@quicinc.com>,
        Depeng Shao <quic_depengs@quicinc.com>,
        Yongsheng Li <quic_yon@quicinc.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d4bd73 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CE45hHjwcgbT6912zacA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: DykwzgMTJlcAuQBds0WqyYn4EEMdS9UW
X-Proofpoint-ORIG-GUID: DykwzgMTJlcAuQBds0WqyYn4EEMdS9UW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA3NCBTYWx0ZWRfXy53FD1gtIhup
 r3oN5vYGnkCcs/DN7cLbZYmE9Jlfzgmbmqx1p/pB7cPj/puwhT3HcSR31NuhZXdEhv5RB+xVHkp
 aMCPbbEfqm2cHRXr90wQndr3vZIbLrCxHnrJt5r7UYUPEliwCMD1eL89bDKoLXTFxAI5Jt4tAp2
 YtFM2IHO2JWa3X2QFBJ5qnBapb9oXSWLYECGfHqLyAt2vG4D9LKzJpHo45t9gsJZ6OBmEbzE1dg
 0foZs0/fv5yrh9VFHa+6hn/MaaIDjNLQnzRdZwkjNbGzUOjkofCFRo4dAbyvIEQJSlbQKvG9p5j
 EDX5ZiSUclwm2miuBCjFsGGwrWATb8MISTUVKtrlfjzC7rPi9rrQS3WFwKFc3bVnUgeJhxGFY5C
 YIyXS+ZQbR4I3L4OEB1UObOcVPBokFEUZNTtWITvJTT+0DVt6JfE05MoyGur2X98jxp7sPungrm
 u5LyXmbMcGYmGOLR7Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070074
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233515-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,quicinc.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,mail.gmail.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B5AA3AB315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bryan,

On Mon, Apr 6, 2026 at 11:55=E2=80=AFPM <bod@kernel.org> wrote:
>
> A serious bug has been copy/pasted from CSID 170 into various different
> implementations of the CSID.
>
> In simple terms we have a broken model of enabling virtual channels which
> needs to be rewritten.
>
> Taking the CSID 680 as an example. The CSID can output ports RDI0, RDI1,
> RDI2 and PIX.
>
> Each CSIPHY can connect to any of the CSIDs. Each CSID has four output
> ports RDI0, RDI1, RDI2 and PIX. To get Bayer statistics going we need the
> CSID to write on the PIX port.
>
> Each of the RDI/PIX ports can process any valid virtual channel.
>
> When adding virtual channels a spurious association was made between
> virtual channel and the above mentioned ports. In simple terms
>
> vfeN_rdi0 will always be fixed to VCO
> vfeN_rdi1 will always be fixed to VC1
> vfeN_rdi2 will always be fixed to VC2
> vfeN_pix will always be fixed to VC3
>
> What this means in practice is that it is impossible to route a sensor
> driving VC:0 to the PIX/Bayer path in upstream.
>
> Given we have now gotten a mutli-stream support in the kernel upstream we
> should move to that API in CAMSS.
>
> First up though is to remove the breakage of invalid VC constrains and ma=
ke
> those available to stable.

I agree with the observation and conclusion that proper PORT and VC
support is needed. However, as things stand today, this mechanism is
also a convenient API for leveraging different virtual channels.
Concretely, if you want to receive data from both VC0 and VC1, you can
simply use RDI0 and RDI1. Changing this behavior would effectively
break that usage model, leaving us only able to retrieve VC0 data,
which feels like a regression to me. The more compelling use case, in
my view, is the ability to stream different VCs in parallel, rather
than streaming VC0 multiple times?

This then brings us to the Pix interface, where streaming something
like VC3 does not really make sense. In the current csid-340 series
[1], I therefore took a simpler approach/workaround of forcing the
main channel (VC0) for the Pix interface.

[1] https://lore.kernel.org/linux-media/20260313131750.187518-4-loic.poulai=
n@oss.qualcomm.com

Regards,
Loic

