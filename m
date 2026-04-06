Return-Path: <stable+bounces-233394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF2DIEjg02lxngcAu9opvQ
	(envelope-from <stable+bounces-233394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:33:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E13A5564
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A9F13019118
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE538B14B;
	Mon,  6 Apr 2026 16:31:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4038B7AC;
	Mon,  6 Apr 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493086; cv=none; b=B35uI/SY2HsCkMrlktJPkdy8xVpRTvX2eMrtwIPRZ79/Pq5j0sxgnD5Vd8Xe9D2F+MY1iNnIZr+N9VrXB0ixTdyK0ucLtmDTqk7a5m0lz6J4RRSis7X6QQvD3UFYvPcK+D4sKfYdOe5I1ZeK3WZGUOGBEamk+Q8zFHZpVaiLjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493086; c=relaxed/simple;
	bh=b4C8M9P7TZeLYRYooFF4o5tEcOh5YaL72dAK+ECRQQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVNxct7IYR44EWl5jlh2r/atULkz6w4Kva77fxiCf8ZpdRE1gNWXumPykOzdDoO2a0ZM9uJ1CsDmDQStsZN8tiOx6P7Iwt6PRhE7hBlsDxDkIWbHh26LrkG0yd9P67AXXxktBYv6ha2vEXD8YVymL56+gVtQb8/+XiCSEi7Bt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CC1C1160197;
	Mon,  6 Apr 2026 16:31:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id B851119;
	Mon,  6 Apr 2026 16:31:20 +0000 (UTC)
Date: Mon, 6 Apr 2026 12:32:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <20260406123232.3dacbe94@gandalf.local.home>
In-Reply-To: <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
	<20260406111531.779571d7@gandalf.local.home>
	<CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w6wwgiws5h5na11491ygfex38f5azhq4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9EOO2pqQeQNaEneEBKCiVrrjsav9WGiM=
X-HE-Tag: 1775493080-84157
X-HE-Meta: U2FsdGVkX1/231+NmA25h6laTAVK3WmzKUgG/1gKMIADrvjSAaUrGmf2omeTv2OpCiqRVLiEJMOyfp7TzO9vPggUnOCutNRNldgJ4IjHUQLGmFNoMWYV0trBCVPVIR9G2ukocNV8c5QTCFdo3PUtW+EtGr5OKKENrzdttZk7uuxzq1WVTYlQNoAg7CBhI6+ORyfjhF47lJILMC6LXKIBoCLMExMsQSEaQu1xU80Wu6faewf/JDH3yWRlUMbI1hI5GL3KDJqbgUuc/vmmoJ81uENUgUNbVfyxfiNZqQ5r44m7C96kBnRR6dGXsLKZzmDEmJOnfcatPeaZv2QhpNHDZJE7vjcef6vN
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.963];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-233394-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gandalf.local.home:mid]
X-Rspamd-Queue-Id: 030E13A5564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 11:21:39 -0400
Tamir Duberstein <tamird@kernel.org> wrote:

> Thanks Steve. IMO that is a very big hammer and not warranted in this
> case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> by default [0], which would probably interact poorly with the change
> you propose.
> 

Branch profiling is really just a niche that is enabled specifically for
seeing all branches taken in the kernel. It hooks to all "if" statements!
As you can imagine, it causes a rather large overhead in performance.

This option is only used by developers doing special analysis of their code
(namely me ;-).

The only real concern I would have is if the kunit test developers would
want to use the branch profiling on their code, in which case my suggestion
would prevent that.

-- Steve

