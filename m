Return-Path: <stable+bounces-230585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDPqAhgJxmkZFgUAu9opvQ
	(envelope-from <stable+bounces-230585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:35:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D833F216
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9DC303CE2F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC64373C10;
	Fri, 27 Mar 2026 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SeLS4og2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D01DBB3A
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774586118; cv=none; b=JrrzRw0iD6M2L25CykO/5/EoCA4truOHJWvcWAhySsm2IJgYLru5eFtU2Hg9KzBs32+VCqDgFutSvgQnL8aPa8uTy4xwzyYtnl/VmpRR0LbPocu+OcVfLhveKYbpIn9+zL+XtYIOR09tn6l/rBoj4yQpiu4PvY2xD2NCKA1DLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774586118; c=relaxed/simple;
	bh=1Yhbp6WWEPHp4MH3CaCJMlkM+u+gxZlNkP7Xfjd285o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL5S4NR8SUNbjU1nS2Ie0zTOiTTHoM/oP0ZskCafG3zdjkhPjbPNjUIybKnUO1EkRi6mEOiJQ6mZiSP6txalXih26gJljmWD7RHmoHzF1HOOjquTr+gTLz3byejH9d55Gw8UzzCE01DBIO732v9f5ImKrsneh64naKJDU0FEZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SeLS4og2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a5db525cso13468966d6.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774586115; x=1775190915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPND/ARcmlMUL8XYaMKBEVAJ/JxuIj72dXRRctLfbj4=;
        b=SeLS4og2EJKBF25dQWYDmWeK/ul3XHjxoVSVvJGL9BaSvkyudHwkE97rR7spsjKHoL
         eYEdoAwJkVQyGdKNbXTqa2p/lOd8ENBqde+ur391YW73AMJ1uknSXJ8bQ9I3692P7OZf
         AmbvssboidQewjUyUsObgj32qi45FQdKQPCOxazYeBmp6yR91r4lQfZvnAFr+C8b+vBl
         9K/bpmQk9jj9VRlnCeymVP3Ok8LRv5zAOV9mxGjtHTISz3QWmEppo2PK2Wm4rgfG5GYT
         Je8tFNQPFndsmAQL3pzCX1raQ+BgvQr+KXJcT0ZCnXX6SbLVNckDs14t2SL4FGRiWpUs
         gQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774586115; x=1775190915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPND/ARcmlMUL8XYaMKBEVAJ/JxuIj72dXRRctLfbj4=;
        b=sFS1sl3aEkDFqs2hl01pC9l//6sZPDQB5SzP5G74C6Tf6SKytgERRaLCKZ0kJ74yDH
         ywcojLpGzTovyhVCRAtiprYIp+c3eUhVRICgYDjcj3dpAYBa9ulpKCYffFX323vUeydP
         ME5MnEtaOxzAR93XldWDyehgEfUXekHesAsjGCGzaY/eKIZhUf4HSDiTfGWs67tyuIXO
         OWhyAVp6qi0dKLBOUodisbwI2UJ65E9v9w7LV3NRjyGtevm8PmiP1/oL/kBoS7uBTz75
         v++AMPHTDBjNTWIMndCeZuQt9V9rbNIPmB6MV1i+PAHglTgD2nbwjJGOXc5E4tOXRAe0
         SfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsDNp4md17zDPzGSzovbKToy7lC5DKUOuD6Od0+IzHa9yjBpQt/e324gav9W+YfZjfXP4hMgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/8M2F9qYIdF7c/JykSsnzbsNZoih3NqNRiKUH7sHxYCKIpyLU
	7fCyfCoPyKl/R5CWuTxSL2kckf6du/ViQohN3L4aV0rzGH/pT8LBpanQ3Lq5aey9H8A=
X-Gm-Gg: ATEYQzz7IQmkTmo0aFvUnvOkM7iegCkp6vQA0/qxqfZLmBBS0NnQsZIlbegyXEnLfUO
	HL0ZOg+MwMgJ2FC9hbwOBvEDUzACztkATEDq36bFrcr2xY29k71ugho0hTf/B/O3gYRIHsWICU0
	WNVCv+tesfBdg5E2PMvFUsEkobzjL/mp4tAG2KxKg7Uk0kMUn9bTeiywablN96a+hOBcJi9khjQ
	yzi4ylPvBEOpRY5ayXgCtR0yOs5T32RoAus5mTtKkjIJOBTLaox2tvQYi9Kv7+ZQY30SyiHdS6e
	nrXM97VVQbofGWIjHGuxYc9kDD35h6bDpRsUUTWZq/Qt/JNdgJxeQvLh7IprY7B+lOwKfkYMgF2
	ogeHINFlDeXFZ3Yx3W5xfU7nSZ8OO3O3mz3DhSVykJugEUwxS1qmETr1jLnTxF4UbGmCYMgT7x4
	rPrDv0xnUwwKQiL8uWjL3iQGwINuQajIORcHs=
X-Received: by 2002:a05:6214:6012:b0:89c:823a:c4bf with SMTP id 6a1803df08f44-89ce8d6bb84mr11384906d6.14.1774586115260;
        Thu, 26 Mar 2026 21:35:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a24fd9sm40782376d6.25.2026.03.26.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 21:35:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:35:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <acYI-gqDOBbZ-bEn@gourry-fedora-PF4VCD3F>
References: <20260326162611.693539-1-gourry@gourry.net>
 <jm5rmcwiauy2fn6fvj6cjowiu2dudjndhhlcd2tm275ibmos5i@dwxwchbs24ko>
 <acV83cdc9ZfNk8Xh@gourry-fedora-PF4VCD3F>
 <bnukmnuxxuhdfeasjz33miemgr7w35c4aa6pqdmgupx7oxmeeb@gozgc3yxhcdd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnukmnuxxuhdfeasjz33miemgr7w35c4aa6pqdmgupx7oxmeeb@gozgc3yxhcdd>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230585-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: 655D833F216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:16:05PM +0000, Pedro Falcato wrote:
> On Thu, Mar 26, 2026 at 01:37:17PM -0500, Gregory Price wrote:
> 
> _If_ there is indeed breakage here regarding tree rotations, I would suggest:
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5754d1c36462..7b4e39063d67 100644

fwiw this does not resolve the BUG() i'm observing.

I'm still trying to find a good reproducer that doesn't require
launching ~100s of VMs and ballooning them, but the condition here seems
extremely narrow.

~Gregory

