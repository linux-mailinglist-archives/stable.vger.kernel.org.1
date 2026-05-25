Return-Path: <stable+bounces-254108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INXTItUJFGrVJAcAu9opvQ
	(envelope-from <stable+bounces-254108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:35:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 881035C7D40
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D73533005337
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1C3E3C48;
	Mon, 25 May 2026 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+vCMvkX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brx304EY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BF3E2AA8
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698115; cv=none; b=Y/qRUWuF9jIZAnMMDdrwxorAaoFkfbVY2xwVHTC6eq+mQ9OOVYZFdWh3XARJ/8SKEwjyHBJKl5MEtALPsaDeObIMcQYDEk/B1gv/WoNQl577I24lerfX1Z0pVzYnAF9sprH4mZA1Dmdmpw0DPlBmX9YoQVejhFN+gh6Ndoy9ETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698115; c=relaxed/simple;
	bh=Y+3n8jIuDzVA+Lypx5YfLppuC/Bti6Rgo6cllyQC3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCJrOeCPJeB7eIds1NItSmVdssmfnlBWKx6Pp7PH5PrHJdffNgUV7vLtFm3u4BHzHjL2/sWIT6dX/7iCoYmYjF+0Mzp1gFoliqp/SKkc4WvMPOS/+GkZAoNiAYv4IXgeibwPcrZC1tlBEKM9UfMMq4Ciyi01UNO2wm5RXFpeyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+vCMvkX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brx304EY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P5amwC311737
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iJzfxaDzkqM6VgHRcfCAXDJC
	gw+Fp/v1dA7ABLX8i0M=; b=J+vCMvkXZ8RlIuuDHkUkVN83mBOcQk/negMfehdE
	4peBdKYMSH9q2I/Ru3Kw1rrRY5coXglEa+GZrP0A8Se+V9WfU7cooT8RdqqZwPo1
	OvKHFQ0+NTx2EeC/hM+mo4XWVvYcgtMYFPAy6MFZ093agRnWkwAO5rmqUAtSNwDQ
	P9oMhMyQ3EqjvD6IfxiSywXoHHLcLttvbV9MSNr2qxSkSYayFO7bJ/jgeZEVZsMU
	HngZP7OsvFO4y2yqCBc+24fdwQV6Ci1BHoLOtkbUjfJeNOpEPognU3U7taEv/NIz
	BBRL/oU7qyJb2MqRiHL2mcdDKziOgVENp1zDENbPKc/Bhw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmp6m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:35:11 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95fd0a49df1so12529149241.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779698111; x=1780302911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJzfxaDzkqM6VgHRcfCAXDJCgw+Fp/v1dA7ABLX8i0M=;
        b=brx304EYZxxc4vvKsnnO8j2hZ3snxWQAxFvbr+a6HLmB3FmNwvf1gDeMTAgyAC/6fK
         vMDctTRXcZYQnfXQ004Vy3VPbTUOHx6Uq8yXruPn65IA1uJi7Veg6LLrSzVZXKADT4yt
         K4MRiVTnwaf8iSTTaUOD4IXOS7iQzg5z56ukllNVkWtwLgICFeRFrBQr8NzJSHKvYqFw
         q1uLueUUNjCKWpmtoFKvwP/ESmOuWNEVheiWH0EmA4X0lD/xO5LIas8wbnbglzHSyZD5
         aRjaiUgh9yoqv1QL4E4B5/u6ZvYgPbxy7Rvrcroa1HJs2W4+Y8MzFCk/+IS1GpOTjFI3
         ioZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698111; x=1780302911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJzfxaDzkqM6VgHRcfCAXDJCgw+Fp/v1dA7ABLX8i0M=;
        b=Xgzq7iNQkJlrXMXcgMV+/L6OttNm83HBPHkgxZpBNf3N8kD6hOB1QSO+pQrDwxs+OI
         MbrCL3mxmffVTtcvhmvrGOfMvFBPxntCmZU1Z5guppWKhtWSMGQJcAVo3mhs0Y8JpEM4
         wuQ+8whjJguKg+SCqcSFByD82sNexKv7HywuSH1VJdXndzUel6ngKLZ24o6LzCQzutqA
         HhPr7m6PF+GEKqTC3Nh+Ao+SPvnGMEPPham3A3CA1dq1jPInC9Wuu6bNbWgu7Y1Jn7rx
         wUsZNvRRTryCbhCt9ElKika+YbpKJO4li4HrTAHTa7agxoMa/WvVai/kPnwiG6quNC67
         RTtw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZeGY4nJh+mDkcYSU3yDt9tAB0TwEXhu0sLHu1KoBCLqNzCLBiL3Rya8ZCe7zHFa/tJ4SrxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJZnsjdVTWFXGnfv0l4Ws5/CaV0SAgzrxMbEClQkFLteJizFu
	gDU3RokAcORLB28bSBBfa6dGJVBdZNIytEvVKhylf/pM8IFLqohZeyYwpICRtXPj33OckegjT0U
	NukU0Qaq4J9vUvR2vNKOu5bLjWZ92kXkATB2rVLmEg9lLwSKcn4BZYLsDRkI=
X-Gm-Gg: Acq92OEuRnx9HN8muMQXM0whNrxOw/8tHW3VltoNXXGqagQpBmFd+7k2+TgEhMcI0+n
	jZ/UWrbF8G61EDMuWcAjqK9wEPPWfPy2kBefmA5RqZBxQI9uDOEc2SVOCdhUT0Ox2uzTAPjw07I
	WjX9GeI5c5pyqFFws4pjxAM941OeUnKseywiF6CS+nYZIuLin2+py9RG4bLbqCrxJ5DHAE7kF/3
	zDswbWk94+aDeHV7HCNOl9AJD49JRca8SLvTKyoBXEWglBJ8cXQgj37QJbGxOTjG+ok2kBw/lbA
	Gvw/UY76HazUdrlP4jhHflHLkL9s4AwuxJfFEvDDxavOOmDlFxYZ2VeDQIcqChdS0oS+d97YZrR
	7te/ezpA04CcD2U2NPgF5gSsPbBH6uiTHxap9Runi3++4t+daEYD4ecj3Vs7d0ER/JGMupb9D+7
	OJ02rOYoNQH52G0ZFF95f4xi8ep0jzrSi3eko=
X-Received: by 2002:a05:6102:8651:20b0:697:8b50:5949 with SMTP id ada2fe7eead31-6978b506c71mr626180137.19.1779698111266;
        Mon, 25 May 2026 01:35:11 -0700 (PDT)
X-Received: by 2002:a05:6102:8651:20b0:697:8b50:5949 with SMTP id ada2fe7eead31-6978b506c71mr626166137.19.1779698110912;
        Mon, 25 May 2026 01:35:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cbabd1sm2466936e87.34.2026.05.25.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:35:09 -0700 (PDT)
Date: Mon, 25 May 2026 11:35:07 +0300
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
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch
 and NVM loading
Message-ID: <foqjrfyu7ahktzhpnzv5wgxti6bob5d6rza4tv4mhwdvdokqxa@twdr7hts35b2>
References: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NiBTYWx0ZWRfXwgLb47O6FijO
 jVy8iGB3h5PMJ+l1BtQmx3waxXzj3goa7JOv+g98Zw6m6hqCIA8lsV1aMCq1x3glKWjcmO9pf57
 NPt/7qja8WlfV92X9+YaUXtdi/sNlbXNnl9NqUY2IYYZVnK9dGunit5naEJXna5oOKPdx9wo17G
 pSS1LjFhIyeC//F9NcVUnByC9vfTa+S4dY2lN0XBi1zf3+Gvr0j9wJlJKaSeQTcCNBVZHXOsCPa
 ArRKbNKJDa1TCZhqcc1F7LYOKULKnGR7aM54VXShZKCd+Ys16UxYdm37g7ARETOxqbE6SaaHms6
 QTMf7pVqEM+lLWDyCXFFpRJFwfkQvhX0AiLvG78novNTUiOIxGLGxjmJEMqeuaRowjChqE/ZWgr
 29XhpcoLh0SWOdBdlAu/zRfputwcmm/S5pquB16dH+1TFs7lV18soKmAhXcja3Fc18E4jHSh8zO
 AdS8s+/ivbT3sCgqh5g==
X-Proofpoint-ORIG-GUID: 3GrKZMTJhoz7jsc3Wy69Ljgn7nD1-sju
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a1409bf cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lKc13Z-neGfXDhYO5DoA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: 3GrKZMTJhoz7jsc3Wy69Ljgn7nD1-sju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250086
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254108-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,vger.kernel.org,oss.qualcomm.com,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 881035C7D40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 02:51:56PM +0800, Shuai Zhang wrote:
> When bt_en is pulled high by hardware, the host does not re-download
> the firmware after SSR. The controller loads the rampatch and NVM
> internally.
> 
> On HMT chip, the rampatch is ~264 KB and the NVM is ~9.4 KB. The

What is HMT? Don't use abbreviations which are not known outside of your
company.

> loading process takes approximately 70 ms. The previous 50 ms delay is
> too short, causing the controller to not respond to the reset command
> sent by the host, which leads to BT initialization failure:
> 
>  Bluetooth: hci0: QCA memdump Done, received 458752, total 458752
>  Bluetooth: hci0: mem_dump_status: 2
>  Bluetooth: hci0: Opcode 0x0c03 failed: -110
> 
> Increase the delay to 100 ms, which was confirmed as a safe value by
> the controller, to ensure the controller has finished loading the
> firmware before the host sends commands.
> 
> Steps to reproduce:
> 1. Trigger SSR and wait for SSR to complete:
>    hcitool cmd 0x3f 0c 26
> 2. Run "bluetoothctl power on" and observe that BT fails to start.
> 
> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

-- 
With best wishes
Dmitry

