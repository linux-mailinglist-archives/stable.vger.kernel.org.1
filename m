Return-Path: <stable+bounces-244813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFTyNqQ3/mkroAAAu9opvQ
	(envelope-from <stable+bounces-244813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:21:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B14FB0D7
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E7B1304741B
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6E3E95A4;
	Fri,  8 May 2026 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5gglEjc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXY1ca4W"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF302D8795
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268040; cv=none; b=uAZyNo8mqFgCeoRzZncccCQxeyFffChfybug33qgA/PdbYLLqIUebkffQBJpSNSJGepKxvjsJtZJufcgUJySLudKNjevuaR+97Fdfce017Uo02LVAPEaCYtZJmQ6/h8/dbv2H3Qc5sxAPPU4okadgMWmVwcMdLp7dJX5UQm7pVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268040; c=relaxed/simple;
	bh=UAMVwWLPOlb06OiGlUHEI7yxWTDO23kLGEMFXjCn5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkHPTFC1N3OV21jN9sgoF47km0fnCewAiDbFq0sAv4vNeHQ03xT2p8qeTHSgYrWJP37+FF3Ee7pxKnJsIM6UBidwAfJHU0lWNnx/wGB19tYPpuFFIYgBh0gMD0vVRHbuN9KKbNcS5iPv9Yi80rkqOxu5/lJOcxh4GHKfKviC9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5gglEjc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXY1ca4W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648HdoEZ874099
	for <stable@vger.kernel.org>; Fri, 8 May 2026 19:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cMtQJYJVO2Gf9M/V1tEx2sOU
	Xhro7LsTOX7c9UtcKe8=; b=O5gglEjcEVXSpfd3j/yiolJPtp6hq8KO2hTF7sPR
	9sVRMaKQ/bwlBqlnnT/apkrzBTQyvNU3wi37SxAjGQkxTBmR4ExF9b/prHiqNSqc
	a4MoSrVjbM7SyH8yMaxttzTwQKTxHqsD99d/E+luciQOcF/UUE1migTltYPmcrUm
	k6na5Qhw0Kbyo+fsnVKiIZ/bUwlWpKDVQcbCSQc2VtqN2iV9CXxGepX+TlnLyHM8
	wQaDvw1AqNCHm5bY0JYdH5o2LjbKeqKWli0VALnSVwOAbULO1YsEe6oINke4ZyU8
	rPAz1YEI0Yef5r57W4Zjfg1IvBtrM5lZhMPPaEWZ+xTWcA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1me80akj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 08 May 2026 19:20:36 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-631a49033bbso74913137.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778268036; x=1778872836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMtQJYJVO2Gf9M/V1tEx2sOUXhro7LsTOX7c9UtcKe8=;
        b=WXY1ca4W2nzWExAHgYKkKnDqT6ZfLd2NZq1WJ9JVXoheixv9EI9JTSGejsJonoVRI8
         Xwi7u4U2n3kdppOHZmSkOxKqeaWzqR4fY/P/qTn2CS1WXZV16akhDXwS0hvYfpM5ca6L
         Ol0GcZ4CEKtIsQWjT2ey0ARByRWKwJjI4kTPURN9zMzYFep9d6dBqF1EKO0wDyBUj+Nn
         u3PFNzdW8ByXm1wlZdEwre/r80Ve5OqLsffRW9AqDWXZTfc9NJIX+MIZGD66Fy/8chLO
         V0+2pMFJ9AFptnRtPVVNqKEhHjeebsh1YSixudTxcdKj7vnrIgFsWQCKQmYx1tE89nFm
         weuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268036; x=1778872836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMtQJYJVO2Gf9M/V1tEx2sOUXhro7LsTOX7c9UtcKe8=;
        b=BZL2xFCZBW+7abM+wyEIDklzC9P7vATweYASplKj4LKAt1ofpt8Rut4De1/GH3gMJk
         QtEKVwe5E7h2rbw7ajEvDB3r5GcB0RYZgsQ7gUeO9+JOyJbN6pczyjhOmDcP+FauYdcI
         Ovv4fAJf+Ntrr+L3WsJmo1Sx4ClRTRiuw+v8lUDUwTrBklg5PK51KUiIwzPKZM6Hia5W
         xYJxw1xPNOWltn95eGGnpsAVVvNrI1j/SXgTRdKpSyAMMNKndUp5GLtM/VAfAy5uGZRl
         EjB93ABStVtCza8xxc4OWj65Z4li5ZRM2PYQ2WVGpSv1rzYDIe+Zwesf+5qP9vTJezfN
         Fumg==
X-Forwarded-Encrypted: i=1; AFNElJ/SA4LIz3R82cXhPoh0LC6s9ODpz+iNeDg+/UwWX4ELA+gZ5b1TO+5ZmRH1LSDS+cO72essIPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOSk6GoDgko3XNakAJdohj5eFyXZrRjY5lf101ugfGEujwxVy
	T5l6gAUcFdLr9WDj5CuTt5XT2G+AjYzlY+13clmOrdXaXj/5W5fq09xNPtSZVjMozFUPVU2kU06
	8D1Q0sIcG21W/sdKMYjo9OU9FLcArOzD/u4LNMYngDejKo68JyvX/I2j+0JI=
X-Gm-Gg: Acq92OHOSJvOkQP+zxkOCTYNGcNBJutfNJvYhlWA9kg0jqz2yKz0lfUKssq+17y+PV+
	msqZ/PUX3nsV+jKR1TAKLkV13SsYH2SeCHryi7GVSI8TZD126NVNYbbJ+ySOcEII4he42zLzx4/
	2/vvLLlRDKOiEgM/ePCRdNVNNtJhA2AB2pUi5Jp6U+4TBsyt/oQvIGEDSSuE9GtdOLw6oVi2dFH
	WtoQqyo77tIpMQ/YlUkv2ohlRHPktLNOTwj1eBt3mD+KK5CZb3dKoc0Ebfsb/M97k68yLmXrhqw
	5//qUb9Yt/aXbuLWBsrKdDmHtpwslM33BgXMEOfhTiUXcj0G01vT8IhlyFCdve9TZOXAkDzchl+
	HJbMUuD4yRUuAc4sAezaN92/Whw1/tVi4kreiBmENwEu9xuo3thEm9MiaH+uYS1iBG3xQmGc1QG
	xba7+OaSiR01+MXU+8IC9Xr7CPfP2cpFrYoT4=
X-Received: by 2002:a05:6102:26ce:b0:60f:928f:bf98 with SMTP id ada2fe7eead31-630f8ff11cbmr7365927137.17.1778268036316;
        Fri, 08 May 2026 12:20:36 -0700 (PDT)
X-Received: by 2002:a05:6102:26ce:b0:60f:928f:bf98 with SMTP id ada2fe7eead31-630f8ff11cbmr7365894137.17.1778268035868;
        Fri, 08 May 2026 12:20:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951520csm747036e87.15.2026.05.08.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:20:34 -0700 (PDT)
Date: Fri, 8 May 2026 22:20:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
Message-ID: <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MiBTYWx0ZWRfX9P+ScmzX2OgD
 kvhBv8WdRWcZP+ePebHkhsuG7wvtL6MdHXSX/fzhCihb+Iuf4WARiWu4vlginXHrxFjZ+aGKl2c
 DMJHcD8UKwkqPBqzbQ7TxDsSpO5EiLTqwXp8VJp9MU6ySM8UfnelkHd789jgoo6trWqrYT4co10
 5sze++zZ0XyiEl73s2PtT7n3GkdkbUysYuSgHFpXKrQJG2/bV2Udb76eoJVfHLduXHJlSSnvfzi
 itRrV6ZhDDlGGw2BeTG8xJb3fOCAg2lLRcG2R79Sbw769FT7/7czhgCNlYSpbtPCLt1wVIHj/Ax
 WFTh3eHZil4BLpXtz9Oq+fJ4n9dcQIg+gR9bKdL6Rh+pL5JP6nhPVxzQ+nrQ1IU4KRB+gyVZUr+
 fys/zWgYlftRJzCIXfpQREmh0JPn/ajvWHgB7JFfZanLo59UyJTCispQ84SXmvxvfeMfaVpLctR
 GTK28aVYjqBmoF/ca2Q==
X-Authority-Analysis: v=2.4 cv=BsKtB4X5 c=1 sm=1 tr=0 ts=69fe3784 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lCV4VpG5okPm4yurM3MA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: rl5piNyBr6dmngjRv6eT_yJAdSIrNOtf
X-Proofpoint-ORIG-GUID: rl5piNyBr6dmngjRv6eT_yJAdSIrNOtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080192
X-Rspamd-Queue-Id: 499B14FB0D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244813-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.

The explanation is pretty suspicious. I can see this write in venus
sources too and it was added in the initial submission, dating 2017. The
driver targeted two platforms, MSM8916 and MSM8996, so this write
predates Glymur pretty much.

> 
> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>  1 file changed, 1 deletion(-)
> 

-- 
With best wishes
Dmitry

