Return-Path: <stable+bounces-230264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLWSOTNfw2lLqgQAu9opvQ
	(envelope-from <stable+bounces-230264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 05:06:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A433831F725
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 05:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9E4830903F0
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 04:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71251329C71;
	Wed, 25 Mar 2026 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PDoM1P90"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A95326945
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411291; cv=none; b=Y269fnPYqYnV/ede9w/WdH9QHFgpUuSvHyL+HG6b3P0ZkVu4GyWoPAoyilFNis0FrDnm0butRXZxI3ndwB7cJhd56vD72ryYjarsQ3i7Wd8FXTkV8NU1E5gb1cRB9p4vTLP8+OjFm9Jza4QbKxqsilbZ7N6aILrs+v0gkbofjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411291; c=relaxed/simple;
	bh=PY0FKC/6Ynk7/tAqABGC3zZgRBL246W47PJxeFaO45c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvlFfS8OeIIYkl6er35QYgzT/VO8Wml7aRDhONW8wFAmOTQTmFls+z1LPtCey2LphtK9LwrrkzhRqSeP4u+W5lNJIa+nZ3Yg1iNeJMCR9iPJNy5zM6aEIhDm6nkDoLRqT13EXlfsDZSS1jFJJ9tataABBPC23J2RFxL5IsR6gvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PDoM1P90; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([37.140.223.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62P3xWZQ013834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774411183; bh=bWsKz8AS2uSs+uc9INQDfPBdx9X31On+hmvMUEROVhI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PDoM1P90eNlALQDyazi9cc4NzbqiBYsUg/XxtjotqbKAQfr6uidvAAVk7mqrfbkQI
	 ZBgPdeI4oMOqsYw7/V7KVyu7XsXwuibHyyHgzeqVszNVoLRmq7RJHhzvj5/2KTdEtv
	 Xni6DVeWNi8NGQR2f596xHhZ4DaAcrjLXhprYAzQrHDJGsEvY+EZ1EtagTzC+yIRw7
	 BK8deBU7kIfU0riJG8laKQH/QvhO97yOSgEuvDLECw3DmnTnetIN4Dk+katZpOhF82
	 +dg+8ReK6raD3Flt9bVTiEbAYkG3jKQqvKTJQX6QGbVKkTVzupKapVWsqeXcu1uYb7
	 S+fzPbtivzwRw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9D38C5F2E05B; Tue, 24 Mar 2026 22:59:31 -0500 (CDT)
Date: Tue, 24 Mar 2026 22:59:31 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mark Brown <broonie@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Yongjian Sun <sunyongjian1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, Gou Hao <gouhao@uniontech.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Zhang Yi <yi.zhang@huawei.com>,
        Baokun Li <libaokun1@huawei.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org, hargar@microsoft.com, achill@achill.org,
        sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
Message-ID: <20260325035931.GC61656@mac.lan>
References: <20260323134525.256603107@linuxfoundation.org>
 <20260324073447.GA5062@francesco-nb>
 <mhqesgj3u7dr33zit6iwjhykw2zpuallru4qvoloyyqzdqgvki@bpwwmihh357r>
 <d8080343-20cd-4a4a-b726-b9e3c6a5c5eb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8080343-20cd-4a4a-b726-b9e3c6a5c5eb@sirena.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230264-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,dolcini.it,linuxfoundation.org,redhat.com,huawei.com,infradead.org,uniontech.com,huaweicloud.com,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mac.lan:mid]
X-Rspamd-Queue-Id: A433831F725
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:36:21PM +0000, Mark Brown wrote:
> I have a bisect for an ext4 issue in v6.1 which comes out at:
> 
> # first bad commit: [29897d75d6491ffe23cdc9d96caba9282a20dfc3] ext4: convert bd_bitmap_page to bd_bitmap_folio
> 
> For an oops which looks very similar (but on arm64):

I can confirm this bisection; I was testing on x86_64, and using
"kvm-xfstests -c ext4/4k generic/001" on a failure, it would crash
before running the first test (in my test runner infrastructure when
running syncfs on the results directory --- go figure).

Unfortunately, you can't just revert this commit because of merge
conflicts.  In order to get a clean revert, you have to revert (or
drop) three commits:

% git log -3
commit b12a69d9770b58fb02d3b4f72abe5acd28aa7e76 (HEAD)
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Mar 24 23:46:15 2026 -0400

    Revert "ext4: convert bd_bitmap_page to bd_bitmap_folio"

    This reverts commit 29897d75d6491ffe23cdc9d96caba9282a20dfc3.

commit 9c95c376c79f47fe9ee8ce562249d3630a50ab12
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Mar 24 23:44:23 2026 -0400

    Revert "ext4: convert bd_buddy_page to bd_buddy_folio"

    This reverts commit fe80bba8f76f9f0995cdc64fc89b65173e1ae828.

commit 98f5de80114f6194af4d9fae572b73440efa67c2
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Mar 24 23:43:40 2026 -0400

    Revert "ext4: fix e4b bitmap inconsistency reports"

    This reverts commit cb45b6209aa53979b054bd026d938107d5a3031b.

I haven't had time to investigate this more closely, but I'm assuming
the automated stable picker was trying to backport cb45b6209aa5
("ext4: fix e4b bitmap inconsistency reports"), and determined that
the fe80bba8f76f ("ext4: convert bd_buddy_page to bd_buddy_folio") and
29897d75d649 ("ext4: convert bd_bitmap_page to bd_bitmap_folio") were
prerequisite commits --- and while 29897d75d649 cherry picked
correctly, either the git scrwed up the cherry pick, or there was some
additional prerequisite commit needed, but wasn't caught by the "it
patches cleanly, ship it!" algorithm.

I don't have time to investigate further, but Greg, if you could drop
these three patches, that should address this issue.

Cheers,

					- Ted

