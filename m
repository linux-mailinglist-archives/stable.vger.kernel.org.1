Return-Path: <stable+bounces-222563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK4XLiZjpWmJ/QUAu9opvQ
	(envelope-from <stable+bounces-222563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:15:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C11D6351
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E013073D86
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA39395DB7;
	Mon,  2 Mar 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wp7Ur5B0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atdXtUI5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37217395D8C
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446162; cv=none; b=bbJKD5RFVQQHko+ijYaaQXX+9zNYTa/eOr+d4iHiYWRsLSJqdqhVkGBC0/sLxxBZHPh8vb9vMcWNDZ4iSjvyPrUBmNkkLdu/dWmjW0QonIetMwGBYG8JbCXStRaXyyqP4LXWWfmJU9sehXXUl0Ke4BEUipYqCjF4s0nprW8yEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446162; c=relaxed/simple;
	bh=l7uceIMIY1mV6pvYa+qMbFOH1vYdC8XntB/RP1WCv8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upw60YarhsfXVJzT9W/ZtkdsfHAbfUT9X3caczLygZh/xTovY83WngYBaYTmnbrIN7g7wVBcc8JhhPE30PdKBpu+bb/gka8fdm1rqrPEDobd7EfnNpQqgW7JRKtiQg0MaZVt/TRP8xyYc0DxMj849EOWqTMpfebKaLkGG2x0Rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wp7Ur5B0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atdXtUI5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226h9192504598
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 10:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gsrfegSNqrweAQN0E5QffjLf/9EPehHhXm1mL9ykDRM=; b=Wp7Ur5B0Vuc+xuTj
	jAtQ5hM8bXkr5njsMNkHFxqKGdeiFLOiAJSC7SwPJI58Wvx9umG/7RibWFh5dqxy
	ETX94KgnToXWqkFTFSm5MgMfQ5chjZrFHeMrEy+U+OaZvziM6zWu67ODy9wW+OGF
	Ot+uUYasejVe4HCirqG2rG/KZpo8fgARl7Cb6bZJc+eZowrQLGQaykIq6tg4SBP5
	ytSccKYJHE2/K7UnT2KBwtaGUPRPgiyK0LSPbPhafzHB4n6uDc+me0ttyU1jwQHq
	Wkg4OvWc4J6XoxrraSNJYb7ZYzLECfA9ut9IGYo1th//sarf0I9Hd95dc1zK1zN1
	0uuE9g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5hers6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:09:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a90510a6d1so30547175ad.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 02:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772446160; x=1773050960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsrfegSNqrweAQN0E5QffjLf/9EPehHhXm1mL9ykDRM=;
        b=atdXtUI5wDw07zwl1kG2pU8pUBrAGkQodLZyxsF2ME1LfufGDvs+RJjNqGrufBHMjn
         6L8OVZZLuxKbzKLe09UvqsAVj1Z1wLeB4AgSBz5+IzKKd7hXQdKm6qrgGJXvwfoKNG/b
         E6Re1RnwhedRIw5lTrpxe8HYqu5d+CCqgm91GxucD9+th2TYbJoxVuHuFqWbmci2QLBi
         u8RApMWN3ieEcRMjRsx2lRSShOZH3rmgTIqDmT0BrFjQuePRCC5OXeIC294RNrP8xZw6
         oIDQxXvxMe6iuPAhqUY0RXDEfdXk3UFjN/yqqOC1BapnacsIXkldLFAYC1UUTA5lNdK0
         b6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772446160; x=1773050960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsrfegSNqrweAQN0E5QffjLf/9EPehHhXm1mL9ykDRM=;
        b=CMHbg+Yje1UdjXfs6GmtKRR2hrN4WFWLyEX5RL5Sl/TF83q9H4mA58Lrv7OVZYhDyp
         EdxaiNWpkKbbKFsquCOQyAp5k9NVeLpGbp7RyvG/kvluWllwry1Rcb+g4FHJLGoihn7Y
         /UzPb4G13xcvj4WmV+PgBpfEiBXpS5XUYyuhbE0jrN5B06q8B7JGdNo2eCAGDkODEiEX
         6sA9k4V+gQ2wU9d5G2BEs80xz29AVbzDbC504MDJlZFBZTTedvIY/ZfIr4FlxxjooDYx
         z8EOcnZOoE1iWVA+ClZa9R7WYCJ+CiJ/2A7pXRgIdSxgaP6cb3+7pKLcqongRUvIsVIi
         F1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoEEdDphLYLopFltPzIF0ZoAHZWmk1XZwVqWsf74ZTxKViVdGPMkRHaiiTHtTHBG+z89S6Vrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnUCK63SmYNEBNnQScTcO73DG20bhMzFgYLXcb81Q0LAKNrTx
	0o4gyQBp3LtYN8gkYJHATMQWxb4AAlWvaPFlzbz0alSQIJ68qwcg7JDY5i8eqzy9lmY503h551I
	BIcPBWpUZlChoMSMl/9Oau5xJIW/ll+dLCC/clqb9yf8QHFyJA/8zji/48iw=
X-Gm-Gg: ATEYQzyoPlI5N6BUDLfOqTqT5KSWAUTZ0GfIu1Pv4uYXklCR9XELMESDyVWeSMPhCul
	azRqVjCtxKpCXAUPZWnQLrLglgFo1SyFDUx+lgO/9nsiNdezwctHdtZaGG1FdzHlKSYh9HxMaZT
	OPC86v/Ov/AlO5ftMG/8s7dnXX/l7MFZovRb9EIVoVDSrpLTaz9JMwABNhVFqkKnxH5f5DV9HNR
	OSxgHb40RLBlnU1ksWlUMmyzmcbI1UjGTcW29zLB3tAnZMXLsORKG5zM01rMWelXyWo4ShJdtQf
	Ff2wdolWKu2J0JLDem4EFY+/osX4rF1PXczLf+fMUMfDq7BJyCk2PuF/OiN4Dx4qRkVtHlFeoiY
	qbXnwH5VS7Om8ru5z9+xnztRpkPBVaZsZ+2zVkP8B5Nb+oTnM6RJSFw==
X-Received: by 2002:a17:902:c410:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2ae2b8d4de5mr122189165ad.15.1772446159863;
        Mon, 02 Mar 2026 02:09:19 -0800 (PST)
X-Received: by 2002:a17:902:c410:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2ae2b8d4de5mr122188805ad.15.1772446159206;
        Mon, 02 Mar 2026 02:09:19 -0800 (PST)
Received: from [192.168.0.172] ([49.205.253.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b5813sm136639365ad.63.2026.03.02.02.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:09:18 -0800 (PST)
Message-ID: <a7c04423-363d-4584-9139-f621abc0f0ef@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 15:39:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix use-after-free in
 iris_release_internal_buffers()
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20260216-iris-smatch-fix-v1-1-51f6b41c43ab@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260216-iris-smatch-fix-v1-1-51f6b41c43ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a561d0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=WNU4mP0iZEZjDg176sUGxg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=epIOnHcr0igDC_0qk5cA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: dpNTvtCjY5u1-bQiV0uN6hQNBaYOxwaj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4NCBTYWx0ZWRfX5SbybOsWc3Tf
 gYOr/U27CkzWinXzoFDwg1tWvMXI9/ro3yBEtxGbsIUdqi71CU3SNJvr3/vDSeVAVVWbNADRsaM
 Tqm7y7q0z3+Mmke5n4Cf8FfPYq+PekugF0W5Hpqo+mcwevTT0kdxSw8eMpcanutBpqK815wZCt5
 bVS5yiH6I8QPB6oEyvI8xMRBSHTIfIcxVv5uKB7on9wgUa709JqXy8/cjHBAqXdwTpIdiNxd7Zm
 z16G2gwKy5OS/e50dcUPVs0sUTXMhxUnWWYO5GRH/DquO7HFA+L/3dHwfLNVVt0/AeDQwyA3Co9
 PkTxpQQ+mpaHiBUE5C+UwXeer6HaCpeYH3MaEiiwuB0CHOsCYQbJnwMOz86uv/FAR9rWoUtZXIV
 KdYegd+QM2GjKn6QWMG+24LK8zI7fc5hlrvTTy+QfpmaPiCWDllfVjD+KEFkYYpJ5NbeHvgIekz
 ZOm/E8wOtCMSbFS1ocQ==
X-Proofpoint-ORIG-GUID: dpNTvtCjY5u1-bQiV0uN6hQNBaYOxwaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-222563-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikash.garodia@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B5C11D6351
X-Rspamd-Action: no action


On 2/16/2026 12:37 PM, Dikshita Agarwal wrote:
> The recent change in commit 1dabf00ee206 ("media: iris: gen1: Destroy
> internal buffers after FW releases") introduced a regression where
> session_release_buf() may free the buffer. The caller,
> iris_release_internal_buffers(), continued to access `buffer` after the
> call, leading to a potential use-after-free.
> 
> Fix this by setting BUF_ATTR_PENDING_RELEASE before calling
> session_release_buf(), and reverting the flag if the call fails. This
> ensures no dereference occurs after potential freeing.
> 
> Fixes: 1dabf00ee206 ("media: iris: gen1: Destroy internal buffers after FW releases")
> Cc: stable@vger.kernel.org
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Closes: https://lore.kernel.org/lkml/aYXvKAX3Pg3sL37P@stanley.mountain/#r
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

