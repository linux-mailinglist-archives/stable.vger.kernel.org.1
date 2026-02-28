Return-Path: <stable+bounces-221230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9dxvC3qBo2lEFgUAu9opvQ
	(envelope-from <stable+bounces-221230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 00:59:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9061C9C53
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 00:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73DDE301BA5F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C73399025;
	Sat, 28 Feb 2026 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RBycUBJz"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89298430B85;
	Sat, 28 Feb 2026 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772323191; cv=none; b=esA7zR5q7/AuwLDih1rzyXhk93VE9MHiUzpsYX3NiMkX9Lfro8b09EuQKJhc3QcZq+6/6Wfs04GagZ0qPkMwUgHKsTlTMNe9f2Rp6XwX1d1MONdbFFDuX4C7Tj1cErLOLeXl+lcu7rSeYjl2DAEgMdFSc2+EYUCn+uF5a6corGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772323191; c=relaxed/simple;
	bh=hKXMk9JqLxIF/o307cUGlK9XOB5P+KxCRqeDOLdx134=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awIN2xRG9zohnm7qMgjjwEgwgGXFEK4mHS/j1dIZJVfuE2/8SqMXbG7enn1q2nkGVmsdBvoAEigjcf8orVBlOC+9H/SoegUKeFUH19ToJEvmd+d39y/fLoV3nsM4vkdqD3qy/n6EG5+QwbanUA7o2Rc0nQrTtpR93oK3u/24ln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RBycUBJz; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1772323189; x=1803859189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKXMk9JqLxIF/o307cUGlK9XOB5P+KxCRqeDOLdx134=;
  b=RBycUBJzl1TnEirhzoDPyUP9699MSwRerISGm1K8Ukxqb5pjWYBbnP1O
   5bgTEXuhiiMXxn/Ab2DImaA5ExD9+UNuOfe/Cn8RyO4JXTIdqnGxp4wMN
   FNjl1M5ALJ6uAgnYBmmqMadcCd+vD9YaSfne1oR/JzlRg+AXyJQQJOsGe
   ieLjzJ+PfG4EMmqJV/G6TLUzQESXHp3St3mydIeDv2DYeSoW2VUndo/vH
   hugYKtfkoH5C/8D7pn0wK7vo9L+iz03MOF5IfFk+9Z5MYYkbegkrqOVY9
   eeK3ZTnfQEa4VdKJNqH01OqRzAxsJELvr4fYLaFkpmSzVHr8AdFVcLmzb
   w==;
X-CSE-ConnectionGUID: UHUJOMCRSv23JoznsU88lg==
X-CSE-MsgGUID: QEADJu9oSbqIMFSlYLgYag==
X-IronPort-AV: E=Sophos;i="6.21,317,1763424000"; 
   d="scan'208";a="14019297"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 23:59:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:21683]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.152:2525] with esmtp (Farcaster)
 id 34b04a31-8249-412d-b8fd-6b389c0de126; Sat, 28 Feb 2026 23:59:46 +0000 (UTC)
X-Farcaster-Flow-ID: 34b04a31-8249-412d-b8fd-6b389c0de126
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 28 Feb 2026 23:59:46 +0000
Received: from dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com (172.19.90.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 28 Feb 2026 23:59:44 +0000
From: Darshit Shah <darnshah@amazon.de>
To: <darnshah@amazon.de>
CC: <Jonthan.Cameron@huawei.com>, <bhelgaas@google.com>, <darnir@gnu.org>,
	<feng.tang@linux.alibaba.com>, <kbusch@kernel.org>, <kwilczynski@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<lukas@wunner.de>, <nh-open-source@amazon.com>, <olof@lixom.net>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drivers/pci: Decouple DPC from AER service
Date: Sat, 28 Feb 2026 23:59:38 +0000
Message-ID: <20260228235940.47613-1-darnshah@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211164257.81655-1-darnshah@amazon.de>
References: <20251211164257.81655-1-darnshah@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221230-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[darnshah@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E9061C9C53
X-Rspamd-Action: no action

Hi Bjorn,

I'd like to follow up on the v3 of the patch submitted earlier and see if
we can merge them.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


