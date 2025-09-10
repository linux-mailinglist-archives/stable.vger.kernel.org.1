Return-Path: <stable+bounces-179202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA1B517E2
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB187B7752
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D642882AF;
	Wed, 10 Sep 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="M/jHAVD7"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564E268C40;
	Wed, 10 Sep 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510875; cv=none; b=DHpoZNY9E4Rjql30bKQuSIPldtuT0FqotCZkNskhn+R7YdYjIQ8Q4zLSmA++pgnn+24rKypB13xZHHTpecisMuSEfd0Gg/owIAIfb5kJNV/7CmrNN6BmSYbfD8+x47rAIqYzLBL7xart2CXuZn/kCSquoilraSAyt+qibgMLp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510875; c=relaxed/simple;
	bh=awfqlwgX53oTfwO/7YoHdRBa/b4NGg0ONjLzDMT4ALM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hwVmXUxtqCSPCAPcFmRBOduPVSyGPUNocp9Vs2enNn5Sc/QGwb5Rna486w3UUOv8oyEHYyNyxFOVwBwMULWn36plCopI4bYC5ZgiVf/8vxEWizs/wALUPUr06SqzCVQt9fLWwzJMySE7Ygl9XYBKCIMz8rE4iEYIajHywxBJpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=M/jHAVD7; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1757510873; x=1789046873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=z1WAYwpOpbJQ/3/VG+2lCAd7vFoMsWcm2ALJ0pZZzE4=;
  b=M/jHAVD7CextNxyYkSTXFhZ0K1Q4/CtTIYPQBk6WCzDBeTnPzZC8RGDN
   0xFGqLleL96kHle35FVYcJXAt9NyV64wWGIB9yhXOmvcTIJMXDji1QY3z
   nASuzf/luu0C2bXawfNzvperbkpC19eqyQM/T17ibhX42jBVHvwkWQZLG
   9YQ4ZIiZlC23+K+/DpF3khccDMhAUOAQwlmMzJ+ARyCrzuSj1toLskdNC
   AWwJK7b03NrmarnWlTU0WLTqgAiw1uucrXW0wQSxXOmrQ7NgqogTsNguZ
   sBNDTCeK97eZe3AJACkMqO6rWdkrCgLGYEkBeor7tKBlbrE5ONztVxCoL
   g==;
X-CSE-ConnectionGUID: 8ejaJJDzS6iA9c6ltpiPzQ==
X-CSE-MsgGUID: iE3QeQJWSWeG9I5/1J1sxw==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1803234"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 13:27:43 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:25030]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.161:2525] with esmtp (Farcaster)
 id 1c71d657-dc03-4976-8228-6efcdd5e4dcb; Wed, 10 Sep 2025 13:27:42 +0000 (UTC)
X-Farcaster-Flow-ID: 1c71d657-dc03-4976-8228-6efcdd5e4dcb
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 13:27:42 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 13:27:42 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.020; Wed, 10 Sep 2025 13:27:42 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
CC: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Thomas Dreibholz <dreibh@simula.no>, Mat Martineau
	<martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Mat Martineau
	<mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	<matthieu.baerts@tessares.net>, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.10] mptcp: pm: kernel: flush: do not reset ADD_ADDR
 limit
Thread-Topic: [PATCH 5.10] mptcp: pm: kernel: flush: do not reset ADD_ADDR
 limit
Thread-Index: AQHcIlavWY5piCY3ZUO2RAwcaloAJw==
Date: Wed, 10 Sep 2025 13:27:42 +0000
Message-ID: <20250910-odium-dab-8683f6e2@mheyne-amazon>
References: <20250910-nicety-alert-0e004251@mheyne-amazon>
 <a71b84b1-3dcd-442f-ba22-ca2f3ef90fa7@hartkopp.net>
In-Reply-To: <a71b84b1-3dcd-442f-ba22-ca2f3ef90fa7@hartkopp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCE17F2F4E22FB4EB92B1874C1D09640@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 02:33:28PM +0200, Oliver Hartkopp wrote:
> Hi Max,
> =

> I'm not responsible for net/mptcp/pm_netlink.c nor can I be found in git
> blame of that file.
> =

> Why did you send this patch to me and having all the relevant persons in =
CC?

Hi Oliver,

I don't see your email address in the CC list of my patch. Did you get
this mail via some list maybe? To be explicit, I have used the following
command to send the mail:
  =

  git send-email --cc-cmd "./scripts/get_maintainer.pl --norolestats 0001-m=
ptcp-pm-kernel-flush-do-not-reset-ADD_ADDR-limit.patch" 0001-mptcp-pm-kerne=
l-flush-do-not-reset-ADD_ADDR-limit.patch

This uses the get_maintainer.pl from the 5.10 tree though.

Regards,
Maximilian

> =

> Best regards,
> Oliver
> =

> On 10.09.25 11:28, Heyne, Maximilian wrote:
> > From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> > =

> > commit 68fc0f4b0d25692940cdc85c68e366cae63e1757 upstream.
> > =

> > A flush of the MPTCP endpoints should not affect the MPTCP limits. In
> > other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
> > limits'.
> > =

> > But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
> > limit was reset by accident. Removing the reset of this counter during a
> > flush fixes this issue.
> > =

> > Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> > Cc: stable@vger.kernel.org
> > Reported-by: Thomas Dreibholz <dreibh@simula.no>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v=
1-2-521fe9957892@kernel.org
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > [adjusted patch by removing WRITE_ONCE to take into account the missing
> >   commit 72603d207d59 ("mptcp: use WRITE_ONCE for the pernet *_max")]
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > ---
> > For some reason only the corresponding selftest patch was backported and
> > it's now failing on 5.10 kernels. I tested that with this patch the
> > selftest is succeeding again.
> > ---
> >   net/mptcp/pm_netlink.c | 1 -
> >   1 file changed, 1 deletion(-)
> > =

> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 32379fc706cac..c31a1dc69f835 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -869,7 +869,6 @@ static void __flush_addrs(struct pm_nl_pernet *pern=
et)
> >   static void __reset_counters(struct pm_nl_pernet *pernet)
> >   {
> >   	pernet->add_addr_signal_max =3D 0;
> > -	pernet->add_addr_accept_max =3D 0;
> >   	pernet->local_addr_max =3D 0;
> >   	pernet->addrs =3D 0;
> >   }
> =




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


