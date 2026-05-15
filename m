Return-Path: <stable+bounces-247467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLNkB6nPBmqAoAIAu9opvQ
	(envelope-from <stable+bounces-247467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:47:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A38254ACD5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D0D3016ED5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA33EF667;
	Fri, 15 May 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1H2e7/Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azro191K"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B43ED5B5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831015; cv=none; b=ffxs0IR22lNW+XE375qz0httMR2lKrEMZe96kXis4kroU3kVVlL7QnAtxalZXrgnp9GoQlMnm/KhsO2b4/PvsaK02PFWYHs4pi8el1bkw3K5DWEOUgYI8Y2JuWL6ylcHCx+CUWcGOhJ8lZOH/tAdJbZwY+qsN9SjE5HJVr4s+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831015; c=relaxed/simple;
	bh=+4ePIhu3O40dHWjlCdwyhUEUNi1zHfIgpYolXR3DEio=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KDGoWRWM5y97RMGzA0OiR0h/CsUnzJd0MMmai6x6ryy3yRmEGzk6qb0bYKk6d/bWfk5EW0ScrHXzhfsZeOgDV3CYNtTInoA8STF+6VHCtt8tYKEexrfnbskY4VLX73XwdgwnWHuNNFqt0E25kVWvyqMnRtC7eQP6WrvMi1IutgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1H2e7/Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azro191K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5DK7E2678563
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Z7LPMBLyHHjy4yfGUUaKmg4n9iqRPbm6MK5swWzLHA=; b=N1H2e7/QC46tHRD3
	i1B48ip1E/cj+Z9QoyCDebJgoBkH1zNCXClrOju29al0KbywunZp+ckWbhL7rVSV
	IoAvOGwT+4jS5POzf953rQZZqCimZb1YtyX/KZ9fm5o23jakW+sTB5YXp27EYrWm
	nb20YVfSCmj5HWYII2G/XpVHiLFn7gWDbY08A4+J0FD73edPqm/ymuIxuhh60dxx
	88ucnnFDssHDNRVmBgS7KXTNuPmxZWeXJ81x+hOEIIauGNAZP+Nt/OrmMVpOHWjJ
	0i2xqPmEGbrz8icV5G5p2XzCIH5H7/ZIsg3mUvQK+qPcOTeVbkL5K/o5xmrWJ4j6
	iNF1YA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vt7hj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:43:33 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6314220f28eso12110270137.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778831012; x=1779435812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Z7LPMBLyHHjy4yfGUUaKmg4n9iqRPbm6MK5swWzLHA=;
        b=azro191KDfIaQm0EmsJsrxZjXeAhyomnTxVYP/1k1k39Y7p8QTdNz5HFnBAfLXQIn8
         Zz4BHzQepMGos2wpudZENR3RIQJpV08MxbbxX3OGgPh73BRkJWNjNi3nl5RnsHMKW1BS
         RVA/1Twqmq8qf0DFXIOQHbOG8SrPwxpPW9quJhz2HQ48PInUxAxRq2tvmUYqBKezAXnH
         I06VTSYloio36Dtwh71BRIznWqJAapR8PdqP1qbuQ9xZ9+8t+pSVQAYWbvsTCn+RIdJF
         RCVrZn/UpyY5+jWH+WyU0STGQcLvCQctfQGRsxbDZm2opyAWOo86w8+I09Xg/IGfzBoF
         RjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831012; x=1779435812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z7LPMBLyHHjy4yfGUUaKmg4n9iqRPbm6MK5swWzLHA=;
        b=qgE24RhazE0xvVkeMG+480eLto0CuHDuxNtM05IXQrj1LSDkIHUWXgNW6lCWOfC2vD
         OUe1WueC8Wr8fsPtflqAVBtEmDOcnJJCV2PeG/AjwtO4/dlapMN5YbXHZlQ6D5kZCwcK
         v4DAytyR1TFWsAEkTzSXoPCk/vuAJe8LUtz8SdqxRCMT3eaaTStcC4n6nlCPqtMeRdYI
         VDoOZcw0mtE+XCrjGrFHhq/JZer11pmzp47XNT4tl4ec8Xu2+WuXjpoX91SFTXSi5yNf
         dDYE3xJUND6OVBqjuRgGSFTfzC0OyiyqEFfUx+tYz2H2VawKYqeGSgwlUi7KMiRwRcNw
         4S6w==
X-Forwarded-Encrypted: i=1; AFNElJ+8OOg9aeAZuplWd8yAoTCS2BHD41GPYRxMBiM+LX35hdutM6R9blL45hjLMZhc+CbwKwI0bqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz379kcrWyKVRwzKvOkph9dJ/LDiwUNYHOCAuVPbWbgOQJbqhwI
	GVgNVujQfTHDnwc830zFLYGKtoBm2ARDNmwoUqE+DDvD97Ybc5OK6uRfiMga+dfMVvpsKRwuDBg
	OeKrFUA862N3NehjfZYIrwHYFUc2Ux8ROI/xiBLwGSGkJIcxAhe1EMcq4dVE=
X-Gm-Gg: Acq92OEpm/0eDTdvukNAoz4avFAeS0UYYljvBc2WH72yvIAkHVNfYnEekBc498DdyT4
	iKWwKy2/+emz8oPSAPOgVUADuP7LRZJGVsw8AcikueGeV9gPe4s517Mlmfpdo7aJvRSESZ44KxD
	LQoXM64D3MEqSLULkExQSxXHbM+5L85sS6Euiv9odr05ds0/H6D0/Wgbon+FDB/pBjZexgK99Ue
	1NnX1VNyzwd2L3ibAzXg7DubzDzY934YPUGo3wMOHw9Q6o+cdeVuqGN/uyV8z8IdIOj8J6mxP8+
	H72Oe5VW6kCLqGafM2nJ9B1Ac/mYyv+TEwLhihbduA6tOwOGomD4UFqTwBeMwkPAG4UD51TGwiR
	20QKkKwNY9YutYBxKpFSa+gQMzWhWMdmbghRB6+4L7PoHMBrKfV4XboMSPwTT0tUAVMrNyUtZep
	q6z9Y45btz+Mob1rVRRIvLKM2ByLyXOE851vjk9Jfk09kdaZTZR7OSkKF9L9/Uj4ZPBRt48F0wy
	xAwBY0MS6uQGkxl
X-Received: by 2002:a05:6102:50a9:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-63a3ea7d313mr1297692137.18.1778831012086;
        Fri, 15 May 2026 00:43:32 -0700 (PDT)
X-Received: by 2002:a05:6102:50a9:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-63a3ea7d313mr1297679137.18.1778831011680;
        Fri, 15 May 2026 00:43:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd2f5csm187895966b.3.2026.05.15.00.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 00:43:30 -0700 (PDT)
Message-ID: <7ba6b4ee-fd2a-470e-951c-2c69961b977a@oss.qualcomm.com>
Date: Fri, 15 May 2026 09:43:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: Linux 7.1-rc3 regression (Bluetooth)
To: Greg KH <greg@kroah.com>, August Wikerfors <git@augustwikerfors.se>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>,
        Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>,
        markus.suvanto@gmail.com
References: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
 <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
 <51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se>
 <2026051514-scorch-ecologist-5e7e@gregkh>
Content-Language: en-US, nl
In-Reply-To: <2026051514-scorch-ecologist-5e7e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PKE/P/qC c=1 sm=1 tr=0 ts=6a06cea5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=x5eH5QKNjoUSqzY6eP8A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3NiBTYWx0ZWRfX+JCRAYs9PpUz
 XGdiW/JuCRRlvgXPuHvgdeNY9yqSBRUb6l17KoDPjHS5z9puPjj28wIJTLkkiTwhBX8mqlwLCp1
 z/18U3VZQnyDy6PVgumn+wWg9J5JY3dUAPJKAbw6SWzlZ+zy+WSD9skwrNIIqeXUBM5x/5A1NrA
 Mk2NjT/N5saKv4LUbi3SAjsXnn9HL9Z9Fs9B1SOeXGNCQ0hdKl9B/Wv1QtU4e+NgMrK1C2Q8jRW
 NaAnFtJRx76VtgSkt7WIyJBqkFKH49OOHhkWrC8/7n3kCIp7/zCAMqACTC/aFr7J02bhDOaoDhr
 yRLdy+CYqFkImnEXP/BlspCJCWWwgBy2UcmM4IAusuH1XVZRCaNK2ikRNpj1SQAcGFhKgGJ+OEv
 pHofOnnYpHOkNd1lSPpo+EdMek315ueN1rLJnaKGclUzD2XiMHv4/s3EqKIdxu5HG+hjNFUhOeV
 xch9GSz7JSlixZEZBDw==
X-Proofpoint-ORIG-GUID: qVYmzhnMue4IXxa4JpLVndD7iipT3PRI
X-Proofpoint-GUID: qVYmzhnMue4IXxa4JpLVndD7iipT3PRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150076
X-Rspamd-Queue-Id: 9A38254ACD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[leemhuis.info,vger.kernel.org,lists.linux.dev,gmail.com,iki.fi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-247467-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.goede@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi,

On 15-May-26 07:37, Greg KH wrote:
> On Fri, May 15, 2026 at 04:26:38AM +0200, August Wikerfors wrote:
>> On 2026-05-11 08:30, Thorsten Leemhuis wrote:
>>> On 5/11/26 07:17, markus.suvanto@gmail.com wrote:
>>>> Hello
>>>>
>>>> I upgrade 7.1-rc2 to 7.1-rc3. After that bluetooth  didn't start
>>>> hci0: Failed to send wmt func ctrl (-22)
>>>> My fix was to revert commit 634a4408c0615c523cf7531790f4f14a422b9206
>>>
>>> Thx for your report. FWIW, there are two proposed fixed for this change
>>> floating around:
>>>
>>> https://lore.kernel.org/all/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
>>> https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/
>>>
>>> Given that this is the third revert within a short time-frame I wonder
>>> if we should fast-track a fix (once ready) to spare more users the pain
>>> of bisecting & reporting.
>>
>> FYI the commit that caused this regression was backported to the latest
>> stable releases (6.12.88, 6.18.30 and 7.0.7). I encountered it after
>> updating to 7.0.7 and can confirm that the patch from the second link
>> fixes it. That patch is now in the bluetooth tree as e3ac0d9f1a20
>> ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events") and a pull
>> request [1] has been made to the net tree. Unfortunately this seems to
>> have been a few hours too late to make it into the net pull request for
>> 7.1-rc4 [2], so the fix might not get into mainline until next week.
>>
>> As a side note, it is unfortunate that there does not seem to be a
>> process to prevent patches that are known to cause regressions from
>> being backported to stable releases. As far as I can tell, this was
>> added to regzbot tracking [3] a day before the culprit was queued for
>> stable [4], so such a process could have prevented this regression in
>> stable releases.
> 
> You can email stable@vger to let us know to drop a patch, or when the
> -rcs are released, respond to the offending patch in that list.  THat's
> why we have -rc releases!

That relies on someone actively intervening in the process though,
I wonder if it would be an idea to have some CI which checks patches
in stable RC releases vs regzbot tracking?

This assumes tegzbot tracking includes the mainline git hash of
commits causing the regression (if/once known).

Regards,

Hans




