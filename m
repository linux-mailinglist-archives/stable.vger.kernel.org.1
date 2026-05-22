Return-Path: <stable+bounces-253802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFEuIx1oEGpJXAYAu9opvQ
	(envelope-from <stable+bounces-253802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:28:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1115B626E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3160B302759D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401443DA4C;
	Fri, 22 May 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFYDhm+Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKUd6vLm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B28409130
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459589; cv=none; b=Jk07kUTnbXK22iIgCKTSPxBMB03AtxnihJTK4Z8glWZusT3wuBJ41BT8GEz1QZTdDGJTdfMSpK9YX45WL+T1+ofJPTBUNF7DWvih2A9M+Hjy+5XIEi2ae6MlWhkEMgrsRD5uW4XXIjVYTW1ierxhQBigO6SGX2Wb1syxFF53U9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459589; c=relaxed/simple;
	bh=nlhwD1TnjFIKn4FnqEWgsp8KPK7T74oQB93SFxPxztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhMSlzIiR11ywqLseJz065GWbQJ8YTU2pzbD+5NO+j9yr8vl/abxnTRpgw0o7nqfAWng8de6+2tSQtFkIj6NT5Pw0jLWrIvp1QW0eI4/AYUxEzdsHCxiq4bI6oerHDe2PwyxjNlRHUMfR+2CRep6ZRJ/DJU6RQ8+xTZMr1iVIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFYDhm+Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKUd6vLm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8aT7H399102
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QALT+lqGX8YNkBTxqKWDpjn0
	E/tfJGp0u5h8Wo7ogaY=; b=kFYDhm+YQ8496HKUBCdSCdCELD08GwsG0wphx8rh
	JXSRpeOmhDPAWRJ76er3d7HH0UYQjx/5raL3oCQVPqGt7MiRmIYZi50sBDPDsSpW
	sTqQnP/vlYqfDJwq54lEH/X/+DC351UImNbyrrHrpAzBgaiYZsfZs+XHA72PyBHi
	SZMx6GiIQPutweRhiRK0O46epBEjjMvCGW6zsfyV+x1a+2mnp3MoPg/Is7CUcUdD
	Q0AZXJm1mnH3emG0Bk3wTOGRiXZ68LxrYlzNQs1EWpKIwLaamgUw8N6YRfbyWJKq
	VxSHYtVhtC1vs4FYUu+mtAlu7rV1SrDn1vduvfixq9NP9w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9vntx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:19:43 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95ce07ddc14so10429848241.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779459583; x=1780064383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QALT+lqGX8YNkBTxqKWDpjn0E/tfJGp0u5h8Wo7ogaY=;
        b=MKUd6vLmwTWyyAB50bTAXsKy2GC9x7qrnt3vV8JHxrSvMuGAnbwrNIEVkQKyAdAQGG
         yhJwMTJHVmN3gqop1OlOc3jCj998EHDJBhJ65yaRjdYZ6DLdOKRIqT1VR0jSMh8lROlc
         ShvVBj99P0eXs/s2XzTRbSyvF3VtKjyMbopqsvksqyEQgDpGg7JFILJOU+j5cas04LJo
         dGZAoyKelNwVvv1COyyWX3nw0cvSO3jfyFyq+/eWmz/pW+hIn7POBVMt9zkn4W/lwKL8
         8l/G8Eq+OlkrvrEAVbb3HR4vANc3IJwOPd1uaLWlo/bsx9ul9d3aYD7ql9O9JkRuOwSJ
         fwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459583; x=1780064383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QALT+lqGX8YNkBTxqKWDpjn0E/tfJGp0u5h8Wo7ogaY=;
        b=M3l7Wao1EisoU/GcB6NHOeErkxTREG7yuepnnWgBuf+L90bI9yXqqn/ZK2UfL+kCsj
         6LaEVKNVC7lx58zpVbnqcHwyUuU12cW5ds8HXsJsxyfqnu+7ojUB2D7HCI8DUvXmPqNB
         qt9ZpmHrjLDDk3pgOUiMWMr8VxXrgYc4dM3tNzgOW4VuTTpk/LMxbsk7kPzp69VnoXDT
         o2HGQE/4pwRFiup72SSP4uhSq1v1Smp5R19Owy5rVjYZO/WeYk9xanTzm2cvK6Oa2hDD
         XLE2gvm/uUp7hTVoOTLvVjQ2XJZukjb5AsKjekFE3QTYiAsYNkojZ5R3MJS5tL60X1QP
         SlsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pBXAx32yTvbhHlYLAIiWF31XMCnlcShoNwNGKxMHLVvCUPtJOTchLPIJtE17xEaIX5gu7d6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEfDozFRdkaMKyTZ2BLGgpiUhmFq09rlNMeA1zsj8UnFxfDm3
	sTLQDEwcjWep77EsN5L2E0rFVYwLsPMnL6oOWylxBaOZaR65X2pqJ54EF9jURaCHOZ/uiYocIeU
	bFxxmtgfogHkEy1SfaxIaDBWmaL+wzzbJciiyYL448SNA9DTsx4d588+qNTE=
X-Gm-Gg: Acq92OGGd0e/tOTflBQuWsbpL3ScS1XruHZqPSCgYi4kp8NhRKMJE8wwETztJKCU75y
	aj1UiJ1JBmMsHb0mN0puhzkh39mzsRMdJJD2CjL08MYtJtzPFwHjF5RyThpwd6vpZ97GWZpbPsk
	gYdn1zDfXfsYJZAweT99HkWc4PBV+3iZd1o+rVYO9ujAYj2wo/t3ORQU0Zmlv82CwXVoQ81F4Jk
	4Ob0sBYzRtH+KC0QsFc03w7i4YX7iRUtPSHKRNkKoxYn7OoiukwRyb9/e9Jc4dwLj0Y2165GyER
	xPZNx3XbV8oEm5vMM+1lombLDEDGiJ+La6w7rciu2DjimRlWQ6zQZqZlnwCy9zahzDJNzyK61JX
	UPm923rmdf+CYoa8VWF1932Hg9BmbZsOp+gAkA/WOt2uLDpvvyy8VEOdihzvQ4oTPZCpQOzjhfK
	LL7Ejx6lWFUiFVjQe9d1DgOfJZe5fPkaLdc5U=
X-Received: by 2002:a05:6102:504f:b0:632:d8d5:2908 with SMTP id ada2fe7eead31-67c8b3aa864mr1915575137.26.1779459582760;
        Fri, 22 May 2026 07:19:42 -0700 (PDT)
X-Received: by 2002:a05:6102:504f:b0:632:d8d5:2908 with SMTP id ada2fe7eead31-67c8b3aa864mr1915528137.26.1779459582386;
        Fri, 22 May 2026 07:19:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca74c88sm3715591fa.12.2026.05.22.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:19:41 -0700 (PDT)
Date: Fri, 22 May 2026 17:19:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
Message-ID: <jbpujugiw4gbgx3hxnseop6q3w2zvqigqd6pcdg4shdnyy37it@6ytmgq7jejhp>
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a1065ff cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qPZ7hrfojItUN558QmcA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: Qhz4lup3zuAqxm1FSdqAgk78th9TW3nu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MiBTYWx0ZWRfX2C22cw88elW+
 0u1WTGFK/Jppl/3QONktQhIrxM57SpGldyZTxsL9rpoDHBLoNXTzOaDstCHS5EryIA4YuTfRDm8
 p23XR+lMt5TYa8qGrB+8RGCrPRzGXxzYZPds6VVsSM/qDgLWkxIGB5abTA4HrWv3d0bnIZKi3lJ
 nDjPJ7jXR4lmbf90W/U+ir9zPlZQktiC9mOfh59kJdFkHEBNiSAIUd22FWjZFkoak+/ZXdqGX8V
 JYRi9q4DZLFhT1/9FTfAIfjt0rluhEonc4uBUMhdpMUXhNXY0veYMdKVpBQU3MSUVmwVhpZb+TK
 ZKpXATJmrwwTQ8hcFdhTYr3hU0sLjRcxwUKeDwYWgt6h9fDgbwSdY3iYNsTTMsgJc4MSamc1i40
 BTMQ35npLdVw5BnR9d7HhtuDyunbF54+YxI4uhlhnBMtOU9zcVFX+KBE4t0wXmIEOmJ/ecKjqG7
 Drxaw6GaSUJhL3uA8Pw==
X-Proofpoint-ORIG-GUID: Qhz4lup3zuAqxm1FSdqAgk78th9TW3nu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220142
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253802-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,vger.kernel.org,oss.qualcomm.com,quicinc.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E1115B626E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 07:08:38PM +0800, Shuai Zhang wrote:
> When bt_en is pulled high by hardware, the host does not re-download
> the firmware after SSR. The controller loads the rampatch and NVM
> internally.
> 
> On HMT chip, due to the large firmware file size, the
> loading process takes approximately 70ms. The previous 50ms delay is
> too short, causing the controller to not respond to the reset command
> sent by the host, which leads to BT initialization failure.
> 
> Increase the delay to 100ms to ensure the controller has finished
> loading the firmware before the host sends commands.
> 
> Steps to reproduce:
> 1. Trigger SSR and wait for SSR to complete:
>    hcitool cmd 0x3f 0c 26
> 2. Run "bluetoothctl power on" and observe that BT fails to start.
> 
> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

