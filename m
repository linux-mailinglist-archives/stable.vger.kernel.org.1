Return-Path: <stable+bounces-237733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKEXC6ri3WnrkgkAu9opvQ
	(envelope-from <stable+bounces-237733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:46:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D33F6329
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16119300F97A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECA36DA1F;
	Tue, 14 Apr 2026 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mpVvfKuh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gBZO+ndt"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6036E48B
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149001; cv=none; b=uZbFNfE4rWXcSr1qiqOtAHYTyr6WJVA+bQOTxkF46pQnRUz+Is0z8Eemjxvan2SXyvswgwjpC0aTpDRpVuNjH/SsgtHaz2eakQOrQANBq1LY0ygCZjsULVXQbBupLwc3D9qhiCJrK4aMWlPSMGed7brbYdDFktPxkC5x9s4m9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149001; c=relaxed/simple;
	bh=qGYM0IN/IE6gIXEcNZAdzWaCFRZ9g7FY1bYZKtfP26w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YL/gWr3NFmZhEb/Y4zHNd4uO0uUxittIWOLZdLu0vuTL5QLZJWpxz0BB7iF61UyhXyGznOMj7WXBUgliKEO3SDmcy10ZS22cwjsiomisrOwq9gidH3MCSc3iBJHxaHq6lKCu5IERkwNu+d+Z5csqItC82PglZIm7RrVI79tJoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mpVvfKuh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gBZO+ndt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCau5967261
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooS24x9VLICMx3FC4zHZJS9uTNKsD8j0SzaYRsjwM84=; b=mpVvfKuhiMoV1xr+
	gyS2yoqIG5S8QlXYoSHSQPuKMSieUydQ3HMx6rZe3j86+4wxHNKjK7MYGkr2VuKg
	JImjLBEVO2vdJP3WlvOhp+QLQcJmegAyBasWFUsCnoupY/xSBr6YSGnRKba9QwSM
	AMra+lGsYunteNB3/SeN+g9PseX2u79cV1ZcXq79zLfTbBrQL3it6rKqbTwUzPUD
	nC71v7qzg1rBg9B+ZxOK9vqFRTQ1m+VDQXHXt/T2NMq3mzLkkDLkWAxTkEEg97wG
	eHi41YrOcBZBj6ZDXX52fwwFUhfihnO7XHl7gcRrl7kUuW6B6Vj3qTBqLOHI51wG
	ULqnSg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86v1c07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:43:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24e9b4d82so42697485ad.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776148998; x=1776753798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooS24x9VLICMx3FC4zHZJS9uTNKsD8j0SzaYRsjwM84=;
        b=gBZO+ndtUgIab1shgPCi0DlY/gzJLz/ikA0V/ih6zT8W8f2recxHaLh1wKry32u5FK
         4Am9vGEGJLSL7JCbUuzOWW6AhNppT/s2z9jklIROVmGC8ysOBCB38Oj7VGrc7LU9yIYY
         SKvNX8ZTZwgRJTR6LaD97YFLcjNYB18q3o9ULei5QM4Z3x2Bs9bQGkVTRBwG8tTXObEA
         gVu3d8K6VBp+Qd1ocTXXiRYlZkKhSpKFsNdgdJUt9Qc3n0RWagjiUn75IOJO0IUBsHnm
         CrZ48+MGw+KVcmaW4dft9hZD9P61M+OOKAmmnGo4EeZZrPBmKuIcvgFhkMfe1jEfZApf
         0dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148998; x=1776753798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooS24x9VLICMx3FC4zHZJS9uTNKsD8j0SzaYRsjwM84=;
        b=pnUyvzsxB19ZTUlKsSYVOsb242Vi19faYy//WWIRmf6uZHDXQrVjBabMOEUvvvbpax
         JgrcRWwPR5uSY/TbDqtplr4szQsyqORlHfak9CWpN6EB1JDs4qMPRWGaHawnclQnzqLl
         AJ7wyNPv4Q/FIODUBTmit3YO5ocMPVlufRtxr0xPPt57c3kuGGVuFIqRXXSvyqza4H2+
         uAy+a4O9q3zRzcchFqUGOX8BSb/mzkAhLFPki1M3xW9TuO3RCIvmEfae5+Z99/cPJeu+
         kOomRDrgAhtxxHlggvrHAgkazsoFYyFg22teexr2AJbJNc1judt8jo1/585QsJLnCUii
         csMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sbIMqp+VJsbfJa1pc+BQB5IY+A9ydtM4M7he9lwlbiDd0DjEqhtwe4RA1HtK7EFay4N/4f1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipMxoc4jelqn0JgRXyr9vWdhHkf+W2pE1/U1hG9s+l7Az+4j9
	KP4Ft8dKuzlLiyu1chKpivmACvjVfkuEbtAHUrlAG8GJ7a8pBTXeA20T6YwkvcKMPmMsHXg43gU
	GcKG+tcNF3EMV6eBNvytErUuSsEw8Dxtuae4bsQQjeAL+Iirs4OVIyof3AXQ=
X-Gm-Gg: AeBDietlv8FQ2Si8J7QqKnyLJugua20xcORjlUwjuOAqUQf2nkXgMbItb4TfQY5BHSj
	1tIPlB/tU7NSlRfnTnMCm8B/ptALt3WiqY+UaNUpckmJdKci0LgSbSeEYV6L+DHEUESF7LLJpqt
	VutDX+g1qYrtvkmmtoscqtN/8jntV9rL4+Am+qhpFFv845G+wPnJLuZtX59A0GBfipnLsKHn8tp
	23u5Cq14dZHH4OuH2fmCMSa53t4c1MY0H0mwib1xOXYyskmbnMvIuyfh2WT7g0A6OAHPBxhNLw9
	PBzRvlm2RpqOQ52BqIki4OeQ5vnkPVMwb0APbme3kl3WKG1YDQ5a2CpF7wVAMGwcRhtWPAExE/S
	XxZK6dU+J5C1XKBkq0Bg8Ov1k9uwGPCvkqMlEO613zgWmuDLaa3iLrEUCuvcFYe+qvr9oXx+V77
	MTso9EB97JIUsaSD6BJQqCGu43Z4Ks5A==
X-Received: by 2002:a05:6a21:328e:b0:39b:897c:6f84 with SMTP id adf61e73a8af0-39fe440ebb3mr15043050637.2.1776148998327;
        Mon, 13 Apr 2026 23:43:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:328e:b0:39b:897c:6f84 with SMTP id adf61e73a8af0-39fe440ebb3mr15043028637.2.1776148997793;
        Mon, 13 Apr 2026 23:43:17 -0700 (PDT)
Received: from [10.133.33.118] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1d0d2sm10359483a12.27.2026.04.13.23.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:43:17 -0700 (PDT)
Message-ID: <ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 14:43:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: Kyle Farnung <kfarnung@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
 <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
 <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA2MSBTYWx0ZWRfX3+04gNBwgw1+
 2IBW/CONs8z3rQE+PJ672Zxg8O2Sd9UDrlFs4T0C6Z6q5u5KkVSvqY8dTWX7OmwMyx3D+Z6Xen2
 dqKDXTl5EKZEDd16KXzJzZQWME/rFk5knHlQi86bUHF3F7eiaKGx5G1uJBaNm6QtHs69zYllOlN
 ckW39xGpfTNnsiDSBiBLNrYzrPmYxZoxmuHR5zsXdkbSxI4RqkKy585SGGI8cmDIT+l5qehvtJ+
 0bOHTwa8TshpUjI2T4TK9nklq9BSYQCvNibNxj/NgKfxe4AdjEUD8bBzWsCwc5wNHSnCLd/GiMg
 9LigHNjFnpHDyXFhHrbPUKoRtPeDTVVBfll6VXnN+pCl98DFH+yazWY/joZefSOm+BgPRiPlNvG
 oO94TXR8VMzAaaT+XBqlXetucV7T8rwz1ZsuFnrFpitCQMGrTPkJYvUygETabxcJ205cGM4XSAC
 VcI2Tin/BHtbWTBtzIw==
X-Proofpoint-ORIG-GUID: FmMyEmbxIHLDTZT4EMxr2TdjqKcC9Tp8
X-Authority-Analysis: v=2.4 cv=Iowutr/g c=1 sm=1 tr=0 ts=69dde207 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=8k6WQxmsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=4Wa1Ze30II_mXCYJOSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: FmMyEmbxIHLDTZT4EMxr2TdjqKcC9Tp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140061
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-237733-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lenovo.com:url];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 685D33F6329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 11:48 AM, Kyle Farnung wrote:
> On Tue, Mar 31, 2026 at 7:08 PM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
>>> From: Kyle Farnung <kfarnung@gmail.com>
>>>
>>> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
>>> reliability issues similar to those reported in [1]. These platforms
>>
>> how similar it is? can you describe the issue in details?
> 
> The issue is that intermittently after suspend my WiFi adapter connects
> successfully for a few minutes and then drops. It will then keep trying to
> reconnect in a loop but never succeed. A reboot will fix it, but eventually
> I found that reloading the module also resolves the issue
> (modprobe -r ath11k_pci && modprobe ath11k_pci). Based on some searching, I
> did try adding "ath11k_pci.disable_idle_ps=1" to my kernel arguments. At
> first it looked like maybe it worked, but then I hit the same problem
> again. At that point I decided to try building a custom module with the
> ATH11K_PM_WOW override and so far I'm two days and 10 suspends in without
> issue.
> 
> Looking through kernel logs, the issue appears to have started with kernel
> version 6.17.4. It looks like my Fedora install jumped from 6.16.10 to
> 6.17.4 on October 22, 2025 and I started seeing the issue two days later.
> 
> Here are the logs from the most recent occurrence (filtered for brevity):
> 
> Mar 29 15:26:24 kjfp14sg5 kernel: PM: suspend exit
> Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: chip_id
> 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: fw_version
> 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
> Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
> Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
> Mar 29 15:26:35 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-CONNECTED - Connection to 68:d7:9a:2a:94:f8 completed [id=0
> id_str=]
> Mar 29 15:26:49 kjfp14sg5 wpa_supplicant[2373]: wlp2s0: CTRL-EVENT-BEACON-LOSS

this is the reason to your disconnection

> Mar 29 15:26:55 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: failed to
> flush transmit queue, data pkts pending 9
> Mar 29 15:26:55 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=68:d7:9a:2a:94:f8 reason=4
> locally_generated=1
> Mar 29 15:27:00 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=80:2a:a8:98:26:3e reason=6
> Mar 29 15:27:05 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=74:ac:b9:df:54:36 reason=6
> Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=68:d7:9a:2a:94:f8 reason=2
> Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Batman" auth_failures=1
> duration=10 reason=CONN_FAILED

and the bssid is disabled so association to this AP won't happen in a period.

Anyway, although it works, using the PM quirk seems not the right fix. As you mentioned it
seems like a regression starting to show in 6.17.4, can you do regression test to locate
the issue commit?

> 
>>
>>> were not previously included in the ath11k PM quirk table.
>>>
>>> Add DMI matches for product IDs 21ME and 21MF to apply the existing
>>> ATH11K_PM_WOW override, improving suspend/resume behavior on these
>>> systems.
>>>
>>> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
>>>
>>> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Fix missing mailing list recipients (linux-wireless, ath11k, linux-kernel)
>>> - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com
>>> ---
>>>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c93d9ef692d127fe 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>>>                       DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
>>>               },
>>>       },
>>> +     {
>>> +             .driver_data = (void *)ATH11K_PM_WOW,
>>> +             .matches = { /* P14s G5 AMD #1 */
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
>>> +             },
>>> +     },
>>> +     {
>>> +             .driver_data = (void *)ATH11K_PM_WOW,
>>> +             .matches = { /* P14s G5 AMD #2 */
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
>>> +             },
>>> +     },
>>>       {}
>>>  };
>>>
>>>
>>> ---
>>> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
>>> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
>>>
>>> Best regards,
>>


