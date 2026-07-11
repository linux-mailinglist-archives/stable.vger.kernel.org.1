Return-Path: <stable+bounces-273348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ITSRIrWTUWp/GQMAu9opvQ
	(envelope-from <stable+bounces-273348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 02:52:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A573FDD9
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 02:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=PdhPCfAl;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273348-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273348-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28516301F987
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB413E02A;
	Sat, 11 Jul 2026 00:52:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5235893
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731121; cv=none; b=BnSGXSkorert9/uyLeypi3xWwkWj9nIM1TB+0+H5LZwSSDF0Nn6nMz5v+UJm33AFYQa3YP1gDH7G62YTXyprOamRXwIwNs7fWMCUQ5xw16MAE6acZopPsHsB9CBEVA2gKHRrNpteXd7qhwqPB4rQ05Fp7LzGyyPg6IsdQu7ixIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731121; c=relaxed/simple;
	bh=f6ii48A2qm7BmvBmLEybKtUxiEA54YO7HFu0yk0bNcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAL5Y3bAczgiF5xslpipdVm3FGYOtZpiUVb8ivwgXPBH6FeejdtSBCCK2gATPFenMlZ8PK1GKC0D+MO9+fUvXpP8oxm2OtuAYfg8I1v1HJzAkrAogVK2rCfM3tTsxl8NHN4pgiq9mP1/AUUfGpQNGy6ulqd+zyV9eaQSaNeEfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PdhPCfAl; arc=none smtp.client-ip=35.162.73.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783731120; x=1815267120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6ii48A2qm7BmvBmLEybKtUxiEA54YO7HFu0yk0bNcI=;
  b=PdhPCfAlvrkzd6hvjQPSc0403Z12mV8K4IZnw+Q/jobwQskDMb/H7te2
   t0JafKiIJXmfdLxVNs1Ke3p0zU3l05fJuCApsO2nLrh8Snd41X8+bBeu1
   rIccipO47hVkKWetEfQYJFhOPFcz5T+D5kHtvHRv2MSnD3FX7Y3bh1UTa
   kVAG2gdFqr9SFlZ7hFBUpRSbU0HV9BURVcIzRlKxADAgBLAAlfvgBlpUW
   8egtf+bQ2+exPi4zsifVqFposR3VNA29czpLD2d7AGbH2j4v4i7PanhpD
   ilKP0HtZ/g48C4ntMuvmZRslB0XRPP9/4lpeCXXgwYcj3EkBEH9qtL0io
   A==;
X-CSE-ConnectionGUID: DUss6yahSpKLA41ZU3293A==
X-CSE-MsgGUID: 36zvVySTQUWUXZSNryx+dg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23266734"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 00:52:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:25824]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525] with esmtp (Farcaster)
 id 8c7b7e93-a97f-474a-8984-603708c7a8a0; Sat, 11 Jul 2026 00:51:59 +0000 (UTC)
X-Farcaster-Flow-ID: 8c7b7e93-a97f-474a-8984-603708c7a8a0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 00:51:59 +0000
Received: from dev-dsk-mkbund-2b-ce767ba1.us-west-2.amazon.com (10.169.40.81)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 00:51:59 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <eadavis@qq.com>, <chenridong@huaweicloud.com>, <tj@kernel.org>,
	<syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com>
Subject: Re: [PATCH 6.12.y] sched/psi: fix race between file release and pressure write
Date: Sat, 11 Jul 2026 00:51:49 +0000
Message-ID: <20260711005149.4054833-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260710224845.3892042-1-mkbund@amazon.com>
References: <20260710224845.3892042-1-mkbund@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[qq.com,huaweicloud.com,kernel.org,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273348-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[mkbund@amazon.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:tj@kernel.org,m:syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkbund@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,33e571025d88efd1312c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D09A573FDD9

On Fri, Jul 10, 2026 at 10:48:45PM +0000, Mark Bundschuh wrote:
> From: Edward Adam Davis <eadavis@qq.com>
>
> [ Upstream commit a5b98009f16d8a5fb4a8ff9a193f5735515c38fa ]

Please disregard this backport. I sent it without realizing this commit
had already been proposed for 6.12.y and declined. Sorry for the noise.

Thanks,
Mark

