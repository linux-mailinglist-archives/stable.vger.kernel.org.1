Return-Path: <stable+bounces-222671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHETBArSpWm1GwAAu9opvQ
	(envelope-from <stable+bounces-222671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:08:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EF1DE3F5
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15AB83026A63
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C0317172;
	Mon,  2 Mar 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfeASf6g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A423126D7;
	Mon,  2 Mar 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474884; cv=none; b=OdsSI7ecVDv9uyPnp71KEnSgEfwmObtCWDjGxk276MZ+9s993RGbqRJByiBVsjrLozh5s2d+i9GXo+Q8vZlSWK9U1zFlmDgOvQcnaF/rui1ElNtGuzeHcsNlX1lxH5dppKle1IfJb3xxiEvU6avmJPQ0JwcjLzFohbPkWqW0yDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474884; c=relaxed/simple;
	bh=FN/j2igpSwXZlTH47039eaQB+TToiNBvVbGGLdA6lG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNHVTTkSW7WPzrI2ygYAwivq/fLffmBe+91xT8JnWDxd5/Zsf4ZVYun62MMFNGR9qw/3i8dLMGqE0Il/WDuEdqIHVNUFFPaq9hLDbK6Tsc5GGoE4XS4LPqEBKY1B5AmSw3ZOw5/sT1fV5Gs3RV4hwiXA4VDHr0aPIhJDt6S4Sik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfeASf6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A64C19423;
	Mon,  2 Mar 2026 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772474884;
	bh=FN/j2igpSwXZlTH47039eaQB+TToiNBvVbGGLdA6lG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfeASf6gWY18MwrMOh6YrQg7l8+Kq2Ob31KG7VZOkDay1FgGxmt/+016kj6NSKoyQ
	 mAYQ6Xni6n2/95QB0n2WHDJE3vvjwBmJsfzwXlgRrR44bBsRlejLeyWXIC1bZTRq0Q
	 L/TKAZRsMDFRly6pUttHOF7SNIRcXg2nfzCP7sDbDZXFRth+5ccibEI/Ad8ohFgFao
	 IAxXG7mFCces691fJSgNzFshYT5PmNnWX//U3jQQHiWk+BzYFKd/WqqbUeSKHy+qUg
	 n1U6SXlsYjUmqZH4GmpstQ2RzY+MF69+eZoTzXZ6zcdkGMgK5tldypwLIyBp1My4NO
	 lIpdbvOza1OpA==
Date: Mon, 2 Mar 2026 13:07:47 -0500
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Peter Schneider <pschneider1968@googlemail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Message-ID: <aaXR88OfyuzhWaqw@laps>
References: <20260302160943.2522184-1-sashal@kernel.org>
 <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com>
 <7cfc1cde-a8e1-4802-831c-3e082b22fa73@oracle.com>
 <aaXNvoIGNjR86bKY@laps>
 <06e95a5d-70c7-430a-8caf-7af0da26bcf1@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <06e95a5d-70c7-430a-8caf-7af0da26bcf1@oracle.com>
X-Rspamd-Queue-Id: A13EF1DE3F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222671-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[googlemail.com,vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:28:18PM +0530, Harshit Mogalapalli wrote:
>Hi Sasha,
>
>>>Also I see something unusual -->
>>>
>>>6.1.165-rc1 --> 232 patches.
>>>
>>>6.1.165-rc2 --> 533 patches.
>>>
>>>Can you please check ?
>>
>>That's the reason for -rc2 :) See:
>>
>>https://lore.kernel.org/all/aaWWE5uQqz_eG69i@laps/
>
>Thanks, but shouldn't the 533 - 232 = 301 patches be sent to stable 
>mailing list ?
>
>Also not speaking about 6.1.y, but when rc1 passes tests, I don't 
>trigger tests for rc2. Should I always retrigger tests for 6.12.X-rc2 
>?
>
>Usually rc1 --> rc2 --> its mostly 2-5 patches in general.

Yup, this one ended up being a bit bigger :)

I didn't send out the whole batch of mails, but it's indeed a larger update.

-- 
Thanks,
Sasha

