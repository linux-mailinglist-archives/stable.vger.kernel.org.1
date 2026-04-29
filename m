Return-Path: <stable+bounces-241832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDpYMkqz8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A410449076B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C57302F999
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0055359A8B;
	Wed, 29 Apr 2026 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ljn809wL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QukfSswP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0063A1D02
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447441; cv=none; b=ByLufZNOd44lmw+LeOKpD/9UoadOxCASIuU18gXTEbZ4o5UWA4zMEG5NgeWCrtDXnwT/PAWhjoM719nsHs2C5gjh1VVRRuJtp77iHakcw5hg6/rVe43t8o4UfeCh1dZ5nb2B5FG/CNxYMVDtSLrkzpBYG8rtMdRjo+IeOloUpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447441; c=relaxed/simple;
	bh=4kMjEWgH0O6MSc6+Ivs0TbjE3sJ/FOasTo+8HTfQQDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVo8YIJc+gUUm9z4+KZQqT9UN0zAOkiGuERCvMpBeHGe+B54guJY1nwuEvxFu1BpxqoOzY5Fnia23QdXvfWWQIMK7lJqLYUSWii5xe2innUhcyRnCaNaaRWZQMN8PXACQyMiV8OFyc5eCFWxVTgUze34zCabKaBFlaYGHlQKlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ljn809wL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QukfSswP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T6Exd01281962
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 07:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UvKCNndBBkYUc0nxuFbkUYiO0WRhlXQti+/4X6+udB0=; b=Ljn809wLwDtH+Jki
	+Z70R9qKW+U6dKJhlu64OADISW1Iw0ExYW0z0WuLKYXgoIcn9l58xSh6Z3EaRJKn
	+opWAOajEVw0bx3Qs/mKFyy0yWazAua7CHkzC9CCsJCwJDW/niKrzLCPu4J3/xEJ
	lH1Zx6hrAOLLQhYJpu+9NiZJ5/DFjHNX8bLEm6jP+fVceniOZKN4mSdV2RUzIY42
	zx8ps02linokJCndkAeEXE6mGqz5Ca4OWKSjwhsZ1oJmRWttjKwNfRQrPPjyDCPW
	Ayl49f5E3CsHgs/z6UCGMZkyfnZ2PdI1sbkSYzFXEp/FoEedNs3Y1SHhG6D7hVrr
	IqJyzw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj808g5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 07:23:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso16071664a91.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777447435; x=1778052235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvKCNndBBkYUc0nxuFbkUYiO0WRhlXQti+/4X6+udB0=;
        b=QukfSswP3c1VcFt8QCAnprFaSFgRtDmblOTmCVOYHFZg8lAwrx94OdoGjRBkZln9WD
         FNWD9k5cEvostEfwjo22lk6VypuW8+evWecBO8tkvvPXw+VPPR1Vg3d4LUxQ0bWBSxIb
         VkuvrpBNYt+QadFNTL9ERxtPOUFfaLCeLGLtld6kxUVws/XSwVkSZrav0ikD7A/GvMS1
         vs9A1xSl0wIj6JezB8Wyi4n79yhvGu+sOx2x454G7Dr4lRY5Dh+znwXh5wIxYOhzC1Bh
         1f4fzWV0BuqUVYHo5/RXITiOrqgqgYP9uqZUM9rjzTv+segFt8O+xmU1GBrT+lLKn53Y
         GBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777447435; x=1778052235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvKCNndBBkYUc0nxuFbkUYiO0WRhlXQti+/4X6+udB0=;
        b=X7fGD/Q6FOqW1fbdr7vZ3OWwhHYnjxjvrBctJR/4f+eVeGrpxdpCjfG3ayeUiRecLK
         7TPc7mdt6Un3zDKNG1DcMnmXjPbc+cQxQVY54BbpPqsWIyHqZ7eS3w68IS90IFl3MbNE
         UHcTEOproWbHGgYsyzwiquKwmy0oVv6Z3OXlaMFo6yppVfTahdr2x2l2T3zQCaRaCp1N
         iUUS1RdIHUea7mfjP7vtiE9CCm1CKlJO9MuK+wiZ/12c2H/Xk8z0o8fXZ4q4cLEqBGXE
         ZXLL6rZUjfmjWE+Al2+qhV0GsKbHXUqCJlORB+N2K8oqmPQSimxk+uak+UV6pH+zZxC6
         vl1A==
X-Forwarded-Encrypted: i=1; AFNElJ/Ud7zcyS5QDST7vwuDPPsLSJBpeaKQR4WPEZH6PGrHqmRKdRmrvbMvCeW+8KgUnKmozeMtdfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEJ0SGW4NkxOJp5hkkI5ZkGy6zcezoXvzf/oTMBQwVnAeSqCS
	wh/b1kMhWCLXEeqx/s6K4BL7MG+60u6C+/EZJ8Vl2/F9A4rUkSW6CBOu13QYBuwvaslw7JlNUA0
	EE1Goo7qFv3DWHxAEGYX8dPkwPaaLUNuyrMSZB3l2FXpcMX+ToS8Ij0NmYIE=
X-Gm-Gg: AeBDieuTMDMk8HTKWV28AWudgExgY3O4OXS5CQgNoyuZCiiAtMQc8xehbgMTdGwNQOe
	Eh5xElhXKSLVHTJRlm1ZvD69COGCgi8g1x3+t0Is9RgeGMuIIhSqevyEDA14sOWxTsgbVC5Rua5
	vTFgi/Z3KvDOdg1R4dTnrEErlr01fkwtCldQt4sOWVWp2zNayUMrJ/DRO0NofBPmvd26oDpB8PN
	mnzJ5mWmf0mNiTWHdN3xlCdcc9uCUFbicewPT37soNAbrDSDOU7Boqzg3BkMv71hUKQrZ2ho1/J
	xXFW0bJYckWzIBfR+M+LG0v+PuoFTw2Wg0CxzaE6GoZk6Hb/ars2jbOzJYVTOKxutB3CEvnqEoL
	XZZ301eGhS4IvU3uFw+QBeBP+ouOrwj6XkmGhA/lsGv5aH80/3w9YwehobIeE8JeF6f5H0zWpig
	fXI7wztBxtqHlI45ukOndZzDENwuqz7w==
X-Received: by 2002:a17:90b:3fc5:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-364a0adec05mr2719574a91.2.1777447435141;
        Wed, 29 Apr 2026 00:23:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc5:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-364a0adec05mr2719563a91.2.1777447434764;
        Wed, 29 Apr 2026 00:23:54 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a4180219sm1292125a91.5.2026.04.29.00.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:23:54 -0700 (PDT)
Message-ID: <0ae92497-91b7-4eb9-951a-dcd2258f538f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:23:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <c0d2b6df-4109-4c93-b229-7eb2d3fca6a7@oss.qualcomm.com>
 <20260429051414.6625-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429051414.6625-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nLceHfnB7hNu7GDJwLwTfzQelAh1w0yi
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1b20c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=hnrE4znNAVy8RLhoGhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: nLceHfnB7hNu7GDJwLwTfzQelAh1w0yi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA3MiBTYWx0ZWRfX4tGW/UYwieId
 l2tIPZaI3tuM6FCFSdCvFWKi1yomfJYhpHgWA1iDbFH+qtrmCwNNMz7gdIaxShZgw0fiJ8ux2h6
 FqeqM58NLK04/FzC/l8R4t+iSlKWuwOklZFVNUAcHbs0IXSmSOTimKoj0loxE1/eAlDT1ohbVKr
 Io7HpedkvaGdnwlFecl2pv1/ysoPewyp9a07zlpzDehsTnh/snMDMkWpl7oSDGz/wZBk3m6PQCG
 kcAMw2dLXc4njhMcDxBa8pyq/n/pPQewth+RsM/UV81Mm3aktHql60F1bfqFg5Tug+ovC/oLX6d
 OqifP3VO7Ye9eY9fuV6R3jPZgzI6sgNvHEbM8ruhHrIk1CwG3Ji+xkqCOCZGJMxTaEdGv3imW2h
 cferjKJ7TTIgY7t1hefmLjZdUv3pye+2ShDwV7IEhYWbDb9PIC9yYcB+t6pI6lPtVxxm8RmazWs
 L9aJQ5Fn1RElMmQACBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290072
X-Rspamd-Queue-Id: A410449076B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241832-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/2026 1:14 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Baochen,
> 
> As I try to comment in the commit description, the warning is not at
> the intialization, but comes up when the device is unbinded after a
> problem at the initialization stage, because due to the problem the
> buffers were released (probe). Later after the problem, if the unbinding
> is commanded the buffers are released again.
> Setting to NUll after releasing avoids the double free.
> 

OK, seems the first release happens during the error handling path of
ath11k_core_qmi_firmware_ready().

> The easiest way to reproduce it is to run in a VM the default upstream
> kernel (that is always failing on VMs) and just unbind the device
> (ath11k_pci).
> 
> The same problem was fixed by me for ath12k driver here ca68ce0d9f4b
> ("wifi: ath12k: fix warning when unbinding"), and I have seen the same problem
> is also happening for ath11k driver.
> 
> Thanks
> 
> Best regards
> José Ignacio
> 


