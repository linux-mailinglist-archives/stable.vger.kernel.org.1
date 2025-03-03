Return-Path: <stable+bounces-120058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C50A4C05A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 13:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CE0171C8E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298120FAA1;
	Mon,  3 Mar 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="siAw71ck"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B620F093;
	Mon,  3 Mar 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004995; cv=none; b=ciB0b3sDguxQf0+H8dGmRGIXRcIugA37aanch95oQfiWob0XOrjcxcBCu9HYUEK60VDdVA3XkNRrtU8tFa9f57VbrfZJt4+zRVE+x+jwk3YxErDF5P3+XTinw01sIKLAjkzHXUd0L53ngcOE4z4iGOj/e2Z7UBbORlTVvUghrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004995; c=relaxed/simple;
	bh=r3mxuMjNusqmirVJKOK5JOo0+qILqWy0KjInHbfQg3Y=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=iv9QGnaGyoET6EvUiSTuVl42E/vusi2XzNIF656VeN541UfM/C9dJYEKZ4tWfAOL+K75c7Zpnu3w0Pjysk7RbDdfpIfjLW4JB1QyKsO9Nk8ozCbvXRWc0XNKc8AMSv4CO3AZdF5hIB1QW9s7Up7MGtP2oB+Ch4lMrQ0xE/E/qVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=siAw71ck; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52382ge9017916;
	Mon, 3 Mar 2025 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=7
	HBksRmujiRqIhNMXWm0stTBBO2G8Z6mwPtk8Cx3/I4=; b=siAw71cknw6UcArEi
	KI2X+NtfzjLCrCpIBNyKK1AMdQ2nRJPzdvXV1IX70Lrtgg0YmTAPb9wxsbyZLuFf
	LqYXtePCrMCTCK039JRsJO6Aunc/KEd0XibKFbjezJS7TceS709/l52RGTMVCw1F
	+8R+NaZpwAarOvr8CMDvsivEil2Lk7GT5ASBs6UY8skmClFJ8U5oDt9vDwX7XP0A
	uB4XfAJuvxksC5hOc1SCvOZKYVNpKjG6FTIC6rkuEGu9xk69/9wGBlWRZoPq2nl3
	8qIrV6/KMlcHMlL1qV4CobbujgPiEZJaSksqG64Fy7QqrC5m4dqyQzqliOHbON03
	3qYaw==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 453u711fe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Mar 2025 12:14:28 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.8.157) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:14:26 +0000
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
In-Reply-To: <20250226-fence-release-deadlock-v2-1-6fed2fc1fe88@imgtec.com>
References: <20250226-fence-release-deadlock-v2-1-6fed2fc1fe88@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: avoid deadlock on fence release
Message-ID: <174100406750.47174.5779964447854559103.b4-ty@imgtec.com>
Date: Mon, 3 Mar 2025 12:14:27 +0000
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
X-Proofpoint-GUID: bpIBZufc03XJfFS43l1NXtmySg71wGFl
X-Authority-Analysis: v=2.4 cv=LrJoymdc c=1 sm=1 tr=0 ts=67c59d25 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=LHZ2_XVCwAsA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=r_1tXGB3AAAA:8 a=Jn6vUoLUptEalpbYKOgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: bpIBZufc03XJfFS43l1NXtmySg71wGFl


On Wed, 26 Feb 2025 15:42:19 +0000, Brendan King wrote:
> Do scheduler queue fence release processing on a workqueue, rather
> than in the release function itself.
> 
> Fixes deadlock issues such as the following:
> 
> [  607.400437] ============================================
> [  607.405755] WARNING: possible recursive locking detected
> [  607.415500] --------------------------------------------
> [  607.420817] weston:zfq0/24149 is trying to acquire lock:
> [  607.426131] ffff000017d041a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: pvr_gem_object_vunmap+0x40/0xc0 [powervr]
> [  607.436728]
>                but task is already holding lock:
> [  607.442554] ffff000017d105a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: dma_buf_ioctl+0x250/0x554
> [  607.451727]
>                other info that might help us debug this:
> [  607.458245]  Possible unsafe locking scenario:
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: avoid deadlock on fence release
      commit: df1a1ed5e1bdd9cc13148e0e5549f5ebcf76cf13

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


