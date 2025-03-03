Return-Path: <stable+bounces-120266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB89A4E694
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23CF19C7575
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558F927D771;
	Tue,  4 Mar 2025 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="gkODV0mH"
X-Original-To: stable@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6D27CCFA
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104736; cv=pass; b=rKTQ823jk7OzafX0K94/iXA7uZHMPfwF2Sq4rJKFhQ8CK1wieKS03Udyuktt9jNniBkyEGiWX/WLxBTvK15xFDVxqzlhw/iArMTR99wfqT4bUoKO61ykeOWi3882pRb8tPyQiFIrxFaWSk7YS/rRwAYK0NzdrcLEIhJQq+Vzu54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104736; c=relaxed/simple;
	bh=CAHIeJskj3GY78yrKCJxxiZXsQiqmc5JVWs7VaNB0Bw=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IjdR6UBmKzvzis6hbT3cdEITRhxR6ieTO5tgomxK3Y4HmpC+wJvcdPh3EHZZQJWCXsUhGULF43TgRk6mV6SQJwkMeWcclAk0xx+u3Lkl9j1ROQyx58oteUUlWaQGLhC5Z9xR4V1GAgl0zc4YFtocNvVRk9djlZI6aYHUkMCA+6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=gkODV0mH; arc=none smtp.client-ip=185.132.180.163; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id D2A6C40D571F
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:12:12 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=gkODV0mH
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gdT0prszG2PV
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:10:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5B49642743; Tue,  4 Mar 2025 19:10:33 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=gkODV0mH
X-Envelope-From: <linux-kernel+bounces-541705-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=gkODV0mH
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id B91CF420E8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:30:36 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 909B33063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:30:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AE61896B85
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CE21128D;
	Mon,  3 Mar 2025 12:29:58 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8061FF602;
	Mon,  3 Mar 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004995; cv=none; b=p2utL/Vz/SnSF6iZf+XPHQgv7OJNaWkdWetj5NA51XN5lhLEdfi1QKOTSOU14HNWnxH/9KZhTFDHU/houe/fTuv7x2N/4ULlauYbesq1EHM6aFYdbs3EevnH6MPYxmcA86oTcJOlQzXtHTu1U1i2wDy3Uo+3rB5w56MnsyAC24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004995; c=relaxed/simple;
	bh=CAHIeJskj3GY78yrKCJxxiZXsQiqmc5JVWs7VaNB0Bw=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=p9PIGiReKc1b5I8WG5EJmL+pZ2l4S7XbimMAljwCYejCBvJOwYyyfBGhHJ/pKSgRJYCUzDcqehgfHVwVn6KLjvkoifp4E9mCEFdyRnvQjrRFOynAHJw4GSyAkyUIEkps5DVUsc0dliLI6U32PgDr1hCZAhzHj6/p0/zvJm+SRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=gkODV0mH; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52382geA017916;
	Mon, 3 Mar 2025 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=e
	Wf6UfpGRBwwk8RKifIcIZGcFzxMgif6kyP1suPkusM=; b=gkODV0mH6q8KPZx/k
	mEHB5dh69em4eoKOovZDYJLCEl3sTfhRKBJs7j7ofQtUpZ/ufqpx2kptuiGoxBAA
	y/Vmo6TLTHyiHyS9BdwNAXwB/vmoU1a79DYW1Y23CNsHN821HFttCMaWnmnWRDd5
	kQd5RW2k2L+eF1pFyXW8iv/HZWAFjrzuugQy26VXrs8zSzsaxxgXQVnkX8gcF0J0
	3AUuBdSIc6mU6PnQA1bQDMex4NeyLkERc7BGhfLZlkyzDTkSm5hbgtoVWGsCboaW
	5Es8oCQleBCgg7XYBX3zA/79SgUepiRWH9f1H92UGf2xd3O17zpCHSCdV0D+Orsg
	775iA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 453u711fe4-2
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
In-Reply-To: <20250226-hold-drm_gem_gpuva-lock-for-unmap-v2-1-3fdacded227f@imgtec.com>
References: <20250226-hold-drm_gem_gpuva-lock-for-unmap-v2-1-3fdacded227f@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Hold drm_gem_gpuva lock for unmap
Message-ID: <174100406813.47174.5029499450421532895.b4-ty@imgtec.com>
Date: Mon, 3 Mar 2025 12:14:28 +0000
Precedence: bulk
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
X-Proofpoint-GUID: MBgX6RdhLT-wlApSMlb2hVmtXwXw0j5C
X-Authority-Analysis: v=2.4 cv=LrJoymdc c=1 sm=1 tr=0 ts=67c59d25 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=LHZ2_XVCwAsA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=I97S-O_Z-kIA:10 a=r_1tXGB3AAAA:8 a=HtLarFGESsWcHrEFRNYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: MBgX6RdhLT-wlApSMlb2hVmtXwXw0j5C
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gdT0prszG2PV
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709446.24151@lyVCFnc/VVw93g0/DNpBFA
X-ITU-MailScanner-SpamCheck: not spam


On Wed, 26 Feb 2025 15:43:06 +0000, Brendan King wrote:
> Avoid a warning from drm_gem_gpuva_assert_lock_held in drm_gpuva_unlink.
> 
> The Imagination driver uses the GEM object reservation lock to protect
> the gpuva list, but the GEM object was not always known in the code
> paths that ended up calling drm_gpuva_unlink. When the GEM object isn't
> known, it is found by calling drm_gpuva_find to lookup the object
> associated with a given virtual address range, or by calling
> drm_gpuva_find_first when removing all mappings.
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Hold drm_gem_gpuva lock for unmap
      commit: a5c4c3ba95a52d66315acdfbaba9bd82ed39c250

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>



