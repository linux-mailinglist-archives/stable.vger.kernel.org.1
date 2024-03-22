Return-Path: <stable+bounces-28629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB1887106
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 17:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDCF28525D
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904785D729;
	Fri, 22 Mar 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RPFXo4jk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB95C90A
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125614; cv=none; b=LMLBAhO8z4F9KiSckWCgYEAwWzXdpnIDDBKikC/xWtpCh0IF1dg5Sk5F67mET0Rxx4kG28XDo37tXaxNWNbkIAobELCVsvnO8OImTMmIlGucz5X5XuNtsjvdNjOGkE867At0E+dFXsZ/fnV1cxyPHLqF3whjbIb+AXlIpSd+WKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125614; c=relaxed/simple;
	bh=3OCd/PG1riagSwvp+0YZBdv6h6xzFkRZdcL7HBpMmjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pyUoaaY6DhsY11DWHACayHk2Or3wr/rLmDMcHS4zrxOsX6n1nmi51dBNZ9wHm7oxeL26lzM/gSGQO4q+xjK15bQ7l2MXzLv9pFm5cduFWCGnUTEHUl1NQbqfVJdtH9SZCygyhB6Qu5i5Czw4gEL3SP5z3juVqZMgQ4bor10O1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RPFXo4jk; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711125613; x=1742661613;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3OCd/PG1riagSwvp+0YZBdv6h6xzFkRZdcL7HBpMmjY=;
  b=RPFXo4jkdevrPK7uL4H14xjWVFUkxTo5bKATL7n+aTsGbnDMyHWoTAj9
   vI3Cr0HUoGVyUIvhClK5VSqlvcm6AWknNNIrNqJ7Pbwsp+QOhzqUp00ZY
   BViHl7gZUH8mUCrMJWF9t2maAxx8CaeduHVoywZ+hh0iWbJIJ2bAIE7dQ
   c=;
X-IronPort-AV: E=Sophos;i="6.07,146,1708387200"; 
   d="scan'208";a="395328454"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:40:10 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:4550]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.1.129:2525] with esmtp (Farcaster)
 id 0702d3c1-33a6-4e66-ab4b-6006588b1c58; Fri, 22 Mar 2024 16:40:09 +0000 (UTC)
X-Farcaster-Flow-ID: 0702d3c1-33a6-4e66-ab4b-6006588b1c58
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 16:40:09 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 22 Mar 2024 16:40:09 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 65A9A8F5; Fri, 22 Mar 2024 17:40:09 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <sashal@kernel.org>, <stable@vger.kernel.org>
Subject: backport 'regmap: Add missing map->bus check'
Date: Fri, 22 Mar 2024 17:40:09 +0100
Message-ID: <lrkyq7chufceu.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

 This commit needs to be backported to 5.4, 5.10, 5.15, it fixes
possible null deference from the following commit 'regmap: Add bulk
read/write callbacks into regmap_config' which was backported to these
kernels in the latest released versions (v5.15.152, v5.10.213, v5.4.272).

Commit 5c422f0b970d287efa864b8390a02face404db5d upstream.

Thanks,
MNAdam

