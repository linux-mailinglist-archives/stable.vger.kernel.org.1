Return-Path: <stable+bounces-235614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMWmOlq72GmmhQgAu9opvQ
	(envelope-from <stable+bounces-235614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:56:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5803D465C
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B58F300EF4D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCE3AE6FA;
	Fri, 10 Apr 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzugPAnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXUEBXly"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234843AA51D
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811412; cv=none; b=obYuMxCT8qKvKqdPDbNP/kP/Ayrf8BfQlbNsMW789hAS1FFMhFHJxuurUPIpnsG6a5Ql2j7xQ9buq0KI1N2OWpWHRpq5URi3vrpG5TFT6uJqfm5bezFZu384XLQUUsDdkvOIKMgmEVkNLCMAl6Bsce2TxYBLAwR8u0bhh9PAUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811412; c=relaxed/simple;
	bh=4ll411lMrhIlzuNnvMxpl7djAMvUCJvTPlpnDmRVExo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlXPwNT8brzoYmuOaYPwpO6ocHU/Eba1YFn0kpkApJpDvAkrOlYGAcgdpP3DTIw3Ut+HfQcupzepTiZt0aZEqWZ9QQgkFdsDsSe32AlO+YJjWNaoZ5nFuh5Aq7t8kYDwrZUKpZn/TzpTr1ts4FOg+zkG326+qBtY2/kmmKz8TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzugPAnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXUEBXly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A7E6TL3934514
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DpL5uUa/L0RcqMu/HKlHy5vqEr9XMka9y9pgSUMJX/I=; b=kzugPAnQnU0tgLbI
	wpNJl8YN+Lalu7vBgLTIiyFqTiznEHZJXgy5fg3a/eNjj/RTmVy2SdCTpEJdp0nz
	j50LPD/ZUtkrLz/NoL3Ak6ssgYsTR81CSmLXgHsi6LmVl3S2IHiXf7P2w/B1+xBs
	VwJ3lqWsI7h0r+ARExdq6HHFV+9fMx3WfHPtC48XmlZPlwyrB+CZWZpjvGp1km9F
	PDJFDMzFgpHivpZRIP4NU/CaTMzR8J4i00XLda90phSkLuutvAqOG9c2nuspHTHT
	eNw83w8dJyc+MQUA+gRnnhMTxvqD2fWgKFpQNgUah89m9NMFnh/nEdd3y0YTxZLH
	NrMXGQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sbb9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:56:49 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12711ec96fbso1401977c88.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775811409; x=1776416209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpL5uUa/L0RcqMu/HKlHy5vqEr9XMka9y9pgSUMJX/I=;
        b=SXUEBXlyDPCWaQkxKZWcPDUTbRZofLxiKx3mUTDobDCDgHnhr0/XoXFpZ7UV4JwEvZ
         nvaFyIlXG1zYJ+tj02CDWDIEFYDRbk+4WnMOSS7rrPckLFUpjRfq405N+XXdodtHjZVu
         ZyPvoLNc1z8MCGwFXiyIhfajZw20Jle9GNsUemMQelEIOFuTta8Kq4WEVBUxHldmSNI6
         dQ/7L5YhdDFinu6lFY/Bm5BAkzZCwyMjgg1oERMsHrPal2atAMjJPd9f0MGX2RbvNGz2
         hIOYGHxvVcFLHywoqYHZXGmAdyzJe6TCHE0ZtK6FaV5GB4JBjHDHkHfU3E2F1b1Sw7fH
         KfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775811409; x=1776416209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpL5uUa/L0RcqMu/HKlHy5vqEr9XMka9y9pgSUMJX/I=;
        b=tRVs/b+rD/XFNYKMq8p5r4ufBL1pOvg9XLFanGuGY2ic4he1hnypTod20qFB2PQ0D2
         U4+dRqD9fziCNQtrbJYomd73t4XxDMu0M41nqVI6rq87aXfjhVfjwSFRCTt5gjY9lZqV
         d1OiHGFmPPrR5YSYIloIRhT+Ie3UGG7B5tIgu9wJ+FPk33OX4dWVATI0hwKEmZKtsQvL
         sqB1INx6ijmuBpRt4qDhDBcIKfZJvpLeUJjqYZYInvURowhyAJXQICIxphCefnzK4XX7
         CRSdbNjzjRhEeGF1B2Zq/VGLV1M0lsLVh6jHH5SdUf9H+yJbLBmy9HLfXxoLyFSiUK9m
         vBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLBvWbLHn8DHRQUPJXPvdtnt0euyCrSFpnh8636uTqhlxpireDCuwbgoErtEJ4WRw0z1wMcI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlckqDMSL5WMJ1aijsl+h/hfuU4iPMG6fP4Ab+RMXnP99ctKi
	v0mIIizdpPp5ua18/tr53YgFLtYCV1NRxWsyC33rUajanrft9b0sdFqt5qrR1NZOqZzwsLXlmR5
	xKrlduhXNLeAK5CAn2MGigOpzJUPT1gs57LUg8G61nTguGnI9Okw4QtRvDdc=
X-Gm-Gg: AeBDietfXOynfGjq2UV0PVISO0YjqLqyJKd+2WKzCrgBwd9jU12Aus9KW9QEfPKt13G
	UQ4AwoB1xL0guOxIhyKfsDc68194pgwae/w9HfVOb27Gxs6STfRAREp1D1Y0hc4/LoLfVavLL4j
	WPcdwXiMAdlC3W3x83rk8QXODtgVg4tIEqm60eKuIYJSgLrG9Lhwazq8GQvcRCpPdTCsRCIzct/
	PB5BECmwdnHLSUdpUoL33Q+ECDSIRHkJd3+fif7Ol95qsc0psTsQEejeFi5G4KzryXsa4xujrHb
	iOONXRUqCFPpErAe2NYnWYW8yv9G1UrQqO72ujTNzslfnsS4bcQg2vVCxPB3fpbU8fJ9fxkZWwv
	AGOFCnfYE+BoulDJAeJ2y+da2UR+3zI8V3dH7Rj9tjZJs9uXk
X-Received: by 2002:a05:7022:e1b:b0:128:d107:da0f with SMTP id a92af1059eb24-12c34ea9471mr1340456c88.10.1775811409007;
        Fri, 10 Apr 2026 01:56:49 -0700 (PDT)
X-Received: by 2002:a05:7022:e1b:b0:128:d107:da0f with SMTP id a92af1059eb24-12c34ea9471mr1340432c88.10.1775811408369;
        Fri, 10 Apr 2026 01:56:48 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa5257sm3342942eec.9.2026.04.10.01.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 01:56:47 -0700 (PDT)
Message-ID: <f6a9419d-5e63-4c36-a7e9-aab6ac798703@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 16:56:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b9JV1kQVuN_CqGc4LnBduYQGMPb0YdeU
X-Proofpoint-GUID: b9JV1kQVuN_CqGc4LnBduYQGMPb0YdeU
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8bb52 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=mEO4ALF7hCPe5JJGosAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX4qgpIo/GcrNU
 cUnX+leVUl3MM8U4SQaD9IxKbfQBxbxrg1Ve4v3CB4R+HXV8zsEjje3ma3QCWhwu/YMsfPp9t9O
 rDi0sc2dqXFkf3kFTq5awZuN/hyzje70Bb4jH/iyukKhTwoAiDdNYKjXL7gNF+KJwuJ87KUChv6
 QWbY7lUs5EWzkTQ3Sh0Rh0q4tyEsLhvjH8FNoicyb8w604fXl+B43UYSlSy/r+llqDzoAfWnuJv
 ieRDO4i4d91kmK8SLjCQgPC055gTbaQO86CyVzhmc3FFTC+Ac+hQ/ssUjIJw6X+0uZMA/goqtwN
 xJwes83Kv+L+B9OE8xNVxM1EgAFSAuYWOBgFXxiG1uBcD+IkNnKh79QfaAplwijK+Yv6UWgMqMt
 sdAtdXgdHuwxz1oprZk1EH7qPLgZ4BiEN4vxom2QQOsyMdepVq/m/w2/gKdGvQiwrhWi2Xf3utr
 YuL6Rqcr0LtgKcnnKiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100081
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235614-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,mpg.de:email,sashiko.dev:url,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuai.zhang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F5803D465C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz

On 3/28/2026 1:53 AM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Mar 27, 2026 at 4:30 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> From: Shuai Zhang <quic_shuaz@quicinc.com>
>>
>> Since the timer uses jiffies as its unit rather than ms, the timeout value
>> must be converted from ms to jiffies when configuring the timer. Otherwise,
>> the intended 8s timeout is incorrectly set to approximately 33s.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> Changes v4:
>> - add review-by signoff
>> - Link to v3
>>    https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
>>
>> Changes v3:
>> - add Fixes tag
>> - Link to v2
>>    https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>
>> Changes v2:
>> - Split timeout conversion into a separate patch.
>> - Clarified commit messages and added test case description.
>> - Link to v1
>>    https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>> ---
>>
>>   drivers/bluetooth/hci_qca.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 228a754a9..d66af13ab 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
>>          struct qca_data *qca = hu->priv;
>>
>>          wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
>> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
>> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>>
>>          clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>>   }
>> --
>> 2.34.1
>>
> https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.qualcomm.com
>
> Comments seem valid to me.


https://lore.kernel.org/all/20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com/

The wait will be woken up once the coredump collection is completed.


Thanks,
Shuai


