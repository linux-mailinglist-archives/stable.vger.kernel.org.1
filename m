Return-Path: <stable+bounces-194781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC6C5CAA1
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C74BF34F77F
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954F31326B;
	Fri, 14 Nov 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HyyIsd7N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tt4JQ2Of"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF903115B5
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116907; cv=none; b=Rfd07IbgNIJvbOEIdKAUjJBa+D3YcIjNAh8LjlrBZvXIFKfNDJdaGe6M8rI/1HxecjZZS2uu7b2yMmh+VRmVuVnnBMZUP+9lnP3wwC8vUIzMt1Kk0z5b7qpW3TPq/gHLoBzUS6T+FBPcM5Xz8tRAay18WRjXpKfEn3uO/p3XxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116907; c=relaxed/simple;
	bh=FWRS6rfuA3M4tQOLPtzKGVQJObMnHGM+3P/mKoL/Adc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apxA40rKZ8OWHK14Ch3e5kKJDYFer0qSklrQO/m8SBkjfSMyq3H5rkpWGDsGmqv57l1kJx0J7MM9Lf6qGXzNCsIbe1WLgu8P9DY3DuVSsAcTQX1x5fUHVW/6egvwp/u4mtQOPAd0jFK/VNGFCLW8sATpDm2eWGpLdgTBKXx8gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HyyIsd7N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tt4JQ2Of; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8CVQi1745332
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 10:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CiP73qI4pEgUV+FvYEu/Z/eMM0H8JKHxQ0wI59cmF0s=; b=HyyIsd7NGa3Ic5YY
	QZbOGDRcez3NJeQ2taean1d0hOBxQFSF/IzVcpYSOkhScEqJ5mt9YMtIN/xxF/8C
	uLMSsRHqlDH2z6KlWgE6a4yEuHLAuIsePgyIFYRq7om72Wl0aLlTsNnJLofqAgdm
	L8KvVomKgwZVCxia6C5DvN3cwbSNRavdyNgeeTJUDxnjt16abQUnOwL3yTjB4EtN
	v56rwRL0xWRVEU9lM9aoNDph1H07iAMkfFPhrYX3uotyxPBIlck/To2EkRdrzDAI
	JyL5n3iaLMGB86s3W0PJBFQhgjil091b9oSMNEzHDL4T1RDbsSl79ylB70HgGYsu
	XraekQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9ehva4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 10:41:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630753cc38so4053379a12.1
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 02:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763116904; x=1763721704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiP73qI4pEgUV+FvYEu/Z/eMM0H8JKHxQ0wI59cmF0s=;
        b=Tt4JQ2OfGWHG6b5H/Ac8k/j2f+ZnGXPyEvq5kAg+uoTmn5OIrzz6axNll4n056hqVx
         hCMs4zD+BwdbF34wQcg+OTr3zGkPYol35UtaPQMVFqO3hL2xRLnU4oFgkQ/FbBJUJS4F
         lYa5eDAJNwE8ZO6ePZSttaHL1bI+ro7AP7un+gWYZ6q4zHe6yYHmku2vDxwEAodJQRK3
         VAtFYj6ejG4OhgoJY+eRm9QdEY1jdwFSnJSMmt6xHMlkK6BqRS3BV2GKNr3lfKxVTF94
         an5ycv/oK5znFMfLjPjz/VeZyWtvmHC6Qfw6Moz4gCYjPB30pBOcsIu1EVO5PzvNxjXt
         vlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116904; x=1763721704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiP73qI4pEgUV+FvYEu/Z/eMM0H8JKHxQ0wI59cmF0s=;
        b=H/ryxaDzvljeI7mwOaOHLBu9ogG+6meTZ4ww+Up+8Y+2wzyCWKdf8RV3MqNSyX8QXU
         POFbfZIanm8mJo18WV0QiPSeVPXHn+wLwTtnFfVk0XX18LAYDXjR8LexLxGtRr9Sibv5
         ceIKPdsa5Bs2uPDHs2M0efTZ8ZnHAifsSm0HjXM5tn7zJ62nntTuGyNCbVIh/CQY6EWl
         cCibdNEIE3Oo0wCW8idFOYKHCTLxjLHh6ApYtG/92R3ehPHelh585TcdPBdKocSanSKE
         3ZCJxsz1ZeAS+fhJq6fr/j22ZcrQAAOTHHvAT9OnZLD7/LOA3BqcuV79GFZYDy7uxIYL
         KonA==
X-Forwarded-Encrypted: i=1; AJvYcCUzbLphr4e139d5cSjXQFM0EQvTmiNGzTuSOyiojzAn5qKYSz530xV0sb7jeoIPEXEhYf0bLR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUOmpDAGy9711KMFSwHdVKsN5YZRdollt8iossb6CyPQLA+fQ
	2it8uNv31lQ0z8CQA2YmKKAUoVHFzrHoInGkUIq9ODw4Los/eJ9mtlAAc/Ol6xjTvZUbi/HUuG+
	0MeAhiN6MwBeYIubDfBWw2xRYKoErHzUZefum/ZVqez7Do3RH6tiKAXdktWw=
X-Gm-Gg: ASbGnctEHmiwIPI59va6xQfypCNt9UhGzyZApJQdNL95qWAcM+Xrhu8H/lom7rTdjhM
	KsKLgLQRD8ck5Xp0KNytIPxIrI5kzynlw2x6Lb0+veY9Qr8/b/TZzRp+6P6mj2RM10lrxchn4B3
	Xt+fP7cO8a9+n9nJDyJSFTMftWVD3F9ms6d5iIErUA+wQKvSu6BQhJuadZl0W9JLe9Ys04LF/ZJ
	dZ3f1FBaAGzbrRSrgy0yUJeHnf8bZu4xMBihw3vd/WXOybXQh1hXoHwTd/fx9Lve7QoGRvqjDBv
	k6rqtxIdBQoWefHDUhG252Mea4WAsZBjVUOOKpx2cf6ldg+785q7lhdhJV3Te/AqOzdY46Syj68
	2UkZ48t1xWUJ8+390qC7aGGcM
X-Received: by 2002:a05:7301:4613:b0:2a4:4f52:1fdb with SMTP id 5a478bee46e88-2a4abd7173bmr658576eec.39.1763116904237;
        Fri, 14 Nov 2025 02:41:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8kch1hbaPQUPyIY0msT1HJwSc6UxlU2GxUQb+kuMAMGN+yWhCSUCiSgKmsyjTc3BQus6KJA==
X-Received: by 2002:a05:7301:4613:b0:2a4:4f52:1fdb with SMTP id 5a478bee46e88-2a4abd7173bmr658564eec.39.1763116903630;
        Fri, 14 Nov 2025 02:41:43 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49da0662dsm9320970eec.2.2025.11.14.02.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 02:41:43 -0800 (PST)
Message-ID: <32c952e1-39c0-421b-ad77-26603907d444@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 18:41:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20251114081751.3940541-1-shuai.zhang@oss.qualcomm.com>
 <20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com>
 <967d99e5-7cc1-4f8c-8a1b-21b1bd096cb9@molgen.mpg.de>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <967d99e5-7cc1-4f8c-8a1b-21b1bd096cb9@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA4NSBTYWx0ZWRfX0GeYja3BSB9X
 pyKNrHLv+GyJGOwKFuiJ1g0cywzRuSj8nI6OH/3X5VPiNbnnF/YO6zc87p7rPjsAKl63/d+zUG7
 AIGZsNrH4t/SAg0qdIqR5Wsh+OPZ1XJRyCFqwR3y7SJ0dBFG9MjU2vXZSjg6/QPSKDAdnmDk+jo
 OkwJ7BD6k98Vj2UEcnQTZPnSftY1Hp2kW5ei7QfWdXmrnDq5cihizomWHow4mCPOfbdqAm3k6u6
 iQc7sCE9lVkRBFKJZ6si8kXNUFLDDAeKqNLvaZN03gWHh6GkI3Ef0OM75ZfEp1/FhstoamtrOc5
 mUUy7H2IUXd3sJTu2nyPWTy2Xg1YUeBIFTWG+0SdopBKF38S0Qcm9Gq6jhgt77f/UfYJ9zmCJpo
 UcSauYPFxo5NkGku+si8DS3hg9zKWQ==
X-Proofpoint-ORIG-GUID: pWBVzhZ2lbUFS_dJ7cFht_kEUfJ3MQD_
X-Authority-Analysis: v=2.4 cv=Afu83nXG c=1 sm=1 tr=0 ts=69170769 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=IErVSbJppH_-YMdZ5rYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: pWBVzhZ2lbUFS_dJ7cFht_kEUfJ3MQD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140085

Dear Paul,

Thank you for your feedback.

On 11/14/2025 6:04 PM, Paul Menzel wrote:
> Dear Shuai,
>
>
> Thank you for your patch.
>
> Am 14.11.25 um 09:17 schrieb Shuai Zhang:
>> The prefix "wcn" corresponds to the WCN685x chip, while entries without
>> the "wcn" prefix correspond to the QCA2066 chip. There are some feature
>> differences between the two.
>>
>> However, due to historical reasons, WCN685x chip has been using firmware
>> without the "wcn" prefix. The mapping between the chip and its
>> corresponding firmware has now been corrected.
>
> Present tense: … is now corrected.
>
> Maybe give one example of the firmware file.
>
> How did you test this? Maybe paste some log lines before and after?
>
Should I put the test log results directly in the commit?

>> Cc: stable@vger.kernel.org
>> Fixes: 30209aeff75f ("Bluetooth: qca: Expand firmware-name to load 
>> specific rampatch")
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 7c958d606..8e0004ef7 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>                    "qca/msbtfw%02x.mbn", rom_ver);
>>               break;
>>           case QCA_WCN6855:
>> +            /* Due to historical reasons, WCN685x chip has been 
>> using firmware
>> +             * without the "wcn" prefix. The mapping between the 
>> chip and its
>> +             * corresponding firmware has now been corrected.
>> +             */
>>               snprintf(config.fwname, sizeof(config.fwname),
>> -                 "qca/hpbtfw%02x.tlv", rom_ver);
>> +                 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>>               break;
>>           case QCA_WCN7850:
>>               snprintf(config.fwname, sizeof(config.fwname),
>> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>       }
>>         err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +
>> +    if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
>> +        snprintf(config.fwname, sizeof(config.fwname),
>> +             "qca/hpbtfw%02x.tlv", rom_ver);
>> +        err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +    }
>> +
>>       if (err < 0) {
>>           bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>>           return err;
>> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>           case QCA_WCN6855:
>>               qca_read_fw_board_id(hdev, &boardid);
>>               qca_get_nvm_name_by_board(config.fwname, 
>> sizeof(config.fwname),
>> -                          "hpnv", soc_type, ver, rom_ver, boardid);
>> +                          "wcnhpnv", soc_type, ver, rom_ver, boardid);
>>               break;
>>           case QCA_WCN7850:
>>               qca_get_nvm_name_by_board(config.fwname, 
>> sizeof(config.fwname),
>> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>       }
>>         err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +
>> +    if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
>> +        qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>> +                      "hpnv", soc_type, ver, rom_ver, boardid);
>> +        err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +    }
>> +
>>       if (err < 0) {
>>           bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>>           return err;
>
> The diff logs good.
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

Kind regards

Shuai


