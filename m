Return-Path: <stable+bounces-211244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD6EFKBLcmnuiQAAu9opvQ
	(envelope-from <stable+bounces-211244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:09:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F169A2F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDDAD7C9DB5
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56513559D4;
	Thu, 22 Jan 2026 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ut1IfzMd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WOEx22MZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44E326958
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093354; cv=pass; b=eQO3DapS/m8EP27Ox+mV5HMZTnzTstoJZPZkaTUrGsHR72I4wXIOsU8K3dP9qgcfkJwwz31NA2qLBpfIK+oqYRf+4UihnO27hDkiOeFtkudCm01sfnZ9+ybw+gxNmp1c/AsafqOu91Oq/IRMV98hwzlyUsEpIjyLJR9ZjKTaQ3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093354; c=relaxed/simple;
	bh=Lar4HOB7e8VArpjbUfazpMYvEBId/fZGFosr8nw1T2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCIP1/Ql395ox+nSj45s7zCRY7w9Ct0gUyoE/x/zrmDVXboT2Yu6+vEsxjezKIb/ALQWE5XWnjKe/AxD1+ibbyH0zkpZrMFJx6Bke5cIiN3xBNUYlSU0SJ3SpfUt0TZeEMRKoHfG+Ec81y4TDEW/jNzE1Eb58yK48ceSl7ZO2sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ut1IfzMd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WOEx22MZ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M84lDY646018
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 14:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=4ByJBYSv8dzNIIUkvQF5Zr5fcQD23vQS1U1kIJNce+Y=; b=Ut
	1IfzMdvR8WqnLjFGEe91Ra1O6lHEaaAyFCgtuHq5UTCqcigk/TqXGdR47MZQt+Vc
	IhZl7T0Jgledm1PLOM4Nt0gw4NveJh5QCnuGd3IPv3x/EWBBN7NHXe2qy8XdyJOG
	1RLd9fjE5hOjGpfJif27MdaywDAZCXgYAT/KCH2kHWd4taEfCvNwZevtPHGWznHz
	LjPF6iiDGyQeb0ZEVyOvUpIxs34Mpge5JUS6x4TknR3Qs15k8pBAZgDIqYKxPvuE
	t4W/f14VmHYx5NR7+X3YPPdLoEJ03nCqfo7rviS1+jLLC9AqtBvUWenVhFOuTNjN
	22lgkZwgVIPKOoBXY0yg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu8j9tg4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 14:49:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b72dc38111so295379eec.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 06:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769093351; cv=none;
        d=google.com; s=arc-20240605;
        b=XRjUGdn1fX2sIag4nSq3hx6+F3XXZ6tPr2auoSEzSfHKR9W96OQQL97MHfjT73QN6g
         L068muBieh7ZwQo0Im/eRUelHPLkZsh895odW5KLdgBc0kvlpp12MDu9p+pUPehwvNVZ
         h6iqh/6CmTR9IPCiDybTRE0FSOqx8vtbjctbILtivWxE9GdfAtzwv0cc9NI4xaS7mtR4
         ubD9bDIdoIj55wO638jt5fRT4k5hvsujDT6qXufIGpYMpzel6EESr4eyxZiqfbEIh0M4
         X/CjKCPc/1Bi1Y8i5OrWkOeAGkuvbPtEkAbB/TwTQRENGkYrEohIdkMZhPxfOPYGfxwu
         BDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=4ByJBYSv8dzNIIUkvQF5Zr5fcQD23vQS1U1kIJNce+Y=;
        fh=puKpNqGIqIT3h3naFjX/ov2AOGuB4hmbKuUt/rkgYcM=;
        b=FpbA6M7llXM24RfJxSe8+oRcY2ayKSlIYSa3nGYjShKKiBeC99APo9zJLVLQGXxsE0
         wknd1Tl4JpkTKJ/HJZBA+lfvDvMSPPW6/o+eNWRVIYX6FZ9d5DYbEhfZmRYUDtBKCFJe
         XTDjcWchmH4Qk90PoabMdb544kufVxfZppSQQrF0BlRH18hBWmlZ7nFLGN+nGhhnYe2d
         VAEPJGZdkEvY3ysdCKkyzucv3+Xfj7x5LbC6guU74gP7gMbIA7HD6fGh8TsYCCjCG7Zn
         S+t6zOhwNtC86muYtTKVwTbn91AmwAyqTAIc9e9UWNXgGOxarq4TuqykZKSmgQGYEJmy
         srTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769093351; x=1769698151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ByJBYSv8dzNIIUkvQF5Zr5fcQD23vQS1U1kIJNce+Y=;
        b=WOEx22MZqm7lEqzY3HHDttKzky0ytwU9UJgzLeduXLROeaE3MyJJefQUQdaYODI9b5
         5msROJ2Hh2/GQUI/PuSf1WDgZkpwyBhV3PExlket1BdctWO0mYuNxDOl09kFYeQGGMQh
         x5KMKTpAiOWcHMXB6pUee5E8kThY/vxXpUgTobamiQ9yDGSP5q5JHDPJZGsXWgBZjDTY
         oCT1T14PLuXRdKyz5SgZSWqGkuqgcnM8azTVCG9DZKvOU4hocby/F2pW53p12WiYwX2w
         pkcm6bSBQdlgZOVbKoIfoKyc4K9wlzQOhTTRMJDw0OL9qT5cWl8YB++Uvc1yHyY6th3U
         WK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093351; x=1769698151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ByJBYSv8dzNIIUkvQF5Zr5fcQD23vQS1U1kIJNce+Y=;
        b=PM0ZQiJB95+nD/elhXQSQzcayvw4ri8e5VNptsDq51JMitvryuWgGYU3nUgAVnMSEY
         NyYQaqTXREpPRxodn2vJuiAw399Y/mdRq074dOOgecQkUhyIiZgg/ivQhSWY2Ur7ZBLA
         tgnFpAO0xBMS+O3H6WEaRjIE2RXiTdsY+231vciKBWR3AV2mP9vnu1dAtNIh+j+cLNN5
         5P62fO5lLAvBu3rLSpEF9Ha6DTXUpxwkbYseW0xcCATlHnQ/qyeqiF8zJ3G13bXd0GFl
         W/SnrOWBYUzwjs7mEAsQZ3yoV0BwncU7HLsIlH18JFRd/XNEsUsCc/mttyuFUh8bfWoB
         T8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFH7YCYCJAmqN5vBRGoxRU9gBCKftcxMZS89FoM5v78JxKrhKtBqSXg3eYmvMn1kO0o+J7w0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjNiIFnftoieJsiTLO1ZI6E0iD8pLL3USg08ZXiCFD3T+g93J
	r44S1yHG3W9QBFKNRBh/tIXBddJ2rS+JAqkNKffhfWDrwkbegGn25QWUeI56IU4gORB2osBcpnz
	D5qjonKlenQRKvIF0Bjz2F1+IXdq0borCYKBfUwSc8nkYVBoq+N+dqANM8VVbRLwnzgxjthfmBF
	dDpxQeeBd5aOnYah19L48HKT0fQQXdjUikWA==
X-Gm-Gg: AZuq6aJp9Pz9MjQtn5qO8HCuHm98eVoBvssMMG/wqr6J2Fe+0M2g6VPslhkGmE3kbRE
	ZiQ+OoT0iHqd83f4oPkFyyCy+Fdsta1puJ+ea6Qfx/J2UWMi9kTQp4B74fEOeAAIUr/3RJis/Qi
	GJj3rn/Abe9xvcbA7SRzxuilOMXi31ynyenqK81wyoYf5Yv6xz5PY4fQFEkX6esH8Bw6bP2UMep
	YJu1p9HOnHtUZ1nrt4XJnnGEg==
X-Received: by 2002:a05:7022:e1e:b0:121:d898:edae with SMTP id a92af1059eb24-12476b20423mr2297863c88.24.1769093350741;
        Thu, 22 Jan 2026 06:49:10 -0800 (PST)
X-Received: by 2002:a05:7022:e1e:b0:121:d898:edae with SMTP id
 a92af1059eb24-12476b20423mr2297823c88.24.1769093350042; Thu, 22 Jan 2026
 06:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221164552.19990-1-johan@kernel.org> <aWdaLF_A5fghNZhN@hovoldconsulting.com>
 <aXDt6v_iO4EFCqyw@hovoldconsulting.com> <CACSVV039g9CcAKhtMAwn=hH4hMT2nV77vxiasgUSFF-sn=+JgA@mail.gmail.com>
 <aXHwrnMS2aj_PYRj@hovoldconsulting.com>
In-Reply-To: <aXHwrnMS2aj_PYRj@hovoldconsulting.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 06:48:58 -0800
X-Gm-Features: AZwV_QjkYdq6c3XPgpYIaf_pN0lJpl-wNv-t9mB4a402BGd58WCopYg5GIRuDVY
Message-ID: <CACSVV00vk95aYZPrVThoAnHzBUsCHXxnSoEHJNaoLdyJJBOZzw@mail.gmail.com>
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
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iAQ2ak25xld3YkVEJOV1xdKr9tFSzcwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExMiBTYWx0ZWRfX9MkQd5aXhjAe
 GvJxIwBflHfmhh62CKdbJU70WOD4/mz/JDLkPJkx+bgigBaIihajnPNA0PQjCa7N8PFK2716A5K
 DejzhK3YQJlVRLX8T5y0ZyhQCNEAYXyx3Bxmr8oBBuWIzGArE7TZT+zf6ThxLaKgszjCLx8+9tr
 tZZJ0xs9iK5yM49BCRWQtT4zWU8/+TnEEtqrl7+BeNJd/Nx7LWyhHz2mpRcinrg1KOxfngeZye0
 cCHoFD8eEytNACluFY2ha7tgZ7w7XPgBo7Z19LyvEj8MKZA1ymW/HSNLSbHVNmphIYNfih9abtD
 s2ROu+zIjmAU0r9FiwAwAJQmcq9neyAg6VgVUeMU5JwH3oO0ULx/9dDuHwHPVjHYdDYyWTWjQdd
 FFu0gwLkTIUnG/TJ9SFlOhXE41PqgJ56cJZ24ss061iAPlXwW9TKjrXAiKhqtLXWu/wSHI/+nIm
 qt4vkpXCSbAkRWCN9lg==
X-Authority-Analysis: v=2.4 cv=U4CfzOru c=1 sm=1 tr=0 ts=697238e7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=V1jUQ0fd79-Hst1t40gA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: iAQ2ak25xld3YkVEJOV1xdKr9tFSzcwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211244-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FREEMAIL_CC(0.00)[poorly.run,kernel.org,oss.qualcomm.com,linux.dev,gmail.com,somainline.org,vger.kernel.org,lists.freedesktop.org,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[rob.clark@oss.qualcomm.com];
	R_SPF_SOFTFAIL(0.00)[~all];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob.clark@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D90F169A2F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 1:41=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> [ +CC: Dave and Simona ]
>
> On Wed, Jan 21, 2026 at 08:59:51AM -0800, Rob Clark wrote:
> > On Wed, Jan 21, 2026 at 7:17=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
> > >
> > > On Wed, Jan 14, 2026 at 09:56:12AM +0100, Johan Hovold wrote:
> > > > On Sun, Dec 21, 2025 at 05:45:52PM +0100, Johan Hovold wrote:
> > > > > The hw clock gating register sequence consists of register value =
pairs
> > > > > that are written to the GPU during initialisation.
> > > > >
> > > > > The a690 hwcg sequence has two GMU registers in it that used to a=
mount
> > > > > to random writes in the GPU mapping, but since commit 188db3d7fe6=
6
> > > > > ("drm/msm/a6xx: Rebase GMU register offsets") they trigger a faul=
t as
> > > > > the updated offsets now lie outside the mapping. This in turn bre=
aks
> > > > > boot of machines like the Lenovo ThinkPad X13s.
> > > > >
> > > > > Note that the updates of these GMU registers is already taken car=
e of
> > > > > properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
> > > > > properties on a6xx too"), but for some reason these two entries w=
ere
> > > > > left in the table.
> > > > >
> > > > > Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> > > > > Cc: stable@vger.kernel.org  # 6.5
> > > > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > > > Cc: Konrad Dybcio <konradybcio@kernel.org>
> > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > > ---
> > > >
> > > > This one does not seem to have been applied yet despite fixing a
> > > > critical regression in 6.19-rc1. I guess I could have highlighted t=
hat
> > > > further by also including:
> > > >
> > > > Fixes: 188db3d7fe66 ("drm/msm/a6xx: Rebase GMU register offsets")
> > > >
> > > > I realise some delays are expected around Christmas, but can you pl=
ease
> > > > try to get this fix to Linus now that everyone should be back again=
?
> > >
> > > I haven't received any reply so was going to send another reminder, b=
ut
> > > I noticed now that this patch was merged to the msm-next branch last
> > > week.
> > >
> > > Since it fixes a regression in 6.19-rc1 it needs to go to Linus this
> > > cycle and I would have assumed it should have be merged to msm-fixes.
> > >
> > > (MSM) DRM works in mysterious ways, so can someone please confirm tha=
t
> > > this regression fix is heading into mainline for 6.19-final?
> >
> > Sorry, mesa 26.0 branchpoint this week so I've not had much time for
> > kernel for last few weeks and didn't have time for a 2nd msm-fixes PR.
> > But with fixes/cc tags it should be picked into 6.19.y
>
> I'm afraid that's not good enough as this is a *regression* breaking the
> display completely on machines like the X13s.
>
> Regression fixes should go to mainline this cycle since we don't
> knowingly break users' setups (and force them to debug/bisect when they
> update to 6.19 while the fix has been available since before Christmas).
>
> Can't you just send a PR with this single fix? Otherwise, perhaps Dave
> or Simona can pick up the fix directly?

Maybe someone can cherry-pick to drm-misc-fixes?

BR,
-R

