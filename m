Return-Path: <stable+bounces-256553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACw/F2NRGWrzuQgAu9opvQ
	(envelope-from <stable+bounces-256553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:42:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7745FF586
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FB3230F8430
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF836BCC4;
	Fri, 29 May 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="mPwWyoru"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6DDF59;
	Fri, 29 May 2026 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043908; cv=none; b=Bu63Qa9O9RazuLN51X3JH146oX7Lz7KhIqoljwkUUAkTgd2ksl8kUkMobuI4jy7tBJ7mqfIGK9r/agfEtPls4igaqSrOVPgW81Wyo1seh1Awuar49BKajpVSsVOlE9hxdlCiErG6zba39FB3DBmQC6PON0DAPnzWAycitMRlSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043908; c=relaxed/simple;
	bh=PP63Nxpfk1pg0J5X5ib1D46jVYgN+lrbAlGgTS/6zag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=tAPJQnfA/adx7lOezWfrVxgbCi/Tp6o3r0lJoD82ARj8ETVZ3j8/3BBvyjPxynFos/MnoXxBMP2WebXMMxaG84YFUptXgw0wndc1IZmaBfS7Yt5xrXpgcUFMT7M5+pznRGU8YtunLCmxfPhgsWZrD9Z+/IU3+My2KrRhDM7lC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=mPwWyoru; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780043907; x=1811579907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PP63Nxpfk1pg0J5X5ib1D46jVYgN+lrbAlGgTS/6zag=;
  b=mPwWyoruHCkXBKO29XKQDvBqrNgMI5VaAOAJ7+BbWzIHjW4UgqM4G5u8
   60dTLYu3A8x6tq5DfmMRn4r8mwSOsNQu+TtOtWZRUDU+4MK6q17bbFyTO
   AUUPFGywVw+NF+g51BilXffTQlGI83OYg5aeBIgxyPb9FNECZlWHuNG1A
   rWx5S21+/VnbgPbZT+ZZVnZIprj05Fba2cqP8oYQyo6VThBXDp3AZIOAi
   BZ6qCoLd7yH8SD8FrhpVKGeyiV1SVslTvNHnNeTmFbiPlNG6JgrueXIVh
   ZJ+PgVD7AS8Z/lcLyFN9IVSKP/bYiXnkwlHuRgVdrl9XiSSsz4dpqKdVE
   w==;
X-CSE-ConnectionGUID: TmDwMfudR42EvBM/XquFOA==
X-CSE-MsgGUID: 1hu4YY2cT8m/0v6pZTfXNw==
X-IronPort-AV: E=Sophos;i="6.24,175,1774310400"; 
   d="scan'208";a="20684257"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:38:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:28357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.154:2525] with esmtp (Farcaster)
 id 130eb445-6549-4bc9-ac7e-f69eb12094af; Fri, 29 May 2026 08:38:23 +0000 (UTC)
X-Farcaster-Flow-ID: 130eb445-6549-4bc9-ac7e-f69eb12094af
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 08:38:23 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 08:38:22 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Bjoern Doebel <doebel@amazon.de>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Alexander
 Bulekov" <bkov@amazon.com>, Fred Griffoul <fgriffo@amazon.co.uk>,
	<stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: stable backports for "KVM: x86: Fix shadow paging use-after-free due to unexpected GFN"
Date: Fri, 29 May 2026 08:37:44 +0000
Message-ID: <ahlQQlD1ygfiQ3bG@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <62bedd23-a9d8-4c05-bf39-662c2d37b793@redhat.com>
References: <20260503201029.106481-1-pbonzini@redhat.com> <62bedd23-a9d8-4c05-bf39-662c2d37b793@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Status: RO
Lines: 11
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doebel@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-256553-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com:mid,amazon.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[amazon.de:+]
X-Rspamd-Queue-Id: CF7745FF586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

On Tue, May 05, 2026 at 12:13:34PM +0200, Paolo Bonzini wrote:
> I'll get to testing and sending them out, but it will take a while; if
> anybody wants to help testing, I can provide my tentative patches.

took us a while, but if you are still looking for help, my friend Nathan
and I would volunteer to test these in the context of Amazon Linux.

Best,
Bjoern




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


