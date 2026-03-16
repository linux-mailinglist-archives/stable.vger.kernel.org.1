Return-Path: <stable+bounces-225551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIPGCp4TuGk7YwEAu9opvQ
	(envelope-from <stable+bounces-225551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:28:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8072B29B5C9
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E89E30470E5
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B431A9FA8;
	Mon, 16 Mar 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DY4l0qEm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EXP9hStC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706827F75C
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671265; cv=none; b=a2m2sPvnjp5NH4w/Md2O7aVvWFCOSQwI0oEqAc1wi6nyckF3XXychcnIFV42KXYz2peURyodfjwqQdkKKSLvKmZY14b4vDqN2t+jZROeuGaIQ9xBF3W1yHwjoVaVW30UgJyJF6CnCl6HbCEbPPKFR+cA1X46NlaDhxdN0SCGoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671265; c=relaxed/simple;
	bh=ZJWP2XPIBdq0f0457iS1c2gdO4jhRPhcrXMS461DxYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAlO7guN1oezUswCqVffldsA8qSFDV7i8RZ1FJXetKvTZ0w9ts/fzgG6ikkWXTBrhR/ymU7MxqLTJTIDUyKBB8Zose17gVhEACcYj0Y6JfFH0hAPxYS78rfHDou1GBY6DCQ+mlZnFnOF4zbQWEE57qimM+w6ciUlOXV5aGv58QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DY4l0qEm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EXP9hStC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBis592672139
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Zx478U7FWl0KqKjnadyysy06
	Ggj5k5dxMbWmzfb1eeg=; b=DY4l0qEmxwlkzT6MqShZajFpm6oDVovfvdI/LGhi
	rNpyyu6b2GSb/yORSuQMMOuAPwCripkoUmSslKGvomtYuKsLCSp9GUNsrjeCEA5X
	eVw98uAeyOh+vJIB849VRNMAqKkj65VsGa+BAFi1p6fydtkZ8VnPKxoSmXSZfPKf
	hJZLS0Z6SGEdJgRLHNTfPI5uQgX/oTMX7ZCW7jSX0+JxuVbBujcZ3V2wJuQ+L07k
	TwoOh5jKUHYlIx61TO/ytFB+I4bt2WuF5PcU+yG1493qvdNP1li7d3kuAOhIm6rB
	8WloDRMtnMviwDQ5bho2yjLz+D5G1YDH+QTsbl/jkXzA3A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xp6r3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:27:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd76ff19d5so47997585a.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773671263; x=1774276063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx478U7FWl0KqKjnadyysy06Ggj5k5dxMbWmzfb1eeg=;
        b=EXP9hStCNMiq4UNnkXdHwDM1PxNMm9ns3e+/MIX1hBezfCKPRKzoPpWySRCINrOim4
         2P1HlxE5F+BR6xjML66Tb4OerDBtxpNZMvZEyjs9Pq2VPUXlh4wVuiqR1gWiGXKfGulp
         rVpMIVVhgC6Hu51a2sxcnUzgkk93mpYxnIoPa1Ys1S1kWxTM6y+p4wznXLp7aOvWYSZ1
         aKF2dA6X1xcV3ab/eXzGL+AbSXLjSE3ZoSleyBqUzcCVw+ekYtlIsHZB3dT0L1FXzRmM
         vQdMkLOFLc+gjYX3CKAUn5YKIkMw0Ws7+MmEXodRCfOnHiN+EpjlDvsWTE6rg26ly86t
         A4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671263; x=1774276063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx478U7FWl0KqKjnadyysy06Ggj5k5dxMbWmzfb1eeg=;
        b=iMgP1hzujwDLJQCs/OMgFPUhynjVsC2Gxx//UpaqHVx6l0wMkBWB7Y/UbAWDE0qo52
         yONJDdUBVFefk1s97cmM9ClRcMhcgfbtq1vawPG1AEpiHBe3pJEJTh6zBR50K0Ji1Rx0
         pabG5uzaOjPyTEO60A/Py5kM/DZhU3K4PgNjxN4uuXIHvKErXiBOgdSxsIgPm4ZRYrjR
         8OQ5LwGgr3brk7sAJkJnu40zTNSVMk1ahUsXfG5/wZdDyrdlSBegl7GITLg4PUMa3ZiS
         8GwFW+DE2HJRk+0e9BsoaeMXqz3Ua2VGxDTu3fh45HYQQ3bhjJ8iZW/COgdNBAnJLEls
         LeRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjQoNbRsqGqwrOshKfPkEQOW0ksuhUAoa7QXs5w43ELdxIKGoQbkMQc+KpzAwUUvk2gg0YolA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMKUbi7fwZr5Wlpi9bA1VXn7C8irkMiAWngM+6zxphM10q/qu
	0L9bB2iVliVYsltkslN11//A8ZBTq8yq+g97InkziQuISSQNOqdvO0G4eBkkhbaN5rx6IkVIEAm
	p8HewUOhZIFSdOK0Eglg6YstMhuaZpkkFvSxI/cLzkaX6MlXCD5ZvPUbH4Lk=
X-Gm-Gg: ATEYQzxtphVd2sQSEorq64ErOfMKi6CuYMDGScg+vQenvhr45V1SE529OJwr2mBCu2k
	fzGAPqQV9GMU4yQtjh5lZPEA9g+ObfhI0Qr2LScdkOx9Z3ouSMb7oWrsoDOgSv1Q/bZW+eRhIsW
	jCv/ETzx4SXyT9EHxIEzGhLjHkGzhBojeJnkKEu9oGD9SqTLaLJKUIjQRK5LUfrZWEyjYZDbEtx
	PxKImB3SlWYvYZONhpwNdCSxqr3jHTvofqUgGk2DRNjwRMx8comMKt0B3+H9+83Ko5YThNDedB/
	AqVczteSApJ2VkGLyvMvmXnTh064TkSlzWA+cbmUgjOmKwiGsSIuKpQ947cI0GyWPCv/zJuPbNx
	ZMFJLMmYiwqZdMrK+e2Mxg1PsOys+SWYVKeVZZdAV2TNMjW8gKo2VOJm/iQE74qu33gC4Ut9MQ6
	1egGndhCLbdJQeBmjqXWbHErxhF6wUW/OSb2U=
X-Received: by 2002:a05:620a:6910:b0:8cd:8025:4e81 with SMTP id af79cd13be357-8cdb5a67ecdmr1750094685a.23.1773671262542;
        Mon, 16 Mar 2026 07:27:42 -0700 (PDT)
X-Received: by 2002:a05:620a:6910:b0:8cd:8025:4e81 with SMTP id af79cd13be357-8cdb5a67ecdmr1750089585a.23.1773671261978;
        Mon, 16 Mar 2026 07:27:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67d61f25sm35276501fa.7.2026.03.16.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:27:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:27:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Message-ID: <6qhpiiroqnpzg44i2j5rgmlw7uaffw4t5z6gv2kgubfoqpktpd@r7h75knlv5a2>
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
 <2f4e4cc7-2600-482e-88d9-d4b20d328a72@oss.qualcomm.com>
 <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
 <7d8211c5-7b12-4349-a329-cfb51a918a1c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8211c5-7b12-4349-a329-cfb51a918a1c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOCBTYWx0ZWRfX2tYChw3Cmv52
 H4uJptZQNbDknQvyqSa1RZVyssfsnsSbSIzWl4bKEUVCw6OFNnECGyEkdYz4Rb8UPBOEO6Pzs07
 5e7xvQAZ1HkBlREqQ92lSt8x1z6gs0+PA6x74xZzPZRUY2QS77VNolgCYYL3hQMIjj+vVbKV/HK
 yAVco/hwdYdHOxVndL4ftOFFb9Kepb8GA7BhaIL9RKw7zE4EAN0579uavSo5OxBpUO0i+eoGpzw
 zIE1n5qiBjHDBKrkeLdtbimVoxstBZ7SzJ37L+RQ1IryFWYVx8JeEhdb5L1HKnGAHPNKLiSYGQB
 AmEWR3RlP9PMJa/wViUxODOF9Ncx7m9NyIJcsaatfGgTNa2SqLbpUhYytv3D3EYTt9amnnp0U/U
 1RjoN/a2V77gNgAd3b/6E/o2e+5hIHthEN+CTR/5WmMdq7zeu81h0jDpPBT1bkuyqbjjP+sYBrs
 BGGhJS9sVhbTRhw5/ww==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b8135f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=hLSxji5Pbl0OwNBPb8oA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: mhq4jWb23aLPnvDQlozP8x3C5WxBhdtE
X-Proofpoint-GUID: mhq4jWb23aLPnvDQlozP8x3C5WxBhdtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160108
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225551-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8072B29B5C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:27:11AM +0100, Konrad Dybcio wrote:
> On 3/13/26 6:39 PM, Dmitry Baryshkov wrote:
> > On Tue, Mar 10, 2026 at 11:36:26AM +0100, Konrad Dybcio wrote:
> >> On 3/9/26 3:44 PM, Abel Vesa wrote:
> >>> According to internal documentation, the corners specific for each rate
> >>> from the DP link clock are:
> >>>  - LOWSVS_D1 -> 19.2 MHz
> >>>  - LOWSVS    -> 270 MHz
> >>>  - SVS       -> 540 MHz (594 MHz in case of DP3)
> >>
> >> This discrepancy sounds a little odd.. can we get some confirmation
> >> that it's intended and not an internal copypasta? (+Jagadeesh, Taniya)
> >> FWIW DP3 is not USB4- or MST-capable so it may as well be
> > 
> > DP3 link_clock is sourced from the eDP PHY. I assume there might some 
> > 
> >>
> >>>  - SVS_L1    -> 594 MHz
> >>>  - NOM       -> 810 MHz
> >>>  - NOM_L1    -> 810 MHz
> >>>  - TURBO     -> 810 MHz
> >>>
> >>> So fix all tables for each of the four controllers according to the
> >>> documentation.
> >>
> >> It sounds like a good move to instead keep only a single table for
> >> DP012 and a separate one for DP3 if it's really different
> >>
> >>> The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz
> >>> for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
> >>> in that case.
> >>
> >> Even though the Linux OPP framework agrees with that sentiment today (it
> >> will set the correct rate via clk APIs and the correct rpmh vote for a rate
> >> that's >= 162), I have mixed feelings about relying on that
> > 
> > Why? 19.2 isn't an actual working frequency, as far as I can understand
> > anything. Or is it a working OPP for running "shared" clocks?
> 
> No, I meant removing the 162 case and relying on OPP to pick up the
> required-opps value from the next entry

Isn't it a documented way how the OPP tables work?

-- 
With best wishes
Dmitry

