Return-Path: <stable+bounces-249675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BA1Kym5DGrdlQUAu9opvQ
	(envelope-from <stable+bounces-249675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:25:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23476584214
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0982F301E201
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE93AF66C;
	Tue, 19 May 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieZJxt8/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845033E36A;
	Tue, 19 May 2026 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218719; cv=none; b=q11eBHimmb4okQDZeypApX/oRvtL+JriT7J+caIEmyLxamVn7kY0PBv/5pPUlkq27fj4Phjrdbzk7G109q0I62qLnSlL4nIgj490Q9kTep41aYGpWsJuDkeza6PkccaYtKZ9hvIcjEgBjCuh/suXl4FKPlGTwW/m7WEk7GqjxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218719; c=relaxed/simple;
	bh=vwPboUPDbV7npqeRkpbl0u7Q2C8xbRBRbLelcPhK/mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkue6V8FnfiDqDcOMwJJM3/ZI7sn3wfhAwCIKKraHLBXhkcpImf9etytCH0gRgIp/k1dvQ2ZsFAU2agHLF1QU0/qjehgfYU/xjIa6VESGk6/jL3cjsXu+bgyiXRn9VImxCu76Pi2JnhKnSm+LjX2VX7HhFyK6EarKqU9gId7GNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieZJxt8/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C341F00893;
	Tue, 19 May 2026 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779218718;
	bh=oLZ9ayoUaHUGJ9Qpjclc6QvZCC3Kft8sm8ppKHt7aN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ieZJxt8/9S4tIm6Eof2I/UxOJE0lUT/amqNz5yAxrQIOewuyU6cZNv8YXGGiG7qN9
	 BxL9NKgVbSjg06XJ/Sg47DxPI9nZ33CXWcMbaULlULU99eA8QgMwPdW0JYrX+DkCxQ
	 f5YJFQUmoKN1XkIvEPUKVaKx1kOrTNGM415PaCjwNAvBvMPhDkxW4LgpTIiXKJu0/y
	 sOqQwKnCEdlMqbdQj4dNePc4VCu2voH0qeqP9s4EVYYDp4RmcUoac7e9nP9ETs3neq
	 O7Zo434hppxni1EjlTbLiOOOXpikipcuj3lLcRX/m8BNxNGD/IxW7qNCVqF6Wjbld2
	 Wknz0NwlYUitA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 6.18 000/188] 6.18.32-rc1 review
Date: Tue, 19 May 2026 15:25:12 -0400
Message-ID: <stable-reply-20260519-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516020430.110135-1-ojeda@kernel.org>
References: <20260516020430.110135-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-249675-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 23476584214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 04:04:30AM +0200, Miguel Ojeda wrote:
> Via arm32 I see:
>
>     drivers/hid/hid-core.c:2050:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>      2049 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
>           |                                                                                         ~~~
>           |                                                                                         %zu
>      2050 |                                      report->id, csize, bsize);
>           |                                                         ^~~~~
>
> It is also reproducible in mainline, though. Cc'ing a few folks...

Nathan's mainline fix (4d3a2a466b8d "HID: core: Fix size_t specifier in
hid_report_raw_event()") has been queued for 6.18.y and 7.0.y.

--
Thanks,
Sasha

