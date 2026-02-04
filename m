Return-Path: <stable+bounces-214343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBP7I56bg2nppwMAu9opvQ
	(envelope-from <stable+bounces-214343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:18:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFEEC017
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A9B330398A2
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200DA3D7D78;
	Wed,  4 Feb 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="sUbb8God"
X-Original-To: stable@vger.kernel.org
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9583EDAC7
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770232702; cv=none; b=kikYf6XEJOtdstuMFFgHRCTCvlP6g39SwR9uHskaR+I9yuGLzSK0uuQV7rcp+7/7C+9G6TQO7amulgfY+IxKaZn4UYMzjNRhV4FBPK24yRQj2cppXCeGrTNxS8DRRjxMFXU8bcIBBsTbgIwm/Hu9ozw1WRKAwQBdFvYcvzTbjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770232702; c=relaxed/simple;
	bh=sbR3nMVqESOO5WeZDUcQTRTwYDiFw4MOCejjFS43sa4=;
	h=Mime-Version:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UZh8pssyn1zbHw9BXPwABTxS6kQpmqgfvfwLTEJNAl1R/wp928rwkhP/1t5m7mjXFMmyeLNGfnI7HBqDWF5cqAzmUL0VID98YOAhU7X3qeVJnXiY8rpoLNmJ2DuyVQwYS51mzF6xf9LMfGaJBetd7OZwPoTHxYYrnX4KKcJBTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=sUbb8God; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 9B9919A2A09
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1770232140; h=date:message-id:subject:from:to;
	bh=sbR3nMVqESOO5WeZDUcQTRTwYDiFw4MOCejjFS43sa4=;
	b=sUbb8GodS7FP3+dBqn5RtcqvWvEqoZJWfdWPJNqc4HSWylBDiKsjp5k1auQDDeVMdasqr9coASi
	l784MAeeHFv3L427ln/AGsoXjnmZVe9s5wDqj+Jacl5qO3tXi7CrJ6q0cW7aFr1ZKbjPwaP7ElX4p
	YgyckyFLw3kMIYHEhX3jvQ0yxJT9e/xG53uTvSA/kY0GBsrgjYDOJXHDDDIMX7hXx+Eqdq2/GstFg
	DDfxOeYAG/fDzCTYnm9vCF9IJcw0NHu/EgZWQ8zZE4Pi9VjF2vfABMjhxcxInjAPAovkMErL7Yb1C
	wy86NRMELjlAcgHbrmsU/1oFUd7/sR68iGCg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Feb 2026 20:08:59 +0100
Message-Id: <DG6EX5VXGTFS.1OHH8LNWSP58M@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
 <conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
 <achill@achill.org>, <sr@sladewatkins.com>
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260204143851.857060534@linuxfoundation.org>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[achill.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[achill.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214343-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[achill.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achill@achill.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0FFEEC017
X-Rspamd-Action: no action

On Wed Feb 4, 2026 at 3:39 PM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.9-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Build-tested on all Alpine architectures & boot-tested on
x86_64.

Tested-by: Achill Gilgenast <achill@achill.org>=

