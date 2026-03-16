Return-Path: <stable+bounces-225536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLJ8IGIEuGlpYAEAu9opvQ
	(envelope-from <stable+bounces-225536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:23:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D260A29A48E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5AF5303677F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0E395260;
	Mon, 16 Mar 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="dw2rTAjQ"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209C26059D
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667293; cv=none; b=DNvHwBc2zmhVVCi8Zx/Bc/7dc9sX2WgZnsM3OHlh5l8J3KERj/cIuPg5aGVr9kfuq1ey15jV/TXWnNc5Ri1zWvpI5TePYVz90DetMZ0q3NQCTddHKAHkgiOs3sFKa2MSraFDppp/48PGDZg3NZSVB2ooNWwmCsBbCn+6H96tyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667293; c=relaxed/simple;
	bh=L1DH6XtuRd/zlVi5gbZ7bpcyNRJJtfSD0Z1NBLD/CDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=edHIz0+m+WpwgcsXBRF0b4fK2jS0lRmUrWZYmApmqACU7eANPW45EsZzybO08KvoAGyuyfARtnX6DqCWFyaR7BrIL4YSglXnBriLLlLNCRlu72nCa1fTCTCFtb0dzejd09WxcyMn8u0AIjtyS0BAKSvy6xoYpmdrz0h1aITYrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=dw2rTAjQ; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1773667291; x=1805203291;
  h=from:to:subject:date:message-id:mime-version;
  bh=L1DH6XtuRd/zlVi5gbZ7bpcyNRJJtfSD0Z1NBLD/CDc=;
  b=dw2rTAjQPILoZHsYQx4GJo8jbfB7p6z/ZGQT7aAi8PjrBzEV0bj1lcCA
   nEgntyiDbiNO08S8qvVOATknECdVqAZp+EbLwSwWzihgcWSG+yviXR69o
   4Jtt0zr/aSDLDlsR0Em4/Gj+3+UztkY8BQgyOkoMvzDyTej4FglpkMcnb
   312PRiS8JWEdDg/15dxra2MND3+lb4KoiP1mhHQ5k9NSFlsIY8xc++2BT
   1sXQJTZMmVmiKm+26lktI+W6hDL75Fjk1DQ6UToPuIRQYSej43UKXBBj7
   Egn7EMIWCZ90uXvgQ7U0HJ+hBwlC/EUwHGmb+Qh6O+u/Ii8iieuI6/pWp
   w==;
X-CSE-ConnectionGUID: wpU/8qeBSveKjrdppMtUNA==
X-CSE-MsgGUID: eOM8+IANQwaGY0cSx8cTeA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="15136661"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:21:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:28751]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.176:2525] with esmtp (Farcaster)
 id 86a18fde-01d2-4657-a6d4-6bb7434e5d7a; Mon, 16 Mar 2026 13:21:28 +0000 (UTC)
X-Farcaster-Flow-ID: 86a18fde-01d2-4657-a6d4-6bb7434e5d7a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 16 Mar 2026 13:21:28 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 16 Mar 2026
 13:21:27 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <stable@vger.kernel.org>
Subject: 6.18.y: Please backport commit 31b153315b87
Date: Mon, 16 Mar 2026 13:21:25 +0000
Message-ID: <h6dsx7brbucyy.fsf@dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225536-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D260A29A48E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

could you please backport the following commit to 6.18.y stable:

31b153315b87 ("drm/amdgpu: ensure no_hw_access is visible before MMIO")

It is a follow-up fix for commit cd7ff7fd3e4b ("drm/amd/pm: Disable MMIO
access during SMU Mode 1 reset") which was backported to v6.18.10.

It's a clean cherry-pick.

Thanks,
Simon



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


