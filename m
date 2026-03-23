Return-Path: <stable+bounces-227913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gII2A7L6wGkwPAQAu9opvQ
	(envelope-from <stable+bounces-227913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:32:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692062EE484
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 759BD3034299
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473C036E498;
	Mon, 23 Mar 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cl9rXJGm"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BF3603E0;
	Mon, 23 Mar 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254362; cv=none; b=CGpjoJFY8XqPV+QaydqRK7g/YdVUBf7Z9NbcJeWBLqmVo29Ple304VLM1PYRH0HLWLPpHDVDGoIerK0IkW2YrHAPVbK2JM8gX/laJwAjsrg2AR5OR5UYGCPe0B2JbPhiWhNZYwrKlg6bvDNp/knD2hh3/Ei13lcz+13S1dd84WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254362; c=relaxed/simple;
	bh=Klg5LH2nJ1/ced6EaoWVD3V9cJhwXViVfxPzhTgojk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hk5+e4rA9so8dj102m/6JeINMso1V3JdPENOIxd2pggIC9i4B7WjIRr64xJoG4kkGVq/w/CEQXUR09xgyeiP/e22zTs1Wk7a6YPFzdiYPcWlvqlCLZsSIpKsCRjx84XTPnJ5UY2Y9FOLzd8c6BWmwkNuY509C7E3HwzNiJTYgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cl9rXJGm; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774254354; x=1774859154; i=markus.elfring@web.de;
	bh=Klg5LH2nJ1/ced6EaoWVD3V9cJhwXViVfxPzhTgojk0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cl9rXJGmvMPvV6tUoRD9Lk2iT3KJvMNCxHLwlmNEku/sfVKis9aBgB80kgHSxHFT
	 fS97VCDMF2C1BfRq40/jnuGJXbwYySIjW70Wj8cTzHV96K/PUPZLxvlhzX4XEw8Fx
	 EMrbnDrUKdEsOPEKV2HVDY9tJsHJiOjl4QktrXxyx2WKydF1hsyums3ACxAHSwcK1
	 RVATZwR0KX1pOnj8tm8Pwh7yDIN61MCynnE/xaZnOyKIjFjJ0vmeD0oHs5br0ZuqC
	 IOIGKhbWF9+LaWQkedibazajWkJ6gKw2D6bzKWfCOac8jw/Mg9hjWp6QHujTTCF29
	 TpaI/nwX16YSWPo4xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1w0LMx141h-00NjfD; Mon, 23
 Mar 2026 09:25:54 +0100
Message-ID: <0bf54287-b6c1-4359-823c-e47db6f7830b@web.de>
Date: Mon, 23 Mar 2026 09:25:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/3] mm/damon/sysfs: fix param_ctx leak on
 damon_sysfs_new_test_ctx() failure
To: Josh Law <objecting@objecting.org>, SeongJae Park <sj@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260321175427.86000-2-sj@kernel.org>
 <89ab7e7b-ad61-4881-bceb-781481857d3d@web.de>
 <BDDAE837-48DD-4FF8-B7E3-AC0030AF5C9F@objecting.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <BDDAE837-48DD-4FF8-B7E3-AC0030AF5C9F@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:t4Ee2dVS2SNhjOieyUpz0lMD/wuHp5qfs23dSNvdI49lfR0sVlr
 CPhBbW8Uki/NY4XZlZTSvT8Dlz+7TtPRiNUPvbXfEp7pJg8UNANUIT1nThKBjL6WEXgPkcp
 2z5devxkO+IejIQX9uIYzpsw/oqI0Q+h7RubBcwiCJmgJeGGwUWmqdj7bWfy0FK6C/iwp1E
 lTHym49jIaNJYCQ0ZHi9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0PbsgO+VBxI=;HJZ8r3GzLg2Jcn2/kNZfIFgIJCj
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 692062EE484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Markus these patches are already merged

Are there still development interests for the application of a better goto chain?

Regards,
Markus

