Return-Path: <stable+bounces-223853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFlaBFvwr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B18249448
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C814430CCC36
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A113C3BF4;
	Tue, 10 Mar 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jK3TxLBq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hJbxCyWZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007F37187F
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138005; cv=none; b=JOaoOEUZ75FzCm/LgpZfRONoAPJvZBvfJNsXFFE6T0hWNXhLhXJW9/oi+LbCVc+M8sego3/WvzIz4+N+kerliQ4Pfa/tEJAFIgXt1Frvz21HnfnqYJ+iauuA16XvBjp96xqHbkg+2Bh63BO0zRy8N21rlDgA0B7xb3czpRYsCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138005; c=relaxed/simple;
	bh=lxucRPLGFP2tL95+5ul03k27TMgtuEPJHmZZz0al1dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbhi6EnqMfb2wQQQBgjBJOMUAi5GRh6xF9BtXaQ4wFZkZ41aFsfNnNZHMAV+LeN+OB3WFwoAZA/D1Nb/BCZVxksoa2HphphU/d33WxmXHxPAn/rPGd/BUTSHz9Nd5B6WSYMxZS9UDtmX3l/iOgaD/gOmNRfSCmhf6gAwmDE5CQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jK3TxLBq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hJbxCyWZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A5lIPN568748
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xK7UBllLwsfyVBP7rppLjdLPdGs5UskxvKVTbdCf2Dw=; b=jK3TxLBqNiVnhojq
	BYI4lXL+fDKJ+eSbOgxpC/4BE3pXldjTCxwIZRSilZnDyb/+oaYyuuoVZF/M4sJh
	RTN+eWzmSTC73QEcWkcULkx3ldhLciG82+ZnV9yK0xZRXNYRcxY604aKBIKYdahu
	tC2bq+MvLgjG7tKXNBxrx/ZAFXtMoAOfbyzXNCQ0TqKsWgTkz1h1155Zlh7TCCMU
	PqarthxWOmwcM4GtnNGKC1fA4jbeS8O8pIG/oLbF69fyYEgpMRaO2A0Vt+mB1lxn
	s/hyZus/zYTfo7NcJTCtEjlinmpNoEqfpwvh7Q1r+5/IkQC2LIm4EJYNJOQUoEW0
	n9fSVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctdf8gyhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:20:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so1895626285a.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773138002; x=1773742802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xK7UBllLwsfyVBP7rppLjdLPdGs5UskxvKVTbdCf2Dw=;
        b=hJbxCyWZICa2M2JKkg1zokWupRXPwl/ooNyTLZolEXRLpX+aVDWZSrlHsTeCeKe7SC
         Ioqkqd2gYZOUYcY8pPnnnpVG0HVfat3cr0yMyxO3LJIgLexm22c+r3yD+l2cUm6HUcot
         iY2TF8hzRcaytR8JgglzekXxqxREKy+QKIYjps6W55EyXTkzRrM52cWoKccfFALnuagL
         YDyOC2tKSzKYIg0NIfgTkycOb5W5P74ipx0DqLA6IytyXL7B+L6Rem/6kmYsG82Ms8x2
         ew62FjR3yQAZvlTaHKEJLlUZmKudBNeW0oqkvmkEVdJae7uyehIR6cMXfh6byuNWCyLy
         TxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138002; x=1773742802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xK7UBllLwsfyVBP7rppLjdLPdGs5UskxvKVTbdCf2Dw=;
        b=IGiCeV4kRUSVNBIj569avRwdhnu83VhVQyFTnh4a2q7e1F0FSZWZfjxpzJy8xLzkYT
         JQdi2xPdNkB9bkLZ2UK0y4TW41Bk/VvsVRe/rUJPvtD5OPX9xDzcz8j2Gn3uL0Lc0ikL
         htdL6U3Kk8fZqKKVHz2JaIQfqQDBm91bftwgC14b/Xz9jGVBqRirvUwk3MZOei2NMsv8
         z78i6bvkuj9yWV7gKhYI6S8a7rUusTKA7cKkMx7FTpEm8hFrDs0S/MD3HNQ4cIkgruuY
         nWaQAG9Gq4LXS/I8hVrobaAYYT5a+06nQB0rxeywRMD14BjS69VKJaTJRqiw9fXZFsjl
         H4DQ==
X-Gm-Message-State: AOJu0YwHlIFM3SeYGeh0HK2a8IbwQ+hT8zcebRuG4usksLVSfMqahwph
	4CvZ+YsAsFU/vQpAmNc/dGEClfh/y6u0tKBeqPETf6YJNlfvzU8+Zpl97ZsqL970IKSOuBRutIh
	YPzyTvcMvjSM7Xhufh6+3u2TGDFk4zYQFM/0KrN5tvGcBhq21Hx8wmFNGHcU=
X-Gm-Gg: ATEYQzyYbhsHMKC3v09yLV4Vti/kz3wi3uoZmxW+vF4DKiMtsVx7Qt2D8OSXcEI6MTE
	eBdbyC4vn45s9WKEAdiuAuc8XTEAShjgxFsVNO1LcbkzRsyDkRdlKK2OLFZgHgWJlgycg2ztTKZ
	dzdsauJ8MQ1QT3hB7F8KCWmpz3jpBHHZR/lTHrLG9cXhg4D4W7Q4jB0YZbcWwPVlmw3RsOX17tZ
	iduJmZAFiQA6sblXr7k2/lR9Reo7MxCl/wX00Wb8TGTAduwInfwMEU4kresYPZlWOownY5DdhlT
	G5mnR1kcVOFS03K5vbxRz7G+AK1Oj8QkqjmQFo5UToOLWJVZQY01wiRjCvYnZR2wNopPfNXKFpL
	HCOKQX0ZFIFTZkmh1WPVdrKqq2EcBNSHf1cZZUkbWlJRO8hM0YF3gNDIRmDAZzBgvywqAlNr5Bd
	GG9cyVS6ld
X-Received: by 2002:a05:620a:480c:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cd6d389730mr1713761985a.28.1773138002337;
        Tue, 10 Mar 2026 03:20:02 -0700 (PDT)
X-Received: by 2002:a05:620a:480c:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cd6d389730mr1713759585a.28.1773138001935;
        Tue, 10 Mar 2026 03:20:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad977f8sm34581699f8f.9.2026.03.10.03.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:20:01 -0700 (PDT)
Message-ID: <1e64069f-e677-436c-ad62-0f3f26f01cc6@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:20:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] thermal: sprd: Fix temperature clamping in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Freeman Liu <freeman.liu@unisoc.com>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260307102422.306055-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260307102422.306055-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4OCBTYWx0ZWRfX0LfS1BVc1d0U
 A1Vua2fU3MjBGzM2osOIDXKZeV/1U3yagtoByEnFcn7TSbFZNdeHJcVs/P0edAFXhHn0aze14Kb
 I0pG7GFs5tV2ahnHUrDYpoINhyrSMc0aDz0b5UHGDkm9Je4Z2kwybhBbWpv0QkoorYUOI54WZME
 hbmODD1bVB7W+dvTRzOro2eEH9i1lcwrRHYyCl0vXMUQltC/m/9AA3QfRAQRF1RelzZ6ErP71O+
 zJDcvK65D+etITtpm91LUer88bCcdhSTbI+D73O5/9dRsR9QrtuiFoX+GZyPkOZRwYEcw0xkxy7
 MGDuCoMNvTbwNa4R6S6rM1+Z8tH5nlfWbHlKYUKJWhRlvXTrsJnzeAgnPeoyNX7KdJQcSTqP9AK
 x88NIrkVObdHoRLo9pt6WHD+kVTCtUu9XnLaY32op4tFwdKbbA6faEvKW7FqE0+z/EShjcrQL2q
 F5GV3ML4NMjnGc4oocg==
X-Proofpoint-ORIG-GUID: 5t5QEr2QLX7oPN_LWmkubzkkyop-BHWo
X-Proofpoint-GUID: 5t5QEr2QLX7oPN_LWmkubzkkyop-BHWo
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=69aff052 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=l4XDqvM-JdByRFu37KQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100088
X-Rspamd-Queue-Id: 68B18249448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223853-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,alibaba.com:email,linux.dev:email];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,intel.com,arm.com,gmail.com,linux.alibaba.com,unisoc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/7/26 11:24, Thorsten Blum wrote:
> The temperature was never clamped to SPRD_THM_TEMP_LOW or
> SPRD_THM_TEMP_HIGH because the return value of clamp() was not used. Fix
> this by assigning the clamped value to 'temp'.
> 
> Casting SPRD_THM_TEMP_LOW and SPRD_THM_TEMP_HIGH to int is also
> redundant and can be removed.
> 
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Applied, thanks !

