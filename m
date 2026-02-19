Return-Path: <stable+bounces-217514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BlLL+uBl2kOzQIAu9opvQ
	(envelope-from <stable+bounces-217514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:34:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA007162D44
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D722E300600A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00E92E9730;
	Thu, 19 Feb 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gbQro0Mh"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D8329E69
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536870; cv=none; b=cNhkjsB3JuIvP5sXljQorIH6bphfRdasJHwXcHj/nBIRpjosyq9k1t0O5ega9XyjRYcfm7E4RDA/Nvl3iq5FTaSZVb3cILkbAwfDOaBZM7S8aE+pBCMmB+MKZ+7vqBR5TSpRn8TcR+1uADBQfA/sY1yiLieWuExvLjBz0/McR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536870; c=relaxed/simple;
	bh=pGAoJkE9pC8MQsKO7DruCKbIXhxeFRb7boLiCPTzmDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSJImKmCagyXEeD9kFDqWpCo8Q1KASQvf9UX24F8BoTEm0FWqeN8Xwp5yUNm+2+kxmd7tE6clwMtjlyUbEsvz44duWgykk4B/DzvukY+Hzu8P7t9sTcULWbbButcDLPywnuNiPNkXWpAFyyNKhjNriok7eD7LKW1ulcL7GOMlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gbQro0Mh; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771536869; x=1803072869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+Fuwbkh8A0ISo9zHncfPXU5Wq7HxVVMOURG60/3bko=;
  b=gbQro0MhDLjIXNlUyrI7XQaVXFdYYnVNdUqcFnF2q274ZKwlZTm3APjj
   l3ZSNEq96LsbkQ9Z8kEFMVKC3WIiUUL5Umgky3mJVAnM7EJ8/QUT9BfN/
   UOmugwPEgnnfn9nNuf4H/ZoB7wvxLBARX/wpzf9nuj1tz1bjSFd61Ueqc
   74Nrre64SnEjUWhJvYvhxbkSlz6NIe+iDYYHL5MAhXcs2eouILnMM98Ge
   +4iXFlXPKSxJrNeuHVrgTDQDcgp5+QeimLH/lUh/ZT25uV7aGj3OGUwn/
   xLsLxrGWwH3sBxZHbeKMhr2vyQOqHs0Eq691zHH2N7CXzMm9WX1k79una
   A==;
X-CSE-ConnectionGUID: IhRUd3g/SKel+CD4JlYRww==
X-CSE-MsgGUID: Xf8+xQ39SMK6cK/7S5HOFA==
X-IronPort-AV: E=Sophos;i="6.21,300,1763424000"; 
   d="scan'208";a="13397088"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 21:34:29 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:21173]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.87:2525] with esmtp (Farcaster)
 id 3339a726-b201-4903-a245-49682e3345bf; Thu, 19 Feb 2026 21:34:28 +0000 (UTC)
X-Farcaster-Flow-ID: 3339a726-b201-4903-a245-49682e3345bf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 19 Feb 2026 21:34:26 +0000
Received: from 6c7e67c92ceb.amazon.com (10.119.146.93) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 19 Feb 2026 21:34:26 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <ap420073@gmail.com>, <kuba@kernel.org>, <patches@lists.linux.dev>,
	<sashal@kernel.org>, <stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: [PATCH 6.1 148/280] selftests: net: amt: wait longer for connection before sending packets
Date: Thu, 19 Feb 2026 13:34:20 -0800
Message-ID: <20260219213420.94656-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204143914.959181459@linuxfoundation.org>
References: <20260204143914.959181459@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org,amazon.com];
	FROM_NEQ_ENVFROM(0.00)[zcgao@amazon.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lib.sh:url];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA007162D44
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:38:42PM +0100, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.

Hi Greg,

Apologies for the reply after review window. This patch depends on lib.sh under
net selftests which doesn't exist in 6.1. The lib.sh file was introduced in
v6.8-rc1 via commit 25ae948b4478 ("selftests/net: add lib.sh").

Without it, the test will fail on:
./amt.sh: line 76: source: lib.sh: file not found

Do you think, in this case, tools/testing/selftests/net/lib.sh is better
backported? Or the patch should be reverted? 

Thanks,
Nathan Gao

