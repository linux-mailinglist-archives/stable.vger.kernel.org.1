Return-Path: <stable+bounces-219589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPviI4LgnmmCXgQAu9opvQ
	(envelope-from <stable+bounces-219589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:44:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD93196C3B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06B7A305EBB7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004439447C;
	Wed, 25 Feb 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1ocSeFS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQvj1QF1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDB17BB21
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019734; cv=none; b=sDDPSBxGMP2m91CdNl+iEO3d6EGz//Y3okhmqu/Dd2HIuF5P5p6CGW3fspKhETTvrUz9A5gFaRJ2TV2aUSuTgJR5kUPMv7hOJEqhb3rvHKy8bdMLM1fQs6hFlVW83P4k4pNDIFS8i79Ccklpc3DGOLKl7R/yBMQUXOFFqy7OZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019734; c=relaxed/simple;
	bh=U3I1rtmweXCAohfcPrcHMKyxorh1ZVQ6eXNhFsOs0cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCU4I2O8QAdfNVXKkwLtMM5KyIUwqNJDppHb9gcMA+HzgodONGFVTUY1EYk0vrPKNKQ97ZdI0tc5EHVPZTTZSCmZnriMcM5gNescgQZotc4cTM1KS2jacloTmjcwDfGJxh1Z+jjbkLYjuONX9YLIH1uqZRMLwLhTQicCp6dg7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1ocSeFS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQvj1QF1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9StI52127825
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 11:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M0OQnEeU5Q+WwKOM0afwTTmeLdjh3sD9aEF0/WZ5DEc=; b=Z1ocSeFSSKfx9CKk
	Z7W7lxxpWsPTa1SXmVzYfh9Tc9OUamekzIOGJdCotWmggY2LGihUWpDGwbDa2R8q
	J+9PUy1yXQAuSOE9iOov3bPcrZCcYVH12zqUWzDCv2wL6F8aFQOYsIpm6vJusyRA
	lrHqP0uFLgRlvyAcbDKYMkJxVqvx3ROIFUamKt5LYKbK345laD93SRgbiqTYPkYt
	Op8U2WylGH8jo9kWQVmJRXTA4rPcyDUvOcCtvDrpT153YNiK4TeP95SO2uNmfzkU
	sNZ6/4wdA378RPxsfvHPImn1K3UxlOLDmMoyvZXnawuLmf3SBHzQBERmdVaU3QIr
	sbmFIw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chexekbar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 11:42:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb42f56c4aso5653616385a.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772019731; x=1772624531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M0OQnEeU5Q+WwKOM0afwTTmeLdjh3sD9aEF0/WZ5DEc=;
        b=SQvj1QF1dChKO3YDF7Y2nU/DbmpPcjJ12CO0vsj/FN2NdIweK2sEHZqQgEORz/jwBb
         sY+atHAgYgA2YUB1GhqSj/j1Y+6JhpB7e3+TH4/94u02kD3vOM8emMBpu3Cqf/rUo+Xs
         cSOFpOyuLrOBJ+GH7jKVR46rB370ufCxWUbRrL3U3Ha/pARHrFRliZmdya9Eev49NMWk
         ZYWuwSN2EXSC1IiTXIsVMavZ+TeYZx/G6gz/iagGJGiDVa2MpVVmT0+hvJ74vN4isoiH
         nEDGtAfCwJ6cdmgHaMF2Tb9r0KfL/NSpWQKRg0dEELD9BiHroDW5UsAD7COurlTX/gTO
         acIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772019731; x=1772624531;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0OQnEeU5Q+WwKOM0afwTTmeLdjh3sD9aEF0/WZ5DEc=;
        b=pj9iTscqGyI6hZvno0+TQSgdarQO634J4mChOcQFokjDADS2JgbYg819IJSqu95FlG
         ThPp/VtGuSxov37OamAfNfK8VpYiviqYqrtwyrONJNFgproJ6wrTYnRh3p8FYW2DCV7H
         7GOFqSJyM2Ipw1sUhQ6M/aMGmlp0fF5p2TfhYDtcJt4Z2GzdDtKoh9k1qra4c/N6XTkc
         TfaZg7bBaR1gN/qNFPbEEOHNp6XI2ks+DE3geKKE/Iv8BPLBEIbQysmrvgd9Ckd5oU6g
         /mU5j2PUddflIA9am81KeoSUe7wq48eowqWwIhwZ5cVA/g2IFXv8pBLqtOYDoOjIUjep
         PNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWpktL1rTIy34avzBKfxsM5wqEeYkOt8eoUBfWc5vH8jLPut7+52TgynNuSBYBqUl05APAYvqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qIxHg+6DhK2m3BuUXOzdtuvhYEGmSdBkXvPagTjHjPDyYyHu
	IYO2HzVX2EG4FqnLxvyruujflbKvyHhoKG6MVVaOahnpw16pwLHuC8F2663LL1iqQelS29fs0iD
	zCwabSQh1B9yw6wBlIvnxii1t9xlaKf3iF5fQ1iTRtmuMNu+6iHnAehT4KBg=
X-Gm-Gg: ATEYQzwT3YmeSIMeSz3eHSbCo8tLxuyn1KCKTDbJ2HYNktmctteFNWcMLoX3c4+6u2I
	ptJcjbocR4CrgvVzOdm02qu8YpXiLYCnf8CYksZyOpCthDad9lgX7fn+EC2iXI9Q6FNkA1AG8uE
	kyCpVRNNS3Xsh7w6hBZd21tCuL7aigobRLvYVnqDDlzL4cT75SGBNf+5zw/Gkk75qB00/4G9cYT
	QyddD08Q+yL/xSvLcZaWbIHSAqgUFspC3/gfjrUhSoAa77RZpFzNV0Ijvbojcm+STlUa0S+7iNl
	fmvdfh9fLZDkwWzn9slOLvzp1vn9PD0yfWRiEMRf7o8mIt/cfz47Sn9zVq/rm2BSJB5CRddy7t3
	7BwHscKnkhGOXeawc3BtqjkmmKHKdL6KBchcxOzctCLWSH+j2QQ==
X-Received: by 2002:a05:620a:4094:b0:8b2:eea5:32f8 with SMTP id af79cd13be357-8cb8ca0d5cemr2179428885a.34.1772019730882;
        Wed, 25 Feb 2026 03:42:10 -0800 (PST)
X-Received: by 2002:a05:620a:4094:b0:8b2:eea5:32f8 with SMTP id af79cd13be357-8cb8ca0d5cemr2179425985a.34.1772019730386;
        Wed, 25 Feb 2026 03:42:10 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439934cc51csm1432467f8f.3.2026.02.25.03.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 03:42:09 -0800 (PST)
Message-ID: <b4c42f88-80fb-488b-9ca5-95f5795fd2f8@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 12:42:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] firmware: arm_scmi: Drop fake 'const' on scmi_handle
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        stable@vger.kernel.org
References: <20260224-handle-not-const-v1-0-90bf93b53e27@oss.qualcomm.com>
 <aZ2aBD_u_RVhgsei@pluto>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aZ2aBD_u_RVhgsei@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDExNCBTYWx0ZWRfX/S8MljT6oHAZ
 8jHLkEy+f54OthLcYqL+YhBCbmM0wi8+g2ECdSlm8j3mqGWahYSFSZ6dZyFL30Iy8viW117MKyj
 8wUX3Sf/SEwedyvrbiJLVcuy9gBqENeGHfxjhKKj6pmdasYv4sd+oEO/UIBADChHq960vV1QQ1c
 tEY6Z78DShV9kn6Ef7tLvzETKQxKXvWOD0he496cB90wUjk4f2Mc2k7B1R61ZOHx8CGYNaPudBz
 xgfN/bfbNIRlMgqoLE3ZOfmBehHYkmL3F/+9ILPmmKZZMbs/6/oUZBIFE4f7azr9Yc1yKnVPpLO
 xJnGV6ncqUorTrIpSG0817onxyIfaqBcRvq4lNU0Z7WcnMIi48PHsWnLo5v4yd1HN5Y1IqTS+BW
 oIY4LWzMfAltKkVErHWJwYvNoA+AY6kuYmx5Hdq+arFEsmGPLZJI82wvDc71OCJy3+e8KiatVT1
 mQe3BbQ5Tp3fgkhvMOA==
X-Authority-Analysis: v=2.4 cv=V85wEOni c=1 sm=1 tr=0 ts=699ee013 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zDAgSCSiOJkZ-3sd130A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: iCLOZ7M4Um906ri7ZkWbqSmQRUpfPTLW
X-Proofpoint-ORIG-GUID: iCLOZ7M4Um906ri7ZkWbqSmQRUpfPTLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219589-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DD93196C3B
X-Rspamd-Action: no action

On 24/02/2026 13:31, Cristian Marussi wrote:
> On Tue, Feb 24, 2026 at 11:43:38AM +0100, Krzysztof Kozlowski wrote:
>> Severale functions operating on the 'handle' pointer, like
> 
> Hi Krzysztof,
> 
>> scmi_handle_put() or scmi_xfer_raw_get(), are claiming it is a pointer
>> to const thus they should not modify the handle.  In fact that's a false
>> statement, because first thing these functions do is drop the cast to
>> const with container_of:
> 
> Thanks for this first of all...
> 
> ...but :D
> 
> ... the SCMI stack attempts to follow a sort of layered design, so roughly
> we have transport, core, protocols and finally SCMI Drivers.
> 
> Each of these layers has its own responsabilities and the aim was to
> enforce some sort of isolation between these layers, OR even between
> different disjoint features within the same layer, if it made sense,
> like with the notification subsystem within the core...
> 
> Now, given that all of the above must be attained using our beloved C
> language, such attempt to enforce isolation between such 'islands' with
> different responsibilities is based on:
> 
>  - fully opaque pointers/handles...like the ph protocol handels within
>    SCMI drivers...best way to do it..if you cannot even peek into an
>    object you certainly cannot mess with it...
> 
>  - some 'constification' when passing around some nonm-opaque references
>    across such boundaries
> 
> So, when you say that some of these functions sports a fake const
> reference, is certainly true to some extent, BUT you miss the fact that
> usually the const is meant to stop the CALLER from messing freely with
> the handle and instead enforce the usage of a dedicated helper that sits
> in another layer...

The caller can mess with the handle, because of container_of() cast, so
there is nothing stopping it. I understand you want to express that
handle is somehow unchangeable but then as you mentioned - it should be
opaque pointer.

> 
> As an example, when you say that the scmi_protocol_handle *ph is indeed
> manipulated by scmi_protocol_set_priv() and so it is NOT const, you are
> certainly right, BUT the above function and the protocol handle itself
> lives in the core, a different layer from the protocols, and indeed the
> protocol_init function cannot change directly the protocol priv value
> but instead has to pass through the helper ph->set_priv() which is the
> only helper that can touch the ph content...
> ...IOW you are forced to respect the isolation boundary (as much as
> possible) by the constification of ph...if you drop the const in the
> protocol_init protoypes you end opening the stack to all sort of
> cross-boundary manipulations annd hacks: helpers like set_priv were
> added to be able to manipulate the bits that needed to be modifiable
> while maintaining separation of resposibilities between latyers.
> 
> Similarly for notifications, they are kept isolated as much as possible
> from the core.

I understand the goal this code tried to achieve. And it did achieve
it... plus another goal of having "const" like functions modifying
memory. This is not a readable code. Function which receives only
arguments as values and pointers to const is expected to not modify
state of received pointed data. But all the functions here, because of
the cast, can or even do modify.

I understand we do not write here C++ const methods, obviously. But all
these functions look re-entrant from the interface point of view but in
fact are not re-entrant.


> 
> So, I still have definitely to properly go through all of your
> series, but while the usage of container_of_const() is certainly a
> welcome addition, because it raises the isolation factor, dropping the
> 'fake' const seems to me a step back in the enforcement of isolation
> boundaries between different layers or different subsystems within the
> same layer.
> 
> IOW, the last that we want is to be able to freely change the content
> of such const handles from outside the 'island' they live in...

If I understood correctly the composition here:

The handle should be in such case be not contained in the upper
structure, but be a pointer to const like:

struct scmi_protocol_instance {
	...
-	struct scmi_protocol_handle     ph;
+	const struct scmi_protocol_handle     *ph;
}

And since this is 1-to-1 relationship, the scmi_protocol_handle should
have a pointer to scmi_protocol_instance. This way you keep passing
pointer to const handle without ever needing to cast it.

The current solution would be much nicer than above, if the code was not
dropping const, IMO.

> 
> Any improvement on such isolation with more modern C tricks, if
> possible, is pretty much welcome, i.e. I am not saying that the current
> system is perfect and not improvable...but just dropping all of this in
> name of some better possible compilation optimization seems not worth in
> terms of maintainability...
> 
> Does any of the above blabbing of mine makes sense :P ?
> 
Best regards,
Krzysztof

