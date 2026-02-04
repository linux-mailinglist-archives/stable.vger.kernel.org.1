Return-Path: <stable+bounces-213347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGm3KV/IgmmzbAMAu9opvQ
	(envelope-from <stable+bounces-213347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 05:17:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12954E1849
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 05:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF31130A7053
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 04:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0A264FBD;
	Wed,  4 Feb 2026 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lzfb4qZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADXV1aLn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24D3370E3
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178647; cv=none; b=IVmtvazM7x4fB35uR4v99tfXMso8FxLJdM/7/OTY/aRzfxL2tRnC3loDMXI02oUglBjNWzusUv2HzdpDRi8pRE9VuZdJVgQCAcFpsUqEwKLAnw/XabsapmcvSVHoE99a65QbNgCpR0NBVHYzmVfkCtYR6iRYoDihmei/6GSVK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178647; c=relaxed/simple;
	bh=YlZzlX0rc5xbEm+iBlZ/yeYYdH6Sf61IUqYMkk1u9cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itjFSu26m+T5234g3XTqu80PnwMJnFOTmrPxyC4MPQHY3b9zwATbuFG6Qho3R4RMUz+zphYUY19sfoNtXw8eIeule5KLE38H4JtiKnhmjkCi0Hx6tkjmHdydrH1fHxuvKspJcbLj5RFwf9PFFoxjOHK8nvqSEFRybYTik2i2FKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lzfb4qZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADXV1aLn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ImKgY2732622
	for <stable@vger.kernel.org>; Wed, 4 Feb 2026 04:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TX+YgC2mrCIEU/1RHOqvZa/FzaP0cWDEpzd7IkPjJeA=; b=Lzfb4qZWBXJKRSeq
	04vgp1GXLJce96niOR27I/lKbiL6lJQSh0T/3eK6eQNpDIMlveEaq+crdLVZ3QWz
	SP0bd0B3OZZ7k9yn0dApEkg1BA4K4Z86fHgW6qU4xBbWQHju4/YUHwQ9QbpuUWn2
	iJgQz2tztVqo3PI2zkzx7BqjjlYArqYCUfQLA9zkJyCi8GctQ7wnEFPOx14viWZH
	QmR7UHcKsIfgfWyYQZ40YuKc/t9Z9VpL7w2LI79lbyQiy6WdtylLdAjWOdjRE+RM
	l1dZIUt2AG8E1x8LEV+SpeqNE44JgRVaF5kVXLnDF8j0/0IIq/B80MYiafLNCvDO
	pb5HAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3exjk8m4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Feb 2026 04:17:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0bb1192cbso3610125ad.1
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 20:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770178641; x=1770783441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TX+YgC2mrCIEU/1RHOqvZa/FzaP0cWDEpzd7IkPjJeA=;
        b=ADXV1aLnbRGJOZ4SXyPWuo2kr57HOpEPicxGAoBhqdHa1IOUvjJv9Z6XTPq8XA7/if
         ffUX7SXDjLghvtKf1L+f8peWWAuZe+FawC4UoVUAGjM5aMYYgAjHgSkGcQ+EP5eSWbrX
         v4EZiyU6nhXA4xewqGLLVi4qbhHfHTcSHcSffvgGTI09ZoD2ozxYSRGD7WzR6/3o4L4v
         E+VDXS+OikabjrCx7jzvD18M2OWz7afu4l+bPuVcSeFhPNb16HUYZmTMK1bkXPVH1odx
         XoG+4A7seMIQNAABLWDq0G+ry+0gOAVfQFQ2VFqEd9qDi5+LRdLOdopZZA64bH0m56kh
         GTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178641; x=1770783441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TX+YgC2mrCIEU/1RHOqvZa/FzaP0cWDEpzd7IkPjJeA=;
        b=WflqwAT9O4y667SegT5aNu/lNaF/7SbVAbc5z0kXBj8V3wf9u5LRPD4Ax6X+5odaU9
         6ejK2BP1vgJjEsejysxf3EeH0wvFcCBYXZc891Oh4Kk9eihkKeummoKele93+OQHIhir
         roHpPoudDmCOMWTzKnT5BmmcrnjJcpqhw/On5pFWB19F112ltXJoFo+CmwuQv5ahR+1y
         AjvdPboUc4wVRdvX33YQBE/Na6+EMj88RWKbhXa4qqCk5yP0I3KKPe39F/tvrV5XC5sM
         cVf5F2EXCeFUxb8XQzKFnqPWD77QfYOugzCGRciXduH+ZqZ6pg8ImA3btD/BnYk2zRZY
         lTBA==
X-Forwarded-Encrypted: i=1; AJvYcCVzVAbJaqqwcgf57bTUwPKiCC3iJSRsJIiIvgbiDgDpDyClUE4wfZR0geCgjrc7SWJnKaQmHOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxFDmmNHk4xWkRKFvh2fJ33QEbMYCqOgGjDYwYNM//Y8MThxf
	2Fro69Zd04FledubNobHbKdmzr/m1WX/ehYgLRzqXW/lgdKHFGB4tkD687Q6wkb8j842In3obzR
	1NvdsOSFpa9OZuWEOFo8i4dr7FVj6up5V1BKkYE/60/g48cYpHhWPlaNy7WE=
X-Gm-Gg: AZuq6aJsISTRN+D4PY30XVDbqGL3u3WRiWvv+Qg21xPwuu9OrUepXJwDoDYPlZbnQGq
	3PHXzf45mu0SeMS6MNmki93f4iOdHHpJj9gCctzAzZRYiT8ZGKdBLKyuso5CxaynZrNp18hIb+v
	oKxn+a3D9sqWwthPtpjL/dbCPx6l9aGqBPbxsmzah2NAkb60Uo5MRuO5bKdI5HgD5Dk7X72+gIP
	riqH0/b9muKVDS+Zq7XWg3a2s+YaskIg9CEMnr7bgJZa10+hJ0m9VF17hgK7N3DhNBeRjEHdysF
	mSuf8xtm3dFk9uKNo5HHZ4qIm+YVN1tqm66JSVchUFjqsJ2/CFfKHEjHpWtqxp7G1BpzUWKhk79
	rLXM/BS06TyaUoODwH3GpQ4Kzo5KxqMH1xJM5Yw==
X-Received: by 2002:a17:902:c411:b0:2a8:ac0f:9ae4 with SMTP id d9443c01a7336-2a933fb5b7amr15894485ad.48.1770178641243;
        Tue, 03 Feb 2026 20:17:21 -0800 (PST)
X-Received: by 2002:a17:902:c411:b0:2a8:ac0f:9ae4 with SMTP id d9443c01a7336-2a933fb5b7amr15894295ad.48.1770178640788;
        Tue, 03 Feb 2026 20:17:20 -0800 (PST)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e5d4sm8837575ad.56.2026.02.03.20.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 20:17:20 -0800 (PST)
Message-ID: <e94b8434-09ff-4ea0-a762-0869345aab4e@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 09:47:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Move vbus draw to workqueue context
To: Kyle Tso <kyletso@google.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260129111403.3081730-1-prashanth.k@oss.qualcomm.com>
 <CAGZ6i=3ZJ3aihjmXnPq9C-mpVYa6rqzfWTn3qXmavYUiZtE24A@mail.gmail.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <CAGZ6i=3ZJ3aihjmXnPq9C-mpVYa6rqzfWTn3qXmavYUiZtE24A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W8c1lBWk c=1 sm=1 tr=0 ts=6982c851 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8
 a=QySTlIg7yQLGu7ZqArQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Gv7ArVVXccvVJb3qLvpraNflAA4DJL-h
X-Proofpoint-ORIG-GUID: Gv7ArVVXccvVJb3qLvpraNflAA4DJL-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAyNyBTYWx0ZWRfXyDEINQbJuaSm
 F1Gg4Hc8H+mv0f0uYyGxF5L/Zke8IdzhEFyEzkrcBxDjj380ins0GsWaT9EDnKzXNmlyL9Enwbp
 1qEYz77hnkJ0v318zRZ0mzsnYYkqrEw/t4lAxOewOzEdzsgTitZqHh3P13V2mEZsJ5jdQDs1IQ/
 4qeByANpJ1V1VCC80WcQKKCBgZEaeM8RWOl/dij6AiTGNhLIJ8jGgBiHjVnxv4twlBMT78zpWig
 y2nz5J48xcQSOi0+PXmZZCNcjTqwzm2NTlZJZwDEDDkUB/5A3EfDUkQZ/i63Q0AK/cyCvVLEhkI
 eIBDeqtlKpFY8vLD9agAIRXtswxquw4MBRbv2Z3WqiFAr6XoA0Vn12pZBQ+jdA5H9NFuFZ8hQui
 9rzkOYT46qNlc6ZGkfo0U0VmhtF+M9QvspxQUEo19O/LHTXgyRkRYEVICjEBRFJdjyWzEskZgpM
 LKe2A2COeTNaGi3zX2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213347-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 12954E1849
X-Rspamd-Action: no action



On 2/4/2026 9:29 AM, Kyle Tso wrote:
> On Thu, Jan 29, 2026 at 7:16 PM Prashanth K
> <prashanth.k@oss.qualcomm.com> wrote:
>>
>> Currently dwc3_gadget_vbus_draw() can be called from atomic
>> context, which in turn invokes power-supply-core APIs. And
>> some these PMIC APIs have operations that may sleep, leading
>> to kernel panic.
>>
>> Fix this by moving the vbus_draw into a workqueue context.
>>
>> Fixes: 66e0ea341a2a ("usb: dwc3: core: Defer the probe until USB power supply ready")
> 
> I think the following patch is the one to fix:
> 
> https://lore.kernel.org/all/20210222115149.3606776-3-raychi@google.com/
> 

Yes agreed, i added 66e0ea341a2a because it can be backported without
conflicts only till 66e0ea341a2a, but I'll change it to the correct one.

Thanks for confirming,
Prashanth K


