Return-Path: <stable+bounces-250799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OlxI2IUDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:06:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33581599261
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA6A382AD09
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68C3F1ADB;
	Wed, 20 May 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k6CGpnc9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DBKNrGjf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A243EBF35
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296343; cv=none; b=IbYvcYiZiTTgUYon9KTtrNVzHjpFZlbF9UBIrqpE6VOxC9JnZgNHlhVbt5v6N6HhYu5gJCGFD/IYaZbzNu5atR5VZMy6j0h6x7gk1Gp4UebKwHBbcIesNqP7ceSV+SumGQfcMcKAJ60R/EuOt6GBQvdY2FT+9ZBSXKq8BKDlV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296343; c=relaxed/simple;
	bh=xWFtcd/hasCUWDTnPPqJpHIXo+p0ClKnvX8wQuLNXWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JY7K7XUFRDLFWaoXK0RFFZpp0U8Sr6eG+wcVdFluDRyi9W82hQ/OSUnRcWKn05+qyppdYf2yUdyDJ0CW0rdCJoHoCwzwbzoBoqw0ZVrsEuvq4S7NfUMSANSvp30HBu6E2+6NMXxD6kE1aCyhj+3PNkygx1kcuBD15jhHB6WDw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k6CGpnc9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DBKNrGjf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBZqi43085785
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8w2JMUOwRlLFEsAUyTmDijCXInDEtyuvM/BiONWQxQY=; b=k6CGpnc9c3jzCbIH
	HwWVspIf8G1GcMFik+8ocfffRn2w9NFDGuleSLdaPFZeXYOF3IAzgPEcEZJ1E+9w
	7liTTMkHMhflq3p/6ngSM83dFvMBeizgfN/ivULHsbD23MxFxwOoqR8AdxW1YAW/
	VZFe3VqzOT0Qx6gCihqvQGxCSsD11HSLFK6lj9V13kk3p2RtbC3OfPCnZ4EYKG5J
	kqvFcxWulWOOBBwqAnacUYqeMQskiaG7o/hsJQKpyGRIFSHSX3s/1WoE0Y+mnL4r
	fQ8c2o3mVpvP89zMMOnnyrSgYEazuJ3vEZL/3sUxkgZkPsPboVjEleueXHgGm4TV
	BJzPsw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f1bq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:59:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso6270455eec.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779296340; x=1779901140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w2JMUOwRlLFEsAUyTmDijCXInDEtyuvM/BiONWQxQY=;
        b=DBKNrGjfTmDhRm7mjuryJoQiWH+5cZK0b7H4Vt8B3MnggDMMkRrWoJxLNfTjhm/evL
         j6jr/64oi5V8z5mvHZdMv1Ak1E8BtxwGFnGADKEe3NBKmAlE29Nn2YGs95XW56+vLCFq
         N5N0sCWWvnP8TVZFZaYJ3ly+a7huc/82VzsKGPgLT90L78KjD9ZHaJs41HyYQls66ZBK
         2LVLKqoexsbJq87+SsYNTiNSyb8qY1aV7bACef7lYj70X0GwkOyfNItm6XbV4HrhLq+I
         /lNyzSYrFzdoMV2yNj+K99W6HVIFIPqPOiBMajvCfjvAq0BW47JFuDLAEfOtGPoBMOcB
         36+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296340; x=1779901140;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8w2JMUOwRlLFEsAUyTmDijCXInDEtyuvM/BiONWQxQY=;
        b=iNt6PlmOZWGI1PYB9GohtcH9kft3fvoaZZgLeBj+Akc4ysQVPaEiMTQvs/9LeQFa84
         BuaTK6feaZeB8LxzGSWnrXFQFtxGgkrTFrcuTC6kkVRwYLlNI0VVi7L7GgorTBKGqoJg
         YrFftZj13Hfa/EqqL7y2jp66gMivFQOZqLVh/LDTVwt6qkh7LnkzDhG7dxT+fLW2kMjN
         Mcy04I0/Gd7KEXhxVxP051fNT5z15f3cmsB+r1ik5r0sbCQ1cky7iwfcGZCUWwXc2rot
         jWUiQNjsoBNd8XbXCf0/fpqgTDNp810QKdsli5gceuiSUjr0e24I9nI8ax/1ayMhonT6
         GT0g==
X-Forwarded-Encrypted: i=1; AFNElJ9K9T5fG1xJwaiFXKvYPMvFwwCIwB18DXjf28w8jZtbKxrVTJE1si8L9mhsTulPXNsiFzhcF+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUki58HOENfS0jjKCG0xQet9DzPbsDw8kAH024AwJWYtrPlUFh
	VfrITx2PQxWVzwJLlqg0fmUqNAX12VniXiyOjKfX2N2+gc2O+F9sl6IElqLj/TPFZYEOxX/prXH
	XPrbksge+iWDJjtVFr6GcDVlvNOcHjlQmi1w9l5kfyn6x5MsU+jMkVkrK8h0=
X-Gm-Gg: Acq92OEN7685Hjse9KWiEJa+NnpixckN6YjxDdFJsm/C8ANgfBCzC3gr5F/3VMb0ZN3
	T13ptPtN6tjCI8/S0qP1h6aLbGJ+qHvWlQfiJ2l1yqgcqSa0XLLuayspGoHJzKeCTjww/3Za3Tg
	zwzmwEr6VvEu0ahBTNFRyS4jqvsfrCTWCg0XH1qHs1btQ1bwcsd/fHOhASX9+pC6BCT2nITuItw
	wsn3fW9SiU2HF1ZM9elajynnDjPovwJYTuoHcc1ajgpDW8p1yJoKHNSkKvWCHR1YO06bAVfsn1c
	f/QIlfLcmiVD37Prk28ARNkkePE8YH1Uw5y6oLtMOc9avD32w8BiEdofTUrdXhQ/Jeq92R+qz7a
	mV5ADrKtYFwX4PftXXPhrE5BOowDfRV/jbBenIt21PYLamqXd+P1kjJkzQIKqFGMuDaC17teOlh
	X4
X-Received: by 2002:a05:7300:570e:b0:2e6:ffa8:ef85 with SMTP id 5a478bee46e88-30397b9d820mr13045160eec.0.1779296340241;
        Wed, 20 May 2026 09:59:00 -0700 (PDT)
X-Received: by 2002:a05:7300:570e:b0:2e6:ffa8:ef85 with SMTP id 5a478bee46e88-30397b9d820mr13045135eec.0.1779296339747;
        Wed, 20 May 2026 09:58:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978afdd3sm19371442eec.29.2026.05.20.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:58:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
References: <20260420110130.509670-1-jtornosm@redhat.com>
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
Message-Id: <177929633899.2491273.3275587178961944359.b4-ty@oss.qualcomm.com>
Date: Wed, 20 May 2026 09:58:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0de855 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=NCj8lmT5IRo3ClLsRR0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: _7YuQ-YqhAJzv3kQaoabCOz2jRPLSaHW
X-Proofpoint-ORIG-GUID: _7YuQ-YqhAJzv3kQaoabCOz2jRPLSaHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2NCBTYWx0ZWRfX0O0Bq/qKwwry
 p0U2gb7XcH7pDlOi9Nn0TxNoddSnMwStIqo/ZBmy8bRiX/roaI6o+wSOQ1UShmFjOp/31k/W3xu
 hCBWGPfMi2xFDBBks6wPBtM2J1zMTUWNwrd/ZY66Vn5j6u+7wZDuMOtDQAILVSa9li0fZ/yM7RW
 n/YP94XW0VbBxFRQTT2T0wLuHycr56gi1nwRW2ILb3x41dMlCjBYP3hmOkYlgyggJL3pIqaKxAn
 bHqB8enFzDNAfjbMk3gflhnCbA653nS3NXU/Y0FrD8U/4bTUM0IwdZeyrLsHUAC8v83t6hW3C8+
 rMBiLPNErBuMcwR5V7M2rffWuPM5XpQsBWnhxbs0lJGpDyioFl1XTdK8XXa1aqGqMEtv/25ukxX
 RPfG63n2BzwD2wJofKqDlJdDwTHs6dQVGWwG2IUluSfEj1btaqfPsmwICdj/cV0V8wdI5sfgfbf
 YGxQCO64Lkv9UAHr3CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200164
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250799-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 33581599261
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 20 Apr 2026 13:01:29 +0200, Jose Ignacio Tornos Martinez wrote:
> If there is an error during some initialization related to firmware,
> the buffers dp->tx_ring[i].tx_status are released.
> However this is released again when the device is unbinded (ath11k_pci),
> and we get:
> WARNING: CPU: 0 PID: 6231 at mm/slub.c:4368 free_large_kmalloc+0x57/0x90
> Call Trace:
> free_large_kmalloc
> ath11k_dp_free
> ath11k_core_deinit
> ath11k_pci_remove
> ...
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix warning when unbinding
      commit: 8b7a26b6681922a38cd5a7829ace61f8e54df9b7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


