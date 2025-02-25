Return-Path: <stable+bounces-119518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8FA44275
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E3817B430
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DA26AAAF;
	Tue, 25 Feb 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="K5+bAzWv"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE820F076;
	Tue, 25 Feb 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493063; cv=none; b=hwAYexNBN1BbVOahypBP2npyFPGB4wMY4nZw16Tbn+UeN28az8kogFnkK8aqa2JTYWn8k2aptMKZiHKd0HoEBw9YQmPhbYuGgiflPeNc2w8mHD1iLR6189Sak5cmGaxGFs6Ib5dPRRffzAuoFlmFcJvxBFDRGNRO5djG/w1cqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493063; c=relaxed/simple;
	bh=Knb+Fwyr4oljGu5E97sQ1+52xmCIUT7m2z1VnduXuIQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SutP91Odutkb/xf68zuJqH6WBtt7woc2nmC9D1W1PUi7wIFULY8gE5qz0MrYaaXncmpreEjX3SDy6FqQzsqM5P8kmfIr19Y0lwVqBxkxFXcXxeJlbYwU3XsfWIO+so0ojGu0KcJZbnlrgA1X+SrqZtfv1CVimU/FrI2Rji9VPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=K5+bAzWv; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740493041; x=1741097841; i=markus.elfring@web.de;
	bh=3PiIP1hxD1m9jYMgoVMW46TApIDu6OVW3nV0YlKWXjk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K5+bAzWvbJIt2/LVkJyhAchWK0YioCBbAhlBP1CIId69Dt7dcr0Xx9mCJo/FZO2F
	 MGaWN/QWRJ2rc74NfcVQEZSOBHD5w3hVXS5MA08WdJjL0UTpfXh+N5Q9/e7s7quGK
	 T/qMTyz8+aEEqq+xiDWnx4h3WtMXLw04nSpNvFfBvfiB60eA5V75lLz0ltceYwLGE
	 BDnKWho1fRFDbmjm0Fl8faxVY52tCbQI7LMNhBVwM7IIpxq8jT2L9CvjLL8En9tQs
	 /SF9yJ2aWVjzzBJpXNSF8tdz3TcjB4mB8QTJ8j86hxc4vh45K5iFDFHrWOeo5Ihyc
	 bo+lIlSXNiDmRqL+Dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1t0gss0JxT-00gmDH; Tue, 25
 Feb 2025 15:17:21 +0100
Message-ID: <2fabe78f-a527-494f-8c3e-f2226ecbc43d@web.de>
Date: Tue, 25 Feb 2025 15:17:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qianyi Liu <liuqianyi125@gmail.com>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20250225094125.224580-1-liuqianyi125@gmail.com>
Subject: Re: [PATCH V2] drm/sched: fix fence reference count leak
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250225094125.224580-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F4njyynBkRmF31L8qtqh4Qa/sWddqfZ2QogbbKK+kIBC4X8wbf/
 pPcTQOkimUZiYhAGwREn1U46cchQMYvR/IbNYffLU7axxSAS1BinPzHsOAikpsNt5eId7uU
 D2aTkglmAebxcGRlR1czM7zLkBVsysleiCtbaqdKacmptIAhxZHqYi1/JirfBy03UvApvyQ
 go3ig5hY+sTj20lu1nsBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0cMJcX94lzI=;yBRbMs+81Yg541y+4Gipxuzhesp
 Q0ZRKRTW65QhBr/QLXJpf4uFoF3yQkt4fqdd0LyLvo4VDEbs682nOw2sWxMAyMpXvstXt69LE
 2Pt2R5adkO2KUHQgBKFMFjxoqiNjJ1WSoJ+xhNYYqqYOJz0ay31+3msNjQrSlxP7cwm9hCuT6
 MCsOFwd3pNvP6qSvrwnPfOULquqLpROYbubSyPc/TK37RdFQjNIJz4I/xGgk6tyYscwwKkQmh
 ++u+3f5yqq5t/0A6qaJ1DuQ6p9Z7xoxi3HO53u77XK5YccsOkFPOrIATvFTQNUgiHg4xNLlhx
 O+0oiNIaliAdh6FhGsl6IVliZ17y1E68liV/4JpLOjOZq++t0LvFpwmHqDeny84RCUbjyvs+q
 3jeJ6Ry5LsigisuuYF2gS3rguUV761USIOddg49AHpd92GRKSYwCfVEf6hqL5uG6dsVNWPbk+
 DRh5A+VT3zCjPnWy15T2HMAU9j2VcZM++yLzEIO8rcCFMo4JXoQzLhw5PDBsMVkvprzo4WbLV
 gVaI1keTsbB26nIMRLruwdKeWLaPcGIfsWsCNskqSpmHg0pbt0+0oeeG8BYRa3YN+8kqZ7c8j
 8yi9TJVygeZtnLo0bBXhHqsddkwlUBbbINVm/FwH4e0vxRmhNdu5Wdv3sKM8wKoTmSiFr6uO7
 kERAQ3fh1j6kPEshCZWRzDCbwFXC8wLU4ZKZUqKGpGJsotWc80/7XhpM4GlCRpx6WfoJjWJd+
 rVRpaBW1ariusrH/2FatkHucJ2y2GQ7JRo1dLRod8JNXEB3EL4NFBY5/tkt1gAJ5VaIvRwuTc
 78AFXQaUGUex98Itb0vj0Vw+7HaXzDWktDe9jENX/8X9uNMV6EStPyXuWHV+0bYM9ZQxDQ+jj
 CmAHUHJtclVC99JM0nI+WSAEQCqoJi86cyOc5BjBQPQy0MGyY8d1G4GpFMGJum2MY1GBo4Bgx
 wq4ZU+bOPqJ8munQzDTobx6EO3h3R30iXvePKIjc8MMxpZlQ7HYvMjXZoUsQmt+O8xhYnQYsB
 0BA9PMnqk0fPfqWkjYUHw00vwGJd/eQzsA5KjJtowwKI2X40q5bEtoqSRiNO83so17j0XKPZY
 d0r30eTivbghLrqIeut+Nzet8rBC4GSxwUIHrXgeOyMySBK6WZRcAla+QX7F/tWxXmlrhQEuK
 /7kCeUD3BO5ELYgMQIO6BPIefc3W+gqvrrkgtpYM0D9hWHNvsY01UpTMT6yu2kZjCzuFRdJHv
 zpFoc33BYN6TteylaMOMZqgC1jRiz3796Mhk09/Qm0MjTRlsIPlHETObdy3yBa0O8IRL86BiA
 GcfRrpeAGJSF+E9cFflT02P73VFi+ocbMkgM70RlNVbjskVowYkl2jeJEfT7RbfU2dQ6a5Oib
 pCkIX2eBkIOrq1WK7NgFyr4kAj8k0cXsfIvImDu2YqB0+y+jR54nYfbamOwvxsTvKFQ7qAbVO
 TRAS1uu42yscrPScUDj4u6jJPt1M=

=E2=80=A6
> fence callback add fails.

                     failed?


> To fix this, we should decrement the reference count of prev when
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n94


> v2:

Patch version descriptions may be specified behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n763

Regards,
Markus

