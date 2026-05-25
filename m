Return-Path: <stable+bounces-254095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLArEvnwE2qmHgcAu9opvQ
	(envelope-from <stable+bounces-254095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:49:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40A5C6BD2
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A15F63004DC5
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286103290C2;
	Mon, 25 May 2026 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHmOp2n+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SDz/esvW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5C3A9014
	for <stable@vger.kernel.org>; Mon, 25 May 2026 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691764; cv=none; b=k+mBYZGWndk7P4RGafXaEiwKw26zYqO75JzOQfWR3qX1VTX9z19wF+eJbbplxLSDyENtINahUaJQHQCEO4zYwknCQl2BQPh2ZgJhWUeFxa05MT87e+TJb4zFoGCJmKxxx8ieUxJQQcpN7JYB3JQ1GLX9pBDY28SzInTKnBp6RoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691764; c=relaxed/simple;
	bh=utLLGRdarLRCiW1US6VVGRZPWxf5/fO3v/VjqNUQ/5Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fvSM9LFpT00HNeBwxb4fDhRSDfouGpmV5hqkbvihYUiGPn0+F1c3GjYSrtf0cbGkE2kENBb5rdz7CQEgXrM+cHpF+yGqnKgW/AoM0oDuy3ldWl5gJ/n7AZR7L6kv2iI6UQk2T35WdNl+iWW7U91m1H8HlhNM3vqTnrwOXwvqTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHmOp2n+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SDz/esvW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OMEfSR1882056
	for <stable@vger.kernel.org>; Mon, 25 May 2026 06:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xa1aVs2gD/q5yikyQaG219MKMNic86aisit5i/OTAcg=; b=CHmOp2n+w+lkf2EW
	khHn4UFhTvWFL/8VH5pPtW+s7qG8bs2z+9FbqIf1UWO43dSYEnq7FF40cO6n8/U3
	+//b9TdlGUiHWXU7HzCUNZRi6AtA4w4aiL2TshEYThiHHWe5RFnTjFgGBPITWqPJ
	XN9JfvbE+QiuNHfPsktgcbTX85fBMpimwx0zfgRFzP88obCSUOmdAJWrkqp8vLl9
	xF4Lgj1vA1p8MBO3nSlCBqxNG3qHHv+PzFASa0yL5aYek3SRVT+IpYYBNkvUc4XS
	NMLMpzJprUHCoXXdVbN4ZkGPATMxC5yl3Il7vt9nToziREFs0+izXn2UpqdfM6Yd
	H97NNg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgwh2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 May 2026 06:49:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so14800814eec.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779691759; x=1780296559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xa1aVs2gD/q5yikyQaG219MKMNic86aisit5i/OTAcg=;
        b=SDz/esvWSqTudXrS/3Ck89zw2tF4qNUy5zggx0M/iZ7yFii7AOkROXFrpw2+98KqAE
         w6Xi9tFIZDPbuzd9gA0ScLz+bgmvYfaV1mp/TJK8bm0xqLMDfxshbSjnJIBxGX/M70vg
         dmgYKAHkIKsgxL06Y4sWlX4KMfT47f3cGsC29qN6D0fPGO1y3Azqca/Syr0LjO9tg+Zs
         oewV5NORdGC/8WKsf3Lx4ac/tVMc/ICg3q5B1CWtUeO0g/UvpdA176iWVs0Xipy/9k/t
         OzRx2jojhRtEeZzKqfeGKk3o/5guknf+PKpk7hhoNmuq94QdDdKbTY7yZP2uuKwd2gJI
         UDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691759; x=1780296559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa1aVs2gD/q5yikyQaG219MKMNic86aisit5i/OTAcg=;
        b=jAkgbaKbDVBQdKM7cZJujbsJYnCZZrXv0aLfg+yNrvD6sGyk4DOTsAe5KnAOZXTYpG
         ysXSb99rGftMuWwZbmrrYabuVlHnGoteBoOrw6TFjPDm/BU96WRmdk/dHwrQHMFvIg3k
         SP7vWa5fjgT2ZcP5eeLQBalPvnoYtJ5VsviX0ewxW2F3XG28EwjOz17V+6uG/NuGxSp4
         1y/mLE/v2vzuTYPh5jk0/jmb2pNWxFgvDG6C0tFBc/vj0r2lCQ/dDFHm8AnJVxV2aC8F
         DJ99dEYszNr/6Jhd6k2Bxlho7TtfJ6M+mjEvXqvS02cTs0852EKOATvU6/mCeYJTguvB
         jMUw==
X-Forwarded-Encrypted: i=1; AFNElJ+T/n5STTRJfu+UQm1zr+8Rg55VosSHsV/Ct4Ub7odMjNgQMJY1Dy1VoqOkbmKTMc7vkUTt8Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxDIEC1pWx2efeKXx+tEqgy0k15nuCLGBgo0zel1M4Bhl4VOG
	/V5ZjGUh8gInMbTVYO+aMmTmIj9du+89Sjj0r191YZSLYL7N9QqfFFclwizesjjzpUvGmsRg5om
	OlPePKTAYGew3AtAPyOIdP+Y7kdKW/o+rOxOVAG8uRBpcAJw2yQ7g6CQ7cwg=
X-Gm-Gg: Acq92OEdLC+pCmv8BWrXc4u2woj03FIHJIqAuvwaD4dSSVqS5+8qQNUTsO4H2Z5Et10
	RJnsRUbgCHRWpUoYWff4Y1jYL4MUF26xexQKn64BYo2lxcwR8kbEvTLtOAUKkSDBeL6yz9seSwR
	wFTCtHnedGlIx85vRlv7LKFqLWx/31EFwpj5Ki7ypNzCMqJW/zAr2VGaxT80GfSI8ss1zEA0G7A
	E2MJQflex0z+BA7Krzmvcy499ITdd+rDJ0lEjMcUhaSZsSkkNLfeQPJiv5+RlohawIFrs3elNvF
	VMHJ0XJLYdcn0cCzOwm1Hs7lBO1JtnyW+0fgBr9wpErQwq7Xrh+r3QuD0ZJyLDozQxb73PhFpxH
	YTzn8A8DuJyn3hz90hTb44dSh+i3aQhOQr+WZ2Z9kAlsHMwuTERcub+2z68+txCGmKh5IJAw879
	vixw==
X-Received: by 2002:a05:7300:ad09:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3044904e1b2mr6215581eec.5.1779691758547;
        Sun, 24 May 2026 23:49:18 -0700 (PDT)
X-Received: by 2002:a05:7300:ad09:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3044904e1b2mr6215559eec.5.1779691757979;
        Sun, 24 May 2026 23:49:17 -0700 (PDT)
Received: from [10.110.33.191] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452259de0sm6536599eec.22.2026.05.24.23.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 23:49:17 -0700 (PDT)
Message-ID: <4e3d1338-7680-4ccf-a2d1-875c81605d8f@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:49:12 +0800
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
To: Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
 <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
 <CABBYNZLQ5m-24twTZaHXzi6QHqgGdvuDt1aaYwbEi0Vt=R2Dfw@mail.gmail.com>
 <55439fa7-2057-4dd7-9651-db15bd27de3a@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <55439fa7-2057-4dd7-9651-db15bd27de3a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X8jzW5xwVuxhR1Nih7tLyLHfcD8ZvBfH
X-Proofpoint-ORIG-GUID: X8jzW5xwVuxhR1Nih7tLyLHfcD8ZvBfH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2NSBTYWx0ZWRfX7p4KK6JoiCiJ
 lkKNhzYT0BW/NqDxxx1VVbcA+CZ5JDKOHVz4L7Oe4IsOc33WUZJcv5sZzz3nqzCMD97p5X1RoKJ
 WFxBSNCzzRxVKb+Sxsam+v5xWDI+b5z+2UDmZKgWHgfzod7IWT5Bji2e/DO9zZ8MkXmFLannrIK
 4mriYvBPNJLM3UTZqanyRxzKVg88+DSSgneAJUj0NPdfQ1Qv5VfxbFurgb7RsfUwWNnzE19WClv
 4jIVe6Qfbs3zsD/A8HD+VxnH3GrN5OhTygI54HCv0VOZIcwHuEfSbc0RfUqYYtmj/zo+cqBGp2L
 0TP5VISAqsUQOShYUcc0C/xArABuGHeYFORKwPqE8WpunmAs6bf8Mx+aYDHQ3UO+6NEdJGgmGeY
 S7FJBJDF2AIvSiyOgLz6rrPQwh+wIKqM6egq3PDbzJS2S27GhNlrUBlJHq9TzFRMpNGZQI+6KF3
 p9uq9BD2AeFqaP1oTNg==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13f0ef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SMXFAHEO-8xBPAYFaCoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250065
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254095-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mpg.de:email];
	FREEMAIL_TO(0.00)[molgen.mpg.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuai.zhang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DE40A5C6BD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul, Luiz

On 5/23/2026 4:42 AM, Paul Menzel wrote:
> Dear Luiz,
>
>
> Thank you for your reply.
>
> Am 22.05.26 um 18:22 schrieb Luiz Augusto von Dentz:
>
>> On Fri, May 22, 2026 at 10:50 AM Paul Menzel <pmenzel@molgen.mpg.de> 
>> wrote:
>
>>> Thank you for your patch. Please mention the delay in the 
>>> summary/title.
>>> Maybe:
>>>
>>> Use 100 ms SSR delay for rampatch and NVM loading
>>>
>>> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
>>>> When bt_en is pulled high by hardware, the host does not re-download
>>>> the firmware after SSR. The controller loads the rampatch and NVM
>>>> internally.
>>>>
>>>> On HMT chip, due to the large firmware file size, the
>>>
>>> Please document the size (> X MB)
>>>
>>>> loading process takes approximately 70ms. The previous 50ms delay is
>>>> too short, causing the controller to not respond to the reset command
>>>> sent by the host, which leads to BT initialization failure.
>>>
>>> Maybe paste the log?
>>>
>>>> Increase the delay to 100ms to ensure the controller has finished
>>>> loading the firmware before the host sends commands.
>>>
>>> Why can’t it be increased to 1 s?
>>
>> Why would increasing it to 1s be a good idea? Actually a _proper_
>> driver should be able to detect when loading has finished, not just
>> use an arbitrary timer and hope that works and the controller is
>> responsive afterward.
>
> Indeed it’s not a fail safe in this case, and that’s what my comment 
> was about, that it should be explained why 100 ms is chosen, and not a 
> flexible way implemented. Sorry for not being clear.


The 100 ms value is based on actual measurement data from the controller 
team. In HMT2.1 ROM,
the BT boot time (warm reset, which is the SSR recovery path) was 
observed to approach 50+ ms.

The previous 50 ms delay therefore provides no margin, causing 
intermittent initialization failures.

100 ms was chosen as it gives approximately 2x margin over the observed 
worst-case boot time,
while keeping the SSR recovery latency reasonable for userspace.

Regarding a more flexible approach: in the current configuration where 
bt_en is pulled high
and the controller self-loads the rampatch/NVM, no HCI event is 
generated by the controller
to indicate firmware load completion.

Without such a notification mechanism, a fixed delay is the only viable 
option at this level.

>
>>>> Steps to reproduce:
>>>> 1. Trigger SSR and wait for SSR to complete:
>>>>      hcitool cmd 0x3f 0c 26
>>>> 2. Run "bluetoothctl power on" and observe that BT fails to start.
>>>>
>>>> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem 
>>>> Restart) fail when BT_EN is pulled up by hw")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bluetooth/hci_qca.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index ed280399b..184f52f9c 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev 
>>>> *hdev, u8 code)
>>>>                mod_timer(&qca->tx_idle_timer, jiffies +
>>>> msecs_to_jiffies(qca->tx_idle_delay));
>>>>
>>>> -             /* Controller reset completion time is 50ms */
>>>> -             msleep(50);
>>>> +             /* Wait for the controller to load the rampatch and 
>>>> NVM.*/
>>>
>>> Missing space at the end.
>>>
>>>> +             msleep(100);
>>>>
>>>>                clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>>>                clear_bit(QCA_IBS_DISABLED, &qca->flags);
>>>
>>> Is the time it took to load the rampatch and NVM visible in the logs?
>
>
> Kind regards,
>
> Paul


Thanks,

Shuai


