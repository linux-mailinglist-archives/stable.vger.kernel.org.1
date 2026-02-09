Return-Path: <stable+bounces-215542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOfUGCMmimlKHwAAu9opvQ
	(envelope-from <stable+bounces-215542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:23:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B01137F7
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4814300729D
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261272ECE93;
	Mon,  9 Feb 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eav+MmGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC829C321
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661403; cv=pass; b=UQaUOXDjKSmPjloRGR+PRC6tzMLwE47O9owKnym9RyAAUUqS9z6ZX/q9fMYP1Sdpm7sd4YgT32uAywZNR3pDEnqZguq+4+pVTfDfKTYXNYWjGbjcV9JxTyElsFbQBLChGYudp+BLsMNqsb/nAxng9Pol+3ueqGJsJPh6GmmI60I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661403; c=relaxed/simple;
	bh=Ze/Rk5WFcOqujthpZphKY+7Nj1NmEfH45a4ZKRl1LFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ldb9EGGlCB+gDuU1ZxzX0P/ixbLAD7aVYt9dGjdpqQigRcz9hT+ORpd1iR9UaU9tM1eb4fCPkRieKzSWK5IC7rUqN7ASzSWEntFnXWKNEru38cnvOreep5kzA2QOItPKT75umoNfMFT99Xp3psT/Pi1daBJF6AzopYSKMDn0YaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eav+MmGr; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba68df3687so2487419eec.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 10:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770661403; cv=none;
        d=google.com; s=arc-20240605;
        b=Oor5LiiVz8FsUlglP8BkmxUXV5RvR1uk+yAZ9mmDQAXaN+p3hhseRJRdrIh3+3XR50
         b3zjrogGNZYBNvEYoZycdSfMcu6MYTIEpKGoKkS+/rFId+ANMqze7BokGyp55LrUKcj1
         xLIcTeeB6K+1CmRVjK6bqsGg+m/opAyQwirSFUPVYGjWMEAfxxU2HWkTSQ/Iqm6bjXGx
         khCL59Bt9GnUp1E9TMPHWG9JnNfwP9mWCsixVvOaw/PbDqn1CgqbPgxGdpi6PyLYPwMD
         NPPrmXXLjyd0Aa4gtF3frU/VHO31bpGu3AiLav9zPDHVNXNNUlDJ5VhQNH+lvhq+MAqH
         pqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMVaof/1OVk8lLRJok2TPHua87GRlj8RXP7UoaSkwnI=;
        fh=xHsMpZUwhaAmyg4mMmYMqmI7CrsCMmhwg/Om+X77P4M=;
        b=FV/3uB2R3dajO+869pzRUEech/9lpvTzZEHsSvRDLzk6I7x050I9frNiGMkIAeFOi1
         AdQ/tKMiHEHZTPAJel6Rqi7o89zzrNbk7ksnwf3Zoo8VwZIwSut5niVHO24CdMLnljYq
         rNJa9g7FcLQWnXPa580ya9DIlNhn1VluWqyVIpWgHQAP42sAgM4VWAxvwrSYUv0j6f6X
         AC8yYCDrf9hA/as+A9pIxHO2Kpcjf5SX1lnAJYFn3YFAWL6P2zrot+9X5MnW0Hf4mWTx
         deyEPvJO9IAC1U1nPxmS5Vne3kN2LL5LSr5zgvWE5LdkTSJr/Q+FshAD4g5gP+0I/Z3/
         4jdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770661403; x=1771266203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMVaof/1OVk8lLRJok2TPHua87GRlj8RXP7UoaSkwnI=;
        b=eav+MmGroCl1PEraPnJxAHD1hmZ5gIdaeHZj7ki5JgTJTWm93BaFXVqrqVe9WpFnKq
         n3srcVOO5NwHyGd/dph1hU1HQGCSygmXmpWCnjAmq0RGhmwtK90THtbCl86Q6N7wVj5M
         uw6DTdJeonaBcHd8uXLlwJE+iq39D9rUI3iqlPowcuu2K6s6DFw5NEqJrjU97VVccCc5
         wjABSGSlpBTW3UC/81J+YRbWIEkrXcTUeDXwaW89KdbB7tns0Fl1Va3mh5nfw6bFgdv7
         0VXbhg+hq5U7xSQ737EaqIHrb0R7hnHi9yz0PiKZJkdN3eSFE90cFJ5+JgPpyMoT+f+7
         uQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661403; x=1771266203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMVaof/1OVk8lLRJok2TPHua87GRlj8RXP7UoaSkwnI=;
        b=AaDqCCZEgfOiGdIOqflrpQvlvP9TPUkJUwlaShEFD9/WSEhDjwcuCbNiamvPi9fEJN
         Cox8DC1WR5ykEqFTSdQDdT+UmRmrP9mfxGEeaiKN2WOTlvqLm4Pet+bPVsv9PPtme67g
         imVH9UxFYhbJxOHqYwpWmeMHDSn6UeqOZzGdvma48KutR7a+KQWzYYMwEEQ6BEu5gdUm
         4BhjD2W2+brdICB2I1qQ4T/adWe+7xtW7PgmJsLLFLt7ruJMfLS0nWuLTmIsWPs9bHjQ
         DoJOeYBrSkWcajnCBpEKLvzBloj3nYIAP+fCRn6SSz3ZQhuL0RXGWAawEZb//W/500aO
         Vn9A==
X-Forwarded-Encrypted: i=1; AJvYcCU48BxjpbaxZJxGZa5GLPL2Gt6OqjK5eVTjteeYLD1Zt6dbziaivXMTHc7AWQ87sFkF8nrL08s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQt+KNNEJUI45Gs6g2+y5A7u9K44omOp+zoZKQwjtIYNCIZeA
	q1YHtgM719Edct4uaxOMC66aVYX75IALoHQQgx6/VMjdYpeH4jE0D/AxI9LzrdMNdlSpRQqQwd5
	9WNYrnc0ckOlO2Zj71ca5F8DEPCgYjEM=
X-Gm-Gg: AZuq6aJy/WNPq7a9E5mhAIJF7qDLTvsik5qoxszaFPDbsg4uqQxwil4YjvZe1FxNh9B
	lDoqnSa7vaiimUg1rWzx7DN3a02v6gOrS2Te5jVJbH9aNqCeIrmNZSdhWZprRgV5FASqv4GVa5q
	a94u5QExbR3uY2FRm7koyQBK6DXzNnCcOW+wZMytS+CdwS9xmBvPSYHMRz8BIlbNlY4POs42rkh
	yBggN4E8UJvkRaIrUDtX0tB53ed6iFesDbcGOeaOcoeJNhWo1h2lfVPsksBa9F9VGwzYc6ur4Lw
	5r037u5kbYZe44AWq+7OB6GGnUupr++2vu7hHYOra6N4IU3GLDmyvszjEpWQol7ItJKYQRvJ71r
	zOSyZv9SGJa/fMLWespbNqSvA0ROY4WxtgHG17JYIOln3yZKtOEMjESDGJfCvoFIAXuAJQ4njzm
	5gojIounI=
X-Received: by 2002:a05:693c:631a:b0:2b8:c1b4:9cb7 with SMTP id
 5a478bee46e88-2b8c1b4a017mr2572950eec.22.1770661402855; Mon, 09 Feb 2026
 10:23:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142320.474120190@linuxfoundation.org> <0c7d0dcb-fb37-420e-bf42-7929f7bdf781@gmx.de>
In-Reply-To: <0c7d0dcb-fb37-420e-bf42-7929f7bdf781@gmx.de>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Mon, 9 Feb 2026 19:23:10 +0100
X-Gm-Features: AZwV_Qha5YCQzRf67ubA4-i0FU-1CsrY-YCKhL9ssBpK8maTgChfHYLPFkRtMLI
Message-ID: <CADo9pHjJpiWd+D3yn-zy=wuhYW3YbG3P3hsL91VM5sjsoKnwaA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
To: Ronald Warsow <rwarsow@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215542-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,gmx.de:email]
X-Rspamd-Queue-Id: 7B4B01137F7
X-Rspamd-Action: no action

Tested on: Arch Linux Machine a Dell Micro 3050 with a
model name    : Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz
and works as it should


Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den m=C3=A5n 9 feb. 2026 kl 18:25 skrev Ronald Warsow <rwarsow@gmx.de>:
>
> Hi
>
> no regressions here on x86_64 (Intel 11th Gen. CPU)
>
> Thanks
>
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>

