Return-Path: <stable+bounces-226906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KORlEEPEuWmcNQIAu9opvQ
	(envelope-from <stable+bounces-226906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:14:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5022B28BC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D383094713
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7139E38F643;
	Tue, 17 Mar 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CAxYt9+Q"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1838F633;
	Tue, 17 Mar 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782077; cv=none; b=cqmgXmjjoOz4qZwMw8aUfmtjA1Z9OCecBGIqtlwKc5pTCmNvYNR6vLvcsy03qUKC4ULYylDPYW3xFHR1X+70EUq1kHCzJcoLfq+7j9oVBMHe5LQadU09dUw4dX4Nu6RxXpfHAvLoEnU3nJhLLgaxoSPqWlrV4F9Gp9U6NeCprfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782077; c=relaxed/simple;
	bh=KT1d0AZjgEJbzucV2O/0YkUnXeV2gqoESgotqt8FeXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTeUjl9tBWoyos83G09B9QfwBXz+E2TTz9xUxvcHkrBlW2NzujS49DqfH3RKIn596teoSeuM9dMJFhR7rnmw21TW3M1a0SxUxUn3ykCF70AXAbP0qtHl/dHwyGTn98yjvMXa6TXLIZSM88X6cdvd0vwbxtgA26O9eHAqB4XSy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CAxYt9+Q; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773782076; x=1805318076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qFp2oMVJDtMMkCTUqe7bU8d4XmmqNyytww9abTI2MGA=;
  b=CAxYt9+QEnkXb8KL0zbfm36hIiqfsUBpViiRS3KDbRA9R8/GXc/XwLrx
   sVbMcOHAz71Vu1XkfoCodxu4myuaq3HID9mXkWuY/fC8m2SgkS+1ORahM
   GjJBq+yfuDykesrEeffvDOAR9Pyw1OXtHUhBfzoGm++iZeR5wYfutn0j4
   Hm+lOW+pMLM5LQmBVMT+brt0SHejds73co6BuutshjVhQxjrQRLArqtLO
   0rz5DTsg9lkhCPePgfs7jnEIt1pp/4PRwqtCfThI26m6g1VCl8IeYi1p3
   dQhFvxze117BpcNju2rYbxVclZwE+fIpC9nrOUqYd1rU2ch5De9fUODfp
   w==;
X-CSE-ConnectionGUID: xsg/Kp/OQ+eeifqOuf0QVA==
X-CSE-MsgGUID: CQ3RG4M+Qdeh07oWnMNaSA==
X-IronPort-AV: E=Sophos;i="6.23,126,1770595200"; 
   d="scan'208";a="15115604"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 21:14:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:15105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.226:2525] with esmtp (Farcaster)
 id eb4eb0b5-f5c8-45e2-8f4b-153efd7dd4e4; Tue, 17 Mar 2026 21:14:32 +0000 (UTC)
X-Farcaster-Flow-ID: eb4eb0b5-f5c8-45e2-8f4b-153efd7dd4e4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 21:14:31 +0000
Received: from c889f3b07a0a (10.106.82.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 17 Mar 2026
 21:14:29 +0000
Date: Tue, 17 Mar 2026 21:14:26 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Christian Brauner <brauner@kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] fs: fix use-after-free in peer group traversal during
 mount release
Message-ID: <abnEMhJgM3LxEuKM@c889f3b07a0a>
References: <20260314184421.47303-2-ytohnuki@amazon.com>
 <20260317-flugtauglich-zieht-fbf41690387a@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260317-flugtauglich-zieht-fbf41690387a@brauner>
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226906-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,c0fd9ea308d049c4e0b9];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9E5022B28BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:24:32PM +0100, Christian Brauner wrote:
> The last time this reproduced upstream was on:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> 
> which is v7.0-rc1. At which point the question should be "why?" :)
> 
> Fixed by: a41dbf5e004e ("mount: hold namespace_sem across copy in create_new_namespace()")
> 
> In any case, thanks for the proposed fix but it is already fixed
> upstream and the fix you suggested indicates another bug that is the
> real cause.

Thanks for the review and explanation. I should have checked why the
reproducer stopped firing on current HEAD before sending the patch -
lesson learned. I was testing with a custom reproducer that called
clone_mnt() directly from a module, which bypassed the actual
create_new_namespace() code path and masked the fact that the real
bug was already fixed.

I see now that the real issue was the namespace_sem drop-and-reacquire
race in create_new_namespace(), not a missing cleanup in
mntput_no_expire_slowpath(). a41dbf5e004e properly fixes the root
cause by holding namespace_sem across the copy.

Please disregard this patch.

Thanks again,
Yuto




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




