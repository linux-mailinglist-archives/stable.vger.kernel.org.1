Return-Path: <stable+bounces-222551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Il/KJlYpWnj9wUAu9opvQ
	(envelope-from <stable+bounces-222551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:30:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509B1D58FA
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D193025F5D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185038F625;
	Mon,  2 Mar 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoRcKCM7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HAQXKj1L"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973638F259
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443724; cv=none; b=Qc8XnzLKl5/lLL6Mru2fYdyAWyHvJNY+CBAAFz1NcazJyJyqlhtLAGHzlIa2+se3h8cKTqn3ThoWNeKChOIzlph7fHQEq9u/as7+heRsFiQzVlXbOrw2oV0JzXD+qJZkOCu6r+pR6K6urMiQkcxy3DByTNPpnnP3v9xHHxGDBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443724; c=relaxed/simple;
	bh=283ITlUTpw+pnnWf8GlTk3ilsVM0BLNnI2fU0ZTZpAs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oHkyrxO8uJsVysl8RM46vNNThEHJH/I/m/i3EfW5rJKATO93yAh0wQA6LZilMU7nB+i1U6pl4jlLVK7Ot+KYMdDimYdcMOuEcRI0JuWKuy3Zo5T/wHVy0EtfL6Xp2jldbWCWHezUVVLYZ+2UMgGO5k0VhfB9r7Ylgg9JgTuPlJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoRcKCM7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HAQXKj1L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294lYU1291371
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 09:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ht8a1jegW8k/H9PVxZasCwKoJs5NEx57HRzB+8Y1KVo=; b=GoRcKCM7831kuUhp
	I5iRKWUanqqzJFpMCKE4KqTqTkEiVQz8Oq4LpbM+OJtjJu9kqs+IqAq+aMB4u47h
	irngferz5Ea6YPaLiPrYNznw33L33vSJhrzYPzWFkAcWTSi43pfFnMj2s6KhKyPB
	VaJFxFU+CEoQpoGlVu9xQ6d8wyLzyjfL8WNDzUd1Z21CpgxFbFWwSmdso+1T8QZJ
	5syQ7xhsSAhJkuQ1stVjxQO1+8H5+EmoE/hiGDAiXU5FeyMPvf9MYsLRUeK0utc+
	ukYtUiRDUWhz0cYj82yh5zEG2xquF1tBGfaV3z07jNuGyAOIrFpU36Obt8ozCa0P
	Af823Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7ku02y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:28:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35982c5940cso1055365a91.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772443721; x=1773048521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht8a1jegW8k/H9PVxZasCwKoJs5NEx57HRzB+8Y1KVo=;
        b=HAQXKj1LZOf/bkOBpFO8RSxF3p1pu8TmGDm3kL12okUxlmnuF80uTwxY2M5gKNvY0X
         +pVhCJrmkADX04+Hk9zFILjk432uE2clk2fLiIxm9aYviPcHwKkshsA0gmsqwDoQHzVU
         d434cJmCi+Q53psdcOUMmIn7CNK+JqXcesvuKJTUIal/F8uxD2F7O/4heqsXdoTguPpc
         FjVoqL7a/C8gU/Lzz4p9KJHgesp5CUnBxfxlBbcpyeSX8xRmeF4a2QKNMJWFEJY77Hau
         vbcolF4tK6+p+S00PBsIoeXuwpN9aQGKqWnuCQA3siucghQdNsEMkYuHJiLrX/MDVRIH
         Yapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772443721; x=1773048521;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ht8a1jegW8k/H9PVxZasCwKoJs5NEx57HRzB+8Y1KVo=;
        b=rIHqVQn2X8CgSr7URUYDK/Ltt2sioF5+vl861ApoCvsapc0LitAAXTg85gtmY6qGA5
         Uzx/0KJf7C8Qpi2NVW3HPgYkNGAvkOBieZnoPd8VZ7uCjyEkJmzLxIkVpvEuhTHJCV0F
         n2+pOoIUGtEGwTYhPU6a30DdNWc5Jp+9ysXzy7w4Eoht4YkyGESHOKFDnDr9ySXHgpNM
         cdW8ZoB7V0PhsMYQuyOhzks7L3vqrwQ1K7Hq7shc0euLz7pVPtp1BzN2yzmvtWBhEl2J
         5BsYyzv9tKhIOlUasNKZbhUiFOwtz5vvpLS+zIXLQGk0jzXYZ+X7PdULSlDf4Mng3jw1
         z9zg==
X-Forwarded-Encrypted: i=1; AJvYcCVSiUTMPOaGAdeHHZfHfBxJY/4AgIaJz3uG1NhqRj6fN/W8903NwfRxBFWnA5/a0+CXGdrAk9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5G+K16fyvhNsoMV8fKiC+anAKwRZhPnUBU0jtyppZPu5KXEv
	/3tqOIXUYpOCnZWBh94eD9NytnGtIdZBVAhaKR0VZLuA0pPQrJVUkOuSYMYMdVOFrNds1H8Z7si
	7HBsOHceNpZKLN0F6bD2BKmlvk8VC+Y9njtVaAMhRrbEwUmBmCLQhqDjoHo6XbT9kD9k=
X-Gm-Gg: ATEYQzyjJO/SuDxyyfFaS30zBk8Q+8yZZHsjKwN817Eqb+eM+UHA1tbz5Df3W4eGXLE
	hKdgFLjud3Jrtoy3pEUk1va+5cqIMRP0KiI/+zpxYN8mFy+xzwxTcxZTnDOT/yw8vcpzDOtZHtH
	HD7cXPyQGZw7l3fzpXrm55tFf62p/lAlMbsrol0wl0+pcwdfTFCUgDrwkSd4aRHcOcQdWfUb3+J
	WtRPdqgJl3tklxpSDU+DHbVAGnt+weZaadFnB/bd35FguW9L4alwSGwqrh15+jiUonE+UY64VRT
	zhTK7hEW33/RdvWglBbI10R00y/VvKEM6mIYdWRbpkg2jHWNOksPirXyH0g0e2T2A0dxWRoKAhH
	Bo7nzp4ZrtFCC2Ib4Nul9IEIGfKqcGK4UIke6aLTVYNMuGBYAtg==
X-Received: by 2002:a17:90a:fc4d:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-35965cc9d6amr10190642a91.23.1772443721270;
        Mon, 02 Mar 2026 01:28:41 -0800 (PST)
X-Received: by 2002:a17:90a:fc4d:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-35965cc9d6amr10190617a91.23.1772443720773;
        Mon, 02 Mar 2026 01:28:40 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597dfea2e7sm6307474a91.12.2026.03.02.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:28:40 -0800 (PST)
Subject: Re: [PATCH v3 1/4] soc: qcom: ice: Fix race between qcom_ice_probe()
 and of_qcom_ice_get()
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <20260223-qcom-ice-fix-v3-0-6ca5846329f7@oss.qualcomm.com>
 <20260223-qcom-ice-fix-v3-1-6ca5846329f7@oss.qualcomm.com>
 <h2uhrsjlvovjcj7k2ckpkgrhpuwm6biun4ueq7kyzcm4hqcsjr@y3iiqx2vo6s2>
 <lrhali5ukotcmxqp4yb2g2jvbrhlanpqc67cpvluex4l63skne@ln3j4xn6qfvx>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <ea659db4-54df-1892-f04a-74a8f62c7dec@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:58:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <lrhali5ukotcmxqp4yb2g2jvbrhlanpqc67cpvluex4l63skne@ln3j4xn6qfvx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V4NwEOni c=1 sm=1 tr=0 ts=69a5584a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xC54U6B0g8_6vy67BIAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: WlmgK_h5LY0OTCpfkKxQCbWsZaTVNSaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OSBTYWx0ZWRfXz4EflHsTLwv2
 27+r+EW4iDbhGa/vnko1pv05U3XZA4D+CbaYe8VCvKDYhiGdOXHQgZSVGAHr/+uteYCnYZAj44q
 knAIL353BtFpwJgS1F4JJirpxl1g5PiPYSEWLYphQs+Z4cE8PsWKofU9cEqNscjaDEefaJoVLgp
 1Xgw7jB+nf7GXPmOkcs6djgq9ssMqqcJ+tb245CvFQFIAkenLxwfZknyp34KHiqoXLujl6LKsmp
 q3/Qz8ivxOHShkcGBQ3AytNe1OV+Gj/H4IqZwkUXj+1lppXroapgIIa+dmV2bpZwtNzQM8KyJjw
 t+ZFTNKKByJbwzMd6Hkp4o7QyyqvcBclMtngZ6lUYZkXcSjoYbyP5LFpf1WCkbjjASceE+Hr8Ya
 0JcFsx1zl7BLJ9WQ7mKQ/tl8vkSNGyxCVq/u8j7gIc/83aGrIzApPaOjs38P53DL42QKkC4JC9w
 CQTwU9d7dvN1wUnvYcA==
X-Proofpoint-ORIG-GUID: WlmgK_h5LY0OTCpfkKxQCbWsZaTVNSaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-222551-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neeraj.soni@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2509B1D58FA
X-Rspamd-Action: no action



On 2/24/2026 10:16 AM, Manivannan Sadhasivam wrote:
> + Neeraj
> 
> On Mon, Feb 23, 2026 at 02:35:04PM -0600, Bjorn Andersson wrote:
>> On Mon, Feb 23, 2026 at 01:32:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> The current platform driver design causes probe ordering races with
>>> consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
>>> probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
>>> with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
>>> be gracefully disabled. devm_of_qcom_ice_get() doesn't know if the ICE
>>> driver probe has failed due to above reasons or it is waiting for the SCM
>>> driver.
>>>
>>> Moreover, there is no devlink dependency between ICE and consumer drivers
>>> as 'qcom,ice' is not considered as a DT 'supplier'. So the consumer drivers
>>> have no idea of when the ICE driver is going to probe.
>>>
>>> To address these issues, introduce a global ice_handle to store the valid
>>> ICE handle pointer, and set during successful ICE driver probe. On probe
>>> failure, set it to an error pointer and propagate the error from
>>> of_qcom_ice_get().
>>>
>>> Additionally, add a global ice_mutex to synchronize qcom_ice_probe() and
>>> of_qcom_ice_get().
>>>
>>> Note that this change only fixes the standalone ICE DT node bindings and
>>> not the ones with 'ice' range embedded in the consumer nodes, where there
>>> is no issue.
>>>
>>> Cc: <stable@vger.kernel.org> # 6.4
>>> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
>>> Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>  drivers/soc/qcom/ice.c | 44 +++++++++++++++++++++++++++-----------------
>>>  1 file changed, 27 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
>>> index b203bc685cad..3c3c189e24f9 100644
>>> --- a/drivers/soc/qcom/ice.c
>>> +++ b/drivers/soc/qcom/ice.c
>>> @@ -113,6 +113,9 @@ struct qcom_ice {
>>>  	u8 hwkm_version;
>>>  };
>>>  
>>> +static DEFINE_MUTEX(ice_mutex);
>>> +static struct qcom_ice *ice_handle;
>>
>> Did we get confirmation that in the UFS + SDCC case, there's only a
>> single ICE instance per SoC?
>>
> 
> Right now there is only a single instance per SoC. But Neeraj told me that
> upcoming SoCs are going to have multiple instances. But I don't want to spend

Yes and patches for same are under review here:
https://lore.kernel.org/all/20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com/

> too much time on *upcoming* support, but rather fix the current
> implementations.
> 
> Extending this to multiple instances would just require storing the ice_handle
> with node name/address pair in xarray or in some other data structures.
> 
> - Mani
> 

