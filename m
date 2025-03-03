Return-Path: <stable+bounces-120057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0ABA4C05C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4847A7B72
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729EC20FAAB;
	Mon,  3 Mar 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="gkODV0mH"
X-Original-To: stable@vger.kernel.org
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


