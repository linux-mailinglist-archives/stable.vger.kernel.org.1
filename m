Return-Path: <stable+bounces-222672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMiaBV3SpWk0HAAAu9opvQ
	(envelope-from <stable+bounces-222672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:09:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A21DE461
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710AC304A5AE
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9C330D43;
	Mon,  2 Mar 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxdItUqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BB31AF1B;
	Mon,  2 Mar 2026 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474968; cv=none; b=VNcsnmT1nEFYQBeI+6t7KaiMxqjlYk2YBoGIB5gBHE8izS8XA/Ehp5bV+52X5+A+jlnwasfIQMFXfaD3hkyVPRCQezUP+n3DCcqZnqxx/3637VOZORIxcZMnWSXyzL4x/CIzVe0sDUsXL55poc9++uXecoAb6qYi9LRwpVgv0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474968; c=relaxed/simple;
	bh=zALYTjWqPzZUdXtvAVy46PlKCt/tZ7V8BFj6VXwC/YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPHHLWUfCQX5+xCUoMXsTihxHt8rZBjpA2PQLqYjffGVJ72Pwl92jMwrsqucgR6wg6PVwvj/ZYY8Y5irxbez90PYT63kDq7OmzH6IDCH/wnQsQaQ4rj3IG+4ofsDQscFat1j/oQB0iqd/L7efq78XJ5I5YOAT1krgeqNtWOU6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxdItUqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D79C19423;
	Mon,  2 Mar 2026 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772474967;
	bh=zALYTjWqPzZUdXtvAVy46PlKCt/tZ7V8BFj6VXwC/YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxdItUqNi7uaw0u0bnJJwVLHPR9++r5vs3IxeRkQPyw7mVyZEafzUwkjnbgmKJ6/m
	 F0AaJUNWNAfBfiQlJwNCImxlSGagrfjPcCud4miwHaRd5G1Um6WZF+ufiRFriztSlW
	 t/EpTALEQnOAFnX93tsFxx3hdi+aZiPic5B1N8Gps2VBvtGeLqPAz7OJId2uA3EeKs
	 OgMHo2644VKuNu79Aa5dbr5t/mzbYcJEkOLh/x6HKcAw3K41du3KaGvO1od+TBYZD+
	 TI2dxoU49XzbE+J5vbgV84LoISamY4J4P3Ek4bIlO/8XUqCqbgbWQXGAm6AMTP3Mon
	 3ArhYT7g7pPOg==
Date: Mon, 2 Mar 2026 13:09:25 -0500
From: Sasha Levin <sashal@kernel.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Message-ID: <aaXSVaGrwY-k80m5@laps>
References: <20260302160943.2522184-1-sashal@kernel.org>
 <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com>
 <aaXNiwFkUEy8SaTm@laps>
 <abe2fb5f-61b3-4597-b27b-c6c61f5efc7d@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abe2fb5f-61b3-4597-b27b-c6c61f5efc7d@googlemail.com>
X-Rspamd-Queue-Id: 657A21DE461
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222672-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:57:53PM +0100, Peter Schneider wrote:
>Am 02.03.2026 um 18:48 schrieb Sasha Levin:
>[...]
>
>>I'll drop it and push the -rc2 branch again for all affected kernels.
>>
>
>Wouldn't it better to push a -rc3 branch then, so as to not create confusion? (I'm confused now... 🤔🙄)
>
>Or did you actually mean rc3?
>
>Also, the causing patch ("x86/kexec: add a sanity check on previous 
>kernel's ima kexec buffer") is in all others 6.x.y -rc2s from today, 
>so maybe Harshit should quickly check to which 6.x.y stable branches 
>this patch was meant to be backported/included?

I just force pushed a new -rc2, and dropped the offending patch from all
branches for now.

This one will end up being a slightly bigger release, and we can revisit this
commit and any others we had to drop for the next cycle.

-- 
Thanks,
Sasha

