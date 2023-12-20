Return-Path: <stable+bounces-8197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC481A8AC
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 23:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0BA2854F6
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C500482DC;
	Wed, 20 Dec 2023 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YgKbrUHT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CE495D0
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKFAweF013284
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 15:59:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; s=PODMain02222019; bh=FurrxAABdb61qc
	7XCbr1SNaw4K1CB2QdumOKIGbHerA=; b=YgKbrUHTbwwDiMVx8KFmQC3pciGdn4
	samxCJlCqdJNxz6XQSy964cBTsYtCaZIkcHpJcSiRR2FKogCSbSiL9utg/M8mOlm
	2kRuZHit8y34RgcfvlfriwecArfE+r9aXVr1eYNe0+EEvCJu19vY6EgfgBfdhg2p
	VQ5KDErPlFGEInRzTcXoblw6zPXWb2sc9bJp9O2M99FZmVKcubQCpx7Hb1RiwB98
	vVT/BUBjsSpyqWsQFn57Ty3iz8U7iGezEH2QD/3QnMUxMJYg+j2esYXElgQqU8Ub
	0dycoJ9jsv5qKVXLhwM1+42xAFBIyJaFigXbojUN7tkb8fzhN4/fQTMA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a6266st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 15:59:55 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 21:59:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 20 Dec 2023 21:59:53 +0000
Received: from [198.61.65.136] (unknown [198.61.65.136])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1AA3C11D1
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 21:59:53 +0000 (UTC)
Message-ID: <61b58cd6-987b-4c55-a293-1d713b741849@opensource.cirrus.com>
Date: Wed, 20 Dec 2023 21:59:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Stable <stable@vger.kernel.org>
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: stable/6.2, stable/6.3: backport commit 99bf5b0baac9 ("ALSA:
 hda/cirrus: Fix broken audio on hardware with two CS42L42 codecs.")
Organization: Cirrus Logic
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: J7sJIIoGU8E0wlKI_9CpbACMwoiWKt6l
X-Proofpoint-ORIG-GUID: J7sJIIoGU8E0wlKI_9CpbACMwoiWKt6l
X-Proofpoint-Spam-Reason: safe

commit 99bf5b0baac941176a6a3d5cef7705b29808de34 upstream

Please backport to 6.2 and 6.3

Ubuntu 22.04.3 LTS, is released with the Linux kernel 6.2, and we need to
backport this patch to prevent regression for HW with 2 Cirrus Logic 
CS42L42 codecs.

These patch went into the 6.4 release.

