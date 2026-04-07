Return-Path: <stable+bounces-233597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJa3AvsI1WnMzgcAu9opvQ
	(envelope-from <stable+bounces-233597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:39:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 781183AF4A7
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34857306F3B4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD13B8BCF;
	Tue,  7 Apr 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtGfXzhP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jerb/1vx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CF3B8BD9
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568504; cv=pass; b=srW1OLisG4n14UkoxEK3JWzAtd8mdhV2qWXVXkES2zW/u8Ta7cyZ099edUYZFC4jCGMNShLFA7XUXXjfC0ZZ9MyxVERXyCOVVvpdnFY9diAtLwMKsmU3vPUg3Fh1scUxyYt8F8JMPAyatZQfzrNw6LMIFFZK2rSGSvL1nya4x4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568504; c=relaxed/simple;
	bh=3pOru3AI31M/7h4/J1wCs9vsJpaSVKgPBYqi+q3nlak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSqjNTk0XwM+eC54TWPf18HfENr5SUJWnFRxTsniEKsuLEfaYgw737QmonKgQ6iISoxZ+qZ3uUtpYWOLuelSiw/gIOtGOohpIPj/YKdpX1GtcP3U/+6T991N+Ynjv0L2O1xGDzI0WghqgqImDldqgKev2J2RV3jbpY5gp1KqHOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtGfXzhP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jerb/1vx; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376j7Rc2009223
	for <stable@vger.kernel.org>; Tue, 7 Apr 2026 13:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3u3llKzVLDQQ1FlFCEY194yhid55v7vOzxTYrGz6xOU=; b=BtGfXzhPfChAEVCy
	xpiyQDSs/fGZP8cjWz89crppBhT+9xZ5t/LTYmC4ddtYs8xEoJGeh8/UKJmzuJ2j
	jX73Vt8nJ5JEdtWPL0QPiG7ueMw3k7jQetD5WGU1ggIylvdhwxG7f1K+NtY7RtGP
	3itgxU9fZtBkPGBxlZ922aazNS34tjBa8vdvGu+8t07tlTlwxzGioNubVYpYpQP9
	WYZFmordBwNB99tV5yjOa+2IotiWLqi4J1g60UC1YpnC02+QAmUbNhdZtznk4yF8
	omBceh2k+cv673/oRvFZ3BcI8A1uJqx/Cz0SIBFu129cDFTFybBwociSLuLVxd9R
	WDKa2Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrtw15-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Apr 2026 13:28:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89cd4f56e89so98103176d6.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 06:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775568502; cv=none;
        d=google.com; s=arc-20240605;
        b=E1RxBiHmmvZC6JSW4jnzxGZidiW03cU5Hc1dOj54lTNc8wMxqNVmsC8AO5otdaluW/
         qcjk8Y2Tjr+4ZfKxnWfmt9GNpGWDjOALmttrPhGUTl4aHTwvzAAde0GoW4RAu0MuVBAE
         ERJMjkgEIsspTVTEE2k6pK1ioBNZcwC3yP+9+FNwLO/d72fqA5ORVbDKuoQUo/wY3hUa
         UGiMmfgAfkZedD1gwwiQWrPrQGdEb8AqYiNGFnNlSWAbzVGQAbFEEn+JzKxjTwlUfdCl
         qVCw9YPZzZ/tATdxX86tZyOqmaARUIMGmXo7d85Ca6MkrbiVhovKeNA7FuLKW352Wxy7
         70Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3u3llKzVLDQQ1FlFCEY194yhid55v7vOzxTYrGz6xOU=;
        fh=t6haZ/sd+BsyiVhwrvZROpAfp1g0jMW7b/QrHWLdO8A=;
        b=Uq3mWcMe8OX+0qrpJWkkCUuEPH3Ge4SrFvrsedbYE/dppYw1uNhCcWf+tGXSL8voAO
         ZZFixnOMfhqXlmP8vtLJPVE9b6JMA/kEgoERSepPf7Otw1UqJF5ppRb5f7bcluOOVw+F
         ljBCKLNKTHZT96hSp5FixBFOkwMqQQqYyw3Id89TXKmCvpjVYod9drQHYGPjrge0d839
         0DI4jULiFQGZPL4XCznHRKB1xWH5f52bx6P9bobuLYIiZaoRs0ce7Mjx+JnFaissGwuS
         qau3ghUzHUmJEm0UX6jxaEn50fAF/XURV0UOvfnpbVQBevfWytuIhgXoqphCRS1+BogH
         Tb/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775568502; x=1776173302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u3llKzVLDQQ1FlFCEY194yhid55v7vOzxTYrGz6xOU=;
        b=Jerb/1vxVj9QG4HFakiUyKSqV3ryifUYxTvmog5+bJV+Xq1YBJqZ+bqRr3ZH1xuLhU
         5bDPkJm3d+yK/bzzEbqNvXigo9ZRuhCiKp4OtZ7Qme97CnkGC2deS73o/yeRxf4aIK1f
         zLO+dyC7jMmtOV6FTkvLryq7jwIdRIqnj8MRLWh1LJxay3e28MgP2Var/ouwEFvi/lbI
         DG4pjcay02TaawsEtptsR+iIbXrIgxINjgYUHtZ8STYBsJdpDWbjXPO3iP1mOTg96Sjj
         QCBkOq0HX2PO0k5ODmoq4d2HcBIPH4hSyNaZqbdB9Fmvr+GctqDh2g/foBtsGb7A/bEP
         J2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568502; x=1776173302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3u3llKzVLDQQ1FlFCEY194yhid55v7vOzxTYrGz6xOU=;
        b=sSwEs4EtLVxvDqZqGu1fVdarPOnXPvC9jy0WczNx+LNNT67F1/+ZOFhGRZxrj2loue
         szBpnGsPnBqmKPSlwaKUO9fsU6A7wvwGdECdI5yHA9+lhaBT2SS6IB8CjshzPoDCMF6x
         VQUk/wqBnzeW/n7mWLesYPzFT3y+lZemk08AOySdS2pnmDgfxiWaHSjSlKCQ2qi2lJc/
         GaSlz39VfTzPlmhqulfCUjAziY1NIdTBnVpVOuZwEevD5LAxdP5o1t+tFBy/1pz5Tasq
         l6oI/teEtnAM33NmoQbGUNQLTYjygYuGtqzvbY0dnDZ8xvlo9pwFoLQImwAmBbqFNKuo
         Ghkw==
X-Forwarded-Encrypted: i=1; AJvYcCW0nx3Z5HiXYqBaq3uO/J+y2bdt0LpJ+KaofK2aez3BtxMHmLfD3ezdQ76eqocr/iRQaKX5OcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxhZbNokXuHcVkZLp2x3USW3cXwiuddwETDUdioTR5eVPKTDc
	k0IIfCn9OZeIVaicvvtSY88rJg+OrCKOiw+AEJLuO6K3CdAs/gLyjS5IYhmDxeBwpmqxW+VZk0m
	IXYW4PzKlVpWmVfQ9QfTxgPJq38oza7IyLM/5PRfVNxZg261zVtr+ak7XT+vcSUhJP9Sb2QH3xC
	k+fTU0Apih4NP3o00db8xKyv5fdI0+xP+L0Q==
X-Gm-Gg: AeBDieugg10/3+QLNH2WtXWl+6lr0eLCVqXWmQtIIbqx9BESXbbV5iOHy/A+TDV2cZ6
	8HtXtSewrMjiuPG5SNuKP2zdR6gspbC1BECMx/PMX7CX+VMZldrVbZ5jkwObBKJ+3rs8KbS3nm1
	riWSuXnKJ9T+RaDBJRX0WkXjk8xfywfQnbALW/yaFCrHQ3WK87I/LjrRsw3w54/63uW2OOPCEHO
	A1E/t7fwWRQhWVIwqMvWAVBaZDZGVJoHuwlMug=
X-Received: by 2002:a05:6214:260a:b0:89c:e5f0:8f33 with SMTP id 6a1803df08f44-8a7022bbec0mr288401756d6.10.1775568501501;
        Tue, 07 Apr 2026 06:28:21 -0700 (PDT)
X-Received: by 2002:a05:6214:260a:b0:89c:e5f0:8f33 with SMTP id
 6a1803df08f44-8a7022bbec0mr288401066d6.10.1775568500950; Tue, 07 Apr 2026
 06:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-camss-rdi-fix-v3-0-08f72d1f3442@kernel.org> <20260407-camss-rdi-fix-v3-1-08f72d1f3442@kernel.org>
In-Reply-To: <20260407-camss-rdi-fix-v3-1-08f72d1f3442@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:28:08 +0200
X-Gm-Features: AQROBzAyNBpy58RNaEmWDuRNdJwyI4yb41s1_d-Hz7TIYwxCes3dmoGPrtgvyVU
Message-ID: <CAFEp6-0PrSv3YpaMUxhMCYwLenD31jWy4xZ-p4R-sHAT9cYWmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] media: qcom: camss: Fix RDI streaming for CSID 680
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNiBTYWx0ZWRfX+tFXvlO4Edu9
 UUHP7se6cCuMHAIQuRjXCMPla7Dn4t3LaBn7lH7cRf9Rk46zEL6niu97yDvJPpijcjQzjQCyxI4
 uzHVcTTygIXb9e51TTkof3dXR2clE7qkb8nt6wv4Kfda68NRwrJwz0DkJDOq4utJll5Y+Nbv8jM
 4pwYTCj8frqQVhNwxv6JfDNXyU1zdx9EOldD9lFTbO/NMNXVy/8u9UqKbo9hGlJ1mopv+rrFGQj
 Y+awOb390eInENRdnx8EfyCSlLiPMULhoD2NkbJJFlH54aNBgyCIdNjaxRyOxWhoDuFRzSfcuYM
 HHFxRKFdMj8sY+ERYAeh/Kf4iaaPPD8CRz8sp52LGTFIL9NZ5kkSiR2t4zp4wAIOCwilpUKG8K+
 bhhVwRiwi/XnMnVeCat+TPhvZf3RPtPVEoGX0HoDknz8vtAI/TqSHEJew8K7Ht3iQPlAOVR21xa
 HUGxh+VwAH5M6VOo9Kg==
X-Proofpoint-GUID: 2NHyn_ltCONocunscZx4kKp1GSNnytZI
X-Proofpoint-ORIG-GUID: 2NHyn_ltCONocunscZx4kKp1GSNnytZI
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d50676 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=x3_dpc_kMFUGcRNcKJYA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070126
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233597-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 781183AF4A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 12:35=E2=80=AFPM <bod@kernel.org> wrote:
>
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> Fix streaming to RDI1 and RDI2. csid->phy.en_vc contains a bitmask of
> enabled CSID ports not virtual channels.
>
> We cycle through the number of available CSID ports and test this value
> against the vc_en bitmask.
>
> We then use the passed value both as an index to the port configuration
> macros and as a virtual channel index.
>
> This is a very broken pattern. Reviewing the initial introduction of VC
> support it states that you can only map one CSID to one VFE. This is true
> however each CSID has multiple sources which can sink inside of the VFE -
> for example there is a "pixel" path for bayer stats which sources @
> CSID(x):3 and sinks on VFE(x):pix.
>
> That is CSID port # 3 should drive VFE port #3. With our current setup on=
ly
> a sensor which drives virtual channel number #3 could possibly enable tha=
t
> setup.
>
> This is deeply wrong the virtual channel has no relevance to hooking CSID
> to VFE, a fact that is proven after this patch is applied allowing
> RDI0,RDI1 and RDI2 to function with VC0 whereas before only RDI1 worked.
>
> Another way the current model breaks is the DT field. A sensor driving
> different data-types on the same VC would not be able to separate the VC:=
DT
> pair to separate RDI outputs, thus breaking another feature of VCs in the
> MIPI data-stream.
>
> Default the VC back to zero. A follow on series will implement subdev
> streams to actually enable VCs without breaking CSID source to VFE sink.
>
> Fixes: 253314b20408 ("media: qcom: camss: Add CSID 680 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  drivers/media/platform/qcom/camss/camss-csid-680.c | 30 +++++++++++-----=
------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-680.c b/drivers=
/media/platform/qcom/camss/camss-csid-680.c
> index 3ad3a174bcfb8..edf01ba79907d 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-680.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-680.c
> @@ -219,9 +219,9 @@ static void __csid_configure_top(struct csid_device *=
csid)
>             CSID_TOP_IO_PATH_CFG0(csid->id));
>  }
>
> -static void __csid_configure_rdi_stream(struct csid_device *csid, u8 ena=
ble, u8 vc)
> +static void __csid_configure_rdi_stream(struct csid_device *csid, u8 ena=
ble, u8 port, u8 vc)
>  {
> -       struct v4l2_mbus_framefmt *input_format =3D &csid->fmt[MSM_CSID_P=
AD_FIRST_SRC + vc];
> +       struct v4l2_mbus_framefmt *input_format =3D &csid->fmt[MSM_CSID_P=
AD_FIRST_SRC + port];
>         const struct csid_format_info *format =3D csid_get_fmt_entry(csid=
->res->formats->formats,
>                                                                    csid->=
res->formats->nformats,
>                                                                    input_=
format->code);
> @@ -233,28 +233,28 @@ static void __csid_configure_rdi_stream(struct csid=
_device *csid, u8 enable, u8
>                 lane_cnt =3D 4;
>
>         val =3D 0;
> -       writel(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
> +       writel(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(port));
>
>         /*
>          * DT_ID is a two bit bitfield that is concatenated with
>          * the four least significant bits of the five bit VC
>          * bitfield to generate an internal CID value.
>          *
> -        * CSID_RDI_CFG0(vc)
> +        * CSID_RDI_CFG0(port)
>          * DT_ID : 28:27
>          * VC    : 26:22
>          * DT    : 21:16
>          *
>          * CID   : VC 3:0 << 2 | DT_ID 1:0
>          */
> -       dt_id =3D vc & 0x03;
> +       dt_id =3D port & 0x03;
>
>         /* note: for non-RDI path, this should be format->decode_format *=
/
>         val |=3D DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
>         val |=3D format->data_type << RDI_CFG0_DATA_TYPE;
>         val |=3D vc << RDI_CFG0_VIRTUAL_CHANNEL;
>         val |=3D dt_id << RDI_CFG0_DT_ID;
> -       writel(val, csid->base + CSID_RDI_CFG0(vc));
> +       writel(val, csid->base + CSID_RDI_CFG0(port));
>
>         val =3D RDI_CFG1_TIMESTAMP_STB_FRAME;
>         val |=3D RDI_CFG1_BYTE_CNTR_EN;
> @@ -265,23 +265,23 @@ static void __csid_configure_rdi_stream(struct csid=
_device *csid, u8 enable, u8
>         val |=3D RDI_CFG1_CROP_V_EN;
>         val |=3D RDI_CFG1_PACKING_MIPI;
>
> -       writel(val, csid->base + CSID_RDI_CFG1(vc));
> +       writel(val, csid->base + CSID_RDI_CFG1(port));
>
>         val =3D 0;
> -       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
> +       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(port));
>
>         val =3D 1;
> -       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
> +       writel(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(port));
>
>         val =3D 0;
> -       writel(val, csid->base + CSID_RDI_CTRL(vc));
> +       writel(val, csid->base + CSID_RDI_CTRL(port));
>
> -       val =3D readl(csid->base + CSID_RDI_CFG0(vc));
> +       val =3D readl(csid->base + CSID_RDI_CFG0(port));
>         if (enable)
>                 val |=3D RDI_CFG0_ENABLE;
>         else
>                 val &=3D ~RDI_CFG0_ENABLE;
> -       writel(val, csid->base + CSID_RDI_CFG0(vc));
> +       writel(val, csid->base + CSID_RDI_CFG0(port));
>  }
>
>  static void csid_configure_stream(struct csid_device *csid, u8 enable)
> @@ -290,11 +290,11 @@ static void csid_configure_stream(struct csid_devic=
e *csid, u8 enable)
>
>         __csid_configure_top(csid);
>
> -       /* Loop through all enabled VCs and configure stream for each */
> +       /* Loop through all enabled ports and configure a stream for each=
 */
>         for (i =3D 0; i < MSM_CSID_MAX_SRC_STREAMS; i++) {
>                 if (csid->phy.en_vc & BIT(i)) {
> -                       __csid_configure_rdi_stream(csid, enable, i);
> -                       __csid_configure_rx(csid, &csid->phy, i);
> +                       __csid_configure_rdi_stream(csid, enable, i, 0);
> +                       __csid_configure_rx(csid, &csid->phy, 0);
>                         __csid_ctrl_rdi(csid, enable, i);
>                 }
>         }
>
> --
> 2.52.0
>

