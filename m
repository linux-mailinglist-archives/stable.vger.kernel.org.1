Return-Path: <stable+bounces-227110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDQnNuLcummfcgIAu9opvQ
	(envelope-from <stable+bounces-227110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:12:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B062BFFA6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368903247E2D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AC17D2;
	Wed, 18 Mar 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="BQSuC/rs"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59833439F;
	Wed, 18 Mar 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849622; cv=none; b=a+Y1ZIYWnGlO+Ue9/xBPUd5YnH+io8ASkfs/ptNadfesrXNIygXTsmSH6KWENqlNQ+zu2t9syqhy332sEtF7E83ytU78v9P/K1T3JsBl23bh1KurgXGA2js0u0yptp57gB277KG8hsoJq6mOQRK6sHp6TaO5WEKz3KkvIgkB26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849622; c=relaxed/simple;
	bh=GJUV6FvcSsbe70R+iey54f5PAXK9O2A6Ov6XiH6NgGs=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=L3zD/eGMwdrPbsev6ZhBtbytE7pgP6DnGp097mYMk+POxGqUdQb3hx+jt9Rb3F93TNKdwbwH/FFyrixE/E9mpDlPnmSMqD/MzLJcb3bEW8jR/42NtCXvykKCk15IqUsrN0pV0A8M4H+O22BQ2k8XMRVM/VKH3H9+2a2ruU2loto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=BQSuC/rs; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I5gDrH2783940;
	Wed, 18 Mar 2026 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=C
	KtqT9w+PJBtbeeTWC7Zrgj/AtHQG8xGEJZ/Gcw4JO0=; b=BQSuC/rsMNDcKrnwk
	wWIWFu8M+UPf+wtVJa7TWEVZKK9wvPpx++HpGtlGVujN23AsblbqPH5OCrQ+H4nZ
	6LgY54V61fXsXanPhFk+VCLzM5kQmM7wdqOFAit08g80QchWEoZaloBVA+mY5XHy
	MS/6iPI3m5YQBfsuHphh/UfDA2x0X4BNa4GxEwZi78LH2cEluVQZl9tvfbAZL6Sl
	xaGaeJXGJ2rZgx1T3rcnOpDy/ZaNg9sQX4kFBqFbr5LWopjoaXMEOPeN7/Uwaxx9
	rHpoI6ipmIf4W1gerWKQxK7poHrMp8bZeN0aw0i9WVe+1y4ureFbi0aygUYOpWTu
	8ljww==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4cw0mwbr23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:59:49 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 18 Mar
 2026 15:59:48 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:59:48 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Alessio Belle
	<alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
In-Reply-To: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
References: <20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Drain interrupts before
 suspending the GPU
Message-ID: <177384958802.4032.4980677899914669609.b4-ty@imgtec.com>
Date: Wed, 18 Mar 2026 15:59:48 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNiBTYWx0ZWRfX5QrfeDV6bSMt
 z1AKA5c9VWoI0SGt1tdaGdNDFKjxn87MA2PUlk17dcF+KqANBKv1omQT5m4o1Mpl/Sea8UhpB4W
 fdZWhMoaSAaEqX/gep6xjTIR1PeQCthH3cRKYBqnKNhU+nhH4r+MMo93ofK91FZ0rVUYznQma9n
 BBctqsa53+oHifDneU9SL3aWfqxsODl815ESS58dz4fQ2BG2dJRyXuvrTxT5vdQ8OyuGBb0lniz
 UTj29CHsn3t41eij4xWXlvyNyPkc68/xbX2DxJqF6ISTuxf6mJltng9SmTblB6mp6w3EmyBzwWF
 be1Vyf0L5KhJFHkrxdtKnN+6gYHsiyG/j4Pv1/yKFaq1VEjNstx4/tW4ICLA2UR6oRNloG03mlI
 R4j17Fub7wOPrJIJS30OTIpJaoKyyZlOrCpde4RDi33HvzkPtj9z99ok8iYd45MxFhmSmy1LqYt
 w08tM4dsT4BFJleSRNg==
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69bacbf5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=O4Ma4roi3Vyg64WxJcwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: QRQ20va9rEFQjwipdhPxsSIjFd5Fbfwu
X-Proofpoint-ORIG-GUID: QRQ20va9rEFQjwipdhPxsSIjFd5Fbfwu
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[imgtec.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[imgtec.com:s=dk201812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imgtec.com:dkim,imgtec.com:email,imgtec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-227110-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[imgtec.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt.coster@imgtec.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 54B062BFFA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 10 Mar 2026 11:41:10 +0000, Alessio Belle wrote:
> The first commit is the actual fix and will need backporting to stable
> branches, though some of the code being removed didn't exist prior to
> 6.16 so the patch will need adaptations.
> 
> The second commit tries to prevent similar issues and doesn't need
> backporting.
> 
> [...]

Applied, thanks!

[1/2] drm/imagination: Synchronize interrupts before suspending the GPU
      commit: 2d7f05cddf4c268cc36256a2476946041dbdd36d
[2/2] drm/imagination: Disable interrupts before suspending the GPU
      commit: 74ef7844dd8c27d6b94ebc102bb4677edd3e7696

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


