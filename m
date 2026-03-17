Return-Path: <stable+bounces-226890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDfyBT6ouWkhLwIAu9opvQ
	(envelope-from <stable+bounces-226890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:15:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7802B16AA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DA523061CF5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7173F8DE0;
	Tue, 17 Mar 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoPr81ov";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIEOM1Kw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9673F8811
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774900; cv=none; b=ooDyW93tHTi29hVvPvcqHvbl/WnFSBVRmjwGDSGq51UXRXRQATFNR9CqE8QSywQ4tbw0fZ2NLBbxgkh0xipHdFjLFVTmpK/j3iUCCnPOIK2F0H2JPdxUFeb0GIkwtC0a6/lnhOcVIebVZYrkhPgg8cEnMYL9c8vaaM/GlqPOWOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774900; c=relaxed/simple;
	bh=O0GbmyNHI8hlFPn6EqP7ekN8af0Tom1OLfEh8XTAQfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu57PaBhpg/1kznqIpWkr+iazIvVCTRBrwNR9Tu/lOTVxnguhioGoO1F45f8iFcgQ42DAM6L0qbjzjghgJc9b0G/9Vfabp2z1l/JxD4fsQk7FPmhycBDZFesdHKe1tfy/mB3mmz31XOeVpZp04VEsmhAf6gZD4xYFLOVlm3UYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoPr81ov; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIEOM1Kw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJdqZ2294141
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 19:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bNOPxGj1B629A2kXBCZFXpIE
	6RUa9mVOlSveDz+QzEg=; b=UoPr81ovRoDkAFTWzo7563wZ4oonnyI3+es9Ug2j
	ZCVX5sHVYlEvt8bmTE8fpaaGukpHHOG03NhnOyxQwMEhWwe0YrfZinhwa61uDx9T
	/7nhSLyWh5cBejF3eyuzIIJsRnuWyYX3NkGIVce9q+plXikxh1uzAICLg0QBb37W
	6ah4T5/mLYeZjHT7uQhvX3H+tDUWxay2LhnHKi9YGa/cHpLTRyzQoFDQzfLWxt3U
	WiZroIlUmQH+5eLD0LOtmchbDK87xGnJWQdc0ZzHKJhtk58On24cc2+eR22yoMn3
	plomP5Zee/FYswztxjUbmCyA8NTb0OkVAXvfBinBjo0xwQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya83rptw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 19:14:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd767c51efso733164885a.2
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773774897; x=1774379697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNOPxGj1B629A2kXBCZFXpIE6RUa9mVOlSveDz+QzEg=;
        b=XIEOM1KwbNTGYJwh4KdYgj0PMQ6uBymXE8DXL2s8YxPuqgV1elNwR60l0HXQwCQ54x
         TaFA8TlsWTH09eCvYUqL9G1OHYyiexDaIT+U2dKmUojCI0ClsqHc6TL2wKOTGq0FqssL
         Z4aXMFdohYUWMBAANiBj18IHc2+jvGx06bxOUtQof9VTURcw0aCat4w4nS3El8lyQEXX
         4uufuf+MbT+ya1a2uMneTBZOc4neCmJCPrHNxwWFtHNnON50P+WbEVH1gH+OeLtncf11
         UougG6+ZPn1Nzid1yVFj8P8ADyFuPeTphCAf6UVVzrId1jZ6YIZMnrJOevbEPrUilWkf
         UJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773774897; x=1774379697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNOPxGj1B629A2kXBCZFXpIE6RUa9mVOlSveDz+QzEg=;
        b=Oq0PK6TFuBzr+XzdtUM/dH3Qt0CZ2kGz3PC0kb4wVfDBpAV/5vHJJBWGMWgTx2mx9q
         jjb/3ETDC4lsYa1Knn609LQwHVo/py35M5A/AdOAncZjVh0qug7lgjmJfM8fyJRmhU+d
         +AtOSqqnYFOsBTefo2nRKUXdopgaCKrmzWF09Z06eLc2nXA4qe8AzArlDIObBXJ703/O
         jBki/+tI7YUkhNSQtNXWlX+bXL2ahU9LSUvi7z7SGl4bWYpPJbxKMdESPXJJiplyaqZW
         sdlH8snhZqp3JD631e8OscCUQpfIeL/hemoykVvoo1ng2V8wp0L8WTRj3b72cY2fhgwQ
         dwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXmYgB8cHaUBZrxb/ITwuWGVFGhRQEMEz8wTsIWtJHxDLfmjOQIJgSiWr2gMVf33SHTelB39EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1h0cbDB2vb8jp3ZdtbLWXQDt2AVcFGOadPHzEZkZ5JrjCmm26
	GXq/tGB1bgVx/+u+qod9J9rP3dPPqfHFzW6407uUgddLYX+EP1ulJTHlsMu214xqBnleWu5UXEl
	I12w0aghwyKOoLC+eSOKAiyq9/fzVNqaH8fHpvgpuP8A/6hxnywW2Ncl8sbk=
X-Gm-Gg: ATEYQzw8T3KlKy6YzLr4OL5vN1kQpJnUWnTnULjyh+Nz44UU3vL8oRGvoYfxZRUO5QH
	scoIbEOq1SIFcmzfHHOTcXg8aHn8CD2KiajsPIg5XRk0tz2w+bViM/JJ7rUdottMSHdhbyYfNxv
	DeVQRINoctlRB1e+kzdzH4LI/xpQj96V04VDRu+oVU0wOzBEGB2Wy4WKIuu9XfL8X+JgNZCkvOP
	V/yJGkRAPlqueOHExscbRd4WQ186dfhSanq0MV1941vF/Vav2qqKoaFq8ss/8P0nevmbMqNg0MF
	GJyEA6dnBj6dMUrJU4cgMoVGXtids95DtQ9FdBU/jZOBqrItsZ3ymQ1zWi6uNeERCWsCTZB+TlG
	qAlMbzPuNbhRrhzNvLA26N4kGvGJDYa3tXA==
X-Received: by 2002:a05:620a:4708:b0:8cd:b2d8:ec7 with SMTP id af79cd13be357-8cfad268fb8mr109784585a.23.1773774897069;
        Tue, 17 Mar 2026 12:14:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4708:b0:8cd:b2d8:ec7 with SMTP id af79cd13be357-8cfad268fb8mr109777185a.23.1773774896370;
        Tue, 17 Mar 2026 12:14:56 -0700 (PDT)
Received: from oss.qualcomm.com ([82.79.95.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5189964esm1281455f8f.29.2026.03.17.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:14:55 -0700 (PDT)
Date: Tue, 17 Mar 2026 21:14:53 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
Message-ID: <viub5zy2ni7hzutaxxsrc3yxjevemomxrnsxhv75o2higjlh5n@2mf6bowxrqkn>
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
 <2f4e4cc7-2600-482e-88d9-d4b20d328a72@oss.qualcomm.com>
 <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
 <ed3fdccf-d8b5-4f57-871c-8a9cb8676606@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3fdccf-d8b5-4f57-871c-8a9cb8676606@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: LQHzAZd-bFkXSJMRtaF8PkYWahrLQg5Z
X-Proofpoint-GUID: LQHzAZd-bFkXSJMRtaF8PkYWahrLQg5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2OSBTYWx0ZWRfX4t9AF1h3C3i5
 r7dg+wlkCrimEJqxqJHyKyIqY5iXmN3OzpHwdHmB3329jWyIqms6oCTW9dDbpliH5vY1gHzpW7b
 Q8LJ6/u+ygpwl7C38/B6Vts0xzHk6/5hDIbFwcAARL3ov5UDxBaTTJ1XlS45arR70WJXZaqa/OD
 CsIwdSSAq42sHeHDE/IkmBl97wn8xeq5XTqHAUBlmw6Gl/UbKw/r8nF/DF92ZO+XT8GUblwmARl
 2W8f3yTSzU3HU8gKrHr1XrijCwA4zI0cvJvAESJQtVM375gCjJHCTsrQcYfKCgmGsDRjPfpZlFQ
 0VK2v3ntGaQjLLPkRSc0TSm4pt5KvYfXMdpGVMAe8Kc22Mz4VDytyBmIa1d0sqly13KnHqAJUnP
 4kwRz1lzd0MvnOX4UzTYsWruVHjwbA8zrQkR5kj9EUWXiXo4XzKLs+x6nF4zFIDy5V7KUaneOhH
 2jDvokXA4rZ6bu+7yQQ==
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=69b9a832 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iKs3dpp2RB4k51ZqCjcyjQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=hLSxji5Pbl0OwNBPb8oA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170169
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226890-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA7802B16AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-17 16:06:48, Konrad Dybcio wrote:
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
> 
> Please do this and resend

Will do.

