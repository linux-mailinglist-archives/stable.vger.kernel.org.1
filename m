Return-Path: <stable+bounces-211423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H0hKrLTc2kCywAAu9opvQ
	(envelope-from <stable+bounces-211423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 21:01:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957967A716
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 21:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86174300611F
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50682D1F6B;
	Fri, 23 Jan 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/aXxdvL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jD6rY27B"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96E2C08C8
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198512; cv=none; b=UldzJYURHnq+KVGvbaChD5Eg2osYLZAmmbWiASNSLtzSk9K64gM78we2hU0ZLXesIRUcHZXhByWBU7tHNEuW/OlDbGvmJdX1JXFF2MXrBveKi0us4ZSn1Z9CTUzbDUUW/I3Wh+jxCUASiagUO4j9D2AGd4gVyW5QWfFv0Truoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198512; c=relaxed/simple;
	bh=HQa1dso7aP6z1fQza2zERoT8P4/7FVAFQTUB4DDEfNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANXpQbAcCOYwtEqGW8sHPL47JVhxSgIw6wDAas3mjJF4CuG4uuRVrFyXNBjeGMOjkm8pIhy6jJB7vW/vtxrYeb8colBhIRvouMSgBqV1KyLJDfM0+azsZ8szYk0c4PzxsTKCbdamuRmyXAjtKl0gpGqQN9E06fDzuV7Lin6UuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/aXxdvL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jD6rY27B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF8iKO1267935
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 20:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QO9fOs8BxvQ8WpaH5XwHVqxgxLsb6bKPzQB3chuzJo8=; b=Q/aXxdvLjMTLlE9d
	kRx0SHYqzDN/ae+5dN1EyvqWKDmhRwLqFBzhQ1mpFPaL3ZmIZxk35Q+pSFJBQ/50
	Bh+Bw4XLihxybVZhIY9/CEEMjZgnWtBVRrLR3hnh7GJ/+ezTI3dbb/ds0Eeqc2/c
	gQW5k1rJ+aUX7bjRAvAZioZTVlaEZUfPLqsHJcms0WiPnFveMWo7XNCr22Mq/5Gu
	knlqRXD3ayxkgtRneu+OR9vuKOGj2ZU33Qe6EFSGoCcKf5CldpfLj3+gCSymcZUj
	Rej92BH17KxXZxiIJhLtofIzDzPeB5xN6E6mf4MzY8iMr9ZSNgniLMrkfB+pSqV2
	V/41Jw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv4v9ae5r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 20:01:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56637f625f2so1525190e0c.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769198509; x=1769803309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QO9fOs8BxvQ8WpaH5XwHVqxgxLsb6bKPzQB3chuzJo8=;
        b=jD6rY27BiR90DNSj1pLFBPqogF9XYfYGYEC+84cxpi5jKPKneB9iFl10SHoy3JUO4T
         wtSv4t5cRApGDbAlBxkZ2PM2+yfPL6mx9gBrFHAK29AwP5smrrbESPFYpkezEUtx/R0y
         PbDfSoHqVXRR0cjL9NrCkVFnoGR4GX/2SJHM4gI/cjsR6wJG9OJdcZyWEgVYQn7ObGUR
         kHNDJM+VOyEjZtbNtg1Vut5Fsb64jKeCcf8Qj7bzXqWhn5GxiSsfSSYG4F+G3uF5Qb9H
         D6kolyX2uCkwA6TkqjE4x3oTHYo2fKIvmev0WD+rk/eK+A7zlTlJ62dmmVsgZhhzhSOX
         iSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198509; x=1769803309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO9fOs8BxvQ8WpaH5XwHVqxgxLsb6bKPzQB3chuzJo8=;
        b=jUCFTXc8++ETuBxkRN1cPep7++c8CQ3IL5XzZp/YMoHarzVawPK7lxKqbfxXYF1mCT
         sBtAvRfzX3K7CcVmW67Na0DvlkfkyWAdmDPDAroXJ0PnMC3uyPX1ZFVTci8eO7V6ANfM
         +YyrzIeJ9kyF/TdusUzzB/wzqzbUZUkUZiv18wLNpkeLJ+CassiLJZhFhAhkWvNx5BO7
         vGTQq2Yf7At/ToiEuqW7rFyZyTQRmik23mTlaa0jHZcVVJac0oO1ouoHAUEffS39oTWt
         O5VIVEACKhYSXyHUQhW2AOf3UPsi7bsNz/4p8LwJ9cLMpzDJS8aar/Koy+AfgZoU3wqU
         jBsg==
X-Forwarded-Encrypted: i=1; AJvYcCU0O22D6TKxNxfQ8FEXoF1wD11U8ixvwKxK140NphvX++j27KHKDwzDF/RGpKgqvEjrPO81UeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySm5QaGf+26x+C7wLu6xGAk5/UvgT3E/cm6bPvd+FPZ8YyuSel
	FuPzt69365xiiL8p0m/sAQFIQWoJfewdAHFZUs2KYTnt0S/UaHSKJE21kiTFHxPpLOk2dr5ZdQm
	2wIurKc33E8IM1oq63lK6AwIo87HoUpfAgo8Rb8GYOzIiwJ8E5f/nRnGhW+c=
X-Gm-Gg: AZuq6aK/bwkUizdII7LihAPY1JNSDrr2DXI6G30lrJQjthWP5LEA5Wr5c0Ir9DlPGZZ
	9lPhoGo49lNyrBfQ8XrsbAx0QzktSjdBab5ZLD2zehT6egFK2peYsmBC57hwXUhtc2JwTGJ0T8H
	UzfozR3C4vr/3BWgwjMGINqAej2R4dcbvJ+iLhL7Yp77h40mGwdLaGMs9KP7pKiLNR9kTDUiy1Q
	x1pRkOT6quFoJsjU4RStRPXFC1FIdsijAZqrc6It2DdOWO93oeFl0KQJkGu8sNLCNHL2vRmTfJH
	o/zTgV3setFqbdSBlGH2JNTUSJbb5ZtoeWB1M29wfMdNUTW8a+PpVDcrTjScNmOR1Kw5tdkFWpY
	GfufwHQOhRBGho5NC7lUAS96Ols2u0tXVRhTRpnHEmKmUxV7Pv4BRRW40jNLRvRezot5H9OHXna
	yN4ZsEKhvoxceoy6VI8GaXPcY=
X-Received: by 2002:a05:6122:62b1:b0:55b:305b:4e2d with SMTP id 71dfb90a1353d-5663ebbd2b8mr1282009e0c.20.1769198507022;
        Fri, 23 Jan 2026 12:01:47 -0800 (PST)
X-Received: by 2002:a05:6122:62b1:b0:55b:305b:4e2d with SMTP id 71dfb90a1353d-5663ebbd2b8mr1281497e0c.20.1769198503280;
        Fri, 23 Jan 2026 12:01:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385d9faed52sm7868411fa.2.2026.01.23.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:01:42 -0800 (PST)
Date: Fri, 23 Jan 2026 22:01:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/msm/a6xx: fix bogus hwcg register updates
Message-ID: <gofqva7heojs5d7hi2naihqlpkfttjocdazdg4yjqrkeqew5tw@bp57c7rvycpa>
References: <20251221164552.19990-1-johan@kernel.org>
 <aWdaLF_A5fghNZhN@hovoldconsulting.com>
 <aXDt6v_iO4EFCqyw@hovoldconsulting.com>
 <CACSVV039g9CcAKhtMAwn=hH4hMT2nV77vxiasgUSFF-sn=+JgA@mail.gmail.com>
 <aXHwrnMS2aj_PYRj@hovoldconsulting.com>
 <CACSVV00vk95aYZPrVThoAnHzBUsCHXxnSoEHJNaoLdyJJBOZzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00vk95aYZPrVThoAnHzBUsCHXxnSoEHJNaoLdyJJBOZzw@mail.gmail.com>
X-Proofpoint-GUID: h4Ggf7ADWYFnqBEFFVUd9Jr7ivvNdkYh
X-Proofpoint-ORIG-GUID: h4Ggf7ADWYFnqBEFFVUd9Jr7ivvNdkYh
X-Authority-Analysis: v=2.4 cv=H7TWAuYi c=1 sm=1 tr=0 ts=6973d3ad cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ifu46aO8IFbR1bL56rwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1MyBTYWx0ZWRfX8NcNZ+dMowSV
 +iD9FR1YKWFG7RCIOqrczTcNQaH10ISlxxp/xglIIjTxJrucggYqX0DfDMXVXnIRSVI9+1VNFPz
 wNN0yvLfRw4r0uM6YQ8aIxfb1q0jONurmrJ8QvvAzJi94ZUIcIFUCzToByBPCsyiImMRVdGEEQd
 5mZnVftBJhBMQoiLW+dUfRDigHXegN7q8IYbX44bGigjxXCQbgPWD0krMJ277mWbOwe4Sy++qiJ
 RPkKa4M8DK5sB3Kvv5/wbPVxF0mdhmFK35HF4hrDfuT0UTx++e9/xCBcUKS7fMeDQ7iVPRAnQwi
 0Uw9GwX62N4aGouOIhB5aGqsCzTdLhOQ2OlgFlW5OO3r7b/IL8IiKPG6XqvSmXslMHM0kfnvj2Y
 AdMj+9yiG8t//IT+vxLL+osYHIeHn6kjWrVz5B4njf5Fc5iVcpKgfNF+23jfxVtMRBT9PqbXps/
 bFrxsI1RJCMnsbSYCIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211423-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,poorly.run,oss.qualcomm.com,linux.dev,gmail.com,somainline.org,vger.kernel.org,lists.freedesktop.org,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 957967A716
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 06:48:58AM -0800, Rob Clark wrote:
> On Thu, Jan 22, 2026 at 1:41 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > [ +CC: Dave and Simona ]
> >
> > On Wed, Jan 21, 2026 at 08:59:51AM -0800, Rob Clark wrote:
> > > On Wed, Jan 21, 2026 at 7:17 AM Johan Hovold <johan@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 14, 2026 at 09:56:12AM +0100, Johan Hovold wrote:
> > > > > On Sun, Dec 21, 2025 at 05:45:52PM +0100, Johan Hovold wrote:
> > > > > > The hw clock gating register sequence consists of register value pairs
> > > > > > that are written to the GPU during initialisation.
> > > > > >
> > > > > > The a690 hwcg sequence has two GMU registers in it that used to amount
> > > > > > to random writes in the GPU mapping, but since commit 188db3d7fe66
> > > > > > ("drm/msm/a6xx: Rebase GMU register offsets") they trigger a fault as
> > > > > > the updated offsets now lie outside the mapping. This in turn breaks
> > > > > > boot of machines like the Lenovo ThinkPad X13s.
> > > > > >
> > > > > > Note that the updates of these GMU registers is already taken care of
> > > > > > properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
> > > > > > properties on a6xx too"), but for some reason these two entries were
> > > > > > left in the table.
> > > > > >
> > > > > > Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> > > > > > Cc: stable@vger.kernel.org  # 6.5
> > > > > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > > > > Cc: Konrad Dybcio <konradybcio@kernel.org>
> > > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > > > ---
> > > > >
> > > > > This one does not seem to have been applied yet despite fixing a
> > > > > critical regression in 6.19-rc1. I guess I could have highlighted that
> > > > > further by also including:
> > > > >
> > > > > Fixes: 188db3d7fe66 ("drm/msm/a6xx: Rebase GMU register offsets")
> > > > >
> > > > > I realise some delays are expected around Christmas, but can you please
> > > > > try to get this fix to Linus now that everyone should be back again?
> > > >
> > > > I haven't received any reply so was going to send another reminder, but
> > > > I noticed now that this patch was merged to the msm-next branch last
> > > > week.
> > > >
> > > > Since it fixes a regression in 6.19-rc1 it needs to go to Linus this
> > > > cycle and I would have assumed it should have be merged to msm-fixes.
> > > >
> > > > (MSM) DRM works in mysterious ways, so can someone please confirm that
> > > > this regression fix is heading into mainline for 6.19-final?
> > >
> > > Sorry, mesa 26.0 branchpoint this week so I've not had much time for
> > > kernel for last few weeks and didn't have time for a 2nd msm-fixes PR.
> > > But with fixes/cc tags it should be picked into 6.19.y
> >
> > I'm afraid that's not good enough as this is a *regression* breaking the
> > display completely on machines like the X13s.
> >
> > Regression fixes should go to mainline this cycle since we don't
> > knowingly break users' setups (and force them to debug/bisect when they
> > update to 6.19 while the fix has been available since before Christmas).
> >
> > Can't you just send a PR with this single fix? Otherwise, perhaps Dave
> > or Simona can pick up the fix directly?
> 
> Maybe someone can cherry-pick to drm-misc-fixes?

I know that there is some process for cherry-picking into
drm-misc-fixes, but I think the end result was frowned upon. Neil?

-- 
With best wishes
Dmitry

