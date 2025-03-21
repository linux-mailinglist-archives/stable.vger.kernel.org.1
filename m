Return-Path: <stable+bounces-125745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F48A6B956
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC48D462333
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0322D7B8;
	Fri, 21 Mar 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="U7oNcNCK"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BE22D78E;
	Fri, 21 Mar 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554426; cv=none; b=Y35ItC5wvl1QddNwxwsuv5uD3ZmMNO8M5sINzrFAoJXxh+IH3DMso7YEUi0UzAiS4R4NlZ65nTE6fc0vHaLILPx+oeTWF1Ku56h9SLc6SVb3XLo8gUGxuzOA9/Z0NzMgNFKjDL59u466V4etN3Q80i8pZvRyfXWICD/xWziNRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554426; c=relaxed/simple;
	bh=310JQR8rsk+AyCKTdp1SbuSXRQ/gUbmrT2H4Xe03Zls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQDQmcsPYFKVq3qVum/pfdOutnQigaN8m4KxN0wq5QDkN9gG1/wMJH9o7t7f97JTM2SviNpujK+jBDsy1HU5kg0rempOlN7v9LRyO2nV6p9+4HpgApKk9ZVwTS8N2KajlpHpyvc13w3SsDZv2azIJpDkF6JVV/ZK0jWTva0wIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=U7oNcNCK; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742554413; x=1743159213; i=frank.scheiner@web.de;
	bh=310JQR8rsk+AyCKTdp1SbuSXRQ/gUbmrT2H4Xe03Zls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U7oNcNCKYBoI2OXlNNqQOZkjrXB70PZk34zh5auMywaQqdyguXGOsmMjkcfcwsR6
	 op2Ax1rdAq7nbiLp9z6bGxD3csqom3S7TWK7IFBfZHJp4qlPFQ8gsFZxGycn/HuYp
	 bpwIoCk4DB2cHhW6SgBMFnqJVtpx05XOs0oDjqabJgvCkNTD44IRTaG6UsPGXFgIh
	 gmkEgeOVICjE233pAVTR2krk7siP3tpHi0MgqgFAufhcnB9z/2W52Qm/KkHHQbWnG
	 M6gl/6Oog8NqSW66/xtTrn0tK9O5ySOHb63MyjSmuHbWzcu89ZBfWf4xfEvKZIpvH
	 xn9hDDNwDPXR62mWGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([79.200.218.204]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKFF-1tVxTc0EH7-00MR3S; Fri, 21
 Mar 2025 11:53:33 +0100
Message-ID: <ac138eb3-de5c-4fd2-814d-8ff674428008@web.de>
Date: Fri, 21 Mar 2025 11:53:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1.132-rc1 build regression on Azure x86 and arm64 VM
Content-Language: en-US
To: Leah Rumancik <lrumancik@google.com>
Cc: dchinner@redhat.com, djwong@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Hardik Garg <hargar@linux.microsoft.com>
References: <8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de>
 <1742423150-5185-1-git-send-email-hargar@linux.microsoft.com>
 <CAMxqPXXrfMs4zHuOOmTtDp2T5uTbJYnnXQ0E04gFRr62W3SJjw@mail.gmail.com>
From: Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <CAMxqPXXrfMs4zHuOOmTtDp2T5uTbJYnnXQ0E04gFRr62W3SJjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tLCl5C9rDJK9ilFqCwJA7UNwH/ojJ4RHTmu/pS5+vkZliCgR/UT
 q9LvE5Fspic+eRa7wE+/OR6Dh73jQka7uODMJzD8VMJ+YbGkZpp6Yq4Ere66zIEv1+hAvT1
 h7WdF0TD9DFS7MgWzuu+9WyxzL3TasZISKNUNs93iOALFkSDw5FvYD4fd2LCa5WpWLAk0hv
 lwojcbG/5AJ/tXbwVFrRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:39F/bGuTwxM=;FqZdPudSvRQ3ggl96w+OnlJnVqY
 QTK7oMqMA6mERBufmkJ0Lrd2V4DL5NO0+ZonR2xeqHm4UhYN91fEEKgyTaBgR3xbS+dXiLbBQ
 9qgPMvL95EkOYgKS5h9FQJicDsOJl62+ibsrd+fqBHs59POJg8121S+nnA+5QSjM2hyuCWYGH
 ihxrhvxbY6dnH0TL5WGJLRruTOJPfbecMwFDI7sCyqAYGcptPN/vIUHnWx2dKNwuW4hFGFdAI
 UW39SIMPAI4ONLSfQ2V3osLvalnMuUmWeu3iQGhRawqS2CRY1SVp/djO1DUtbRLAAfHPVM5gK
 PZvn2kChrsdGVWBl0kTf7wdnBZoTOXs9PWKCqlSLociNFiU2cH70egJGKf/OiSTdbIqSFwg0V
 KbtVOI8EjOx1QeeF0eRCVtWmRCXy8/6jA0pyfv3sSHJ1PtGXm5h1Afi27HvSxfGlMzBTZ7WMT
 dLFgtZlhCBCj1R5is7M4tdNpbma6j0VAObL1PCgh40dDEkImJxpz3T41HgZN+A7rdp4jAX5Gd
 cazGsiWUHM6gBjgGbsfFZidBEfv+0lcGSqIsfK/o22m/51iJHA4ieRAcEO0Mn6wRZWPJM6w/M
 G5h4alTxYdfjoqMy1AWB+B+BGLKAnQJfBLXZ5o/MciOmw2wE8XdNaFBpUr9UaWLTUPaUvw2//
 smyaNkpCrN+3GrdQSjQfVyGs1pWV+Tv6PNKFbDL5LT1y0DyT0J6hj8OukLMvzwYx9rMVK0zF5
 4npeKoLYjgfYeRarDAdDZe8ffyW0R6Hfxg47lx8UhSQ3+uHge7wnQhiK4xB8b0/YjHDwAExS3
 rqqQvYkvBCtxr6vMrnBRT8wo8/kXrOuYXZDRldEOA6Z84+n5J7RU7odCyIaQCm58SfYN4BIc5
 Fk2sMOhezZbW6Rj+bdLN3aI0STgjv93jUc+E0+p3f8HOoPzN0ag+cKrz8VfOwPRyac7tg0U+c
 ndRxyUhJDuBQ0T2/EyEVAXlz5mkt2QN9gU+VP2PgJF7Nd6JcwUHi+0bA+V+aEAGCuaVkJ382X
 zlKnilo6PIv90oHjOXpcRS+tIAhD84zKAZdHI03cFdwumQRQjAc9zT1WazvHmvV8vkxtzm5Ac
 iUnj93Weu7rEv6FO/X8MRtdiO/Z3siNHXGTHh3YEw4SjLxivT36UcbazU9IxuKvUkG2Fa35f/
 GBmx04wJavz9aStSOqF8Fy+97bwR07bGUhsykfNBbiXK46nupFtHsUmX95hw4eAJCM8SE/dnI
 fc9bwHzKnCbu66IEWs2srZsVNt6F8hEffHY9jnpgPylLONa7N8bYqv62qxi8v42TSe6U7Y1h9
 CyV4j4bF8OtXKJnRX9beZczQesg9e8HlprKPK+Y3/xsu0qYjVQlqNNEKY4jwbcgikxZN73UAi
 BHs2l8IQol+phz8fZJk5zv2uytruhe6ooNxjBXzqJRtUeFCKBAZS0SYcn0/an+xmTSBKI1Jij
 TxZlzPg==

Hi Leah,

On 20.03.25 00:50, Leah Rumancik wrote:
> Hey this is my bad, I cherry picked the fix to my local 6.1.y, running
> tests now, should be out for review tomo or friday.

Ah, ok, looking into [1] again, I should have CCed to all Signed-of-bys
when sending [2] in the first place. :-)

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/commit/?h=3Dlinux-6.1.y&id=3D4fc6b15f590bc7a15cb94af58668d9c9380=
15d79

[2]: https://lore.kernel.org/lkml/8c6125d7-363c-42b3-bdbb-f802cb8b4408@web=
.de/

> Thanks Frank for finding the missing commit!
> (https://lore.kernel.org/stable/8c6125d7-363c-42b3-bdbb-f802cb8b4408@web=
.de/)

You're welcome.

Cheers,
Frank

