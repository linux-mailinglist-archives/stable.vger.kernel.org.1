Return-Path: <stable+bounces-203143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2757CD30F7
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3031D30019CF
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42629D28A;
	Sat, 20 Dec 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OiS8oV1s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H4LuRz17"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAC2BE642
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766241335; cv=none; b=Bkf5YnYbvUXLIEkqQwZ54xFdjtPsLraGK1khq+qZ/MfEAq/QH3WXMwbUu50WE/UC9baFBo2c3VZ8bTau8uWLAFQ1N8/pXztKiz9A+BdvKzcSc6MQGFsOGjQ5oMf5m+AiJ2d5b4G09TRF3iFrEUzoi0ET+SscIvBxeQgYnPRxydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766241335; c=relaxed/simple;
	bh=qsi31Oimk4WcbxHsUTPNXCuh0WGoTJVwfw06QlujWlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYMDUzlUyack7aFj0UYjQ/giKnjTdBKCYwGG632ews2nQO89zefXHUT5qtbi1UTK7sgrstasx8CtRwmJ6ENNzwVRMrhiZd/rtuslI5KwiRwHeygT+jNSwxRXCnrsV2WTjqQijU5/YPNWAP7LC/SwD2aKPvi5Zg3f5NIteVoNuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OiS8oV1s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H4LuRz17; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKBPH8S1404485
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 14:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=nVIV8+8i9IBAcMCrmcMQlDivqxxnolWCKEHEXYMOqsE=; b=Oi
	S8oV1sQr0SCfWaRhx+ScarzHJ9CFixO6g6R2SCi+IGjAnZyWG0Xt3EpLJL9ChYLe
	MHXLN0kOY/OfWwL9CdQT3iklHSl7AdnXP0SoL0LkkI+C+5fpMmT6d5WY1Mtwz3eq
	OKUYQw46b2umCuwdz4pyKGu8uiYIe2YWUMSo0Iq0/bWb3pB+WUFEwQ4dGg62lK9h
	SAEuknNlBTDm8afn9W3eb/6XJv6ilDUF86pRXUBa1A9h1CbEXyLrvFFpSo+L9cpj
	btK3tlyI2xlpp16rKINQNKhnZDKsMcVddXgGL9C+XfX5RKcVEq8r7yGIc/zlkAQq
	uED7Q7SnezJcho3VooBg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mydrsej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 14:35:32 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7cad1393ec8so4930764a34.0
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766241332; x=1766846132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVIV8+8i9IBAcMCrmcMQlDivqxxnolWCKEHEXYMOqsE=;
        b=H4LuRz17TYZzuglaONSIf0P5CE8TLBm5qKlygGr3oNdR6Yk3HoxmMyAZFRGZz/6CBi
         g6TofC0wLzdkSiPwVInBThUYZmK+7yI90QuOScZD5t7Vu45ReBLYAXyAy6LJMRiHolAH
         oNJeRO+h43roxaOlIF9Y+xr6pa5BuFphegZ9a3yhhBOdiBnsybBjWbJpiUauiC7WzMUk
         oX/V3NpBo+UisbSRt0W0NJ1XQfhelUgK7OTTdSPo3TuYyS9oustlgwUZh1UDiSArPwSv
         Ys+GnGdGJhL+VoeV956M9ofsxoW5cnMMGlSdnpRCpd8rsUgaytP0GR1mePiujg4Ifb5H
         vm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766241332; x=1766846132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVIV8+8i9IBAcMCrmcMQlDivqxxnolWCKEHEXYMOqsE=;
        b=Q2ViHsPia+cXbO+TgI8K2GCYrKaZUGNLEOO/IFw6cI/FqwfZK+MWhxAJRb6lAr0p9V
         sI7r95wjYWI624lGBEg8vQ7CeOYsTU0W89rJ+YdwHnR1WCsJVTcFXq8JixEVzNZcOOuj
         JdDmRtOdHgHMov6mFsMlt6dCH/zCI/h14omWfM+wJlCU+PP+GLHbReIEapzFRmjuArkB
         DzzItm2k1zfRNzqSXvquLvnppYsy51o3arg3sl8hsUg4uA5zTtCpCTCkgshIJYg4alpe
         iwR/WWVuTGzFGecLi5jYrespsACQrikqqfDraE/ZnyENdpv0nUy+6gpBuNkMRbFhNZ3f
         W/cg==
X-Forwarded-Encrypted: i=1; AJvYcCWBAQ0WgQ1BDRnFHAsHYaQW2SA7tyMCEtfgvQZa6USMmbMUw0VJLKtlWmIIDxmYKT1BXTLp7Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/Cje1uGCjSat4igq/KQ4y+sFabGb43UWFGafb6wjME1QgzXE
	WFpJ3pd/FsmdarZfIRr2I3vn8MCkQ2emnQ9A/Ec0vrgSQBY24ZWF3O6+o+htQg9DqmM3D4jLzKP
	bzuF97EKztriIUaIAAS8OC++FyqzIY2kaKKw5nvmbFE+vzSFZuDgpRh7+9Kw1QLp7K+BjX0BFzX
	YV6vafaHYhuiMhxDRCpa+66qfyhx4MZWs7bQ==
X-Gm-Gg: AY/fxX4hC8efEUI42+aT6sjfBHGyG4RPa9NuOcT4RuztLTT2hoJU7XQDlydoXzke/8G
	mdd8JXf2Y9TufCKEmHimO0qbOIIA4q8cABKQ+DKN3GKwuFNCysM0/CkR4APkpgsm69ZxsM4oL/v
	U6cHIDYgI4dHOFC7BmKV6gNnJ7uWHW5RmSUCYv9kLHaUfeyc0by+F6gXm28+BlQ3aEFg==
X-Received: by 2002:a05:6820:620:b0:65c:fb86:8a8e with SMTP id 006d021491bc7-65d0e9e3b4fmr2653630eaf.36.1766241331785;
        Sat, 20 Dec 2025 06:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5f9Oswb5AGw/YcWqe6E/LjV+cryfZc4ZX8N5wV3lQhYf3LKoa7Qr6096gGo82YxZ5rP71Nglxog0ztbh0gVY=
X-Received: by 2002:a05:6820:620:b0:65c:fb86:8a8e with SMTP id
 006d021491bc7-65d0e9e3b4fmr2653623eaf.36.1766241331466; Sat, 20 Dec 2025
 06:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219232858.51902-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251219232858.51902-1-ckulkarnilinux@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 20 Dec 2025 06:35:20 -0800
X-Gm-Features: AQt7F2rNuD1rxDfBNPPvFwr8n8VKBhpunLeNDkcBRBSvd4Sz7y3v1Whs1F9jQXo
Message-ID: <CACSVV00zVbcwwZss-e52TS=aAfbWKHPGisXAVPB858CgHoNHcA@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: fix size_t signedness bug in unmap path
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, kch@nvidia.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: MQEEHQTXr1pPB69nNP7VbZiNE0ncU6JJ
X-Proofpoint-ORIG-GUID: MQEEHQTXr1pPB69nNP7VbZiNE0ncU6JJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDEyNSBTYWx0ZWRfX40U5VdNkddjH
 7fo82zMK8UiK+2Zn9IeU4sI47LA3ZSq/zvUadI3TiDRDX2pNGHtRAL1uUiqlclnwI9N3rC5OJyT
 l87iLivV8m1VbA7puoj/+H6gDqSlMgcBjAhjZwkm3h+RRUtooxF4tFQ32R6uc03pGL7oYJhQbZb
 5MCsNyt/DD98yKLEltQlEOjCB3YuKRK4Rgon3g5qU/fIyDPZLBAXuFqxEgL/laeJoBTgyly8D7x
 K7eppfwGOZuFfFQC8+UlGqArX8PF8qVX4BeZ3qLe1ttg4JUVGcT9L03rAB9nBi4OiXu8y9J2rYr
 ibGIOvmRApT5O+kHZQZx69f1Id1DoNaC6QtaaRU7y2f02IxMhWeGZwDANEDrr4zcUniL0BivwKC
 /gmZ+aB4LxdhLLHvmqigdvwLn3xXWW2au9RAyWJYRdzvfJB2+Zp7p2w+Mujkx3FKSTSF1mNOVtn
 7vyapnfQ5vXdhsnckjg==
X-Authority-Analysis: v=2.4 cv=N6wk1m9B c=1 sm=1 tr=0 ts=6946b434 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=io7PTiZowPF0Lk_ivWQA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-20_03,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512200125

On Fri, Dec 19, 2025 at 3:29=E2=80=AFPM Chaitanya Kulkarni
<ckulkarnilinux@gmail.com> wrote:
>
> __arm_lpae_unmap() returns size_t but was returning -ENOENT (negative
> error code) when encountering an unmapped PTE. Since size_t is unsigned,
> -ENOENT (typically -2) becomes a huge positive value (0xFFFFFFFFFFFFFFFE
> on 64-bit systems).
>
> This corrupted value propagates through the call chain:
>   __arm_lpae_unmap() returns -ENOENT as size_t
>   -> arm_lpae_unmap_pages() returns it
>   -> __iommu_unmap() adds it to iova address
>   -> iommu_pgsize() triggers BUG_ON due to corrupted iova
>
> This can cause IOVA address overflow in __iommu_unmap() loop and
> trigger BUG_ON in iommu_pgsize() from invalid address alignment.
>
> Fix by returning 0 instead of -ENOENT. The WARN_ON already signals
> the error condition, and returning 0 (meaning "nothing unmapped")
> is the correct semantic for size_t return type. This matches the
> behavior of other io-pgtable implementations (io-pgtable-arm-v7s,
> io-pgtable-dart) which return 0 on error conditions.
>
> Fixes: 3318f7b5cefb ("iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Reviewed-by: Rob Clark <robin.clark@oss.qualcomm.com>

> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index e6626004b323..05d63fe92e43 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -637,7 +637,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgt=
able *data,
>         pte =3D READ_ONCE(*ptep);
>         if (!pte) {
>                 WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN=
));
> -               return -ENOENT;
> +               return 0;
>         }
>
>         /* If the size matches this level, we're in the right place */
> --
> 2.40.0
>

