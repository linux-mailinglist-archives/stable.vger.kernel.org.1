Return-Path: <stable+bounces-210798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FVuHGQWcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:09:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D78115B0E9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F49F0293
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3C3A0E8A;
	Wed, 21 Jan 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKi/9ny7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPfvPrL5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC81B4F1F
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014809; cv=pass; b=S146gheXbJnsz5bwzern/IAbY4nEbsu0Dtaf4npAW4ol63lgFlhU9JLFaJTAmzAyrupXYv3KiTP7ULfsLT7FNMUL5GVukR7sbWc56nrGpu3Eq+3qxIJZ2cMchL5WFWTuIQV+UJ4AqDfMri3F/z9DIvxaz5CHEJWS6AwH9fLWJpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014809; c=relaxed/simple;
	bh=+joYYSvt6O0WzeTvPCyBVAm2AiyPwakHVoRSJLX3DYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX7rpSpJvshgaRlmjjwzu4VVH0rfH++cRR/gv4OmcMtQJw/Nx6LttXg+hY2rN7Q5BKAs1KrFsAURTbnmaPXwZN8MOcgt0EQSCMjZZ+ZMnIz5Qub7WOOq286fFGcMc0BuvfbOyEYtYDhpshuJ7Iit0wq4CSC79ovZAAAM5ojmBYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DKi/9ny7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPfvPrL5; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LGkgei3481446
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Of1XCp4w1IY/FWfBQqk2YMMCDqdBBDLtge107x8YzfQ=; b=DK
	i/9ny7u6sYA3xbSXbIQHGKSgaSeJxqF1CQpODMhYJLhS9hlss1d8e6vpsgPmAq6M
	OUCTtwcZSlrgqTTEfRp0ot0c9upyzZ3agHCzJ4izV9QA9HtfoYDsz1+5sq4xyXlV
	WqEeTKFxHUpGHzpwQV8CmihLIlOpO33U3duwJaT8uxNEH2ZY1TVo36Yp2vjOIYdW
	w8LC86fSNSGWc4GbC4oi7L55J+zLtLU3YANJ+FrrGyxmHW3uXwdA4Pt572UMyrOM
	jsedXPJ4CfvusCELtzQjx2ymDTDv+Xk75Y99HC+/uqFrouioImZBg5vX1LStwHHk
	zw+arwhsAZsvMDM2YZBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btvef1fpj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:00:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b71041d135so723955eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 09:00:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014805; cv=none;
        d=google.com; s=arc-20240605;
        b=jxziOYB24OfIQzaynGO1IEgEarY0343WoCsa7jtegzf3p0BJuT/WCHP4ujBklK9+R6
         Td0TpXPW6Uo2ZQ9Fbx7Nv71MuuPgueMT/diGFU/WDuzJB4yPDrLje5C/WgFlFlwX/W4/
         7rnGCXAb2R+9nQzGgyJIVlUxmb1gP5rm7VIGwd30jAHcJz2oe8zE2frIo8R2D/mmDJCV
         VomTJms8UdPxyDn5tJ6AjobhPnI2hyS7EHUqE5u55QeQfcw5DHW8QkGONirAPFH+l+vv
         Sgc0q++TGEBmZ6J+5JDA7M+/fvBVNQ4gmvBk2Hhw/Uv1Opfej6JL7KFf0YhqHMb82Tui
         lLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=Of1XCp4w1IY/FWfBQqk2YMMCDqdBBDLtge107x8YzfQ=;
        fh=l/dAy2kDqEPXeJ5DmpPaaWFUeI+FSfElud0gyxBSrjs=;
        b=CqqYeI0A+DIpQu0sNCsUu8qmslwqb7LK15g6vsNP/fEzNoK9K5skW/lyi2fDyDRWfr
         RgM+qSZJ4T+MhwRjJMdyu+QBfCM0awxyYb1LzrdhmL3ux9h2U1hKoQqji/7RvLQoTf3s
         IyFyVzraBZzp2oNcrTKg5P2OMTGJaY5bDRUvf1EgA2sAPB65Mp75IYNuy5Hwr0UH6IB7
         BroL9omNuJIpT/RA38fgWWhJ5jpK0HEtQ9LsAy0D5eY51eRGslyK+71AD8o9jwZUxqTT
         6GCCy/l8knTc79wf/91W3DNMcq680biI0hNswPlpyoddkE5HdVtzg898z5r2yejPshCw
         r/Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769014805; x=1769619605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Of1XCp4w1IY/FWfBQqk2YMMCDqdBBDLtge107x8YzfQ=;
        b=RPfvPrL5Vub9XNUi1CkfP19PQvufpqWWhDd0rhngeFc7vpH0zZvcWhFbyV5fYwJLF/
         53MLiRMUvBGdqlb+LnEUflcyjZsYeea8UdWF6oI11sW1fNsc8D37MLBoYrvjeTaLcYvO
         Snu8zfqWrqIFXugi6DXka87SjYRPscFwphSAFq72yK/EzipV9oPVIaTwaMZJXVxbrT5i
         6DIIXASnbjV4EMMa5cmIOnQHG6KXaRO501kdNgF4eswc+eBA96oFpEfunC+KJ950jxKm
         mquYZHPY7LyPRnGlP4EOZ9Qp/hI/WXFeumB+yjP6wkWZENtUUkGBsIn++Glkr81cwxU6
         mNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014805; x=1769619605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Of1XCp4w1IY/FWfBQqk2YMMCDqdBBDLtge107x8YzfQ=;
        b=MT195pBqNHJkRCJuMHFDQgdX3/ZqFbUr0jvGdJFV2ysU1HgCAgmUclsMkRSAw4gMRJ
         DmAKClgKUxSn7c7xyngx5/cjxjzdIItu2eJImNjqnnbQTgTazP6QcPSDGWnK3jNfm2/p
         8SrDej/EqTXsSpjjBBhN1TjBe1INOJaRxGlwr6gYMYqEcFVgT/sQV4K1p87cCezQ9nen
         3ctBmA3rU6zdzxINUFe0oipHQftOGib+zbeIJe3jH1r/xagWjdcH8pokq0EEE997PysQ
         UqDLZFURTxcwR8j2195+V2LblQAv2X4OvBBbLjDtupF8NzfwSDUebVAiCxw3FZmmdx4l
         pyeA==
X-Forwarded-Encrypted: i=1; AJvYcCUxz0JeNsSQqZbKxVfyxXvi3v5Pc5S6ZYWfBXJKkJ/aWu4rgGx6l//m0Vbt7ujdrX6wxym+828=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTBr3x59NmZqWYF/uWGsqtMh8dtuecoZqyY8wILl6RCCoKSm/
	XeX1H0ifVKg9w8T70ZK+lICh5z/hhe1PnRbntVSa207wCAo0qMvjU8RILpF2guWa1I84YKbj0+x
	wsYlXRSEhKznsWgTaIiYhQyS10A6MpUBpvj/E1KeIZizNg3GbsMquJskY6GeNHOmiIiZMvqfPeK
	eGY3XajAt66SEDkL2MGsjGQtCnI/Y6THPXHw==
X-Gm-Gg: AZuq6aKHWu6mZL0y4hAw7VCHFE9a9fPqSWzXeqA8Qtmv43LneboFtiAUMWUAo6AVnXR
	MRoV4GJoDwDjj3CVhn1f1hJwoOIz7wz5b5r/b8phYeKRScXKR7kZtaaUOs/uVbgVETkPchfOfdy
	JWtkKnWmcfTKGkHNHjWrcilqNDI45wH7KkYBbOcnnw92VaTxgDyS1jjDSSbkY7ORzcAw/TSPNXZ
	DkUHG8Dpm8prkeKsrnypxdWOg==
X-Received: by 2002:a05:7022:a8d:b0:123:3c24:b15 with SMTP id a92af1059eb24-12476b1215amr24657c88.19.1769014804752;
        Wed, 21 Jan 2026 09:00:04 -0800 (PST)
X-Received: by 2002:a05:7022:a8d:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-12476b1215amr24635c88.19.1769014804017; Wed, 21 Jan 2026
 09:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221164552.19990-1-johan@kernel.org> <aWdaLF_A5fghNZhN@hovoldconsulting.com>
 <aXDt6v_iO4EFCqyw@hovoldconsulting.com>
In-Reply-To: <aXDt6v_iO4EFCqyw@hovoldconsulting.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 08:59:51 -0800
X-Gm-Features: AZwV_QiWj0yuZPjfl5AAb2tqkVbhX91Ozb0ASrKflC4IjkW86-eixAz2tomYpLw
Message-ID: <CACSVV039g9CcAKhtMAwn=hH4hMT2nV77vxiasgUSFF-sn=+JgA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: fix bogus hwcg register updates
To: Johan Hovold <johan@kernel.org>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FbYBLFIOx5EBT_-JgMjTF22sF-Kv6JCP
X-Proofpoint-ORIG-GUID: FbYBLFIOx5EBT_-JgMjTF22sF-Kv6JCP
X-Authority-Analysis: v=2.4 cv=CYgFJbrl c=1 sm=1 tr=0 ts=69710615 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=RcnqT8zevFU4LWI_uFIA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE0MyBTYWx0ZWRfX8HERm6FmICLV
 CE8OGWmFXPycHG6UtyCAKR6RMZjuA4LfUEB9JkkvCdf8sQCEpb0z+ZVDW1FSEr7uW3+IjMHqh1F
 xh5qZUJrEjO8IXxoYia7T4ZBb4fBIZMF6ZxI9V9mAQsUHsPV3vM6Moh2IvaFG0VX6glP2ZvHFHP
 Obj+tir3xnkBGTwZk8jj3R4f7OHyYhO0RvG+BOTWtxW+9odsAaZ8uR9NJYMhJ58kMbikwqfJDqu
 9lEzoDm6oLnU00WriKAQwAN7ATjAMrMOLW1eC1ccqFb3DniRbw2v9uogdjTKLUk754PWXSp5Cqn
 jx3smmh9ABwjwrT1WHbEpSoTMDw9sq2AeZ3wNstFaNAByWbzHT4IQoE5aV26yjBEPlWgjn7dN7f
 2Vt37hsgkrFoQn6CU91yKWuWssn01Qc65q9msmSYa2sursveRWyvV4bcvA4C5xJkL+F8q1BI2W8
 tQwJ10Vw4A7y4slFrzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210143
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210798-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FREEMAIL_CC(0.00)[poorly.run,kernel.org,oss.qualcomm.com,linux.dev,gmail.com,somainline.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[rob.clark@oss.qualcomm.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob.clark@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oss.qualcomm.com:replyto,oss.qualcomm.com:dkim,mail.gmail.com:mid,qualcomm.com:dkim]
X-Rspamd-Queue-Id: D78115B0E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 7:17=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Jan 14, 2026 at 09:56:12AM +0100, Johan Hovold wrote:
> > On Sun, Dec 21, 2025 at 05:45:52PM +0100, Johan Hovold wrote:
> > > The hw clock gating register sequence consists of register value pair=
s
> > > that are written to the GPU during initialisation.
> > >
> > > The a690 hwcg sequence has two GMU registers in it that used to amoun=
t
> > > to random writes in the GPU mapping, but since commit 188db3d7fe66
> > > ("drm/msm/a6xx: Rebase GMU register offsets") they trigger a fault as
> > > the updated offsets now lie outside the mapping. This in turn breaks
> > > boot of machines like the Lenovo ThinkPad X13s.
> > >
> > > Note that the updates of these GMU registers is already taken care of
> > > properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
> > > properties on a6xx too"), but for some reason these two entries were
> > > left in the table.
> > >
> > > Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> > > Cc: stable@vger.kernel.org  # 6.5
> > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > Cc: Konrad Dybcio <konradybcio@kernel.org>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> >
> > This one does not seem to have been applied yet despite fixing a
> > critical regression in 6.19-rc1. I guess I could have highlighted that
> > further by also including:
> >
> > Fixes: 188db3d7fe66 ("drm/msm/a6xx: Rebase GMU register offsets")
> >
> > I realise some delays are expected around Christmas, but can you please
> > try to get this fix to Linus now that everyone should be back again?
>
> I haven't received any reply so was going to send another reminder, but
> I noticed now that this patch was merged to the msm-next branch last
> week.
>
> Since it fixes a regression in 6.19-rc1 it needs to go to Linus this
> cycle and I would have assumed it should have be merged to msm-fixes.
>
> (MSM) DRM works in mysterious ways, so can someone please confirm that
> this regression fix is heading into mainline for 6.19-final?

Sorry, mesa 26.0 branchpoint this week so I've not had much time for
kernel for last few weeks and didn't have time for a 2nd msm-fixes PR.
But with fixes/cc tags it should be picked into 6.19.y

BR,
-R

