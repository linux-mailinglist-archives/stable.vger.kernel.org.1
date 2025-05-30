Return-Path: <stable+bounces-148326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA16AC9638
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 21:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B981BC4777
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A08276041;
	Fri, 30 May 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bggFS6HF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885D1465A1
	for <stable@vger.kernel.org>; Fri, 30 May 2025 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748634740; cv=none; b=ldklrg0giJlWVdetG0dorSM5/1xqjrWJlut8fObkrYu656o/3Z2ruQY0TMlWdNe+QVATs0uwLBM8DB/d2OJGYc82uJPY3u8PFA7/Za5Nd2yrXtI03oMTOo4qOk7daCjEG8+2Gu8RZwY+8toAssbgUPYbO9Hp26S6b1g0eff//aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748634740; c=relaxed/simple;
	bh=tg1F761TTW1ulx5weavlH4gZGWdsj+vLKvABDkproZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nI3Xsj+f0AIQ5Rmr7wfPh/YQEIbayYLBBPmmbOwr8PtSsMLYIQ3Dk/C91G89N9Aht3Vrx4JhCeS61NGbHtQ46RVJLA6w6H5Ze14gyLXQYhEgAYk5kE/RSVhHTa4AHXTowNPesHHNVENE0VT3MM4qQxNgDScUI1fcZ9m9r4fsQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bggFS6HF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UJTQJQ008042
	for <stable@vger.kernel.org>; Fri, 30 May 2025 19:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5wtVXZefvNGmABNozAAxXAeSLf81avwgpSKrWz3+VYI=; b=bggFS6HFxyWgdYrV
	DmwFHIlRT4dKCPvJuG/hUs+oudCoZn1I1CPwM+0zjmJ4VHuEK2HvOIjhiMs+XxXz
	7tRlzvxxr/pljLndpr0J5hb6G4UVvKBU5/PL7fFVTP1GxU9Edlu43u0NYuyUcQDJ
	mxYSFTrbwpMsXwVXuGcfBYItqQHQWmyFNIegOFGsZuM3FuKGl21L2EBoUkYrOwGQ
	DBawuOqLl0dBzt/vtBE9Fs+wmB8yq9s7ReEDnvBzF4GxQnxJ24MCL0R3c3lzOSoF
	cUBLrNp0b+7CBMDE71z3XykysYguolj9QqiC6c45QMpuT8ZA0cMxojYlZeyB5ata
	HbXQ9Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whufasem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 May 2025 19:52:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26db9af463so2642990a12.2
        for <stable@vger.kernel.org>; Fri, 30 May 2025 12:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748634737; x=1749239537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wtVXZefvNGmABNozAAxXAeSLf81avwgpSKrWz3+VYI=;
        b=l6Jz886FI5hM5n22PemThnBjv/vvlJ2rwvwKFqe3N0OfI6CbGpGx1Nf8yFGIVCo7JU
         Z06s6qKBBCGsugMONPrbdlC8JJ7CLX+qoC+h4wBTHve+nXQ+PysWqBAXypEQyS8h7T71
         u98V0K84EuZZeJCjY3vMHpiGannoa/inkQsKQrPbNMVAt6GURRD9C47GIX9DFmgcmQ7A
         BGfLI/JI7eZbrtFisCdrJm/M8cH1uiYCPIyWgSsLW7EPS+wok7SxnVwrDQMVCh/OctF5
         GrH4xYQsVRQURE76KNOQWMgn4xFzTfMlHEnNnqhAsm0KymaRzq45j7SQcmWbYz9CEB2j
         IdVw==
X-Forwarded-Encrypted: i=1; AJvYcCWAXzcn41IEYLXYiYy/POMTfZUdYflGXTWRR5cX4TqwTtZ7vyGldo877c8hbqsK/WYEZtXMslE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFVBY1LuLYrhGYDqVtk9wXZouzouO7UPj96M3/kFyyUbyivP1
	wljk943p6tLsmsU68M7u73/E0Vp2t7hqi/5dOojP5PBDxG3t7Cg6GRZzoP/L3kV223GOHNQG2vr
	7AJKwTY20rrH+pWXxjaG9dWik/VMuGd8pvLAhBMQD/RcvlCnB8po8SuZS/fo=
X-Gm-Gg: ASbGncsGTA1bEwYeYKvFFFB29AntF+bDqBPJBzei5sXPO8azad8Mvw9d/gbxLG3xabj
	wDpXWcs3kKYugKItIx6SGg9NOFFxA2LjizaOzd5lu2HLs9Se3q5k8xYL36oXGj13hDxgPj2lyAq
	o843jsHwUoLTyZUlqvgNQBT9ZEu6ZsIhEeiKs5P5aMpoQ13fZMiFLl7G6ioJruOw43OLsKjZ2CS
	2tu+UsU2QX/8wAiQ1A9P94ZJwvM0tK84lj8Lcj6FLY/Fqbmwc++S8MNwCYfx74vuvfnenzO32Vw
	HxPF2S6yzvTcOlDsoQTNGyjnOzdYf4iCsz0zmkpeJT9iDuDlbqU7X+qbhr3wjw==
X-Received: by 2002:a17:90b:3d89:b0:311:ffe8:20e2 with SMTP id 98e67ed59e1d1-312413f6036mr7124942a91.4.1748634737371;
        Fri, 30 May 2025 12:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Z+FIqczFKtKeO5xYxp46pRCGdTc+LvOtstwBKAV9Rw7VYl85NP/udPc4+d8q1IAOBOTiIQ==
X-Received: by 2002:a17:90b:3d89:b0:311:ffe8:20e2 with SMTP id 98e67ed59e1d1-312413f6036mr7124920a91.4.1748634736959;
        Fri, 30 May 2025 12:52:16 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e399b3bsm1570703a91.31.2025.05.30.12.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 12:52:16 -0700 (PDT)
Message-ID: <fe868840-5718-468b-8539-105362914e75@oss.qualcomm.com>
Date: Fri, 30 May 2025 13:52:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Fix warning in ivpu_gem_bo_free()
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Cc: lizhi.hou@amd.com, stable@vger.kernel.org
References: <20250528171220.513225-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250528171220.513225-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=683a0c72 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=xq6Wz9kLQhcqlbLk8JsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: hNkD4t_aK0nj5ir1sYRutneGQuFMW8ue
X-Proofpoint-GUID: hNkD4t_aK0nj5ir1sYRutneGQuFMW8ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE3NiBTYWx0ZWRfX1jyvSehU7es0
 yHAA+qI1ZaRKmqLMDvjWe4wQ1NoXrXwHl45IVbR5HKr1E+XplZSYNBG83pEdw4/qxdjQjgGpmoX
 EtN6s8V+te90+hxtBqGGyeknTD2ZWM/5US8QrspkbNmu5uVJ/mOLkVPX/uoj0S3jz2Gew29Fnxi
 WfA5r+cJZlstlDwH5vn8cnOqa3SBtYvtxJHeYT+U8ajCfrKP/OdiPev9B9P06OnHr4RwnyL8oC9
 /M+n2TnuEp3JMmscKGustqHmaKconBniRkVM0wdOjOkTYP9I+ceJ2cH0uNA0URvRtboAGCZc/Uk
 Mhzz01qMEs/2DzO/K5NUKuZYWmGFjE6/YeZvzR+CuILuPV9SUcu7IE/DMYZWKXl9z1ERXXOnFON
 uUQMZa9b2/FB4Mei/laZR3i6xp1DHnR1NbUCSbyEUJxB5lAzHF3HXwGWHUOW4Wi4xOPnEac8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_09,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=781 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300176

On 5/28/2025 11:12 AM, Jacek Lawrynowicz wrote:
> Don't WARN if imported buffers are in use in ivpu_gem_bo_free() as they
> can be indeed used in the original context/driver.
> 
> Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
> Cc: stable@vger.kernel.org # v6.3
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

