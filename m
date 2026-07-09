Return-Path: <stable+bounces-272941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kibaF9mxT2qImwIAu9opvQ
	(envelope-from <stable+bounces-272941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:36:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07673251B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:36:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=imgtec.com header.s=dk201812 header.b=fMYV+uDb;
	dmarc=pass (policy=none) header.from=imgtec.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272941-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272941-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9297B31A758B
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF312825;
	Thu,  9 Jul 2026 14:14:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75404263F34;
	Thu,  9 Jul 2026 14:14:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606457; cv=none; b=A+QlZDj0Ro4y39qYI/3eJzLrQdRLTixaAXbRfgqnDkzXlCA+TdcDDz7uttAqt63LC9ORVxs48lJtRgWSXMkT2fR1CNYFE9P9c3C/VhzmQFw3/+jEgeE7jUnLjw83P7EPx1yPepv5eKYMJiY3og8/J3qz1c3XEWN07TmLWJ9ZIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606457; c=relaxed/simple;
	bh=I52ImPDwotV3lAE6iIDhlpsBHviI17iV3O/aXFZazOc=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DH5FXyvGrOu9oA1TRq/TlRSZFWYYuAadKzsbGuf/dAw/JelSpkhA6xPvHCfPIpl5K4diZOZW4tT4kz2+lrxx82UZlsBv6ONsrLD8xC1TsJ/KtOyUITmq2WFaAh4e639DulGstfWLoyrZmYTkbOhz2mSjuq++aEm4rpu40FzKdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=fMYV+uDb; arc=none smtp.client-ip=185.132.180.163
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669DtODG3995896;
	Thu, 9 Jul 2026 15:13:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=4
	DMPu7bsQhaRQ5xbamWnmir1UiGaKK5kRlbLZmQ1vjs=; b=fMYV+uDbjzhZPDos1
	ILiHBY4143J9SwQxmyZf5yHxylo0pCMsvZBLZtcMnMSa4j8HeJ0ycAQ92NfsWwB3
	413hZVQgcuwBvYScKRdvEo7w5d0DzGweh2DfZhd1Pb9JsxvkaFjluPfY8FL6zWLo
	QpWc2PsvOmE87PODS5Z8Ew26r2rZuJFZXA39lqX9oYlvlEGXcupEDbykKUw15AgA
	Qb9Fvf3XtfAFc6MfkrToVeCcIbiO7Vh8pAXAv/6g8cdrDwzbz4z8YkgSnOexZnMC
	/cUL8h1WplBrTvcvVdMNS8uFHe8Rpp7vRItmTgRlYeuMS+8CdbFi9Gh5WTQM4pYL
	Fi+Rg==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fa1dw0jmk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:13:44 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 9 Jul
 2026 15:13:43 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Boris Brezillon
	<boris.brezillon@collabora.com>,
        Brajesh Gupta <brajesh.gupta@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Luigi Santivetti
	<luigi.santivetti@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
In-Reply-To: <20260707-staging-ddkopsrc-2435-v1-1-24e160d44476@imgtec.com>
References: <20260707-staging-ddkopsrc-2435-v1-1-24e160d44476@imgtec.com>
Subject: Re: [PATCH] drm/imagination: fix error checking of
 pvr_vm_context_lookup()
Message-ID: <178360642391.200091.11012166992253124321.b4-ty@imgtec.com>
Date: Thu, 9 Jul 2026 15:13:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: -A4jlCwss52uKQx3m8xs49RiKy4FZJIH
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a4fac98 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=XkSmYTrN71B21MVVzw8A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: -A4jlCwss52uKQx3m8xs49RiKy4FZJIH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzOSBTYWx0ZWRfX7kVtO4pgsNgF
 gS3YimicG82iAk7jPvc35haNDKfzcli8Xxj8pkuHNbIEVny28X3xSlIh3Qu2XJo5r+2Qmyk3Uds
 axUyzJ/nlS41cDk1+HPIG7PEJ9zmEEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzOSBTYWx0ZWRfX4z7gG+jN0Zdj
 H2yzuJOtN1JOz01rx3ZLgear7zfNbFFEaALNV5Wxdlg31M4Y1g51h0EKKiQJ2o0jlLpDxWzvIvs
 izG0jwfBiYqHh+p7qT3H0mmZ3LXnwExbma+A8DEwDGLNK4ZJIQtvgu0XdQGxNSbGwILSuYkIKsL
 ITh6vq/tgyzls0SuwiOEQcrUbKwnE1svoo4vLPiC5FHhKHQ/98hxOPaNEDAX3a/+xiLuy+WTZeu
 lX4XwGCKumeJY6jmR0013bAfzwWZT+YEc7imJMq13NQoaGY28jtERus7yL48htQdSjpBPJdIbOa
 MdqS5+NyQ5GRzr2mtTEyEblmTtvQQNp111wDWy9pBtMgwOpeTkkL9FWU5EBz2Aezz0hiKIoNBZe
 3z6yQe3sk/vAk6dK+DNoS/XVdi7Bnpr05BYABTP2jTStabmS1dG1PfoWAs7BFiVT7ppB2ATaiUy
 +nmPiVa/uiPKN91H1Vw==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:frank.binns@imgtec.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:boris.brezillon@collabora.com,m:brajesh.gupta@imgtec.com,m:alexandru.dadu@imgtec.com,m:luigi.santivetti@imgtec.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alessio.belle@imgtec.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272941-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.belle@imgtec.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[imgtec.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC07673251B


On Tue, 07 Jul 2026 16:17:16 +0100, Luigi Santivetti wrote:
> Since pvr_vm_context_lookup() returns either NULL or a pointer, then stop
> using IS_ERR() for checking the return value.
> 
> Using IS_ERR() leads to the kernel oops reported below. It can be
> reproduced by passing an invalid VM context handle from userspace to the
> DRM_IOCTL_PVR_CREATE_CONTEXT ioctl.
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: fix error checking of pvr_vm_context_lookup()
      commit: cf385cf6e713eba0720651174dac0b2d2f5bb8f8

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>


