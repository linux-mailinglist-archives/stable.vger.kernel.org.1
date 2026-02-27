Return-Path: <stable+bounces-219991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFUeJdvjoWmUwwQAu9opvQ
	(envelope-from <stable+bounces-219991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:35:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582C41BC074
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BBD33013712
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83138F241;
	Fri, 27 Feb 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSd9z3Xb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eKZ8XFHa"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BB3451B3
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217297; cv=none; b=oIYMj9BhGkXYlmwARHsMmKl4EGexEDxe1XLZn/QeFnz+qUkCKgP+/spFviLqtza2FOIlbiPlOhlygUGuhzklTxJJDNUSdPx4vPcWeijyVMzGNepqUsc3pQC9DTLcQWqpW47x0N3urDtbri3zdMcyXRnfXcqei5Yuy6syt97Bq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217297; c=relaxed/simple;
	bh=bl7qdYx7SQiFCSladL9pextAT184jszIrRyy/4wRz0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlaM3EHBWsR5uYUnaH2T+KFphijyEK5dUTQ88zXI6xl8+SLjzgLR5UGHUhaT5TyXof3wUN4YONxkkXiG0iV87lytDxfQpgBloMYqQZe9Ha8cKYDJeOv9Oxtg96lg590WkrsehrES1/zc4l7A5bi/ZgP74wzbdYxwmwv4F8A90Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSd9z3Xb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eKZ8XFHa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0PJT065430
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 18:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6haVS/eYpEqKdgXDQM+xM4e3
	rN111AJOPvjFmNUU4uA=; b=YSd9z3XbdA0/o/vaX7meNHc/RW9jd6rJuUPnU0Wc
	gYsrIsf2fFrUQn+jVKbrxfqXR8ABYnwUU6IHa3q2qcAPJb0hOAiaSvquCAUzRw5R
	u51Og6HuVONElhVhlaoF+tqDwXx476793j0gEngU+optdsbsEwZELhoVYIjeYPqe
	itHC7jWpkzeJYpINhWLOHzJK3zfOILu/hDvGP0tWKn5XGMPG+YSmMJySbvo9yHlY
	i5HV3lTupbmGdjibHTvQ+wO3+5DLXRrM4cNneDG/5g4YotvvXd1Io/UNi1746f+o
	7xwzr+o7t+mKRVAx0TunP6n5ASf83Cls/w05nKIp7+6rcQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cka2xhd0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 18:34:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8ca3ef536ddso2231189885a.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 10:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772217294; x=1772822094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6haVS/eYpEqKdgXDQM+xM4e3rN111AJOPvjFmNUU4uA=;
        b=eKZ8XFHawErmoCn6Fjy3t2RChqrR60jRR6NDSAZrsPuIEmVU7yS1xZhmGGBccsoGhn
         pWpANv7CxUN/31Cfjt9Pb34+HszYmqdM4FEvQ5Ufpz/jd7G739OcF4zd0jV9YzwJutv+
         8V9+575oWEuFrx9lNcq4aKOAeiOVeTZZDDtOPXTcz6Om+26IHzubFUp7Wr+d89t/63yN
         gDAGacclL0h9PqtiWdm7YXjZcX5X6j2HGcpzICmXLBmW6nZoBY0sGHVAxSW0npDi8Uf2
         DUpGGLGlvbuUs3tjKZNIIhH9TqJApH5WRYcbANORnYMxVVWqD7FH8pP2f8lhj/Hxmy2F
         XXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217294; x=1772822094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6haVS/eYpEqKdgXDQM+xM4e3rN111AJOPvjFmNUU4uA=;
        b=SWls5Cpl4UQ3LmBK8zzI3oYCcpLKsScdJ84yVySh75JFOcdW1mkOI7f8WNUKpWaii9
         3sEdX1AIiOrirBuSu0FEIQNm6UUCz1kBkLNguU18/T0Fa5GlllSe37jXq2kdioU13uGC
         /PWOYHkc2YXk5qrh8Gc9t7KEuliGgb5uIwCHsqARMCtO1R62+X3cSdbs21Ogm3urMcSW
         2au5ZsnP7rpmjT2clXeSq/mr/f3PhAVtpym7gUlE4eBljRALkY1ltWpPd+OG2YCixnYB
         BNGhO3GA07RqAIju0E9XZ4hc25e9FCZvduJASZaRGAkfo/7t901lolgYRgSpLS5ePSjd
         gTHw==
X-Forwarded-Encrypted: i=1; AJvYcCWA3xSl5igMK/eFs2nRnjheVp+dzJSbpoWnP8tPkPV5SqiRjmO+RR2AmF+7iw+xldmT/PAAM88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWG187ct2E7etIiJIfTvfU+CfnSZ0EloIX3mLiSIjoeuqztfe
	0mk2F1aNfK7Cbl5/X6fSPj3qqbkSm7gmXluO+5eQrdldfmHvuMCmBwAVTWwWXQ7yjMdKD0ShKSE
	FIGnGRUhd78KusrT4EONiY00bup9Y23UQok78SylTE+gEpYycCVnru12R2Ls=
X-Gm-Gg: ATEYQzx+417PRQqnBE4TKRPv60DQKA3/39E6iA11JCVlC4ttKYwIOUJkIwCI0d2M1HV
	ZG+RWFbJa/w7rwfv8lhbMmwuge0xSaLp5kjxX8oxxaD5BcNx8z3FOdH1YEdV9cLfLa4TQNgGXAJ
	rK0wyTqzq82yMcEZeS1MIlYEKSpc/vHV7SVN3JafgXnNnpY9DMfuw38czVpJs51OjWC8W+gv4JV
	vj+2SWcmCv/QFNl7e4M8tdjDUiWE0Ztrj+awjoWLruRCq3KB1uYipWOGhWV1cMt3aNX9/sjZPNS
	rp8UXQafTrLZXWtHoSlUZDbg3iDUC6E1AQT23jexDi2jKtEmWEB1XUcMQ6MDeTMaaDeAF2Vj6E7
	kcILI8faNY+zh75dklNUabVkyvQu3TRzf6hSE
X-Received: by 2002:a05:620a:2956:b0:8c7:fdc:e872 with SMTP id af79cd13be357-8cbc8d9e73cmr490766285a.19.1772217293675;
        Fri, 27 Feb 2026 10:34:53 -0800 (PST)
X-Received: by 2002:a05:620a:2956:b0:8c7:fdc:e872 with SMTP id af79cd13be357-8cbc8d9e73cmr490763085a.19.1772217293092;
        Fri, 27 Feb 2026 10:34:53 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm256624345e9.9.2026.02.27.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:34:52 -0800 (PST)
Date: Fri, 27 Feb 2026 20:34:50 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH] dt-bindings: display: msm: Fix reg ranges and clocks on
 Glymur
Message-ID: <w6rgjozkbhvjbhoiv37ib6hs3ydqnf3zz7app6pziggxitpuo3@3nfmtfqr4ui3>
References: <20260227-glymur-fix-dp-bindings-reg-clocks-v1-1-99f7b42b43aa@oss.qualcomm.com>
 <177221144530.237949.10314173375793939491.robh@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177221144530.237949.10314173375793939491.robh@kernel.org>
X-Authority-Analysis: v=2.4 cv=BOC+bVQG c=1 sm=1 tr=0 ts=69a1e3ce cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: i49Djwl6nJSNqWrMnpix3q8EGx9fXsso
X-Proofpoint-ORIG-GUID: i49Djwl6nJSNqWrMnpix3q8EGx9fXsso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2NCBTYWx0ZWRfX3BwqZNsWOpow
 pB5iFAeibVZQlh8Rs/GVbkmYllvdyI1Jaky1bGrH4MaSQV3u7xq3UktIK8ToisC5ub78hvcSlzN
 cYlf47nfA6pTFTObOa4Be8n4E+dp5zpOzwVkgUsa8unZ+pszHjS9FafW/ZRIY8aUllh8boMs+kM
 y/MGipE6WErUKXNdr65AdPVnNGmaYvCVNPY/lo2qIvlforeqGNvce2QOqQjeclqCbtOU8iLlCGq
 foU1iPQoXsIrwRMSIsc9GInO7w0XLTBOsoOMfCVxsa7NZL6GhDZJ71duGW7ILKWwTbLBfuyVyaN
 KFm/wwo1OzSoI/D3w5nU2JbVhKvJbteav78BrGPDPblxYo7g59WWQyI4+ZwHHVFZn6HmcmLUEdT
 0iaIbi2UGt82MTiUXgMCs4FFBOn0xwrfe1H1sD7TUyQMh6RQ7E/xOGzD8SGwy10/dsn1Uu6ojsZ
 /RIGCctmJ/ZdhzIQRJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219991-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,somainline.org,kernel.org,quicinc.com,oss.qualcomm.com,linux.dev,suse.de,poorly.run,ffwll.ch,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,devicetree.org:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 582C41BC074
X-Rspamd-Action: no action

On 26-02-27 10:57:25, Rob Herring (Arm) wrote:
> 
> On Fri, 27 Feb 2026 16:23:00 +0200, Abel Vesa wrote:
> > The Glymur platform has four DisplayPort controllers. All the
> > controllers support four streams (MST). However, the first three only
> > have two streams wired up physically to the display subsystem, while the
> > fourth controller has only one stream (SST).
> > 
> > So add a dedicated clause for Glymur compatible to enforce reg ranges to
> > describing all four streams while allowing either one pixel clock, for the
> > third DP controller, or two pixel clocks, for the rest of them.
> > 
> > Cc: stable@vger.kernel.org # v6.19
> > Fixes: 8f63bf908213 ("dt-bindings: display: msm: Document the Glymur DiplayPort controller")
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> >  .../bindings/display/msm/dp-controller.yaml         | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.example.dtb: displayport-controller@ae90000 (qcom,glymur-dp): reg: [[183042048, 512], [183042560, 512], [183043072, 1536], [183046144, 1024], [183047168, 1024]] is too short
> 	from schema $id: http://devicetree.org/schemas/display/msm/dp-controller.yaml

Yep, I need to fix the qcom,glymur-mdss.yaml as well. Will do in v2.

