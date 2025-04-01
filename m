Return-Path: <stable+bounces-127300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60FA77731
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E44188B3B1
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0111EBFEB;
	Tue,  1 Apr 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="APO6EheF"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8B1EB5F0;
	Tue,  1 Apr 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498372; cv=none; b=SXMKvNINKFDT/8CWyjrU1QGxvo2O1b/CeEBdA63Rx73mTs0IPGyIMguy7Ki6QbH8pCxM9AgrCwDdmtr/dd13cFTqsLO97HaFE1pRWNH82fW9hHj1cBTP/5K8oWqlesQqHT1xwcd0TXgXPsECcl1XEXF70Xw6QNSmA9iXh9PSp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498372; c=relaxed/simple;
	bh=PIbycf4963uPnEOw6Q97Ma3KqGZuGgpEE2wMJ+AhOeI=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RyopNSyKj6hoKE0veFzrNc3bj2fupENe3m2Jar4TkbmVrwje0C0poRRkJnIS0TzywfawM9Le/N7ZLnhN360ZCoJUG/qNw3AkA66ssRK7F8Q9DCKzz/lRIEo9jtsQJ4Bh5kmw4RnEnoitX+r9cPFu9A6WDoDloO3L9DsnabjGi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=APO6EheF; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5316j2iU027691;
	Tue, 1 Apr 2025 09:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=D
	a0tnkp3T/NCXUI7dfqWoyWv7iwXuY+Nb/qPQDB6l7Y=; b=APO6EheFp746vQXaf
	3nS3Mkm11oFKnSCs8Hi8w4B3ewikw6YvBQQYTjsRJD89J2GU01wQmK4xz8B5Hg0/
	emA+67sbW4NKVUlit6FOXi8X6/JQuQNKm/x7VH1BOkq2iD6OnewGtTW6RarLtTqe
	eCC8eRcOmH3W/8k1mXkWVopjJ0MayolhG1b27Saeh14NPi4hSe2xOOguzpur0akN
	BTzHisVYxujcrUWJN43QqxzZCgwgHvoRUCzicTbE/uKOANNPYsOlTPp5u7oEb9OB
	KwBUHLkyxcqBIaCz8LGjKh1aXkIC9pOWwmV50Q0MUCYqbn9ulHcLeKh3NDGdBZa9
	xeMiQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 45p9u0t0cx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 01 Apr 2025 09:42:13 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.134) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:42:13 +0100
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
In-Reply-To: <20250318-ddkopsrc-1339-firmware-related-memory-leak-on-module-unload-v1-1-155337c57bb4@imgtec.com>
References: <20250318-ddkopsrc-1339-firmware-related-memory-leak-on-module-unload-v1-1-155337c57bb4@imgtec.com>
Subject: Re: [PATCH] drm/imagination: fix firmware memory leaks
Message-ID: <174349693297.75513.11340086159076758678.b4-ty@imgtec.com>
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
X-Proofpoint-ORIG-GUID: UIadNlxN-DwHGOdiLdKEf9rZLmvcXZ9a
X-Authority-Analysis: v=2.4 cv=c/CrQQ9l c=1 sm=1 tr=0 ts=67eba6e5 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=UtEzwyU9vMAA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=r_1tXGB3AAAA:8 a=kp7NRgVx36oRqAarGZ8A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: UIadNlxN-DwHGOdiLdKEf9rZLmvcXZ9a


On Tue, 18 Mar 2025 14:55:55 +0000, Brendan King wrote:
> Free the memory used to hold the results of firmware image processing
> when the module is unloaded.
> 
> Fix the related issue of the same memory being leaked if processing
> of the firmware image fails during module load.
> 
> Ensure all firmware GEM objects are destroyed if firmware image
> processing fails.
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: fix firmware memory leaks
      commit: a5b230e7f3a55bd8bd8d012eec75a4b7baa671d5

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


