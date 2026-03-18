Return-Path: <stable+bounces-227099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOmsF0fGumlobwIAu9opvQ
	(envelope-from <stable+bounces-227099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:35:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 017602BE53D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B511E32ECC1E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D33E3D9E;
	Wed, 18 Mar 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDv+zGyf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdOuw30q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90F3DC4DF
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846561; cv=none; b=XTlRhizTDS8QwK5pO807X7ioAFz9lDuMJnkl4F07gCsSAm0aIKOCZuPkA4aa7Z/4s5s25XkJqO1xI8tTEuyEjFep3uvNFEG7m4ZwiM5OXRtdviAuHUEjpRvleDK+8E1jdgqAVPpC1STsRH8teX1XDQ1c/V0cSaLsztnX2S+nnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846561; c=relaxed/simple;
	bh=8h8t6L7UJjnnHh7DNAu+XCYzbbspRqmakJ0a75DIRUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URl/oJNc+u3y/Vlh9M8Qxt+IhmrNrz0fVDHKcB8b39eZGyNzz4aTH84YaJzkedXW2IIqnRfllRYZrDymCD0ybJ8NKSl6FS8WSDeI2/JgZviwY3QuHI9gHgyifaeuKK8FZsHmy+UbYRJOCXTFLcLCpyJKsJREF9dSiWk2LV/maK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDv+zGyf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdOuw30q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IEEaxo1050604
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2Cn9ilx/3avZr+kRHosYvMle
	e1f782wzMh3Ai7wZ5uE=; b=eDv+zGyfQIybJnDMGPzj/6Ur29oA61LabHaC3hN4
	I0odNdjX7L6xUSgiiq69ZyqtmofBZxaBjHwR81WMuY5x65Vely3egTzdm8K3K5SR
	p8Q/+zZEyINItmriILocmPsSA3ZuSAYeC4wsga6tNNiQ2OVR5Eu+0FotzHrXK18A
	fcajoAq4ffox+XdGQPLOLFu2+BEjiJ/W0KKNDicXeb7xdyZTx3iaPW1bm2QNy0sq
	InSFGmjg5imq/vHk+xl7F5Uedn42/EkhRFI1iBWYzq+lez7oMoXzhcw5D4vilW8p
	bpQTIz+B/4dK2KL6sweyce0blRRrrZ2Lf9xTHqgv3eC3ng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyj4ek2bj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:09:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5091a96f0bcso65799371cf.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773846559; x=1774451359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cn9ilx/3avZr+kRHosYvMlee1f782wzMh3Ai7wZ5uE=;
        b=AdOuw30qkouaY9Gx/6qC0WUY0KhiJEq2E1NANyrXFqj4VJovR92hTvmTdlatWopu/6
         BH/T5C2Jb3XzxEoYl49CTIZ2vv38TlGGBsU4PaBxZlZd+fdvrL1xvKbCJ2G3HHNKqfPP
         Y0H7vsD/QyULzllHIAU9EzEhif7N9zaQOP611UHhupIvGsapGfswLI//wnN79/P9zJCb
         Y+e1Aq6cav8c5iSFZHOyB2EhWG8mDVk/ZpMzbHaVOOvD4psdp/4zDBSV3AKPNYcYPkGH
         AoH8CoRPp3RBEaToYApT2mlehNP2YwS97Hi2EPddtUGxtB519L7Nm+VP/9tkM7a7MO2+
         zTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846559; x=1774451359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Cn9ilx/3avZr+kRHosYvMlee1f782wzMh3Ai7wZ5uE=;
        b=Qhr2m8Gc/bE2PSfo8GzL9svIN9iDzi1X8/BfpNIMtfP6iujA+i4cFWjbTDOC1asjPb
         95bY/2JhujrQtWVxFkskRW0OrBxmwfH0p5sADaP4FddnOC14jD1g+V88tGB76mfmMjfg
         tnxoe0jktCuTvqsVNoblqVcjDMKJqPyIZbFO8mqx/5pcMcDnNofP+T2JjeDMLCqL6h1y
         KBze+kOIjTVw45dc/ecbfefBwGvbokb6wg2AaHbwW2ctRwYdEIFoBzqigX9HyuIzs5+h
         eclos+cPSu4xlzsyBdUc+mQbmgxPunt3XBZPhr83GQW3/2My8J8LGHc+6YffZtL1nz9E
         KBig==
X-Forwarded-Encrypted: i=1; AJvYcCVOxniVJnIJipu53mp9gcVuZLK8z9NCjz+322sEgrjZQFwKUfQ25PXDIxAl41m/urBgcSAwoSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLm+4VyumVA6Vtohfhlgau96BrllDXnOCW1GvIa4fvkzrS7qJ
	UsBna6nnptfMXvdEMaoTnXm4ckGtSWC2uAQUNVq3uswthWc/tv7x+6zGzMMnHgEZNC7vOmqH34S
	bGIJI9dZrnqWz/pMDMFxTEmMlUd4qjH1g17OfBGQKOLYWUXkzKl6S0kwPl2Y=
X-Gm-Gg: ATEYQzwcn9Q4o0/XQq0MBaKkuLLiJyNdJHGZogMVM3KTns1uHjxHIidO/76sd27Vv2C
	WH4ffIWdrhHegNxC1AshxKEk5zfgas1MNZq+56wnjbrVbgC/KwCUzF9XqOyVTXcNdy1f1U/rMSf
	ZqW+7/8it0bKpknO6LQryRaLGiK7B6MycCaxXZDLzj3ynnFQ+BlXnblIsdLh1L6HIgAmSo3Mlj9
	UFKpQGzjTHOvL2LOK9fHMAUoR3AWeT1YluuSHEPCsi9QS8UiiuVRX8EYdWBASyQK3h/oaG7GqrT
	dWwjQbt+It9qPISxH4bBfLc5PZR54sz+WEDo2vwOphgQigbx3AjIFzbm2X1FJUti+DIQseQUzB5
	jYCct4s0hYiM33IL2Ar3yNsYjUHBmd/o9COtxe0QV9A1R6XwFVrb17D32QBQIN9StoICc6jVJ8m
	v0Gr7PjxtLUblHOkpjJBugRAJbEfxsdXIqZoc=
X-Received: by 2002:a05:622a:34a:b0:509:2d8e:3eda with SMTP id d75a77b69052e-50b148818damr45454941cf.45.1773846558908;
        Wed, 18 Mar 2026 08:09:18 -0700 (PDT)
X-Received: by 2002:a05:622a:34a:b0:509:2d8e:3eda with SMTP id d75a77b69052e-50b148818damr45454361cf.45.1773846558375;
        Wed, 18 Mar 2026 08:09:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c27351sm609135e87.15.2026.03.18.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:09:17 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:09:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Message-ID: <gekcz3b2o37z44h4xlzr2eo7ytewhtgtoyt3ifmizyhcl52sn5@xmowdspldxhq>
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
 <taqh3ipe54cgjwcvyqnysg7dx56mweo7zld3jvmv6goq2vo4b4@ea7ksdyyn3dh>
 <sotoyaogawzdlazsbuubwdj7cuoolortj2lzxgs2reew76gkpj@vyts66j4hg2l>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sotoyaogawzdlazsbuubwdj7cuoolortj2lzxgs2reew76gkpj@vyts66j4hg2l>
X-Authority-Analysis: v=2.4 cv=T4+BjvKQ c=1 sm=1 tr=0 ts=69bac020 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=nuaZ5ZqmnFVoJGL9zekA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyOSBTYWx0ZWRfXwv+h2Ela185h
 YoENdFDtFoXLsSFEju6uu81MEmZHZO8+gNvw83JeffUH78tzH+Kd3+pYoUW1b1rOLqo18aKrtwp
 De+N8UMNTzi2tPlp4rAx2AlAL6S4kMHftDYN3RaVc5HwPeqos5YNpJmuXC3U8ufZkn+bI+9eGwR
 ilKcVby05VLmuD2MBToXVxJjh+8O4KzHAmpo3+jp+fCac0efvYxbCDB2EDcSsbA8bwgbSLKyO69
 xGvlmyXtsBPY8OGdWgC568jY2lAwZtg0GYCa6gCFDzGlVK/8owc5WkofncDTREG9MII+o2gtU/v
 eAReniDPNZABeyYVm6gk4mvcK9rVGVdp9DpcGsn5Flv3LMXFlyOTlOnDueEQDf5gKwSn57TM+2U
 nTAuCOdWfgh50X5qOYMnZqUdT2XzO6cKWvQmrnDKIEYlgN14Nclr8YjtoumF3oMwQoN6nGEWfz0
 NCdHV2+F4RrL0tyv/HA==
X-Proofpoint-GUID: hlFEABhO26EFBKOT9Y4cyNI0y7ECdfs2
X-Proofpoint-ORIG-GUID: hlFEABhO26EFBKOT9Y4cyNI0y7ECdfs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180129
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227099-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 017602BE53D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:22:59PM +0200, Abel Vesa wrote:
> On 26-03-09 21:52:01, Dmitry Baryshkov wrote:
> > On Mon, Mar 09, 2026 at 04:44:45PM +0200, Abel Vesa wrote:
> > > According to internal documentation, the corners specific for each rate
> > > from the DP link clock are:
> > >  - LOWSVS_D1 -> 19.2 MHz
> > >  - LOWSVS    -> 270 MHz
> > >  - SVS       -> 540 MHz (594 MHz in case of DP3)
> > >  - SVS_L1    -> 594 MHz
> > >  - NOM       -> 810 MHz
> > >  - NOM_L1    -> 810 MHz
> > >  - TURBO     -> 810 MHz
> > > 
> > > So fix all tables for each of the four controllers according to the
> > > documentation.
> > > 
> > > The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz
> > > for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
> > > in that case.
> > 
> > The list of issues isn't limited to Hamoa. As we started to look at it,
> > could you please also fix Lemans (drop 160, 270, use 594 instead of
> > 540, use single OPP table), Monaco (the same), SAR2130P (leave just 270
> > and 810), sc7180 (270 at low_svs, drop 160), etc.
> 
> For now, I'll just do Hamoa as this is the only one out of the ones you
> mentioned here for which I have access to documentation (yet).
> 
> I have prepared patches for all the other ones, but I need to double
> check the documentation, after I get access.

Sure, thanks!

Please ping me if there are any questions or delays, we can check the
docs together.

-- 
With best wishes
Dmitry

