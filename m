Return-Path: <stable+bounces-224496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IG0Ky0GsGlregIAu9opvQ
	(envelope-from <stable+bounces-224496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:53:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ABC24BB7C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1536630999ED
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F191388E62;
	Tue, 10 Mar 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="mRmzdSTM"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85738945E;
	Tue, 10 Mar 2026 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142928; cv=none; b=CuTxuzevyy1K8mz7ZHDFcn8g9FZJJicFW9HXrNBqx58iKUOlR9+hmVhSoZZL+ugBHGoeD+rhUALSb2gpu+NOlbWIVMt+kiEAw3YOT3SEhZCV+oOxKJ5MkaugGpwxsUktiJi5vcml+VG0IhFCG+qU9zpljq0lez6sZFH2If9m2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142928; c=relaxed/simple;
	bh=5bL4YHBeGywpDABN82IQ0b+mC0W4C1WEQ+RydVB7qeU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MJbmrrfFuUVnL0NkRkevqOiC5dJF1yYuPmSUPLsfLFFv5S41rMBpZhF2JHjViNnXEBEyv9mz2z0Pf1cQ/LgzqOrZGncOuoBXGttB/vXtzcxP9g8NJfyjiEnUDgzA7Lh0vLffQqhI2jBdVER1lN+pHi0otfGs2H42HwtoyXtxH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=mRmzdSTM; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A5m0dH2617699;
	Tue, 10 Mar 2026 11:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=k4+U6BF1Xh2XfkOFMi2nGc2
	nwYE3XF/EdJA264rEz+4=; b=mRmzdSTMDODqQACzDe3Qc4mbWA+bqnDWU9HElYs
	dZrxxEfiKAXjnfBNcPucqn3zvR9uTVrwSSMIIoT6lrQbOreT2fXUL3u8tvaqdjBR
	iPOQs1YeC3d5sUh44yjdAqbxUiSTWE08FGht/BICpoeXUVddx6VOc9swi2Ju+4HJ
	FE6r7i4mS3A3zwrdzdEGhfLNiGLwNrk6YnkO2PzOom5krAhiUpEWYLXImSeaBpU3
	f+rcE3YtmzubawKTzdgMaTbupstylA2e5ThpEkkYQAI+YQYMJk1xNPQiIr5GInk8
	a/+1H95XJnqtAqzBQIo1KEhIkTNgxcBB7zRGn0XZkE7eeVQ==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ct3kr8q36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 11:41:40 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.8.171) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 11:41:39 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: Drain interrupts before suspending
 the GPU
Date: Tue, 10 Mar 2026 11:41:10 +0000
Message-ID: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYDsGkC/x3MPQqAMAxA4atIZgP1r6hXEYdqU81SNUERxLtbH
 L/hvQeUhEmhzx4Qulh5iwlFnsG8urgQsk+G0pTWVKZDL44jshyKE4VNCPXUnaLHNnSzbWxT2FB
 D6nehwPf/Hsb3/QAgo5NgawAAAA==
X-Change-ID: 20260309-drain-irqs-before-suspend-8f9c656516f4
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        Brajesh Gupta <brajesh.gupta@imgtec.com>,
        "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alessio Belle" <alessio.belle@imgtec.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773142899; l=878;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=5bL4YHBeGywpDABN82IQ0b+mC0W4C1WEQ+RydVB7qeU=;
 b=j/yIRlCBUClBcCvZ1/ZSctRC948O+/PshercaizHOjh4+r1XMzEL4Zmi96hSsCu6GGiPnbHDc
 LtAOP+MNPL5CeuvgJ/S/lPX5vWHHuVV6FXmyBvCRdkDEMQGNjffurOh
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwMSBTYWx0ZWRfXwRb9ode5cff/
 4MRqbqLK/AqyH7ucIBTOrcVnCdLPvb9EkVk7RT0UJYFm+eHnB1OeLJ+lXsXWJAHM9DdKwIlJ8sL
 a2AsY0AizI6YA2Wp7NIASK5D93vPemxZuvPWVlynNA/nizEMX9weZvzmMTdlFSJK30IC+SuBhI5
 h6KVb9D5xePgrHsHic7eHowCgx0aZ1AhmoG2A7vxeifJyBfqQc7/7YX7ts/bwqiyQ7HmqLnPDfn
 qOGYp7blCqRf0IQp8RWMOtPYQPcFcL3fyQLyESRxd+7egIxeZR00/PmanYN8OIz/PnqvXMXPjlA
 2/sLpcotIirXpISCyIFCrWVqImsetwTO5EqbK2POGiWnFuXT+PvQ9GBfKCZ4Qnfd3q/c4SCDHod
 Oa2Z6VXBqr1pVsLfmfIrp3fxVIaTgXWv3G0WflvOJp5oTGmDbSQ+L6NXks9yJdpa3DNvFeY8tAo
 btURtZis2TuoxedB4rA==
X-Proofpoint-GUID: tkhlEsA_GuoC7P6WWbVdtC7rL0bfhtqi
X-Proofpoint-ORIG-GUID: tkhlEsA_GuoC7P6WWbVdtC7rL0bfhtqi
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=69b00374 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Rd4DrVCMV_EA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=BBPGza9HeFZHsBj3YmcA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Rspamd-Queue-Id: 72ABC24BB7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-224496-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[imgtec.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.belle@imgtec.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imgtec.com:dkim,imgtec.com:email,imgtec.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The first commit is the actual fix and will need backporting to stable
branches, though some of the code being removed didn't exist prior to
6.16 so the patch will need adaptations.

The second commit tries to prevent similar issues and doesn't need
backporting.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
Alessio Belle (2):
      drm/imagination: Synchronize interrupts before suspending the GPU
      drm/imagination: Disable interrupts before suspending the GPU

 drivers/gpu/drm/imagination/pvr_device.c | 17 --------------
 drivers/gpu/drm/imagination/pvr_power.c  | 40 +++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 28 deletions(-)
---
base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
change-id: 20260309-drain-irqs-before-suspend-8f9c656516f4

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>


