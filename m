Return-Path: <stable+bounces-247128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFItDQ1yBWoTXAIAu9opvQ
	(envelope-from <stable+bounces-247128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:56:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7B53E962
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43292301F7E4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7B3CB91C;
	Thu, 14 May 2026 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frOwhw54";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgUtoV4H"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508B2E173D
	for <stable@vger.kernel.org>; Thu, 14 May 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741768; cv=none; b=J9oHRqAH0XbVxjH4KyBaqrIsQC491cMYVpE1PtYhuOCfMwXlNnsdPL/aWJME3eF31NvdIOT3nV3+r4tp8j7zb3bSS7Kt7YcoVTBhT6ZquesPRw1nnjAwvON+61H6gjh4yqRvMcvfHGzrplQwCQX3DL6tXPquc4jav6DLaQeLFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741768; c=relaxed/simple;
	bh=DhPGY6UsF4oTbf0f1Os+FQL/IrtUC5+741eb5FoC/x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JscDbUMUPuYjgmOqsTSey3+Ew06YqbH6gcZMh1k4OmQa/sH7irM/xutbRv35LYL7kmZibDIbhF2LI6Vetx9inSmJsQisQFWWH1IUURUNmSD5GzrIMPuTbYl6X3E5vLg8wVgwMzym7FjUe52mXElK8dN/RI6+2am+JocUDHKnkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frOwhw54; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgUtoV4H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E2FoYT2524359
	for <stable@vger.kernel.org>; Thu, 14 May 2026 06:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sOOJkS0Nd5Z+bZiqJQePyXnIYm4EiF7YiYsc7T/csgA=; b=frOwhw54gnxyf/7i
	Y30LFkbBnOhTlOx3d4m8ILfwnJuOLS5G8mp/kkb2lyTcamJEjUVjiLkX3MKeHD99
	eRa4BObIwcYOdCWjPdaYHVYehsCBEUAjYECjlNH0gXkwfV8qmFShI8XFvYE5TqP0
	g8IG1ArjacrX4VhOoa3rsF0+MD8GNHNK3Mg0o696UWLlDpvC+dnDKSewREk9t4VT
	N74onSt5yc/CLYkWImwnmxhooGFQrxRq3OauQjGly1H4FurLxvYMuZhKr8umbONk
	Dtiaa8KzgMQA3P+/5gZShhMKjcJwSc/CEPXVb6CKyNZXfqEe2m/Iq1Ru3F5gJFKU
	556oIQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjjq1r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 14 May 2026 06:56:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bd5b20aaa6so5932095ad.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741765; x=1779346565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOOJkS0Nd5Z+bZiqJQePyXnIYm4EiF7YiYsc7T/csgA=;
        b=OgUtoV4HCLo6wEzO+DATG9coRw35P6rSNpNX7BW3PWtPbNjo1yyyTP0tAp5H0QR1QW
         nYXyChUlX37MRRJDwCWTbrbQzjhAyQh6wIwYaeArAcEWVoFhqR68tmCrNPRku9gX6uBp
         e8kGTIhDrdN5aQ9UIQKqL0m3nHC3GRTKbSDACqph/+qNkJzTvenbDmLtX4t4fUpiuUQU
         kwloTcVgp+ngdgne8Rk+KwXlHtSy7UmW1r1ngZfD6W1Nc78ehS38q3Ab3SPP92UcQo2m
         GaTvaflI5+mQeFQmH/EJHvVaykHKSDkLfkEUfEpE+1bZrfFzjqPcXBO1lp8W7Mg8BvqU
         9Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741765; x=1779346565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOOJkS0Nd5Z+bZiqJQePyXnIYm4EiF7YiYsc7T/csgA=;
        b=dkdRKtnYZSq/wYOIgUmb0U42IZTev8uihvCNKqly4LUH5ZbmanrCug86CJeZKCuaEX
         n6qMn0N5D/vK+ZCBXGesYdhSS1wDvnKWo63frLycmns7uWJlxeHp94Y3USfoKQtpddHJ
         MYSWAsTL+aMoa9+oaSgsgMpcPSkIAgHH9jhTMUv/cA10vq8KqW2joHWlTKGllAqL756f
         ynDyn3NvaO6sYUZHlffuJogCcyAIhYxXg1f4O8yaYbJ7Ptqb/WwgbMTC/MUaQujohEPM
         gi5jqislm1oaf9mDXUyDVzVZZTzZYE8Scnb4o9IwbQIm2y5JuW0waQKE1DjZkfg8mRAO
         SlRA==
X-Forwarded-Encrypted: i=1; AFNElJ9LrSN8vEaO8LoQFLbX0vlBkeLLn9IvoUv47DLDNTsSq2pwDtGtdssaG0vGMeA7IpJMdDbO4U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72QMvNcfdv++tuR2qYXDiyFyBvdd9OwoXIa8wKj88HZbw+kga
	LL0kXggf7xhAJhVEwmF0ijnI8FYH9yZA8/pjkod7+UKFuzy1gHrLknq6PXMmQxiikuKi7k2+MAu
	34W/Gk0SUP0Sx9UEuObMtQG0Ij+texBH/fiZPSrB6rGPnS1PZADMRHMYsTj4=
X-Gm-Gg: Acq92OEhTie46vlgdFzGUo9yhIpg4vDCmTnJYpr4fwoUnvYjv06fnwKKMXyDENWWz2O
	DhwyXQ1RxB+Ez5UcIVqDJ7NYaZdAU4sCm4MXgy+e5DYbr9vSX77HOpLw470eTTQSUxNmj3DrcXh
	CirecZha931U66Fnxgji6WnW8Gwoa5U3kSy+bQkyLGX/UfOw/xSxVtbMUC5pA2dgbCNT7JRixhk
	6CD7bh2pcNLipQhItNJ2P04fgnbWnCXiCLCIlZcOUH/cdBlql1RTvk1pgAiK2Vb7yrKvLTDkGT7
	ADvoSnVqk//z+sJvZ+27ZC44u0iO8oGpHWuLJtlVR5o/LK2l3C8oThYSoB+CHOkv7gpDxzb1aAm
	jmVEMzRL/FETeduls540Unao+0HdTD24bcwaOahDG6D3rRWsGoVvbjJwZOU9r1A==
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd2713c355mr71238205ad.5.1778741764655;
        Wed, 13 May 2026 23:56:04 -0700 (PDT)
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd2713c355mr71237815ad.5.1778741764132;
        Wed, 13 May 2026 23:56:04 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600b4sm14120975ad.28.2026.05.13.23.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 23:56:03 -0700 (PDT)
Message-ID: <95bff017-3554-425f-ad8e-767f9cbe1277@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:25:59 +0530
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
References: <20260507070808.367442-1-jtornosm@redhat.com>
 <20260514061841.9517-1-jtornosm@redhat.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260514061841.9517-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C45K5qUPZSTAcNpUeuLV6IWB4flHd6nH
X-Proofpoint-ORIG-GUID: C45K5qUPZSTAcNpUeuLV6IWB4flHd6nH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NyBTYWx0ZWRfX1h1G/qn80TjR
 WY8mq1viEmZ+v5ZlMS8nAV0fS9Lm7GVNFAwwdw9rrhx56uKPzG7n0esy25fnmS7ZaQoQHhbMD7h
 MIKH/Bebkch/6MH1jmv68s06Qa3aK+IF/3g7otMnRhB/7TXdTQYXJMPxGpD+hLVWF2KajADOJS0
 XqC00LJ7qpPDLT3o0neMQ647saCJBaZ8bLN5ETNoCrKr7t3PeoGklpjzUvQfBjDfj3RBLcLAZkH
 8uENFrNkGd1BGXKrE9Wiag5McJbKClq77Vt/VhEvZOud6KA8M2ZGxhgR+6Mir1PhB0F2XFglnRU
 xpxW+NgjiwpyF7dRPaiBXHBwPnCMa7PKe4KxWrj2vGQ9E6jX2pFU9N80Ct73wZM5DJ5RPkY9pol
 bSziVZiIcOGkbuyJZdiz9ACN4wfIvlk/jo1rGxihfCozzdbgPd9JbuZa1NFEZl6UdTyInBdzkep
 3hBWvDd1JsmEcTb19Ag==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a057205 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=M9fMFvqIQJQtvAFehJMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140067
X-Rspamd-Queue-Id: D1A7B53E962
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247128-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/14/2026 11:48 AM, Jose Ignacio Tornos Martinez wrote:
> Hello Rameshkumar,
> 
>> I agree that setting tx_status to NULL makes ath11k_dp_free() more
>> defensive, and it matches the ath12k fix.
> Ok, I agree too.
> 
>> However, i am still wondering how the second ath11k_dp_free() is reached
>> if ATH11K_FLAG_QMI_FAIL is set.
>>
>> In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
>> qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:
>>
>>      ath11k_pci_remove()
>>        ath11k_core_deinit()
>>          ath11k_core_soc_destroy()
>>            ath11k_dp_free()
>>
>> should not run.
>>
>> So if the double free is still reproducible with QMI_FAIL set (with the
>> change i proposed), either the flag is not actually set in this failure
>> case, or there is another path calling ath11k_dp_free() ?
> Let me try to clarify the issue more.
> There are two error actions:
> - First the previous error. I reproduce the situation as I commented: running
> in a VM the default upstream kernel (with this card using PCI passthrough),
> since this is always failing. Let me show the logs in this situation:
> [   15.906564] ath11k_pci 0000:07:00.0: BAR 0 [mem 0xfdc00000-0xfddfffff 64bit]: assigned
> [   15.926520] ath11k_pci 0000:07:00.0: MSI vectors: 32
> [   15.928572] ath11k_pci 0000:07:00.0: wcn6855 hw2.0
> [   16.984192] ath11k_pci 0000:07:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id 0x400c0200
> [   16.984351] ath11k_pci 0000:07:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> [   18.186971] ath11k_pci 0000:07:00.0: failed to receive control response completion, polling..
> [   19.211036] ath11k_pci 0000:07:00.0: Service connect timeout
> [   19.211815] ath11k_pci 0000:07:00.0: failed to connect to HTT: -110
> [   19.214181] ath11k_pci 0000:07:00.0: failed to start core: -110
> [   19.531989] ath11k_pci 0000:07:00.0: firmware crashed: MHI_CB_EE_RDDM
> [   19.532930] ath11k_pci 0000:07:00.0: ignore reset dev flags 0xc000
> [   29.259157] ath11k_pci 0000:07:00.0: failed to wait wlan mode request (mode 4): -110
> [   29.259229] ath11k_pci 0000:07:00.0: qmi failed to send wlan mode off: -110
> - Second after this, I commanded the unbinded (ath11_pci) and I get the
> warning. Let extend here the stack trace:
> [   24.238198]  ? free_large_kmalloc+0x57/0x90
> [   24.238199]  ? report_bug+0x16b/0x180
> [   24.238210]  ? handle_bug+0x3c/0x70
> [   24.238218]  ? exc_invalid_op+0x14/0x70
> [   24.238218]  ? asm_exc_invalid_op+0x16/0x20
> [   24.238224]  ? free_large_kmalloc+0x57/0x90
> [   24.238227]  ath11k_dp_free+0x99/0xb0 [ath11k]
> [   24.238275]  ath11k_core_deinit+0x12b/0x1a0 [ath11k]
> [   24.238287]  ath11k_pci_remove+0x7b/0x120 [ath11k_pci]
> [   24.238294]  pci_device_remove+0x3e/0xb0
> [   24.238304]  device_release_driver_internal+0x193/0x200
> [   24.238315]  unbind_store+0x9d/0xb0
> [   24.238320]  kernfs_fop_write_iter+0x13a/0x1d0
> [   24.238330]  vfs_write+0x32e/0x470
> [   24.238335]  ksys_write+0x5f/0xe0
> [   24.238336]  do_syscall_64+0x5f/0xe0
> Very easy to reproduce.
> 


Thanks much for the logs, that makes sense. The timestamps explain why 
my earlier reasoning did not match the trace: unbind reaches 
ath11k_pci_remove() before ATH11K_FLAG_QMI_FAIL is set by the QMI event 
worker as it is held up on wlan mode off qmi transaction, so remove 
still takes the normal ath11k_core_deinit() path.


--
Ramesh

