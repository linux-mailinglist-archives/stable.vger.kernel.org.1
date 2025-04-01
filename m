Return-Path: <stable+bounces-127301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B0DA77730
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB23188D60E
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA61EBFE8;
	Tue,  1 Apr 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="MiJIQkjs"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF331EB5CA;
	Tue,  1 Apr 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498372; cv=none; b=Yu/2AkY7zofgOQ2CVkNlShOdUIv3IXGzyUat+bLlLTHfV+UcOl52LdtODRDCkJnuuHq1XMl96aTbGYuswg4gWUiEkYvOOAW+hYd7fuQ7sZYJz4T8rPZQOmChFlrdQnrkMV7j/NTBH1f+hyj4lIXeQVq0MVguzqSgnJbocrd4J94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498372; c=relaxed/simple;
	bh=vJXQ6fKZCQBmrvpC2hox6sd8/K5nDDiVBhyWXScvot0=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tVyuidMQSAgqxRlrdkRv+Mc7/LXp4xFpMPFV1N5mwXxY4ZwWvU4Ackr6x3hvbFFfQK+yM6og8ihbg0qbpKFT4Z9+dz/QJ55k/6kCC4uqhH9oiCQoZP4iNhaQucAWYyJzFd4dfQtztnxCWZIQ68bCr2fi6SY2vqxlmtjdUByZqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=MiJIQkjs; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5316j2iT027691;
	Tue, 1 Apr 2025 09:42:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=R
	8TCmtRbqOlDrGi1Q5AjHaOUy2iI6+a6JqFKx2HI1T0=; b=MiJIQkjsAZPWoW+4z
	fF9W2XYmhZpzmPi/kofq1YxITdtR/0VxfY7nIqYbraiDKbqvBkVLp/hbKuMvgl/H
	TFWcoYLAdG6cY5KucHKq09lpKiaw28OufDYF5wDzr2LDADHcZ+c6Jo0XB0IAhqcq
	wuFaeFx0rogHIAHbvYq9hgWkaV6cVhyRxAwHyhDYrWiZYtnnlLRdh+SyU2VGfpJ0
	4N+YS6Y8DAUhB68EhsyrTkbUWiCZPXx/Zf6FmshQHwGanwD3l7FVhwYuEqtVNmIg
	zqiCx8b0L8f5NH1YJhohoiAKZ84T7uA1WRyDNo5sizqvDUDRwpJs8X9d9kS7VKyl
	L8/sg==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 45p9u0t0cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 01 Apr 2025 09:42:13 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.134) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:42:12 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Boris Brezillon
	<boris.brezillon@collabora.com>,
        Brendan King <Brendan.King@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Brendan King <brendan.king@imgtec.com>
In-Reply-To: <20250318-ddkopsrc-1337-use-after-free-in-pvr_queue_prepare_job-v1-1-80fb30d044a6@imgtec.com>
References: <20250318-ddkopsrc-1337-use-after-free-in-pvr_queue_prepare_job-v1-1-80fb30d044a6@imgtec.com>
Subject: Re: [PATCH] drm/imagination: take paired job reference
Message-ID: <174349693233.75513.9819587084207763142.b4-ty@imgtec.com>
Date: Tue, 1 Apr 2025 09:42:12 +0100
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
X-Proofpoint-ORIG-GUID: rXrcd4LUK4OaPkzD9an5f0DhBOyUSUr5
X-Authority-Analysis: v=2.4 cv=c/CrQQ9l c=1 sm=1 tr=0 ts=67eba6e5 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=UtEzwyU9vMAA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=r_1tXGB3AAAA:8 a=dJcJSLYtkHp847Acm8sA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: rXrcd4LUK4OaPkzD9an5f0DhBOyUSUr5


On Tue, 18 Mar 2025 14:53:13 +0000, Brendan King wrote:
> For paired jobs, have the fragment job take a reference on the
> geometry job, so that the geometry job cannot be freed until
> the fragment job has finished with it.
> 
> The geometry job structure is accessed when the fragment job is being
> prepared by the GPU scheduler. Taking the reference prevents the
> geometry job being freed until the fragment job no longer requires it.
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: take paired job reference
      commit: 4ba2abe154ef68f9612eee9d6fbfe53a1736b064

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


