Return-Path: <stable+bounces-233732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFl8CC6p1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33563B5D1A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E25E302DE34
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671032AAD6;
	Wed,  8 Apr 2026 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W711BZau"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4084329E46
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610128; cv=none; b=u2uxure9aW3sMteQ7JlKiCTz1v40GyOswK7L3DBlreN8fxgBbMacW+OvVnc2GoZKpkv/M1i66SPMS5wl3P1FnlnMOg5oMaqagItVKbrprCEglrAAY8ZeyvwV+0WPMKBZNG0w5nKmlf2ybDlYFP86c9dJGwKyaokgNh4Pm33Wd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610128; c=relaxed/simple;
	bh=ePp3p0N8rldNZ+JLDAl8/jqpHNBAe+13CgdP5shJIHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1UJa/5te52fVrA4pTBUak71mMk4J6ig44v02IK9n1iNg9gJfC1I+QqmgPXVgOs6vNRIGVjqudwVGn4wREZIL11q1sJlSJwyy6yTV8G0WljVOVPB9TeiMMU1UL8piQG/lPWFUKsT3JdhbKapj8gQPmoy8sy+EOLapPZTNTxmaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W711BZau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E46C116C6;
	Wed,  8 Apr 2026 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610128;
	bh=ePp3p0N8rldNZ+JLDAl8/jqpHNBAe+13CgdP5shJIHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W711BZauNBbiX8c5sSNlSvET2wPbWkL8VIW36b6wkQOLB51wiahfA+43d4H7KZ7k4
	 85BK+9LvP9KJ0jK4ojuU/R1IU8GyxGgrPNCtea3eWfJLi2FzSg5bxa5FQDOPGh2lMk
	 3hjcLTtAsVj3s38soiyKub1ZHgZ4B6fFY8+LnJAim0ia3Q0rON0NfMbvb7o4tDc+7R
	 I+G+3rRH7rX/d7SqObMFPLE0hk9uO1PnWvnSCZBB5mI39lIxQAn12EhGeEKVEBgDPS
	 iuaNOq0cgGjaPgZIpr8VNDX2LvXv+OpwPTPl9fl6YoKv2wLE/+Aevq+l3PJnhIx46i
	 5OUGFm7MonDvA==
From: Sasha Levin <sashal@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12 118/265] LoongArch/orc: Use RCU in all users of __module_address().
Date: Tue,  7 Apr 2026 21:02:06 -0400
Message-ID: <20260408010206.746150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAhV-H6Jihemh01mXx1wWU4QBw2-x5XwV=a7rUD5ZoJiQ56FDw@mail.gmail.com>
References: <CAAhV-H6Jihemh01mXx1wWU4QBw2-x5XwV=a7rUD5ZoJiQ56FDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233732-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B33563B5D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:46:40PM +0800, Huacai Chen wrote:
> Yes, I have also asked about this:
> https://lore.kernel.org/stable/CAAhV-H7GxtWRZyAT=kedLEMu=C5wH--NUzRjwi3DKXzUq+QZjA@mail.gmail.com/
>
> However, no answer and no action for this.

Sorry about the delay on this. You're right that the prerequisite commit
7d9dda6f628f ("module: Allow __module_address() to be called from RCU
section") was missing.

I've reverted the entire LoongArch/orc series from the 6.12 pending
queue:

  - 8eeb34ae9d4c7 LoongArch: Handle percpu handler address for ORC unwinder
  - 5d8e3b81aee2c LoongArch: Remove unnecessary checks for ORC unwinder
  - 2e6949777d1db LoongArch/orc: Use RCU in all users of __module_address()

These will need to be re-applied along with the missing prerequisite.

-- Sasha

