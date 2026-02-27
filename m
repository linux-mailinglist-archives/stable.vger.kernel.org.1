Return-Path: <stable+bounces-219905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNpfE54YoWlDqQQAu9opvQ
	(envelope-from <stable+bounces-219905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:07:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEE1B2804
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB72311C324
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F83446B1;
	Fri, 27 Feb 2026 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WU1fUeuE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TWddbqBf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A93446AA
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165207; cv=none; b=jQGMfSBZB/iQEh0rkbW3jwgN7QAd9TfCjfan0/yWDjUjVjYYFhVcYefgTxjKm5057apJTzoc4NS688FXOpwmvOgoJRTg8SioqSDp5kl3LsCcrGQFEtg7cUjboQfZHHuwqJ3LoYLiXkQdrIfK6VhNpCoW5yGHU/4YeCy+1GIG30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165207; c=relaxed/simple;
	bh=7dR00TzkZQLFxImS9g2i2+Oam7+hqlJzCG/IgXEyfOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJpBJ5hL4+d2HCBiuQ7g59xmS3CAGf7LTEMu2ZiuDRBjRM9rZ3HX01oO7I3RD4s9AlcX7qDjeWQUQNH9YXeiIstG0jRESmR6t85MqeAA73J28B0Sx97doso3mbPbaAtbNccvzrxkeY1E0jyyJsY87/DFQwda5VSBSxQFSQNuHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WU1fUeuE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TWddbqBf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K2wT1600819
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 04:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VdQjHF+RYM7rSSLaFwhLHU5/
	U+N3CFTxtk5vUawx9aU=; b=WU1fUeuEZi2nZWztsaD8Isc6submU+vTizHM0Nrh
	ZwEdt0mouZWw0y0gQN2m1K3JLpCqP6kh/QNnbmNW2ToliDbNFZZ2SIJ66atSoonx
	imB7dRoxB9OSI75LJSlhUjcRJqE5sDGLvzP5GU0EAlVxE2T+4TAxk8rIB6S0CYxR
	zE+hG3lu6Ft23SRuROKjVl0i+8wqgyuENgndQ830k9OGdGujdywClUGMkMimVTtS
	54T615IJV5C7wPW5hibVLHFRqpUCp7NmyiNTRhij1JZ2BtLDCcDvmhnPm0RjIIwB
	zuj7I1T/ZfwzGP2YbEjhoAgweMtKbq3stEAjlM0GIvN9YQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt99t1c1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 04:06:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70d16d5a9so1080220685a.3
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 20:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772165203; x=1772770003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdQjHF+RYM7rSSLaFwhLHU5/U+N3CFTxtk5vUawx9aU=;
        b=TWddbqBf1Q5fRjDCEeAxJRqBJ5rOfNGR6MqRysNT1VQw1bUObAnVsO51EyLktKJVmI
         A+1m54hJWlPcGRZPaHAuqhDXNxMYnnXykuKxyKKyo1roThzejx5XVaHjrbrI70TYRb1M
         CeovG5Hj+N+aTOpIS7nhj472NHeJF/tnaLmB1WGjdKgW7wvLssbXjNMPlAMKs1QElYC0
         PlKAD0V/ff6d2TCjZV/I8HxRTdZoCtwBlq8VzXk8umBPnrnS43/au2jyq6tJyTmlQk3G
         9xY8UaxHW9lITTuaqTUbzD+qqgtwKYI7eUpui1ht7ggurgbjH+wOsKHO2HyzgzFXNK52
         /qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165203; x=1772770003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdQjHF+RYM7rSSLaFwhLHU5/U+N3CFTxtk5vUawx9aU=;
        b=UzgMdS2H/KlcgLXGSKx5JEhEB4FPWBUPnNb1+OsXtLOqDQ5GS1GNvnCXWoHLRgUoKC
         XzwEkrbICILhs0oLE48jvksm4EKuO9t/EWI8gsAKOpU31tNns9vkD6K+JSIcH7+jEz/n
         DBhy4+7cTKe5S/uFpTkGFfV55KfQDOP46BbnRP5266R9TXSy6wqcdPvPCdGjuaY8Sxp2
         iPmcJo3tXfX7D40wtIHWmJIkNL9qNrWxVYcuXBaiJoqeOuI6atUrrYmyF3n0mMPRUs0s
         sxoi3hKrhEMXCQwTrGEvtJ4W40PeRiOFjIWXi2S1iU4SSBlKELFfiL/+pjOdLGX91VyX
         fvWw==
X-Gm-Message-State: AOJu0YyRmlc0AWvYk/sQr1A8TBIPnFl9higckkudkwTvMzyFj0uA1qjr
	Jq+L2CQBd+N8KO0vGU4B+jZNKHVtHbeSs0FA4JaBAmmDHN7/JBMGCBj3sjDtifx3z2zESUfsSj6
	1gWZ2OYca1r7cWJfnTCCOLHEJz4MB2zXS0+3mvFzXSgHucjtkQt3glC7jvFs=
X-Gm-Gg: ATEYQzy9YbfI75M5tuISnBr7fm0gd0zoSEoYihscfm3ecvKHj8iXVsJx7ZSFOx5+ITX
	WtK7xulbK77i93fxDYDNjUsT8So1LShyCPwEPQXMyq6Y/6A2FLdqgUUSZaAt0ZcRf1OA5Uj3ptC
	1hNzf/Vn+L5hXbrn3ZDJCPWXz8J9fapKphy+BrJ0q5tzsd6kQ0tMaaZoNj8OKQY5dCI6k8HtZrr
	Bhc3QbN4ATss+kUZ8rXMoRmTkD4Yo2hbBVqP474Fr5all6LS7MJjevzCsTrSEAIRfFa+w3lvqmR
	PBIdyOL0Q+7LVZ/F/866l1OzrfFafIb6cTz+wictCSOOZiUrsAoesfGGjpZxYxY6BuBldZgO367
	k96YCxaw8arslMwhSQJIJNwQ6zKX2wo4H+94IKFOqUypLZ+aVQ7TSWattVd9EqTy3Q8HpcfvmM1
	Plo77D/XDSCfocXzSTcVpmBAKMb+ZH3H3RWpI=
X-Received: by 2002:a05:620a:d85:b0:8cb:43a3:8b6f with SMTP id af79cd13be357-8cbc8e1afe4mr166989785a.67.1772165202899;
        Thu, 26 Feb 2026 20:06:42 -0800 (PST)
X-Received: by 2002:a05:620a:d85:b0:8cb:43a3:8b6f with SMTP id af79cd13be357-8cbc8e1afe4mr166987785a.67.1772165202451;
        Thu, 26 Feb 2026 20:06:42 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f3016de6sm11487841fa.38.2026.02.26.20.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:06:41 -0800 (PST)
Date: Fri, 27 Feb 2026 06:06:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm: Fix dma_free_attrs() buffer size
Message-ID: <n4pb4fvxp5toiy3ozrzozml75nkhgb3v4vmljpcx4oyp7kkgic@dhzvtsxhwode>
References: <20260226095714.12126-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226095714.12126-2-fourier.thomas@gmail.com>
X-Authority-Analysis: v=2.4 cv=IZWKmGqa c=1 sm=1 tr=0 ts=69a11853 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yVL_GmymfDenR9L41UUA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: TGVQKrPQiJyb7QInyOObeaBBDXM78a33
X-Proofpoint-ORIG-GUID: TGVQKrPQiJyb7QInyOObeaBBDXM78a33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAyOCBTYWx0ZWRfXxBwpMccPzl0r
 NAG4R4ljo4qqv7uYeJj8TG9gZDSU0rsox7kQPTpPxR0nLM0/u4s8W5/aMDvDXe7OsIekSVWKXZg
 I1LDRthIAt2fSgsKqrSupnbGV7RgObFxl/P796YB/9rRxqzaSzeLIHV8lH8hMOtTcMzX4VyznR6
 rfmHkHVKR1TV676undbufIionnQ+YuWzP19V8pi6OkpX7jfzp1aQyKTpeo+pD8heA9nbwsI51Gq
 wuPFgt/xwEbdB4VT5SlacapVK143zrX10jLhgNFxv3Tpbrduf3fumpuaE+AsP2Ii7YpPfQxMmzl
 0IFQcJW9pwn2yJWkxQHAT8eUixcO0iyDAkLdT0FuKte8ynCmMzWyGvX0eBU6Wgm81rTLbMNF4x1
 sWPJksiiJj4ZTXFkCRJxAPOsDHBADUyYNwzezpmEUy4s1nl2SJzQufTWXuXnBEormOPQR4abxdc
 eWSVIeteFQc2XBlnMCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219905-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.qualcomm.com,poorly.run,kernel.org,linux.dev,gmail.com,somainline.org,ffwll.ch,marek.ca,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9BBEE1B2804
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:57:11AM +0100, Thomas Fourier wrote:
> The gpummu->table buffer is alloc'd with size TABLE_SIZE + 32 in
> a2xx_gpummu_new() but freed with size TABLE_SIZE in
> a2xx_gpummu_destroy().
> 
> Change the free size to match the allocation.
> 
> Fixes: c2052a4e5c99 ("drm/msm: implement a2xx mmu")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> v1->v2:
>   - Fix subject prefix
> 
>  drivers/gpu/drm/msm/adreno/a2xx_gpummu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

