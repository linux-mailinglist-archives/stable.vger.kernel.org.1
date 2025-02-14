Return-Path: <stable+bounces-116386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6955A35970
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E523C3AE837
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341522288FA;
	Fri, 14 Feb 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+c3cKgJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF27227BA6
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523282; cv=none; b=ss+2gMIYdXvzvfAEzugz/pSAOng6bX/NcfppH1MYB0sx7EvdWytMgI/kYEwcRp85LUkwQuzDoUHhxKR5+ah/j2nRp8Dr55RXRYP/RZ0xBwEApVqKxbEIqFyiGcrASKiHepgEpsCmeVbZTXRVgnYFdI3BU6D4CFjpv6n2cl3UsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523282; c=relaxed/simple;
	bh=nottMoCa8aOV6cZJrL7jEgHZtPVKHpnlgSU38rOQ4Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLHsB7dur3sOleboL0qFSikc+DG6orz+ZIu+menoFaZIjIz2PJCUDIebbGNg1zQ4mwjQwwoIHXdj7sX/iKmjSLeq+u98gx4ejukfhxRSRU1O85eerPcaGvTOwLNwHqKtidzVUIXw4L/3yfXM8BD8gJAlXMzMlrd24P/IlUoJobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+c3cKgJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E80cEA020896
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oj8Yee1gTVBAR2OBaCaP5WIbxHVmvmbfZUuTZOcJOb0=; b=F+c3cKgJcLJCsO7V
	dgCJtO3SX5tsVp+RlrPGgFkVEJrOR8xqtAkpjPir+M6c6iFwpX5EmUrsG9De5bH8
	hv3GFCTKM/OOUmk/K6QgcTegivoktt/tbpo0OjojviWkBb+F+CaURrdhm0NmPNZ+
	2L8oXk/EdjaoexbU2FzUm8VxZIaRbcwxNwGaQnkO0J7hdI7qoJ4HTp1D5gsRr8DV
	vyo5H1pDwEWMdlE+mPFXAn5uAz7MEx76h0AEjfd5ZgDxfC7pAU+fmpL2qj6pw/sj
	ZcD5t26lmfkDWBAgTfg9qVL0oh591nSEq1cYIecY9vFTyrwdNxTcCMjXsa3jjXq3
	BdB2Kg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sdyxu5m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:54:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6890d42dso60740615ad.0
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 00:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523277; x=1740128077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj8Yee1gTVBAR2OBaCaP5WIbxHVmvmbfZUuTZOcJOb0=;
        b=lrbcrziWHhSiuo3Qw6z6LADxnDTRZSZd1XmrIAwkZPX/lswftS2p8bp42G5h6q2ft6
         88/WbtRxuvliSnft9EDHqNKcIBO6EzgXijfoyu1l+ql71BSI+RAlxMV3wWXZlt5bIVdY
         qTVE24YGuhyTIHUg3OA40fzBA9ISBNt37+AymsUMyPHdmaPybfkC3H0bO20B1xJlN97E
         L8k0mqlL2700/nbWx+nyTpfuT2q+w1P1L1mh2xHu1ZCsbAkKlBoEF0C0md4WWLsrNsLV
         4CdrpmV/n/B2Ivqu/jeaeM3JBCxQoJJ+bDdR0V4JAnQunR7BgrUhd501BfNrtjhoAtdF
         QaPw==
X-Forwarded-Encrypted: i=1; AJvYcCWsZ9KbJc2jBEOUydLtsihBobX4xqVCLkvEPjLPqUanTSJr4o6/F53luawhPwpgJRB4pCR6P3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VEuRZwvHAbSuh7vUPzjsKUzfkbKprXNk5FcEXhADPy4U97F4
	UJq0VDM9ph+rQDBcC8DUINt4Tct0WPsMIGU3gGLeSpHA/aK4pcU61Ah1NO8uKhYRlFJi54GvIo7
	K4pYhQ/5qZpFikz1WxXDXI8sIoUth3myKilrdV5BD4quGQDN9uiR9qfFn/MJ4tEo=
X-Gm-Gg: ASbGncslJt0LBm+0fW40vVVn7hWp7oTWIcv4/J2IQ81dVKDcxTphIAaR1PzDvh8lbDo
	lYMWnIczeFdqKwQjDrx8x9/jyPg/raCVfP2y7rRwnIX8DS19KcuRaE3fxwFaggLIl6LsX2W7nZ9
	yDSzVRJlW1mzbvwPm7P3e/ojHIsSjyZVYisK0S9iEJoL2rBFZqhOxrDkWfDtcdQ/J7QTbvdNMUq
	vzR23OqQA06Oa+G+6gjBN8lj6yBj825X1h+U+Uh/CNULbHRzf1B7JKfrqfALhThJJcKC9Wtxpos
	XLp02ZwJ/O60z0NwDmV5EnWW669eVw==
X-Received: by 2002:a17:903:189:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-220d2170847mr95303785ad.47.1739523277214;
        Fri, 14 Feb 2025 00:54:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8WQ+Q0P3Hp8eId28DGCMDHWq1vMwRmUui9erU8zLhPW/BTEuxaCh7jaJut82nv5+tq8vQUA==
X-Received: by 2002:a17:903:189:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-220d2170847mr95303455ad.47.1739523276763;
        Fri, 14 Feb 2025 00:54:36 -0800 (PST)
Received: from [10.218.35.239] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c8e7sm24344555ad.122.2025.02.14.00.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:54:36 -0800 (PST)
Message-ID: <bf19304a-c9b7-4647-b33f-cf5e771cfa83@oss.qualcomm.com>
Date: Fri, 14 Feb 2025 14:24:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_ether: Set is_suspend flag if remote
 wakeup fails
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
        Ricardo B Marliere <ricardo@marliere.net>, Kees Cook <kees@kernel.org>,
        linux-usb@vger.kernel.org, Elson Roy Serrao <quic_eserrao@quicinc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250212100840.3812153-1-prashanth.k@oss.qualcomm.com>
 <2025021436-seizing-prankish-ebf2@gregkh>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <2025021436-seizing-prankish-ebf2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FmQL1PCkUarWVD0PaCvWy2GWMudbh785
X-Proofpoint-GUID: FmQL1PCkUarWVD0PaCvWy2GWMudbh785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=791 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140063



On 14-02-25 01:30 pm, Greg Kroah-Hartman wrote:
> On Wed, Feb 12, 2025 at 03:38:40PM +0530, Prashanth K wrote:
>> Currently while UDC suspends, u_ether attempts to remote wakeup
>> the host if there are any pending transfers. However, if remote
>> wakeup fails, the UDC remains suspended but the is_suspend flag
>> is not set. And since is_suspend flag isn't set, the subsequent
>> eth_start_xmit() would queue USB requests to suspended UDC.
>>
>> To fix this, bail out from gether_suspend() only if remote wakeup
>> operation is successful.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 0a1af6dfa077 ("usb: gadget: f_ecm: Add suspend/resume and remote wakeup support")
>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>> ---
>>  drivers/usb/gadget/function/u_ether.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
>> index 09e2838917e2..f58590bf5e02 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
>>  		 * There is a transfer in progress. So we trigger a remote
>>  		 * wakeup to inform the host.
>>  		 */
>> -		ether_wakeup_host(dev->port_usb);
>> -		return;
>> +		if (!ether_wakeup_host(dev->port_usb))
>> +			return;
> 
> What about the other place in the driver where this function is called
> but the return value is ignored?
> 
> thanks,
> 
> greg k-h

Other than above one, eth_start_xmit() tries to remote wakeup host when
we have some data to send from n/w layer. In that case we try to wakeup
host and directly return NETDEV_TX_BUSY to caller. If remote wakeup
succeeds, then resume() would call netif_start_queue() which again lets
n/w layer to queue skb. Hence we don't have to check for ret of
ether_wakeup_host() in that case.

Regards,
Prashanth K

