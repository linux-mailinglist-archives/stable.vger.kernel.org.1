Return-Path: <stable+bounces-20274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8685645B
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 14:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8861C215F5
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A6130ACA;
	Thu, 15 Feb 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Beqk3dEQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CD12FB3A
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003748; cv=none; b=IFc7PpjjPTH8cieic5mnoBirliKqmnBUoQT4grzO81cc7cQ1oE/2utK5+JI+ll37IuYVw1BJWYQrwpCF+7HFQSlMyluZb0Wnj/IFWW40T6qquVfuNNG0UPqoZxDcPmOFP+TD4+UHhTn0BcE7tenqz7MW2SvTm8bH2NGRNrOXMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003748; c=relaxed/simple;
	bh=WiQcge2JnAUCQkfW3l+QG7H/yMlen86y4gaopsfGIag=;
	h=From:To:Subject:CC:Date:Message-ID:MIME-Version:Content-Type; b=Tsv6Lu4qR/sLpfEb+DOiVfsgib7BJOnB/XKpGVairMr02bCjxPrB4hghSFWHKOSq9kfMztGF0oZnJ6vIhswFD8keOV+o8kyvZ7SBe3XodATvd+oDK4a6uojpSsRF1zPqKg0Um+bGjpv50FIlp5/eW/B2F6NCLlTr7ZmHxB5McDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Beqk3dEQ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708003747; x=1739539747;
  h=from:to:subject:cc:date:message-id:mime-version;
  bh=WiQcge2JnAUCQkfW3l+QG7H/yMlen86y4gaopsfGIag=;
  b=Beqk3dEQOcKXYlPciT+cnjVO0nb4uYBmQelb0bPML5AUw0pOZIu9cyqh
   5wUH7Arg8RdQfEEWPV6iceVO7htfUOL8iINY1+6rf8YjXlJC8Dr2HCugh
   NYfhuZdAgvH5Pqlty83b6QqM/0XvXut8rbimPWGBg4TeuTaXWNKrZRUBS
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,161,1705363200"; 
   d="scan'208";a="613271990"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 13:29:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:14692]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id 3acd2b28-09aa-47e4-b6d4-699d4edb803a; Thu, 15 Feb 2024 13:29:03 +0000 (UTC)
X-Farcaster-Flow-ID: 3acd2b28-09aa-47e4-b6d4-699d4edb803a
Received: from EX19EXOUWB002.ant.amazon.com (10.250.64.247) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 13:29:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19EXOUWB002.ant.amazon.com (10.250.64.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 15 Feb 2024 13:29:03 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 15 Feb 2024 13:29:03 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id E588FC90; Thu, 15 Feb 2024 14:29:02 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <stable@vger.kernel.org>
Subject: backport sched_rt_period_us and sysctl_sched_rr_timeslice invalid
 values fixes
CC: <gregkh@linuxfoundation.org>
Date: Thu, 15 Feb 2024 14:29:02 +0100
Message-ID: <lrkyqo7chg8kh.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

The commit `c1fc6484e1fb sched/rt: sysctl_sched_rr_timeslice show
default timeslice after reset` is a clean cherry-pick for v5.4+ kernels

and the commit `079be8fc6309 sched/rt: sysctl_sched_rr_timeslice show
default timeslice after reset` cleanly applicable for v6.1

These are trivial fixes which fix the parsing the negative values when
read from the userspace, but will also make LTP test `proc_sched_rt01.c`
happy instead of ignoring it.


-MNAdam

