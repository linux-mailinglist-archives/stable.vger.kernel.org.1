Return-Path: <stable+bounces-219937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LEfBIhfoWmksQQAu9opvQ
	(envelope-from <stable+bounces-219937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:10:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D391B4F24
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56AF930ABF4F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918D3AEF2B;
	Fri, 27 Feb 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="APG4kawT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MRm8Fiba"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB9346E6A
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183306; cv=none; b=o6NH+hAcNycuh2kyKosL/25PA8fTqDaC3cBld71Xtu0Qf7Nr1svJJv8mjYVThejY7ceMK65vJkwmvfW8VjW/faKKoATQe6tVJM8M9PdoIMwKqcbxwtuWTuLWw4OSAhsr5jyWQXTHMGBDDMwNcqk9Q5ZjCFXtN4Ou0/C61WXUwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183306; c=relaxed/simple;
	bh=rmLR/Pedi1VzC81+2A9Zm2lyAKg0LpV1qkJq0RoPXMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlHnClslDDbZ3axwIVmfwnUpqjlSZSUr57Z15aiXOCebd12S5I/IsAJKzVUfn8f7layoY7UeiSoOGeDzo93FA305r3Md17U1CWA6f/RN8N0+oq8tigp5ETsfiC4/SIaFJEIfSfWsf7S6RXTGU92nrjqgedooWPbdMfFawiuQUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=APG4kawT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MRm8Fiba; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R7fTPM2308648
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 09:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hvb99L1Q0bbxUi8YbQtiYmhnZuG1GAtAwFPHS9tB7fY=; b=APG4kawTZWNM4l6F
	dGkvJjg+2OV5WtCZoNLXx2BP9LcP1JCMV+Ztx1bSyo57L+UT5WBqD8wBy9AydRxe
	DS7sWluxR5OEPna3WsXeB2wJn6ITuLTv5nXIv3G4JfPdx3Bef1uVOKceRZ1qb0Fq
	cCHzYcDWnvs0UeZTymXZHpaQJAPrFeNFbHU0TRo5lrTHPgZEPuHI4pwC9qbdwkYK
	87DtQScpZBQaRCuV259zpDi/P9hVW3T2rxsIiHwuSw5F64H8xJEzWtNQK/BwoacG
	L014Ybrf2Tajr71mIa/RjaY5eMiwXgJ15C5+gq7eY2U+gjWaDvFvDWdfdJv17bQf
	CfCkzg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q08s8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 09:08:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb0595def4so1744401385a.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 01:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772183303; x=1772788103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvb99L1Q0bbxUi8YbQtiYmhnZuG1GAtAwFPHS9tB7fY=;
        b=MRm8FibaHFb6Pazt1uGf0BT6TdOmAiHHK66mxGC2+lfR0CarPmLcjUScKHHVrsXF/f
         lAm8MU3LL93aX2+MK0/+G9RTomTAv+CgRdO5yNwy1dn4ag/q9gi3egFfcDr3T1f/C2e9
         8Y51ouaPIFRjXAq7XE0BCO3S/JCgrUJo4sWlyb5RrPwahXLafanc/gITVo7VxJ5f9DKl
         FH8/OMdYZqAziaPNFwen/h8vASD6EZ/h1/443UF24vOoMPGtT7fYpzWy/eoUqFJL9u7M
         ArI8TmMFPmhsJtxeHT0Q0k1VSxMCAuhfQSQx88i89IyG3t/G9ytdEGXmy83IvMwUppYD
         dPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772183303; x=1772788103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvb99L1Q0bbxUi8YbQtiYmhnZuG1GAtAwFPHS9tB7fY=;
        b=jNLAuj3yQyLfWkodHxAGNoTgBrh/rouepohf3NEQPMRvgq1qjNYU+MW2SrPGqU/Jc+
         nDb2vxuFRszSGFHZMC4om+H/HopMZHjVXme+75jk+YZcNme+i3kjDdN7mJBIUF0xtVeO
         7EXlnSAy6CT8cDXNGSOvgt7QI1xCswv4woULH5/34B6iFWkJA2iV503iuLEzmSBfSR/Q
         TUE/NSUN7z/VwXaMJFCrTC1omKkY3oKKptrHEJ5Ysrk9Q/r86TY0PP8EKV4C/bMdr2eH
         Zmx+JZUOUWlc63Ii4VonfmifdPyjAYcdpojZaVBPKkCTXxHsFx6KZaGhh4XTB9pqfbr5
         Wj5A==
X-Forwarded-Encrypted: i=1; AJvYcCWRsdyzm7TgNyzK+X5HS1yFcIt4ud71QDXGqLXkeQvjiruYfqz1YukQGu86PeGfLdS0aQMd2eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPrFzwwsGtN8w65F2Y2DCzGZH0TTzrMYkQS7SMvTsvxFl0hrP
	9vvPcMXExUW/rjv8q16i7FFSzRxqmswvFYaA1URvzk7uJB4Tt+KVcDORsPlzd6vXhdIiJOmCjS5
	g4APcGFTTxoF01ZPp8L3Exioe8Gcbz3NyiVgRApGFYlbGbBt2Dv7PfcIlXS3b2DkpTtg=
X-Gm-Gg: ATEYQzwrW8ULh4wylxTLHxmB+DmGcybwVog15MQkCABqzYKDEydaLsaqRUPjQ8An9+L
	6ulg9bKfGwJzrH3QwgAp0I+BL3A9PX3ShGi3amEcvYkrgDcxYzB4HYHs2rc/Hlcqa4FkRRa0YE3
	1UgWHmprDoGScN4wU2lxgsDKSC8J+VcZfzYnTfsecBPjl6NDZmeFdICTu6umw7WKfK6dYD7jwoS
	on+H/Lg9PfzMHb76dQ1jzL57sguUShAq9TYIKgS0jg0QJWE7EbB/efxeD1+JJztPnxdLOdsP/Y2
	suv31KAdc7efJWdotnaXljDxv4iMOryVxAy0rT5shyr5gUdyFu8S+L91nEiIPBjJOyjn165n1zF
	tGCZjL7RAWRIejhxvaAWlq40FK2UHVwDKpVK1Y7YuwQZO1G3I/rU=
X-Received: by 2002:a05:620a:254e:b0:8c8:e139:b08e with SMTP id af79cd13be357-8cbbf3f3792mr693890285a.33.1772183303240;
        Fri, 27 Feb 2026 01:08:23 -0800 (PST)
X-Received: by 2002:a05:620a:254e:b0:8c8:e139:b08e with SMTP id af79cd13be357-8cbbf3f3792mr693887585a.33.1772183302764;
        Fri, 27 Feb 2026 01:08:22 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8bcf:177b:d085:ed57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c763e78sm5640945f8f.26.2026.02.27.01.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 01:08:22 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()
Date: Fri, 27 Feb 2026 10:08:19 +0100
Message-ID: <177218313069.8853.3389428325341696673.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205092840.2574840-1-tzungbi@kernel.org>
References: <20260205092840.2574840-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OCBTYWx0ZWRfXyAGtpCPEynoA
 emz+RFioIpgw9vLwAXGQibjPzvrGvMnzVmtsjkW/bfsZRF56ONffeeHlBvBqRAryMqt8Pspd0cU
 dBEq8Pnaz17of9YH3E/Whi4VMOKB2OgflgXbkx+ATLhai+tqSrjcyroilYNnaELpzwyzaMHOrj1
 5jFoky0iEkswO0ayfSst/J+z+TBRgWv+LUZOzgFL0Y7aLrageQwLZW2sRKfuNoEZhRuKAp5JBoJ
 8J+lafGJm1lNO4+c2JFBdHNahpuLBYTZkYgQJTgFKjbKYBkqX15cBqEg7QhGmimf+M84Nb8N8qw
 T0+Ml1Yt1MLbiE4iPOTLu9WfdZJE/YsOKkpDPMjstcLv8/JoyzPmdF/piHrkz3101PRHSkemLEb
 Sq7rn1Kq4Et6ftNpDCTAS2B3Pu/ojktuheq+rI/VAR0l/d092Siorzzpqx5xu8R/5msqIjIAKHs
 PTF+WNxLV/Z/e/FeFPw==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a15f07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qoPWTQsIWzZwHgpNMdEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: hWvrgKAOaZQqbVLcmXxmwwSjOxfD_n-V
X-Proofpoint-GUID: hWvrgKAOaZQqbVLcmXxmwwSjOxfD_n-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219937-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62D391B4F24
X-Rspamd-Action: no action


On Thu, 05 Feb 2026 09:28:40 +0000, Tzung-Bi Shih wrote:
> Since commit aab5c6f20023 ("gpio: set device type for GPIO chips"),
> `gdev->dev.release` is unset.  As a result, the reference count to
> `gdev->dev` isn't dropped on the error handling paths.
> 
> Drop the reference on errors.
> 
> Also reorder the instructions to make the error handling simpler.
> Now gpiochip_add_data_with_key() roughly looks like:
> 
> [...]

Hi Tzung-Bi!

For now I queued this for v7.1. I want it to spend some time in linux-next as
I think it's a high-risk change. However, I preemptively put it into an
immutable branch - if all is good for three weeks or so, I'll send it upstream
for v7.0.

I see you added a Fixes tag dating back to 2024 and Cc'ed stable. I'm afraid
this change will not apply very far back, do you plan to backport it all the
way to v6.8?

[1/1] gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()
      https://git.kernel.org/brgl/c/16fdabe143fce2cbf89139677728e17e21b46c28

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

