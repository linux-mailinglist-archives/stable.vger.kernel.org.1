Return-Path: <stable+bounces-224617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHFZK7HFsGnTmwIAu9opvQ
	(envelope-from <stable+bounces-224617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:30:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320B425A56C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06405314C822
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F799368287;
	Wed, 11 Mar 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNdLaoif";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcldvMY/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C72874F5
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192619; cv=none; b=gVVEqOT5AFtgug4rN7f6JVxbt463bbNtoSmemC6s0ATeAbPPiTFWxkhFKNFoYV5w8IAScm3O54gZBrK4TOkQKvPd7vhA40yPpHbUPqf35gfjPtnJByA9bC2fyYFPpoJPIXToBpP9EobsRbsRvfYkYdqxtoRBn2pkU38G6gIIStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192619; c=relaxed/simple;
	bh=KhYfk5La3zPS9sY/f9J+v3gPXX+NIozeZDPHjR1XfM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4aN/EYR/TEAivjMrVs4PVJ3aOe02W2HmMeJFNE7uDoHRFGoApQex9JlX9cG+IgsThNB1YRHVZDWEQa2/xIWCOJ6fgcdjC4jYY1p63OpGpsekKY2NzvKN0aVIlBIPH4kq4o/8F+AfNsKjpM9q9VinlejxskcjApzsIJEbupnoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNdLaoif; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcldvMY/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIkcHd3893470
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bkxQqKRENO2AomQ27AYoBHJA
	PGDEOt3uW5XK36rzZco=; b=PNdLaoifCFCbxWyrergbYQ4vzvXT+4kj3Rt9chIe
	VFIp47pPwAezmxzfoOoTI7xIeKDRP7//mGEElrYEzxMOky2udA4oBiNQXajJROit
	NQwtKb1daUGdP5ug3KcrerHTh5CX9SlCAqKKigeazCiVTeQnOT87MmWgMlyLx/Et
	VUKHZYKs26M+LR0i3Ia/JzCSjqucQjTPbRNgpd6dt5ku8hU/2kJrvcnwf8UDWQCa
	BACVFiMCc7yKVcnWA++6PWRu32T8T9VAb9oPQq9OHpyygylCwW57PPtDD03Cbwi4
	3PB8tXWLbTA9ZQBwOrNhulq+w4bkj5K0/Y/N0gaA3RrPig==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmytk1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:30:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7a25c5a9so1826900985a.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773192616; x=1773797416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkxQqKRENO2AomQ27AYoBHJAPGDEOt3uW5XK36rzZco=;
        b=dcldvMY/eXunl99OqFTEhJl+9OLTiDhrBvmSKj5z1JlNwmDuzD/3OjXucn3VtNeif9
         vwBJ+rRMRZgH32PBPZ/PZZFxmqphZeS+70DTit/Fi5bJ4PSUGaWx4dWQ1unWTlEFr2Ez
         4Dp25fpjqswkUNda0SdQX+4Sostv1v8Ow9tiXsUYUc9ANgg1Bjywv/GyjwWk1PIUVU3E
         wXgKkYCPu4FY7an6XVuksAxlaN9Jb7Ea03w/yPYOUjCDj38ZwKkUMqqpUzLS5+RLCUuS
         gVBusc/C76XWgw7iLwFisf9ufVt/hd94YdDWa3tbl74g/O3j53T3c+7FKo0PthwlBF5B
         uZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192616; x=1773797416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkxQqKRENO2AomQ27AYoBHJAPGDEOt3uW5XK36rzZco=;
        b=X0rGmagsYUBrSjaQtZ9IhNFsDkzfFLiUyJUMn60rcIBjI6xB3wjuy1QqcFWNGSyQK4
         BN/AaxtBm399fP6dbwaJZSrsdQBRDn5XiK/YHoefBukoFORIy79ilKALCX8GLPJPdbZ1
         IHKjz8xoa/KjcIA1SNrtbJqT6Vo35BrNpAHg3jJLWncPNA2cm6FkqYmte/ioyW7yBbT8
         RGDQ+w81JRzzhCuFgpfQWu+8QhAYFs/yabemAcMZEGbijsMC6owzTdPoYIOcdq+44QJy
         FE7FvixSs5gd6/nyiiNvhrV++FZed9L09PhlVvPJbZmWUayC+GxyUqkbmgvAHmXJcpfB
         ZOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUIohNCRkX6xBbXimacBCVjdOFPX2AJ5H0YajJUZgDk1gsPC7LEmm0aZY8x3+jgwRMyARAMuIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGvLpZFrECTkkGK12F4G1FLomeCwSv4Oc38WYvhkU9zcxtnkC
	rLoEs56u4yoSPliSJlOvml9Si7fRzKbQLm5lYqRDty8xdLggD90fR7MlIkixqbbb+E8BQwi6cYx
	i7I5ayjqOYjGns5ZmhWK9IVSauYek09mRFOws4PuSJ3PN7PwRtaHBCjrMtMU=
X-Gm-Gg: ATEYQzxzgrONNHW/a6wCdAqy9cFYs2GY1u1dzaa+gxCzS9mocNvPo+lxRdBjgx5PUmN
	n/58k4/BZd3NPQz6zZjgLZBEw1UtJRBCiiWVl13ay4e4I2/ADDKqeqmfhOQYb5DuV9omb39vftp
	4A65XGR6doBJPkhO4N5acik+NAdhVrM0F/36eNQw8OIvA6siWKO+y/P7PYVHPZe/lljLLlSMKrX
	9tyRi5FGUPGct+iANK95oEAqx0jsn5WLqlXycT2Ki5A5UbBEmSKmZ6MesX+6avNVyVzC+/rj6uZ
	NC4quOv+Kxl6R2ybYz9d+y3nwhWTrCcAkKktCrnFP1xLsc5WnaehaUBsq0zhUhNppGykIlg+h/k
	SYBF3inaejSnWGVWVEXGFIRlUy9M+r/j8qBw30rLPawyMti68T7ZAxbYColk2Xd/NtgAiyygJpp
	x1lIflBqoX8NIH2olpW8ssyXtM5jTTpVLI/AY=
X-Received: by 2002:a05:620a:2983:b0:8cd:926f:6474 with SMTP id af79cd13be357-8cda19f768bmr127379385a.25.1773192616508;
        Tue, 10 Mar 2026 18:30:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2983:b0:8cd:926f:6474 with SMTP id af79cd13be357-8cda19f768bmr127375585a.25.1773192616014;
        Tue, 10 Mar 2026 18:30:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33be6sm128000e87.7.2026.03.10.18.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:30:13 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:30:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] slimbus: qcom-ngd-ctrl: Fix up platform_driver
 registration
Message-ID: <xgqxuvyiclvrhlaeozvdo43qb2dw6omvm4av56k6ftmnykiwq7@23cotrwzjnyh>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-1-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-1-5843e3ed62a3@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b0c5a9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=507G7j8PtStOqQvpsA0A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: awVl80-O0Bx_H5pKlS8eTaoYWtlYuzPG
X-Proofpoint-ORIG-GUID: awVl80-O0Bx_H5pKlS8eTaoYWtlYuzPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMCBTYWx0ZWRfXzx1dDXT0E80i
 ATqS+ozpZuZxCIbemENNiAfMyz53hBko6EGS+NyTCO53EE9HOhWpd81n2krBgNHWGKlx6mkWmHn
 sJi4hcxcYOXFCKD9RPj/QKREyMD4OMdOCVq6ZiyFU1qTTOY9ea0eNr9l9tyQ5iiCi42ZvOP9iZq
 sjHz7QoO0Jd4aQJPebXuhLNeCZyqKFJdqMMNIkCXMBpvv6BL/Y4x+zOEEXjBQ1X2OUgnzPS1oU9
 sqghKwieiWdd4Hail/egtWMhl59RnApvheWGL6vKG4bnQiiWaGYV1TvC5a1NsqLs2hgulP54adj
 LC6HLU4csaJ6gPy/1G9Ucn2ZqyGbQTbU+4DfGvgKbgDmcZA5amFvpzaij3+PUMgzHdiofAcQ2+Q
 Y/AgRvSu+pgyEZKGi7uUVjdqW1wZMfmH71EEZnxWVvrCMbpF4ziF5rjjfH+8VN6Glvey8E1KTgj
 G5m/W9lymFNJ93/WTpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110010
X-Rspamd-Queue-Id: 320B425A56C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224617-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:02PM -0500, Bjorn Andersson wrote:
> Device drivers should not invoke platform_driver_register()/unregister()
> in their probe and remove paths. They should further not rely on
> platform_driver_unregister() as their only means of "deleting" their
> child devices.
> 
> Introduce a helper to unregister the child device and move the
> platform_driver_register()/unregister() to module_init()/exit().
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

