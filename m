Return-Path: <stable+bounces-55874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39860918E9B
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 20:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EE8281993
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C918FC85;
	Wed, 26 Jun 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cngGrrIT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E66E611
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426746; cv=none; b=J8G1TMmC7UuCf9mC+y6EMOORBFLCMyCQ6vqCmSd6wdjia2KYRVvGTca7/nVuDUTq5QYod/G2p6ZZM+UnSsGTVYj6hZgrJfT69R0XAE7FEmxbESkBaM6of77wDbeqoGuXlTuAEgdlObTR80IoXJ14PihdQzl4dPpISShJ9f5StgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426746; c=relaxed/simple;
	bh=K/DhGELPqlEQ/6opGMZn8V8lHUwAMSZi0EJs/ik3Bfg=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=YE4CQKqC/UVDsbq30A2OUaGIzmE1ifoB8PrMWzzn78jq7geOUsAHy2fUpaDyy9julMa/WJfQNRX2JwkHWmAnL6eCLQhE2ea4tuzXqOw4fe2QDecAei8JNHlYaEKZU5s43cPijBWdZFU66JT+O04HzyFERfw0veE28G6je5m+QaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cngGrrIT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfaGp029266
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 18:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K/DhGELPqlEQ/6opGMZn8V
	8lHUwAMSZi0EJs/ik3Bfg=; b=cngGrrITKp9Egz09AJ2qUUCwvtiOVCUyv5oQc8
	kzlAjPWPY1Kqe2GRO7a20kBLgEzffG497GvfqKe5GhkzifepFeMRslmzGrCySrm8
	ilJrAA68b+ScJIVpailWy4nalswIWu9iceSU40VfRNeGr+EVFxWEi2HepuePf/lD
	Gec5zW3xcuhuj2vsaEMmASuuoiPVN3erDXBcHrq5vgZsL8hfciQGZX3vajPAiLbD
	mgkOY7hUiXEzBnZfPu3ff9vJ35MLN9nl3gCP9+lbKPdsuHH34VoG4CyPS/TvwL/g
	cMZuWhC07ttppWxYZowMRFWHq9F4jd69tkS6JPIHR8hdd6Ig==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6t27y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 18:32:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QIWMgR018810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 18:32:22 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 11:32:22 -0700
Message-ID: <fc31dd6f-ec32-4911-921f-1f34e9ad2449@quicinc.com>
Date: Wed, 26 Jun 2024 11:32:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <stable@vger.kernel.org>
Subject: Please backport 2ae5c9248e06 ("wifi: mac80211: Use flexible array in
 struct ieee80211_tim_ie")
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W4aFqb8hWxs1iduKGgn5XkiTsdQp4G9A
X-Proofpoint-ORIG-GUID: W4aFqb8hWxs1iduKGgn5XkiTsdQp4G9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=440 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260136

Refer to:
https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/

Looks like this should be backported to all LTS kernels where FORTIFY_SOURCE
is expected to be enabled.

/jeff

