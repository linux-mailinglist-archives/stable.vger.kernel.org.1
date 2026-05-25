Return-Path: <stable+bounces-254073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tr3tHBDWE2pKGgcAu9opvQ
	(envelope-from <stable+bounces-254073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:54:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A05C5C91
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6C7B3009F0D
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687912F7AD2;
	Mon, 25 May 2026 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hb6Xo9KY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EzHsKmf4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF230C147
	for <stable@vger.kernel.org>; Mon, 25 May 2026 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779684876; cv=none; b=DZGr2JrQGJmZFjXcKPixIVP4Qao+hm3PIcvFvQIPnTOQ88IzdzvldqlK06ikuvLL75MbnWnUUlPrzxPaLxREC/t5tVt1DnqRCro9HUvV2Ne+4/4xtAmN2inaacUnM3mK6ra1zakO1VdwKV0jaWqquFA9Mqup931535QAJnIecSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779684876; c=relaxed/simple;
	bh=mLKpSdg5UZFpJKCKH2pdp7Peb+6WwPB+uVGIggRnO4w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kT5U/sF4nSTsSBOSfRFC/artPrrcRQusVrD7Gim9cYKmrt8H6IYh4j0Co0togPY68RCFxyKad/rNgMiFhs3XyJADl3tx+m3Jr4Jcw1TeJofB3jjzjvmWU7SbtbUv2FA6CAe2ezm2zXs+8vNa/Tm389DmR9Hde6HMo3vf9U9g7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hb6Xo9KY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EzHsKmf4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P1eb3K2297568
	for <stable@vger.kernel.org>; Mon, 25 May 2026 04:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0Rs6oaK/jqTub1cx6UO6JWIsXdV1vKT7AXCB2yogII=; b=Hb6Xo9KYv//g1fLV
	1vC3sk2gtWb5ZAtlbZAwV4tZ9K/XU5SkQawELNH1e3B3pE+sRwxxya9gqIuJtIPD
	Uv3vMvMiYaTov2Ork8PeSRwyZLdyR9HLWids/TF0dyXndIuPet9XgUyRWFN288GV
	w1bZZkJUDrKjwxDszG5BSR70H3oVekswagSwnuuti4HzcFU5ahntIQPX68oYnDhS
	nhpcFOKso9ZgFDC7h5cBA18KD3pvh+1ViW6vBXP8sc6zKSreqYbbY1N1ZFY5TxK+
	PmiX3e7pbP9p78fS+Q/uL/1vQL7YVBy6O3o0xIJgCvzMr0Y1b0iNepm13Nq8xyFv
	/Y/0lQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgw22y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 May 2026 04:54:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-135f774f5e6so7722105c88.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779684873; x=1780289673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0Rs6oaK/jqTub1cx6UO6JWIsXdV1vKT7AXCB2yogII=;
        b=EzHsKmf4WaRUBwcjCy5qquoACQyDxvc1TkMaNwqjYe5LgEautzQjC+AWCdjdX0tD6c
         FfVkN+mLBEN6/u7c5kl29iD0LwLUTZRLm2zQb1Z+pJrZWIxLHbQPiUrJ833ds3nqVgUu
         kVwC+D0YCtrEjlOTNXfNoIiVdYkQjl0zK0iK/zu3Ph0fDgVFDzcrfrmgfB0gJMTLJv1x
         sODg9mRYskUIk08hSyHeiEwDsPYQWwXvZ4MnhZpJ26k56FN7lXh/9tkKVTu/A5E8MMGe
         uERkP5X8qU3R8PbegF5D3KXx/3bcahsLg3iL5ACJQkY758Y6+yz627Vx/ZCecwgmL/R8
         nr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779684873; x=1780289673;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0Rs6oaK/jqTub1cx6UO6JWIsXdV1vKT7AXCB2yogII=;
        b=mrWL5gceQs5yarx+Sl0hXL+1dSXZVfBDPducNK5Gn0TRGNzBlcZ1rv0efWr3EXu1f8
         cMpwQtHVmUHbJUJe6LEM1MO4fIex8651aJg0GX00Z1Y+9KJTTUTkVCeSYY2Ulso1HLt0
         tiAEBDFhuIh9fqULf0lVAcXYveh4ubeVQsngkhQn7yAeAGY9JTDYz8YZDCQgK8lshX/q
         2NADqVO1LdUrQs65nvONTMT856p8rvhXNSh+fmrJ2WIvGK/3VR7auSOfinCzR7i7/imp
         9BEHUmQvzwMhMN0eYMdmlbZBq7auw8Ky1S4HW/2RMaA1qNMWBwP2zfZOl22043xomFic
         I7/g==
X-Forwarded-Encrypted: i=1; AFNElJ97HBlF4eG7gqc52kX7RJWKCasNxDD0TbQL24/iutfaylpGx6DDrR5Aaj5aX5jfetnZzbcv/JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzyg53Ict6ON1b4JsbxZnh3k69vzsJ0NVxpRaW9R0BClrxMmBn
	pm6eR4GdgtN/bHdOCCZgReGIAKtEhY1qV4bPt+YFnefizkYR7Lo7JMuxLGYZAgJRJDOsLXBJ138
	TU7mn+GZcL+U23Wb74lIPFjsLNn4scdBc6ylZRuP8e1+mrJg0hYfWLERgk+o=
X-Gm-Gg: Acq92OFF8nWFaL7YibJOK5K3lYLqk8fSe6rPQT4ZzVDaIVGjgi1NbM+9ldqzEhhTrDU
	4hiwTNyHRPmQ48tCs5Dq6MfFurptbkIGIZ8gDwIlvxk+DEWInX/NPnHKixbrs+Tlp028iNVi3fw
	l2wqKHQuBAgDoniHgAjNAFZ9CBPsqyH7ayby0N/KioxKPy48P87h/B54ux2e2+ewzluH1gUXRQZ
	ImNeBAF9R9WZJr8R0tcVG5D+pjE1DOh7TwUb1+TxhWI1dAMLmTUxccztc82qeGE+pB/VL9Pu6o1
	wd1rl4XZmA1Lve/mi3dQJPItvId+GCjyGfdxYpXnvgYl1o+9k6Oe0ObHiIqSm/+IWkwRy3hj/YT
	E/sUfD+PLlgrjNIAND9FFwnfZ7ryVJZlSTnDGlxOZV0UahT6nGkHIIT7Zp2tNxumLFeR9V2/glc
	nz1A==
X-Received: by 2002:a05:7022:913:b0:136:5631:bfed with SMTP id a92af1059eb24-1365fa355cfmr4334357c88.20.1779684871985;
        Sun, 24 May 2026 21:54:31 -0700 (PDT)
X-Received: by 2002:a05:7022:913:b0:136:5631:bfed with SMTP id a92af1059eb24-1365fa355cfmr4334343c88.20.1779684871402;
        Sun, 24 May 2026 21:54:31 -0700 (PDT)
Received: from [10.110.81.142] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba39d7sm5189913c88.14.2026.05.24.21.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 21:54:31 -0700 (PDT)
Message-ID: <9f898fe2-0b38-489a-b3d0-e13b00a68ab8@oss.qualcomm.com>
Date: Mon, 25 May 2026 12:54:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
 <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9ICEN87UZJ__fqmz1erwKU-lioCJRUDC
X-Proofpoint-ORIG-GUID: 9ICEN87UZJ__fqmz1erwKU-lioCJRUDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA0NSBTYWx0ZWRfX6SVWEHf/5sJ6
 H6wDkHAKK0OBYZPFb/oSYIzIaPytt+HyjgL07/phJOfKLkq5u7BguwrSq8gJZbUE1eIKK1HdGYj
 Hd4Pe/MJf4HQKWNj+YYbjF1L6+LoL2r8hLMzIKWI+M77nFGAdrFBNM79SgOQmHeHp0T7FJ8MqYj
 oiDR1TCVW12Z4i9GIRpd4nFlZJt3nk+FUS5eTvqeRDu71VRB5WaoXfC1Q483t5l9q9zaZvL6y1S
 FQ7x00ZmHc3Vto4UFzuVfvvb5y6sWlp68u4kvMfwHzlhQulsx7sDsV+cy0ajouLQfzneM+jEfmy
 Z1sUCgyMvtWYhVZvOmtdcI3OApPjzo5PVxzQs1kZKhBwP41bUlRn0oCFg3hCfUbZd7NttojLiXK
 Bu4CmvX/gK5SfHYJNaGoVkShqWR8hTgd0pktkO+SEnZdME00ONceL+wmA8nrGMoN/EKyHeEXdKq
 uI9QCDL2Hv0ntPVEFGQ==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13d609 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=k2v91a5pJgHk7pTncY4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250045
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,vger.kernel.org,oss.qualcomm.com,quicinc.com];
	TAGGED_FROM(0.00)[bounces-254073-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: D47A05C5C91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul

Thanks for your review and suggestions.

On 5/22/2026 10:50 PM, Paul Menzel wrote:
> Dear Shuai,
>
>
> Thank you for your patch. Please mention the delay in the 
> summary/title. Maybe:
>
> Use 100 ms SSR delay for rampatch and NVM loading
>
> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
>> When bt_en is pulled high by hardware, the host does not re-download
>> the firmware after SSR. The controller loads the rampatch and NVM
>> internally.
>>
>> On HMT chip, due to the large firmware file size, the
>
> Please document the size (> X MB) 


On HMT chip, the rampatch size is ~264 KB and the NVM is ~9.4 KB.
I will update this information in the next version of the patch.

>
>> loading process takes approximately 70ms. The previous 50ms delay is
>> too short, causing the controller to not respond to the reset command
>> sent by the host, which leads to BT initialization failure.
>
> Maybe paste the log?


  Bluetooth: hci0: QCA memdump Done, received 458752, total 458752
  Bluetooth: hci0: mem_dump_status: 2
  Bluetooth: hci0: Opcode 0x0c03 failed: -110

I will update this information in the next version of the patch.


>
>> Increase the delay to 100ms to ensure the controller has finished
>> loading the firmware before the host sends commands.
>
> Why can’t it be increased to 1 s?
>
>> Steps to reproduce:
>> 1. Trigger SSR and wait for SSR to complete:
>>     hcitool cmd 0x3f 0c 26
>> 2. Run "bluetoothctl power on" and observe that BT fails to start.
>>
>> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) 
>> fail when BT_EN is pulled up by hw")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index ed280399b..184f52f9c 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev *hdev, 
>> u8 code)
>>           mod_timer(&qca->tx_idle_timer, jiffies +
>>                     msecs_to_jiffies(qca->tx_idle_delay));
>>   -        /* Controller reset completion time is 50ms */
>> -        msleep(50);
>> +        /* Wait for the controller to load the rampatch and NVM.*/
>
> Missing space at the end.
>
>> +        msleep(100);
>>             clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>           clear_bit(QCA_IBS_DISABLED, &qca->flags);
>
> Is the time it took to load the rampatch and NVM visible in the logs?


No, the loading time of the rampatch and NVM is not visible in the host 
logs,

as the firmware is loaded internally by the controller.


>
>
> Kind regards,
>
> Paul


Thanks,

Shuai


