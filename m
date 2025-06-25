Return-Path: <stable+bounces-158634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D61AE913F
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 00:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4AB7A7DF0
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19F2F3C3E;
	Wed, 25 Jun 2025 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzZsVX6T"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE726E6E1
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891778; cv=none; b=emdc2azLClG1GRuq01JwBpY71k+++slqTBVgnXNWJrQwOxFpXwUcfzHcIXkU9RFnxQETWDHC9C5GI1HGMyN+BVl10Hg2095/IooWgVjznNhQP45MZ1X5o06uLxfc3RuHY6Rq6J8lyy1pUrccwKBbSUxpE+UUNaQIeLjbi8GmoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891778; c=relaxed/simple;
	bh=HF8iVUJz1QzUsQNgUHUXzFhHWT0/wyLsFN060cIC5nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOvjzrbH5UlBilQxfbqB3aYRUv74jHA6mPw31wDtNSxUgquPwprDGHQRUuzT+2q1YrTs8yT4VfHSBpV8N+m1BbUiH0gpXsisz7Uzi5bt37xcqlLctQPaOIFoiFGx6Z21Cai6o4sRKiOzPhNWuglbhek5mQi8evDaNUBi9f4IjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzZsVX6T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PB4qVt023175
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 22:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYXaxidIb6o34oiQEyhpZSqVGpMdSHiutGvzRB5jGiM=; b=DzZsVX6TzJQRs/HR
	bRX/HFFcsIPrDi8G2aPlQdk1nt9qCoJe05Es2nCus5/Um0EoFURMIo22C5Hlpu2k
	JjzyLKchDYcRwLAxE6c6DQTtl8ZCSr8AS6QLlNid6jfiwgtykTfmOLGzoN3XNWuL
	S5rSugxhg92L83UPGKtrNOli0npseIdqyv/S7C/G869I5pgrj0MjWOeGWUCyMBgl
	Xb8F3i2td6retMw8ySDsjiwXv5ciBGAkctZLGy7dH0czNCfucf6CZNnT/8k+SSqt
	WW8cp3leiwDnPCcgB8oz9ctPxwba3ZTE2p1OC3nj0uaqvy0H27YlGXIwVEVm6gGX
	DSIC1g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fb3wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 22:49:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74913385dd8so576528b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750891773; x=1751496573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYXaxidIb6o34oiQEyhpZSqVGpMdSHiutGvzRB5jGiM=;
        b=Q1eP8lhVKJdS/rbDSbqHIb5xoGNgNuSKASvYrd617HCrtDCxGVd04HmoP53WvseX4k
         MfVIv2mPRCNQBs16TsnoYwf08SXsaqxn/vD5P3wMJ/AXpnhKsaMMVwObc4ZAZME3ZRaT
         SJ5x+TX2oiL+CB6pNxRnz/3qWNTcHZ1Fy9S/RXx7FH54/hZ9f3jtDOuHCohrv7hZRUNO
         H5K0W7d8eqKGAvyeHheZ/tOVszpfp5kF3rBkXUHwLuY6RQP1DcvdWREaDxIrHeX0Z6d7
         e07wCwi7ABodRD7caL+0PHwgD3h5VOqQHASH6v/1psCcCAN+9hGU0e8en6EC0hbw8Er2
         mDew==
X-Gm-Message-State: AOJu0YyxkQOtSsFZJszFABcw+VNeiUEg+oUyqtfXRKjkL8CK8pJnhAkq
	XmCV2DIgzYI8IzIaQOPusjTQAq3pvJ3nLesJTfmt/MRbvvQlz/p7jQAWWeFk0uoHSJhiXq5QEum
	4R8HyigdWJWD2o6Q+gN+2VpJUVShzcxjMfD3GwPg0zbccEeIJ8FY38dr9pb8=
X-Gm-Gg: ASbGnctWhlvlxgN9+qgFBPfWY3OAL3EBt6wR6AdhiAugnWbyP5Hqi+3dBUzbPVvENPw
	aLZ4dPDkvVVE+UyXS5Ygf0oNfl5shKq94wfqZ+TmoTAOFMILnux30fveeMZUGR2d/+RD0jx6b1U
	3XYGFbWI68dDIKCswRwqJ5et/9UbACVPsAkLWPl46Yo4mGnmiJfDnZqxXk1we7zwcUrG5V5POqe
	279hQ8nthUl/7/HJuekgZr4v6q+TPjHrqJSEBKfTHJKnCAiPq71YT4OWAhvxH1QK0ROkqLkTVj7
	y65zBNUmJWucXwmI2KwCh2W9KXCMqLgqAd4cQTSg9J0qJlg5+W0HxvQK99t/9E0XHiBEzTqtMIC
	TFXJpK1AhFYcPTHE=
X-Received: by 2002:a05:6a00:3d16:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-74ad45e6addmr6632857b3a.22.1750891773410;
        Wed, 25 Jun 2025 15:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE54s5I4oNaz+6DdNq5r5PUAHS80ExntzXwuXQWgZDeiN9B9Uwzx03BnRvYfw/dYhBnX/LtMA==
X-Received: by 2002:a05:6a00:3d16:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-74ad45e6addmr6632818b3a.22.1750891772820;
        Wed, 25 Jun 2025 15:49:32 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872c7fsm5252175b3a.167.2025.06.25.15.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 15:49:32 -0700 (PDT)
Message-ID: <35619c11-71e8-4372-b38f-7f1754c777aa@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 15:49:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
To: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gregoire <gregoire.s93@live.fr>,
        Sebastian Reichel <sre@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
 <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
 <aFwOVGGHOHbko9So@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aFwOVGGHOHbko9So@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE3NyBTYWx0ZWRfXx10pBOSBI0M1
 6Iri4cyzbDHmk4GzStyg+MTKqCCk8Y5Ee2/wOdV49QT6mofVc76I0kndNf4aVczCQrOxCYl2FB2
 blFEO+9io1QhCa2/btrpMMePS0riXRR5hn4EGxUYjeXQPAUKQTA0jK0zf94sA33xOHHRj7KXP3Y
 VygARGxCen5b0FTKDcKfOAyznmolUdG1OTyeYIKxVoCZYOJ57aklJVax4+96/AUBdb5n0RD9MgU
 +0rM7FaTfKBS6xYTRTqJyso3WX5CEs1kmh7qTmoox23QZLJ6U0C2MhGl0T5dAyB6kJzeZu8qrID
 oC/Yg7cwKnrw3cRb3I8dbAA7yJ4b7NRbahp1q+dnJCa14iX1zpTFw3KHLx+RWtLmD6SQM6+1Jb+
 cozloMxliEK/jiU8ouMEjGvB/hQXxcPXAfHKw5rcYRH6r9lyfqU0w9dML69G9BR4KAA4PJjd
X-Proofpoint-ORIG-GUID: nK--mubM10M0eWmbtXc1vzBeguK7fXhn
X-Proofpoint-GUID: nK--mubM10M0eWmbtXc1vzBeguK7fXhn
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685c7cfe cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=LVwp3io0g4xlkmLrWVgA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_08,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=820
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250177

On 6/25/2025 7:57 AM, Johan Hovold wrote:
> On Wed, Jun 25, 2025 at 07:48:54AM -0700, Jeff Johnson wrote:
>> This is a 0-day issue so ideally this should be backported from 6.6+
> 
> By "0-day" you mean it has been there since the driver was added, right
> (and not that it's exploitable or similar)?

correct

