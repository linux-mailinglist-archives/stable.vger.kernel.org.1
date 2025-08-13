Return-Path: <stable+bounces-169352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828F9B244C7
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B4C3AF108
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5D2EA173;
	Wed, 13 Aug 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWWmUR0L"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257552D5C7A
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075432; cv=none; b=Xtr7COJ3SOfghEK4uE51brl9jGjgwXwU7VVui24Bic4eF/yJMu0aAO390PRtC3U4NcxY8KqdWjIh/4nqE6J+AuQh+qq2J57AB0SLpf9FJh7Qw8bbcS5T2m0F2RNcE0iPxvd/cLqZ7XB6ysL67qXdT0/dzc0Drrxro49YvQATzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075432; c=relaxed/simple;
	bh=83w7pj4FfXqNxu+ZrGUToQWKRscr0yX0oGMlOlS6y20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLfjXLnQCFfo3o1fkcfuKUK2h/Zd9jW6QrrnWVatSNiGMF+THCrPc970C2ixGdZQaYeqJZs4xE3Vzpp3w0jhqn2ngXX3yTMiRpssE7oIko5p8P3z1sIp88yv8rEq93/U1/60Ze/N6E8coUimEIZYDAoV8rAJQ2OX4aLkdFTks7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWWmUR0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mJUm008724
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZlgaL045z+2LDRggZ/H4bQjLQbfz/Os1B7uL1iTg22g=; b=LWWmUR0LFOGDFV3V
	cq7RT7HISdg21hlxzA8xfDyNuf97rsdLF+4CQmSNS6l/bvfTQVcOMx6JmFGpoFXq
	FFhCpOjXYGtLAwEvZ1rDxArR4zxqKU31iJ5aU5XvJtyfo+SYSU07uKill4WYyZNz
	kI0lexpWl9wzUZc12VsEB5U7nN138BBjYTu7I0I+repf6uXxszHsYSuYWlPPwwlo
	cb9LEl9SeohL1U/ePGEPv7cMlyZ8E1+gzkaRQmuyk1tW8IsV2uTDosaOpWI/hDgR
	h4hVBhoe1hzrrcIt48yHgrCkdgOyz2w0X0kadprXiuq1/M0x/cZYZFLnKHYpdBWr
	CclwJQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4f41u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:57:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-709f3398a0dso61836d6.2
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 01:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755075428; x=1755680228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgaL045z+2LDRggZ/H4bQjLQbfz/Os1B7uL1iTg22g=;
        b=cbeRyaYQnJd8qCRpcZE/Ny44eZsXcX5MB3Y5HfvyAkY+VdhN2f9ZlSJ6rD9ZJAGSTC
         KiC8n0egF3d9okU/L8BhTi9Jj74flf0ak4zQheQ3KPsNccSSHrFtAoZBvtBz9OZaIw4h
         6wGFPdsvAty5oUh6/RWLbzsMtp88jGg/tdgyW9a4FIjkA0Mrmx+kNJdEGtnXIUhFKt+3
         zEBOT7YlRcCcvXX0epbY+1HZqTghgq6DnCTgl1c6ArsaZFpnW1NtP6XtIXtUqWjWsKPN
         1owe6qLCgv1bmW1/yKG79YjSQXoLYAa/4ZNbSTcZ9iy+gWJQXIxFl3q+bM19hlHi1hVc
         w4rg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/KQnU7GqqsNDgeM9A7oy+Mu+Jack9vOFtocu+6A7M6m7fNjO4Z9+oCBlfripmM68Oxs4PI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdZX3O9WXyzICgmcwj5VPt9ky0NRDutDdngj+EBbHgnSHOMjy
	lZ2PoXa4wWvTOq3uBa6tX/uuE1IgLH6VjVdXMD4A+VmoCo+YABRhUd7h7sg7kZbqVCK+eMsgoXp
	sV35mZwja7RHqXoWwZC+uGnEF8IatdhNeUUmlcrYfDTW8G2E15Z3U8QWX85g=
X-Gm-Gg: ASbGncsaCqGDSJEDVdBn1epQv3OwyUc2EyZnjVW7NPEBIXYf1Ln9bWfGuEibXAB9irE
	+bMnHCprdjYgu7jD3BZ1Gcuko4zBlpJ0geVDV1X4my1Ee1MtO5ubWm/fMO+AGV7WAw+JEGmfrW9
	qHOMTIxoJWF7d2uUpB5Usn7fq+iQfTqC7/w+spPpmcij8Tbc78ONHf6BQ4EajXXIgWyt4KzyUNm
	/v49g0eMOGDkZB+4NVsGpwWgVRJ+mJ2vla7ztuwHQM9McUK3LNSIAgClp/kiUTw/KOPxD+6XmcO
	er1JUkwVEGcdcHbMb0Ec0VsQFlUaCE8k+0FijBATiy7jy3K1zqSLmWdJvbytDL4Kv+EZnmOOaDs
	OSNK/wkzbwqkHyb+Jjg==
X-Received: by 2002:a05:6214:262d:b0:707:5f89:c024 with SMTP id 6a1803df08f44-709e89bbcf9mr11265546d6.8.1755075428089;
        Wed, 13 Aug 2025 01:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQjApPYi0wKEKWmlApDg2/wrAZ/m5OBdcXLYtze/08Go6Liq7J6MIRjVz4X81xbMj0W96/1Q==
X-Received: by 2002:a05:6214:262d:b0:707:5f89:c024 with SMTP id 6a1803df08f44-709e89bbcf9mr11265446d6.8.1755075427501;
        Wed, 13 Aug 2025 01:57:07 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f00252sm21420703a12.8.2025.08.13.01.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:57:06 -0700 (PDT)
Message-ID: <debdb50b-1979-40ad-a135-c6f65d48b322@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 10:57:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 093/480] interconnect: qcom: qcs615: Drop IP0
 interconnects
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250812174357.281828096@linuxfoundation.org>
 <20250812174401.294534062@linuxfoundation.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812174401.294534062@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 18D8YzJGQXLqwpnROKByt0xDY_mjyUXg
X-Proofpoint-ORIG-GUID: 18D8YzJGQXLqwpnROKByt0xDY_mjyUXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX8HMMQcf1KdsY
 1JL4DM8z890mxrsprLRkoNy89xcntwZOHl7FedlgSmGW6U96cZjEe0upB6rPMwfr6gZzefrtNOc
 IGv4aYQToKPcO+wbiIqhNOqtcOte9ql9eru1wjsGhEHWq8zoIx7uPRhSAnx91UTK5DcGmV2ppd1
 UxkpHIOujqLpQu/uPJagZStCyGbX5E93iKoHrC0Ob4vGahLVjdJ4tF+DbIOe6g8J8ydsnp4VhlY
 0UAOZy6g63ind+sxJEQ/2ELzSntbWkA4vXFkL4z2/CwDtT2AuMb2ldcwayOFfveUHAngsLoaMWE
 h+wze7FzPem+sOn5+nLYg588kN8sAgiVO36G8IPckgACRvwwYb3gDp+lZhv6ENcbB51eR4x4QWg
 G8qCYra1
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689c5365 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Lh6LkGG3E_lky4PZl18A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/12/25 7:45 PM, Greg Kroah-Hartman wrote:
> 6.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> [ Upstream commit cbabc73e85be9e706a5051c9416de4a8d391cf57 ]
> 
> In the same spirit as e.g. Commit b136d257ee0b ("interconnect: qcom:
> sc8280xp: Drop IP0 interconnects"), drop the resources that should be
> taken care of through the clk-rpmh driver.
> 
> Fixes: 77d79677b04b ("interconnect: qcom: add QCS615 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20250627-topic-qcs615_icc_ipa-v1-2-dc47596cde69@oss.qualcomm.com
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Please drop, this has cross-dependencies and even if we applied
all of them, the series had no visible impact

Konrad

