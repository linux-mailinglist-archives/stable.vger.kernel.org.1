Return-Path: <stable+bounces-197923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A9C97E95
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A6484E18C7
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518831A541;
	Mon,  1 Dec 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="R24zD9xe"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED67319859
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600680; cv=none; b=iqL+03NglR5Oq0nHJ5SEqU8ltusS9pGkM1TPRFkgujT+IPtbjjfFowI3YaJWXDw97NgtNurf0o9CZzJxintTBCJPquSkf2ytGqLA+0jPTg+Acp8qtCbjjr7URDZ7fdK9VtQ8j0y53WQQYzdVMYU6KD+kwXWwVZJRKMk/ZP3BtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600680; c=relaxed/simple;
	bh=LHZ0DCtsMhR+eSezXQHbJ7vIfX+qvzSJt90ql13r/EI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAJBenQpc4YSqd5E7u1GL+x9ZTriYGQOcer7C3wTsilRp7AhfpL+3tLwi9WDFc93hF04Vf6/E0RQx/Lz5qRr3Bh+iCdfZ5EdBjiaw/WRsLaviP438ULfNnr3e4FrAs3MNrpGILXkFMcCKOPMVr1tPqiAnfIe+pxyQnbGFWIs5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=R24zD9xe; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764600678; x=1796136678;
  h=from:to:subject:date:message-id:mime-version;
  bh=Xb5eWJ4exFLVoU4KdFdOIONbdnfzcY+ttumo2kOb6pM=;
  b=R24zD9xefxBGsp0yViHT6/uJtCRw1vAfSPPHR9RGV0NYMvyjaSG1M8Ip
   My20r73Cr5BC1PvMJFojvBlWqM86QG88HIij9uHawTeztPkUsqTGaLqIM
   v2w9Sk0m7RZVQqsiekjPZ9Qltwvq/C6KpdmiSWgvBx7LHZ5yJ5gyfSjsp
   DJC5I5E1PcCCCe44LnIhvKRXrO1YF0hMYAmxWexTrTZzMzY73JVXnaNsy
   7QwjJ5JFjolF+ntOANDzHM/unldS32nPqdZSqsP8+gwDRtNW83cvylebG
   RJIxMmInSYFUK8bNs0dfN1ZL0j5+YxtRZq/oCN2wCKqAKJFr8NNipC3R9
   w==;
X-CSE-ConnectionGUID: jXQmyU8KQOiisv+1NfkoSQ==
X-CSE-MsgGUID: DeHki8rEQrmYsq8+AhG2Hw==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="8163710"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 14:51:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:1379]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.243:2525] with esmtp (Farcaster)
 id e7fecd06-43f0-467d-bc8d-6149d8c4fe75; Mon, 1 Dec 2025 14:51:15 +0000 (UTC)
X-Farcaster-Flow-ID: e7fecd06-43f0-467d-bc8d-6149d8c4fe75
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 14:51:15 +0000
Received: from dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com
 (10.13.232.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 14:51:14 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <stable@vger.kernel.org>, <lieboldsimonpaul@gmail.com>
Subject: Backport d2099d9f16db ("net/mlx5e: Fix validation logic in rate
 limiting") to linux-6.12.y
Date: Mon, 1 Dec 2025 14:51:13 +0000
Message-ID: <h6lip8qfm45ni.fsf@dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi,

I see that a backport of commit [1] has been merged into the 6.12 LTS
tree as part of v6.12.59.

I suggest commit [2] to be backported to linux-6.12.y too since it's a
follow up fix for [1].
 
[1] 43b27d1bd88a ("net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps")
[2] d2099d9f16db ("net/mlx5e: Fix validation logic in rate limiting")

I tested the change and everything looks good.

It's a clean cherry-pick.

Thanks

Simon



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


