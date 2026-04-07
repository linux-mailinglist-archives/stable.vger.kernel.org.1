Return-Path: <stable+bounces-233525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aILRDDnF1GmmxAcAu9opvQ
	(envelope-from <stable+bounces-233525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:50:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23D3AB836
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0366A3003D07
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFD39A7FD;
	Tue,  7 Apr 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MdbOLc5z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NfbKYmVv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC630CD82
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551796; cv=pass; b=Qp2eYypGWszodL8ZUBtdNoPduCpXegg6mIfskcxoo+4QJBasmgMghqosBYRxtttA5HdGXTvJraihGmOmpEFN0K3+MxIejt6IHSHB3gRFESR2u3sD/P8vExfbXkRKvtVXgrUVh2/my56LyGjWkDNB2bFFTsa2zWZkylIb9RoUJb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551796; c=relaxed/simple;
	bh=w+LHVYfCEF6dTMGNg7i1pUqmoBnUbKwZAxxQ6dUcl2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcE/JljDLxt+pxbid+7CaRxbA95smLcSSodHgkOSeW1VxMa6AkHVPAO4hPQqtRMslb45bJEjFVzjwAZyesGXqBIVd1copHrE0YPDqDZ0jOA8LvR0QVfaqxvg2puzlwDCBASSGrmDWF+rqQY95sNvGTbaUqmndhsqBNMwFPBqvfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MdbOLc5z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NfbKYmVv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376wGmA1405882
	for <stable@vger.kernel.org>; Tue, 7 Apr 2026 08:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+LHVYfCEF6dTMGNg7i1pUqmoBnUbKwZAxxQ6dUcl2Q=; b=MdbOLc5zLAj19UPp
	m5kpftOJvLh9rjER9uhttYGUSnIEhaQtobEFF0qGCxJwYm+w20HSi8QP5Yj6Ctje
	OGBTLe38qT2e/iY4By/TCazeCne19HbVCRf/Fd6kAftoXVRzTkDiUYF+t85BiQER
	N+e3F3+ixjAYyffcgHUhQK5pIQh/Hd8IARgCO8yzG7qm8L0zq5SjcNN88uRt5IGd
	Zv98/k8mLaGsb/VbFhDJcq+3JiVgNaxsnh1+3OOyrt+5Nv0cZyHyxEUO3zY82wPZ
	/A6DDKxqf0hB/4TGtOzv1GctE1Jf+8z61iECz9cFdHV0Wak+15GQDbYc56yix85H
	1N/DRA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrasvun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Apr 2026 08:49:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8a0d03df951so30988726d6.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 01:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551790; cv=none;
        d=google.com; s=arc-20240605;
        b=c3FJxvHgG1F9Tvu+5hJThi7PZOBRm3uF6R4HliXVQMkpmBKNQHVKiaBUjcBW1SBifY
         PmeauTMR9bf4IeYmcSXoUziXcHluuIjKD3irDhsTLNt20Csfvo2YsiJ6i6H2Y3vrmcfD
         y/dpcXNaDWF1XRHin7lVJBHwhOWNhAvEzgjryLvkREYmi6w8SP8AvESPvjrVnInLFSWc
         tv9gClmvUvTcLd7DTmDJy2V/3P6JloVLyoxflWSieSZhX5wO4bJCPZsZQeMEQEkaIEwS
         YAhxbg8UEDso+V7r+Dr8/cJ9JDuwu6q8YcLzXuI0Ia8Dpe8VUjWSthTvQqczkuzrN6iX
         T+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+LHVYfCEF6dTMGNg7i1pUqmoBnUbKwZAxxQ6dUcl2Q=;
        fh=1/ropA2Xq7odUZQkzRX1mnLG/Gmbl2eC59RHNlit8wk=;
        b=KtZLa6vIpUevtx3UabErg8nQkZpJisfi1s3DgD7Gugar0k91Iph8+BwHg8hTwi/Q8i
         V0d1cn8jemDyKFYBHZ1EZslgi5rcXX/2YaEvED6dBRZHqvvO4DLfLMTeGt6Gv17MIflh
         CC5qOrwfqQGZZo/JL/j09qgtU+sx/Wz1UVFYFaW1gSmTWLZY2je1vnN7YYnYoCFLr1rm
         I2R/rpPOe3iPUcegxgl8CyVsrRXPguiXShkLdDRD1cZLYI8zxPg8udQgQ+yuHIL1Kutp
         BFqU7fv4Ni1Z1/bE/DGrgugMWHrcdMP3ma1QqD4HYXyhRm9mcMkTsZPzn3h66WegUj6S
         Osjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775551790; x=1776156590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+LHVYfCEF6dTMGNg7i1pUqmoBnUbKwZAxxQ6dUcl2Q=;
        b=NfbKYmVvRJuzewRCssCYpA2v49NfT603B2hKb90+QuMTICVMEGgx1YJP2RO4I7bWnt
         76ckGDefQn4lLaR2IYSgf0o/bJZumt1tbTlNRLixM9wyRhp/0CRHWSNwmIkrrXarAfNP
         I2ckH0RfxkwEQAS0OXl/WETQNsMuuy0db+PZ/pMVv9AX1melYPmmnauud4Cx0ZJy1apY
         GeMvMFja7ekQmEeT1jezcvCPCvW4z/gJfk5yrHhUFEAbHYLUPK2UGdAsI4JIOlb+Y9ve
         8HekBZvRSYXypRNvaAs29fAT5HNt3r3DsoSbtFZkI9+rAHDSxLVrdZKjgCrV93vAe4T0
         IzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551790; x=1776156590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+LHVYfCEF6dTMGNg7i1pUqmoBnUbKwZAxxQ6dUcl2Q=;
        b=ZV5Djt3+G0QU9mp9HcGnNShCG0eR28FLP4I73A91VYbQdgflz77hw7op6dDfDHQ165
         RF7VcS3YoS/q/rpf7l32YQMf5kclnAYwTMjyUqm1/x1VzD2Q/3hfgNjO1HeGP+b2bkql
         q8G5Uhy16niOkqiYy9k7BVZI5l31v9K1erGNvsE3eRwxNQpPr/dsslcKMGwZ2rF5q6mQ
         orncRz3zCMzxRx0zaciVg4Ebkfepchjke5ccuFOGRS59j6izGVuATNZJqlSsHQBAv9py
         1MD2pShdzJRo5H1uvUvNH5sSjjtBxZ4gyJv2wLcDR8jVY4+cgAM0/mgTqDE5bOH277SE
         pP5A==
X-Forwarded-Encrypted: i=1; AJvYcCW8D6frz7Xg4G09gdhv3m42Y40j7oJgJT9rwiPwcnfD0HwsZoAhYU+h+veyIqJj6x2fkE0GJ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0sCQsufzhNwrW9Sfpsqz3HRyhTTIgNUlWfkWLXDdGMw45f6k
	mTanC2pWWTDvwBuzXDdzzHOU66M1ES8CGBtergwG+cV/FkkZP9ft74LZdLTsxlEUEeimD33u3ya
	mXb+Q01Kv1qARPQpM3EIoDnOoBoEZpo781F94rOB4fLVbGaZb7LZB1EQY8XQzPMp27+VcZKLyH8
	rK2pfTC2nMc6+IxxbEUYtRGlF8DNcfoY7Grw==
X-Gm-Gg: AeBDievecBv0R4rXsOtD/v/4Y+zO7oSfxk0d5b8X5RRHJkOpUVEkkq6cqbHOwWtTTal
	kxpUh7ZawNHFoEg5Can3FnfR+MX3+iJ8iLXk3GipT/vO/PwGL3OSSN4uuf881b5Pw+drSLo8nxK
	l2Iw8fKRPQJ2LQTXZ4HO9HTHy3AXJZteKkfhI4JPdABbbTOkRFlh0RPSTDuB6ymRkM9swWK0p7M
	2gzFYKU8YrTsRg2yFYyytA1UPr7BXknQI39/l0=
X-Received: by 2002:a05:6214:449e:b0:8a0:f8b7:3920 with SMTP id 6a1803df08f44-8a7042f9535mr250042756d6.42.1775551790319;
        Tue, 07 Apr 2026 01:49:50 -0700 (PDT)
X-Received: by 2002:a05:6214:449e:b0:8a0:f8b7:3920 with SMTP id
 6a1803df08f44-8a7042f9535mr250042566d6.42.1775551789922; Tue, 07 Apr 2026
 01:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-camss-rdi-fix-v1-0-d3f8b12473d0@kernel.org>
 <CAFEp6-2BMaT+u0cAJnZNCaxbiNGCayYs5uMr13AEe2iWWZZxzQ@mail.gmail.com> <5812c794-fd2c-4b49-8146-db6a1c783706@linaro.org>
In-Reply-To: <5812c794-fd2c-4b49-8146-db6a1c783706@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:49:38 +0200
X-Gm-Features: AQROBzCpWYOJa5sXQkGSrLbu31jfSpOfrZncCXLAJtn4ZOEzUaxAxKjCkAz4-nI
Message-ID: <CAFEp6-1HVph_+278jXCb-G-XDc=Bg1X0y9hSq79qr6WG+nJ3bQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] media: qcom: camss: Fix RDI streaming for various CSIDs
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: bod@kernel.org, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
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
X-Proofpoint-ORIG-GUID: MMxxgbrKBio4zlPfrECbEi1QMtKx7EzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4MCBTYWx0ZWRfX+1EwLauh/FU8
 wA+ymVGtBIfvwAIqbUF88QaIB1Ss6O0AYjG1OS8QPPiYTvXDN6bqsXNacIH5E5PzS5/ZZBlJmeW
 tBzDc6zjhi+ISeWZCYtLK4C11M/shMoUZ5w3EaRlv6Fo0Fng3SHV5RKXId+5JbUZin7/Cnu7SAa
 76dGeFB95fUvIXbMvnJRyNpgNG8QfHihClCedM9RVH+DBRr6dPKlul85eLr0ACX2klaNMdlCemq
 TD/A1LAGhSQblsO5Wu3NubgTKyWRby3A2grYgfgDk7Yo07BDF5Tt7wZqMPOUTCmUmeQBvkEp2wH
 dynTfCPBmm2Rx2fzor/7PYbaasGWCIUxXvKvCjOCygGlZUVa7l4F9HWsNisv6PaD58EaMjadSTU
 3lobIjVsBr2YpgAjdLgXIELbEE3gNO8ISaMZOXJYQ8jLgVKBA6HUehxYV00nS5t230CqfzGNE7f
 Hw05oyto2NkJaEzablA==
X-Proofpoint-GUID: MMxxgbrKBio4zlPfrECbEi1QMtKx7EzL
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d4c52f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pT3TQp1K7lpw5WBvr8YA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070080
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233525-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BA23D3AB836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 10:36=E2=80=AFAM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 07/04/2026 09:16, Loic Poulain wrote:
> > I agree with the observation and conclusion that proper PORT and VC
> > support is needed. However, as things stand today, this mechanism is
> > also a convenient API for leveraging different virtual channels.
> > Concretely, if you want to receive data from both VC0 and VC1, you can
> > simply use RDI0 and RDI1. Changing this behavior would effectively
> > break that usage model, leaving us only able to retrieve VC0 data,
> > which feels like a regression to me. The more compelling use case, in
> > my view, is the ability to stream different VCs in parallel, rather
> > than streaming VC0 multiple times?
> >
> > This then brings us to the Pix interface, where streaming something
> > like VC3 does not really make sense. In the current csid-340 series
> > [1], I therefore took a simpler approach/workaround of forcing the
> > main channel (VC0) for the Pix interface.
> >
> > [1]https://lore.kernel.org/linux-media/20260313131750.187518-4-
> > loic.poulain@oss.qualcomm.com
>
> I thought about that however, there are no upstream sensors driving more
> than once VC right now.
>
> So this really is a bugfix. You can even see it in the original commit
> message for this feature, imx412 was used in the example but imx412
> doesn't support multiple VCs.

Okay, then that does reduce the usefulness somewhat... Another point I
hadn=E2=80=99t initially considered is that we may also want to support
different data types on the same VC. For example, metadata, stats, and
image data could be transmitted over the same VC/stream? That seems
like a valid use case enabled by your fix, and it might be worth
explicitly mentioning it.

>
> This is a pure bugfix and now that you draw my attention to it, I think
> you should update your series.

Yes, I'll consider this in the next version.

Regards,
Loic

