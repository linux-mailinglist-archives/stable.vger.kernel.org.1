Return-Path: <stable+bounces-120059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54609A4C05B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7685B18954EE
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB020FAB4;
	Mon,  3 Mar 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="qg0TwlZT"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86020F091;
	Mon,  3 Mar 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004995; cv=none; b=KNjFlQd2WGrLE7Y3mmP+WjRPSmnlcDa1g4dMC76hVrBDX/YiQWWOx3xkEXcRyy6FwHJeMNnXzza6KQGMTLvxqgCclt0CZjukvRsrNgEZ1ex2EYdyPU+hQeV5QDD516Nl2pdnQ+hRlemlqwYzZcFMihQ8RXPeMOwBYw1dHLFHBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004995; c=relaxed/simple;
	bh=Yw7OyfUoJENgwEgIH/H8SqpfQmFqDasXCQMaW0vHlZQ=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=nhqaRpHv/4OUX5ZWWYC5+IA+D2M2AIsk6FdwtL4AQbBzHeE6A3qjgl+Wh0vcjI4RWBwQy3uF75Morhe0Rdkq7Sdp+4o+YvmtWEnjQh0rrJkfnCC4rC60Wzdy7fNjavc9+DUd036WstXI5AaH9gtnYx6yDw71JxmkhdIkfNA1Hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=qg0TwlZT; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52382geB017916;
	Mon, 3 Mar 2025 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=k
	x2Ud6noyLpxA2vmAMFLYxS08s4Ub8isLj5W+G5Lxns=; b=qg0TwlZTQ15J/NXXn
	Rxyyl6PuWchud/n8lkNlnzqfZECwiEOJowczGqvWfzQcP6y2frxlDq9+VjtAuQ6M
	U+s0ZDVG4nTcecHbTkqmNyza6O+VjZ4W9Q6yXmCvLv8iHt7EuxSf3+6wCkJzHY8S
	GlgSqEAP8Bvedoq9ZW9iAb3mCBiJHm2OXTxu87Oa2TeBZOH1OHTREq7CAIE4WnKo
	M0QV68PVF45nbWIUYKDePyGvI1aYZA915OZSnsY/GvqflD1Vd9iBdm1kA+B+EFw+
	2U9+HsRoTBHFNuf0n3gXls8KD2FqT9bNwqBh+uYyhggryzGkRvD7gCePkk4hxi5G
	5XasA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 453u711fe4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Mar 2025 12:14:29 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.8.157) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:14:27 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Brendan King <Brendan.King@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Brendan King <brendan.king@imgtec.com>
In-Reply-To: <20250226-init-done-fences-once-v2-1-c1b2f556b329@imgtec.com>
References: <20250226-init-done-fences-once-v2-1-c1b2f556b329@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: only init job done fences once
Message-ID: <174100406866.47174.11242172602990003821.b4-ty@imgtec.com>
Date: Mon, 3 Mar 2025 12:14:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: OV_UPTrZlYNYta2tQwYW8fdXws1DhSJT
X-Authority-Analysis: v=2.4 cv=LrJoymdc c=1 sm=1 tr=0 ts=67c59d25 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=LHZ2_XVCwAsA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=r_1tXGB3AAAA:8 a=p_fuJcyyES1w3x-Bcj8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: OV_UPTrZlYNYta2tQwYW8fdXws1DhSJT


On Wed, 26 Feb 2025 15:43:54 +0000, Brendan King wrote:
> Ensure job done fences are only initialised once.
> 
> This fixes a memory manager not clean warning from drm_mm_takedown
> on module unload.
> 
> 

Applied, thanks!

[1/1] drm/imagination: only init job done fences once
      commit: 68c3de7f707e8a70e0a6d8087cf0fe4a3d5dbfb0

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


