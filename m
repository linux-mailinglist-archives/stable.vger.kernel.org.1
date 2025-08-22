Return-Path: <stable+bounces-172490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F368B3223A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7CB628545
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8B2BEC2E;
	Fri, 22 Aug 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsHZD8bU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90D22DA02
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886914; cv=none; b=BVLkS7Y/9wCdjhz67+4G2r8kNrWsJEGmh3C/3e7Jl8ZuGUHQbPf7h82hfWg07aXPyCSUFmjsSBeBs9xeOeafv2v1X5olxDgctn0fRDborfIKe9aMRfkmp5LkVKpQ4DXpLo5J9u0iAaCP60kR8UIvrBw1KMjUeu1KnYHGiOHwQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886914; c=relaxed/simple;
	bh=XnfyyBM6Pz+Nxj3ytKVde+CXgWpxq6tYu+r2xS+ravM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj5hJ53QQ9sxjAMJK7zCa3+eVAUxo8gVjPmCvd0zzkRHffjApuxyR8zNS8rCdXpiXvVujmwHxKBI5jdgq4lX15EiqjaBWLQ5CoxOxKfROYvTXXnu9pIJFqdEFMNY9g4zhvqFaTEsGSLJEDoZQH2PmFcxY69w7cAFUgydTt0syvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsHZD8bU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHVDgm007088
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z3XjF/GiPBvLacOcQzaE00w+
	swQurw1OEiUWR3vIT3E=; b=WsHZD8bUiNGS77HfTwzv0EQtuW6ifmDmqfUy3Eiv
	rObPs+LQFsS77HSBCwTVpwLLjBDlC1G9zS8Q/JgXbd/tO+5aOp5X0qgAJKubzx59
	mNA4sM36AcPMyeAnAsGfsxBALIYYuDSTnsWdQJ8TonyZXQ/D0sVRsVrh8lPY7dcR
	T/FJrvhC2dlna2o/DNS42kftjrksAu+hPlB6W4JXr2ErCJyh4eV4Ej9T5pSfrdMZ
	BJhJ3tOFe5xG4fu5EbJnMMkgmk617Zk/d0CHRV1UisvpHNmWW+rDGcwsLZjzUV49
	xU30ssrrS7zUbFFuESZjv3yRwR7T2u/UlhpPVlTVTSLbrA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw0yr4yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:21:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d903d04dbso39671696d6.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 11:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886910; x=1756491710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3XjF/GiPBvLacOcQzaE00w+swQurw1OEiUWR3vIT3E=;
        b=Q5ywtNR5BAR6K2ar0zSf/9mVPSJpaprY8nQOueZCbdaNsChwqzK4FJwodtAkrAAHKI
         ed7u/vvE/ghFyIcPmjUXfOSLW2eAM3/W76UyivlN76mAtopFjwnP/K7YdIIDHYydIkUW
         zn9tgk9Xij1c5DKvPHRkcsubZM9wZqDWVuHzR0gPQR649+xqF0nzaYcvgUCvaIV2e43C
         hi4Rbik5/onet/czGmGMC+Bd9yktyDYlDZpbrUZXld9Ar6xqeRXbeiCwEXlaI5yYSJ86
         HmnYY6xsIlF8ug6+B8DE9XbbZO7dnHw1gYeLd5xdwr/Reil1OLEKg+Xsz9WSeJVpvp0p
         T7UA==
X-Forwarded-Encrypted: i=1; AJvYcCWCVSi9uJeBYS4cnm7pFT9PAbEMe8n+SO516mr+htycGC1EbewqF361xITxSrr07UKGA5/xjF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4jmC75ZrX/iaD/S7bqN04Rbh6dsBP3ozfRhBdGG7BisRlcH7
	EPMzAOE+COglwOuSpUTuHJCfMGU5wdIg9H8jckaG0vs8iedUkrqy9LCkVBR5KmXE8TwDmZRzlV4
	25lwM0q/hypLozzjc8sFut8jbRx3R3aURnzqGukHjqFDroAhhEhhRg8a1Bew=
X-Gm-Gg: ASbGnctC9C2qlKa5xR5LMGEoNWrBMo01EwsdWPFS2MnR2MiKYGYnOAjjniDuZLYW6mK
	U19FEyx5mnR6jMKkqD9HBTAOWmH1OCGeghEKB3GAVkkBPJZ8n3WLRGggLCJk85+s3c+iI1CIdL9
	f3w9DVStzH7Yv+vKeTmuTadXAbgIRrgw8bpcp8/SG9f0A7SYhZRl20XchqIOowKcZYeFXe8uDxC
	hC3JZCHZV8LaLtVMkhIMRUZT6wJppozG1NG01+OfDEUynKXaotNwdSRDRrsZPJypKxxkA+DRJat
	gkrHqSg7D/2nLFrcSRknoOpJ8Q8NQfYWMWrRmxu6BPefKj3xtcvIgqzGr6Fj9weDPe7NK3o9cWJ
	McA2rkGzXxOw+fEzkQe/GkOHk6JSEE8NnCEQf1iEfq0UbnfDBCR9M
X-Received: by 2002:a05:6214:2a4d:b0:707:4229:6e8c with SMTP id 6a1803df08f44-70d971f5efemr56637116d6.12.1755886910428;
        Fri, 22 Aug 2025 11:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXxaLnv1Y9uAXo5cfUz4pwJXUczPdAECaz58MIxnRLI3/YKXEsleDUu2qANw4OMZIlzAK5zA==
X-Received: by 2002:a05:6214:2a4d:b0:707:4229:6e8c with SMTP id 6a1803df08f44-70d971f5efemr56636626d6.12.1755886909861;
        Fri, 22 Aug 2025 11:21:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8ba22sm86692e87.100.2025.08.22.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:21:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:21:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v8] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <eg6hush5t5r2seelkolmb3hqjlmh7w3yzekb3lnn4sm3qxufee@e3eberzr4izp>
References: <20250822123605.757306-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822123605.757306-1-quic_shuaz@quicinc.com>
X-Proofpoint-GUID: TdpndH5LIxXOPNAIUWSMLFCfOBkldgzG
X-Proofpoint-ORIG-GUID: TdpndH5LIxXOPNAIUWSMLFCfOBkldgzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfXzfzY33+hZYlK
 JMJjtLOCXo0/Pj5kuZANshdtvgPixSPPc90lq7/FCozlsgpYt4FUwGFf6OtNVrYImdZZx0x+apZ
 /EnNFJifRcMDHN+GC7xSezz1t8SZSp83p8TqxxxmBCKFFjijdG6fqYhfW5XorMCOrFhKkQfqDlI
 9O1SU+Dhsl8U5y2aeyxkBIWu+TSMF9hcwDJ5HRJxjy6cdyE3O3yRiQRoqxuMsEl7C3NRAc0B3AY
 EoE5X2UgUFrHr5IPX52pxNsAWf//fNuWlihiL8qk3vwTRPG+4CgnhpNH4ZfFR1pLC9+4at3Pba/
 OjZgMWwKR6SUbgrL28pM9LsU/ZVaK6TP8Iu+Ws+RmLLkvp/38PoMoXfCvLfB4ovfjRApIeTeajv
 Rq6veIce
X-Authority-Analysis: v=2.4 cv=TpzmhCXh c=1 sm=1 tr=0 ts=68a8b53f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Xgb9nbmtQSVvgoRKimMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508220160

On Fri, Aug 22, 2025 at 08:36:05PM +0800, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However, due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.
> 
> To address this, this patch clears the QCA_SSR_TRIGGERED and
> QCA_IBS_DISABLED flags and adds a 50ms delay after SSR, but only when
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set. This ensures the controller
> completes the SSR process when BT_EN is always high due to hardware.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> the comment in `include/net/bluetooth/hci.h`.
> 
> The HCI_QUIRK_NON_PERSISTENT_SETUP quirk is associated with BT_EN,
> and its presence can be used to determine whether BT_EN is defined in DTS.
> 
> After SSR, host will not download the firmware, causing
> controller to remain in the IBS_WAKE state. Host needs
> to synchronize with the controller to maintain proper operation.
> 
> Multiple triggers of SSR only first generate coredump file,
> due to memcoredump_flag no clear.
> 
> add clear coredump flag when ssr completed.
> 
> When the SSR duration exceeds 2 seconds, it triggers
> host tx_idle_timeout, which sets host TX state to sleep. due to the
> hardware pulling up bt_en, the firmware is not downloaded after the SSR.
> As a result, the controller does not enter sleep mode. Consequently,
> when the host sends a command afterward, it sends 0xFD to the controller,
> but the controller does not respond, leading to a command timeout.
> 
> So reset tx_idle_timer after SSR to prevent host enter TX IBS_Sleep mode.
> 
> Changes since v6-7:
> - Merge the changes into a single patch.
> - Update commit.
> 
> Changes since v1-5:
> - Add an explanation for HCI_QUIRK_NON_PERSISTENT_SETUP.
> - Add commments for msleep(50).
> - Update format and commit.

Changelog doesn't belong to the commit message. It should be placed
under tripple-dash.

> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..9dc59b002 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,39 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/*
> +	 * If the BT chip's bt_en pin is connected to a 3.3V power supply via
> +	 * hardware and always stays high, driver cannot control the bt_en pin.
> +	 * As a result, during SSR (SubSystem Restart), QCA_SSR_TRIGGERED and
> +	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
> +	 * command timeout.
> +	 * Add an msleep delay to ensure controller completes the SSR process.
> +	 *
> +	 * Host will not download the firmware after SSR, controller to remain
> +	 * in the IBS_WAKE state, and the host needs to synchronize with it
> +	 *
> +	 * Since the bluetooth chip has been reset, clear the memdump state.
> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

Still based on some old tree. Could you please stop doing that?


-- 
With best wishes
Dmitry

