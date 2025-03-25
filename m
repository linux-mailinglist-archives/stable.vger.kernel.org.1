Return-Path: <stable+bounces-125988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836A7A6E882
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 04:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B737A4C92
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175318DB26;
	Tue, 25 Mar 2025 03:10:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E60BA50;
	Tue, 25 Mar 2025 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872239; cv=none; b=F2d8qRcWFdXz2dEG0nm+cBz7eZT9miTHyL69S/UxnuV3ZbwN6IRgWeHvFS6Km8XwkMDubD+pzF1ZOzbyBR64uNd0WueTGI58st1paEk8csjtmILMkJkoSyLZArF18HqWXcNdBs6JO8TwFMCVj+L4fp/Xul87g/kbNOBZSGZTgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872239; c=relaxed/simple;
	bh=DTCr9XlLgIOTZ4kfKeE6NufGQH51jd/COmV0lw82Pr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKseE4Lif7WOujgrVd9zUXKhtsWfBK+mhK/gexGgZ2lnVL+QFuNI5k9hyFKtP12z5TW/4bysF3UDBGnK7r+LORXjTMTvFAvMi+qoGp64l1DJGZpYbiBtBaVFRaRMokswfyJR4ftF6r3+CIxi4DobS77p1Z6bUXNO/l8uz40Bito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ONQvHt006693;
	Mon, 24 Mar 2025 20:09:50 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqkafw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 24 Mar 2025 20:09:50 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 24 Mar 2025 20:09:49 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 24 Mar 2025 20:09:46 -0700
From: <jianqi.ren.cn@windriver.com>
To: <kovalev@altlinux.org>
CC: <edumazet@google.com>, <i.maximets@ovn.org>, <kuba@kernel.org>,
        <kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <stable@vger.kernel.org>, <jianqi.ren.cn@windriver.com>
Subject: [PATCH 5.15] net: defer final 'struct net' free in netns dismantle
Date: Tue, 25 Mar 2025 11:09:46 +0800
Message-ID: <20250325030946.1111059-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115091642.335047-1-kovalev@altlinux.org>
References: <20250115091642.335047-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e21e7e cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Vs1iUdzkB0EA:10 a=sL0TOPfNaK_aAQxBf2IA:9
X-Proofpoint-GUID: okVXnzcUkKTcr0PuCQCPW0aXAydIkUzv
X-Proofpoint-ORIG-GUID: okVXnzcUkKTcr0PuCQCPW0aXAydIkUzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=507 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503250021

We also need this patch for both 5.15 and 5.10. For 5.15 it seems this patch has not been accepted yet. Any reason for that? For 5.10 I saw the patch 41467d2ff4df("net: net_namespace: Optimize the code") as a prerequisite for 0f6ede9fbc74 ("net: defer final 'struct net' free in netns dismantle") is already in the 5.15-stable tree. Would the original patch be accepted in next release?

