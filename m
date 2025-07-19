Return-Path: <stable+bounces-163429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6D6B0AF19
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 11:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52A95643AF
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6559231C91;
	Sat, 19 Jul 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aYNd9kCJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCD21884A
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752917736; cv=none; b=Ea3b8I60RvY6WWYqBtVM5JK9QEIN4dhSr0RBNI09u1su+d6pmN4AkgR8M0EPas8v0CgWy0BePH/pSrKKcROjawMAWPmXekSZMlSr+TkYk6V7RNl6efK5x9VpWFzx/adTVwi7+oG1AEYCXL/IxFb19qdgRti+s9RXUXbiK3U+X1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752917736; c=relaxed/simple;
	bh=hoSWN+5jhLJI9d8DpMrlNxb5YX+YAZkHose3puHowik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Kvp8eoFEzzXgKF4DlIaHRi6Lkzm6cwZ7TGSr+NPPbsO3+tQppPJH27KueyaC64c8YbseZaAb6tSHhKHvOvFdktigzkwt/yjLgPGadUTTtQEX/OlXgtyJt6etm/gNjgZU3sE9SdeH+7Q7e4P+YkNaAFW318FND51eSt6HHy/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aYNd9kCJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4BmJG004249
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 09:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wSbh+xGKxOsPi/4J27pwmx2I
	Cc9rg1Dj97VeqIVuWg8=; b=aYNd9kCJBpJD8plQqeqjz/IuZ6xQz243UkfZsZl2
	xfMrkrgp61/ad0lwFhnxvzBZfBwaJwIXkXf+e4secVC/5Zb66PlHfH2bQ/AkEQ+S
	UEJ/TE/6lu9GEH+F7mTu33dlaEhdBI/Yb4E672HHDkvbeePuQWNPnt5Ugt8xLvpW
	2NOJV3h/UJxDWgd4VAhTCZnyDQVyPnZtJ518PNR2jrsKVTXIl0E2AXtcYmM4tdVC
	mFYYA1Km/E9LwiHwpq3c/Kv9KhFnaLRe8lpUSbJevx37qrINemTr/FNDDjGvOUuO
	6ZFE3SL0a8tE+FSiXq7eCzkMG4OfC1IjMDr/8usJHWdQ+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044d8e32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 09:35:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c7c30d8986so826144985a.2
        for <stable@vger.kernel.org>; Sat, 19 Jul 2025 02:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752917733; x=1753522533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSbh+xGKxOsPi/4J27pwmx2ICc9rg1Dj97VeqIVuWg8=;
        b=IVnpUa6+42Jjr1yr6PaN7eliKWhac+XnKc4vqeUxedoVRtyoLa6DeSeI5Y0anF2Rvu
         KogUu+KxyO4I44O5awd+pgns0tvrmgCPvpzvLMpJLGHbIYEgyhUVbFqE2gPw5y4NPRsM
         ziPzsUVbx9UPFyrSsGIEfTOCjU13HQqAqHvT4q0Xau3DT3VODt6qE47NoN11lufGCFVX
         Qp2k4jHgTn5/E2VdpHOvQK82SuKDhJ297hP9o+MAu/u8W/aiPUaXAn4FkKUIXjCorfet
         aNSDNQD93q+MZKNaoBW7IEC13rgyay50jF23wYN1J8iLJ7sch8+pfDlKSBb7pTNR5PsF
         fNAA==
X-Forwarded-Encrypted: i=1; AJvYcCUb287MHi7JXPSlO7ytQWhiyv+3q4Muhi6vEzbDiu1vHc3CutVmQf4igBGDHSN8R6xGHJRN0bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2gK4refdNM7TF/Jb1p/VVG2wbMJq7kvg7zO0BLHMWwk6Xzj+
	+7Dbg+cNrlMRzgiFf+klWpZAQLCqDDVwVP38YaZJSDJFDoagBrQvFoE6lXqOR4T9XrAT0uIfjNx
	gj7FheTRkyP+gMMEDXN44xje/EfB3Rh5VlSM0aRDdJ45+jwk7/Nq9jr6ZNOc=
X-Gm-Gg: ASbGncvYzRo0GZPLRx9XveghE72WddExOsJeLHOHmmufdB2Ca8ZLdq7AaLoaI9ZXecZ
	tTtQeSVSceUZszbowhcRE4EYxEGdCSzG62kxqwcodxmdqoAlsJT04br4xiPihL3Mbl1d+c8Ra3H
	lGYN9+JxyHc2crHOmWEoyemWmFHD184EZS7Bmf7C8XYElVl2nstlMLK+opd3E0cwM+AWZKxO90+
	nd+yVRi1o3hIOXUShVDmh7I/QJ1yc3psWjKiYcCmk8Wp8dT7K8kUk+0JncQToP9I5UoqNUQUkcW
	tcddXAZfr71kQIRJaOOx9J7wJHCjuAuOi50ClkIWND4lmMx533tMCpXCmgmREyebz58mmYUHL1j
	gn0r010niWpa0KYU2UMtHQtl6k/Aet9C/MOvJRFUobHSesvq3fJpN
X-Received: by 2002:a05:620a:2699:b0:7d4:28d9:efbe with SMTP id af79cd13be357-7e356ae17fcmr791788685a.32.1752917733026;
        Sat, 19 Jul 2025 02:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5wbUvtWyq03MOIlSlrD0IZhIz8P5EDs5+tTPDfigb89vA+4wYsZvArhwqxS6KlWMIpuEvg==
X-Received: by 2002:a05:620a:2699:b0:7d4:28d9:efbe with SMTP id af79cd13be357-7e356ae17fcmr791785185a.32.1752917732539;
        Sat, 19 Jul 2025 02:35:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aba0f7sm648128e87.83.2025.07.19.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:35:30 -0700 (PDT)
Date: Sat, 19 Jul 2025 12:35:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2] usb: dwc3: qcom: Don't leave BCR asserted
Message-ID: <iyvjr6fx3ec327mcbtemxdke32wzm6xy2zuwbdimy7ticsuvmq@rlbqiwdwi4x2>
References: <20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687b66e5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8
 a=eOX_9S80fVGYM9ega84A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: yS2IOg03qc0bKlzC-7dJEPOGZWuj0Srb
X-Proofpoint-ORIG-GUID: yS2IOg03qc0bKlzC-7dJEPOGZWuj0Srb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA5NCBTYWx0ZWRfX2gmYfsiW9m/G
 zpXogGwOv/shZjntbr9VNf0Ss28UMOQjCBlkGt4HtsNgzvmf/3zjBJ1UVBeIhQJnXFDVctBgc2M
 44/p/midni4Zz5qd8ehcpFpYT/Cb3Kp0kviU71cn56PxA75uwfh9jpqEbVc4hGauyxVfsJFJk2s
 gO6fOBhb6c7QjzNBccuVloBd41QWTLOl0njQu8gqdNmubcgCGQffzoooOzWUIXjp2jMwX8HN905
 RDTq5GkapDRRCUOzjfCqdHlp+B7ziv1/Pqg5QdlAz6+zKD1O6mruzCYzQttT2mXUdVw4aKohkZW
 YCg1RIo6G4cSWVm5bL9vZkcKgt7sWl8DcGLH9WuvBd12bx03e+VqCnzoM+owbHIvC0AXguQljWN
 cF7/e+bJDfftFlIy/D3YdjpjTVidYFB4dgTXpV0laMWKoyLbvDnE9ga2+qoHv5VK9gsvDzP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=552 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190094

On Wed, Jul 09, 2025 at 06:59:00PM +0530, Krishna Kurapati wrote:
> Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
> blocks any subsequent attempts of probing the device, e.g. after a probe
> deferral, with the following showing in the log:
> 
> [    1.332226] usb30_prim_gdsc status stuck at 'off'
> 
> Leave the BCR deasserted when exiting the driver to avoid this issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v2:
> Added Fixes tag and CC'd stable.
> 
> Link to v1:
> https://lore.kernel.org/all/20250604060019.2174029-1-krishna.kurapati@oss.qualcomm.com/
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

