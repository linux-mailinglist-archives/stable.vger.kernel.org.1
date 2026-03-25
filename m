Return-Path: <stable+bounces-230319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBjYHMfKw2mVuAQAu9opvQ
	(envelope-from <stable+bounces-230319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:45:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB532423D
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC71F3171CDA
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E6B3CF690;
	Wed, 25 Mar 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oDLQjUn7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRCLY1nd"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BA3CEB80
	for <Stable@vger.kernel.org>; Wed, 25 Mar 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438430; cv=none; b=UErSuYA0l/0GjDjtGZORxubQSZMfE6SZNtCrcHinQIHYApvW+fubmDBh9e43LYAD/zI+V4ldWb9aHarR2HrfdeDQlm+WT5oJchQ1vFK+hTyQLrg2vxAew7IREI/XB1HMJKM+cFKHaJtq7s9wsLDirH5cRryDMmJeBr5buZ5NsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438430; c=relaxed/simple;
	bh=zrTu/Fk6R5LsUpKkvhxFJueXyQGTKcxc82WecP7Bj1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5HyScC4swngKB6kPFmhD+hzJdJJWKxgqO3hVAZ692AoKkTG9xp0xTtdDEJgm/Nx9k25eI6qWZFhm+ztShR9BG206omK3ACE/sD7TvfoaFXywcYfGZ5N8E2bEq1r/C2sT32kCxLU5QK1+BNLswn5mPjRgChhKPDQO+MkAn1KMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oDLQjUn7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TRCLY1nd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBGHLa241589
	for <Stable@vger.kernel.org>; Wed, 25 Mar 2026 11:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rj5/AzTuJ4vyMcaPjO0Gng38EceXd49d1VK/6ipC9lo=; b=oDLQjUn7PQCQaBbM
	l2/1sUxAIvkFNa0FmE7FkXoSDecF85GqndHd+u2p4AxReIWS1eKqI3hnDmspBVl1
	cIS/sEPMfzwnFlI5xm6J1vAmMk2ooI7V6KmNlXZIrJmJ83UN+RNVAkJP13zEDqbV
	pRVqOFXsPQ6+zyrm35yLA4rVLRlJFIfu69VQjdFrrhgwlEf1nASMXC8mrtDNWLkw
	sOgK0XKIMm6l5EnpuNUss1dOLbC4SEWYO2K88zzUchOuQdiiGOe/t4zOTYp7HXPf
	zHhoPPFl0p4POv/6/GE6LsxaSBLGsxYRwM3SuAX3Tirrcle8ted4BlTL3eRUcaJv
	dMiXNQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4cvp0h82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 25 Mar 2026 11:33:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50937cf66b5so329458591cf.3
        for <Stable@vger.kernel.org>; Wed, 25 Mar 2026 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774438428; x=1775043228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rj5/AzTuJ4vyMcaPjO0Gng38EceXd49d1VK/6ipC9lo=;
        b=TRCLY1ndyQnGK5LPGl7Krlj62jn36qoWUAr0HFOUMqWlyz0dmfP4L4xtwVEmGCKEPh
         8hkRURC2yGK/HS0r9KTgiUP4h0kOZsAzkPjwTJTIkx7wRmB0FYxgErpSuexhV4h+1Srr
         oa5SlLIjtU4MrBEr1OFDhtaUz5lguvIbkeR10mwitiqR+cBzcXel/O9QUsuv3Smv+nco
         sYIClWM71WVMAFAt08QxQnP7M+76jYNeqYqQd1ZaHKUT3JSPN9LO76w/hq818CpxSU6K
         sGVA5JCHPCaRlrMuv317mq6nqO1zbX+zbgIJZNMa7eJ1CuaY0K0vc2UNWcNZD4ZJSrkR
         PJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774438428; x=1775043228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rj5/AzTuJ4vyMcaPjO0Gng38EceXd49d1VK/6ipC9lo=;
        b=LQpSdoJ8OvAfgEnNAxoX5xhYkFDWiDGRJp6xeZEBWUWUl9mXwbflIDPtccey/uCxOc
         CVgAJOHM8z/MmPK1DC42cCWgDLeGqOBCaB8Vv4DO908SOrPA5V5wVRHfiYrXGr8kRAIx
         f0VVPaTv3n0N+GDCevF0whXcfm2Ydjhnskt735AtvbcLn1s9pvJaOnNWklbui7abeu8g
         lXHZbkuYZd4CuGNlqymkhsiHBJWK56Hp9MrL5epkXMv0JSCRgYELLZOYJrHsPQmAziyA
         94A8FKvB9Uqawy7T0Ebbx9ILcyJQgbbnqmqAG5wx/If+SCDcrvx7D+NLQF6EjJr0kMs1
         DMfw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ICoINerkRSsvOrOo0dbY8+P2TOtvxNxlc8R/Va7MPTU/8EHu0HRbJ2lWWNfUdoFUoeTY2is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vTGBAvhyJe9niryMJO+mcn+d8WHAPM0GLe4U3qemRQjNfaAt
	v410U22yy+0M4DTviGZ+18++XhMeLRCOnzARD4LWVYdc5dyUbeKkM0omv/5VREIQgxwH/Cdm6pN
	ONR73nvLXw7KnPlVYggbomFIyaidvna4z+WhLbKR/hnXlKKzKbQRfhAD1JME=
X-Gm-Gg: ATEYQzwzFzb9sFQ2DHSUfiB5ELEkWeVEuEiZCh2c1HfeGXfr3cy8JfrJDrUd9d99snz
	1QpjIUXR8el9n0fItWEKfDsPHORGkL8aq1SW3fPO1/syhMXolI2GHBsJzPC+y3tCASMV+IrDjxt
	x0RaXcjsyCq2X4AvtrjebIAs5IkIq2Ez+WT98SYpBX6hOI+OR5oFcN2TdfTsBK/pRMn6pVc6FKa
	uMfdScXHuBwEX6NsP/Y7PYzX1C9OKm5/qRpyXzK+jDm3Y9llj9vlH/Zjt06huU7YTeeQ7+w7Mlj
	Y2wGPnUERi/v0BO0LCSEJDgubSJkm/4+Ad+Na49dE4RsUm/DqQU+22pstbiTxlGBbH9NJvnzkF/
	2x02RBtrQLvuk+/nTUvJu68Dx+GL89JSV5wt/koPjCEy22nsy
X-Received: by 2002:a05:622a:5c95:b0:50b:483d:3669 with SMTP id d75a77b69052e-50b80e82d15mr40947721cf.62.1774438427584;
        Wed, 25 Mar 2026 04:33:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5c95:b0:50b:483d:3669 with SMTP id d75a77b69052e-50b80e82d15mr40947341cf.62.1774438427032;
        Wed, 25 Mar 2026 04:33:47 -0700 (PDT)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4871728a19dsm40109145e9.1.2026.03.25.04.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 04:33:46 -0700 (PDT)
Message-ID: <e03b2cf2-08a0-49c8-8ae6-1651de301a08@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:33:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/13] ASoC: qcom: q6apm-lpass-dai: Fix multiple graph
 opens
To: Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        mohammad.rafi.shaik@oss.qualcomm.com, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srini@kernel.org, val@packett.cool,
        mailingradian@gmail.com, Stable@vger.kernel.org
References: <20260323223845.2126142-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260323223845.2126142-5-srinivas.kandagatla@oss.qualcomm.com>
 <61596b66-4fef-4bdc-93f2-a8639da79d32@sirena.org.uk>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <61596b66-4fef-4bdc-93f2-a8639da79d32@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2auVnmrucWZ9UUSznplEMcRWuMMAFXta
X-Proofpoint-GUID: 2auVnmrucWZ9UUSznplEMcRWuMMAFXta
X-Authority-Analysis: v=2.4 cv=Q73fIo2a c=1 sm=1 tr=0 ts=69c3c81c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=kvLm1XpQD2xK1ocldNYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4MSBTYWx0ZWRfX7LiKvOsIdhtY
 IsEPc06Djsf4mTgxG9iBLUsSdjYlae4O4T8DYDWY37hWUNY95BtOSZ+0P2efBV9UylgZyYNNhH/
 Ew0kseCMiR1E/JHCPg9zXQWlSXSYhign3JDirX31To8ascd5+0L6tzTXW4CIGBbf1UfBQqqtw94
 9/5Be94sK3u0IbK7q7IW1u8vW8N4ZPy0Vigd/coF3rTjouFOXzRK79C9wWXhGmaPBnRzrF8/HDT
 Xotj9jXA3vo2Lzje+9yyFTdveMuveHu9rqFKa1eK0NJ0IQjug67j4lIn53ndfjrGj8DlBtn7txk
 drVFws1hWoznz6M8xIzI/IuX47xnhlfq/NQWSpqYpezkqBTPmvguGawYa3kP4RWi/B21lsvMo58
 TGS/BcoZ9ipgPzLxDSZIYcdCKSpIhhGI6I/ZiIbtfvAIiraNip/NDfowC9Ne9kLBEs/6VLhbp2Z
 r/D2zqCmi6l7CsJIdWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250081
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,packett.cool];
	TAGGED_FROM(0.00)[bounces-230319-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 07FB532423D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/26 6:25 PM, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 10:38:36PM +0000, Srinivas Kandagatla wrote:
>> As prepare can be called mulitple times, this can result in multiple
>> graph opens for playback path.
> 
>>  	 */
>> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && dai_data->graph[dai->id] == NULL) {
> 
> This is an array of APM_PORT_MAX elements but we have DAI IDs in the DT
> bindings over that and now we're using the DAI ID to index into the

The driver has dai->id indexing the array in most places, and that is
how it has been for a while. This is one of the problem which last patch
is trying to address doing a check on the range. At somepoint we need to
move to dynamic allocation tbh.

--srini
> array (I didn't check for existing instances...).  This might be
> impossible due to system design though.


