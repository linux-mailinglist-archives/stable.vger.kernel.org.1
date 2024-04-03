Return-Path: <stable+bounces-35701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D259D896FB5
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F92228E4B5
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008E146D54;
	Wed,  3 Apr 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g+YM99V5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAF146A75
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149225; cv=none; b=oCFpOaZdDTx3kKErNa4NUVon/MG170BAtHYfio1CheOvgKF+CNejdahratkIxdSecTZQYx2btE1SGxsbw4sH/uQ/CRy5V6iYUXDEdHbBQGwgLJGOa4TZaoQG+ylVuseEd3Us4woj5DwwmmHpKq6mRK5eifdP/nbFT47iN5GzqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149225; c=relaxed/simple;
	bh=6fbV3mMwUNkPLFxWvxP9zO58uk9kX3FXIaBmHMzAB1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RcMbRYSkkwVnxWXiOwShMGi0/Vxn7oRGI+s4A6RB3z76/hoODemArXhMSNTrr/hyGCpHHOOn6h/w2TaWFwyVmkCjcaj2eowPeLJMIlla1mciYFgv3JDsRlsWMA+E6LI32rayiU8G0idYK9dATNMxoBNtW3au7hdF8C5no8+gMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g+YM99V5; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712149224; x=1743685224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6fbV3mMwUNkPLFxWvxP9zO58uk9kX3FXIaBmHMzAB1s=;
  b=g+YM99V5zE0C4RC8Gdl4mxIG8R6wjHZTnyuDDKzp2DghMVI3HRqju9r+
   PAv/82pzzJGJdN7JGjP5yHt1giEKhtCjZhsbwgQJJvEnjZJZJbPj3sq0B
   myJs0FlCZ8FXsbDFzIF5UbxB9TitRYQCBbbK9nzPc4x8KxxrnB8/Y6vft
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="397893193"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:00:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:50619]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.213:2525] with esmtp (Farcaster)
 id 632963c1-b31b-4100-9553-77451d6c3e83; Wed, 3 Apr 2024 13:00:20 +0000 (UTC)
X-Farcaster-Flow-ID: 632963c1-b31b-4100-9553-77451d6c3e83
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:00:20 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 3 Apr 2024 13:00:20 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id A4C02BE6; Wed,  3 Apr 2024 15:00:19 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <djwong@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 0/6] backport xfs fix patches reported by xfs/179/270/557/606
Date: Wed, 3 Apr 2024 14:59:44 +0200
Message-ID: <20240403125949.33676-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi,

 These patches fix and reported by xfstests tests xfs/179 xfs/270
xfs/557 xfs/606, the patchset were tested to confirm they fix those
tests. all are clean picks.

thanks,
MNAdam



