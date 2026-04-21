Return-Path: <stable+bounces-240021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCpSNKza5mnH1QEAu9opvQ
	(envelope-from <stable+bounces-240021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:02:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5FF4355D9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E54301589B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5C26B2DA;
	Tue, 21 Apr 2026 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XskVbg+B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2F1A9FA0
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736917; cv=none; b=fgiOVzYGVJhOjfbkfsvEiDnih3bFaRXLmv+uvGicLcI0IHYhxjHomqfG6qIhq4wg/LnQITYYSafHSMYpmE66pGXtR4mgTgjb1HPqVWmx4f7Im8qPiWpYaoVgOTGwk361Fm9EtWTjviWmtRNmGlhzNFUZtYgSrM804eihLADEA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736917; c=relaxed/simple;
	bh=l9bRz9UeCPAV9DA8Zy5r0ie/prB1/Xr8Z+QnqVjykhA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YTksbPcsLw6S5nA/qaMckbJFGYgVDw3SFRcGL1YxeEfQBa39tBVojBaxnSuteABEZydwpo2VpbOi4Pj9MarR1uLk6nJoYBunUG+HmVl94Jf+F64Qai6ELZ9jK+uBLIfpIWSiAgjUC1rB71hNm1sYaoh6QFbioCD0ZqHl4uufYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XskVbg+B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c648bc907ebso2403147a12.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776736915; x=1777341715; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HAfyiA5fxqYXT4gYRX9zfWikwnCgQwE5e6No9OGkL8Y=;
        b=XskVbg+BJsj32X8H+Rf6+BXY8Llvyd4yvTB+mmbWcDkA4v3GBhKwVjRazy9zkOig2F
         AU6Fkl9QCa2PEDPsghPR4e3v64RfZoq7mjp8DkxoGFQv/yfhWgiDQZ4umrmGHfjos8Nj
         7B0KwN9ejXrLewIz+edRFUmOl8F81dtnlpQV6qAkW1NfsS8s3xh1PZgbRHfwA12NxAUy
         fL4Xm3DisCW9om0yRpixnwxFLAjdgLCakxCQDVMatIqYPxBSiRZaNsfDNI5N1aMuiQz9
         38EozjmEDteXe24b68MG4VTErQ64u7m8Hu7zJNcVw3DJb05GLVtll5pTE+PxUUBpkSpz
         cEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776736915; x=1777341715;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAfyiA5fxqYXT4gYRX9zfWikwnCgQwE5e6No9OGkL8Y=;
        b=RX+m+DyueAGyFEaKhl2NkpKOBuT5IgjdMxN1aQS6Rcru2VVRudzRVAUSvNoqTjNoF4
         IGHBZEgTdsOyaWM6EJEtZvlMuCKsmwnbuBujxuxnL6QXi/Xv8cT1N9x0zXtEWg2zF5Fw
         wAavY37DUYYCFSp/uCQhiPG7HVSeLSDgIAzSI/qWt1XUKVo4DKwCZbbEUaw42ufblQe7
         wU91JTtybYKKF6xRO8jV5odJDvjm9bCOMpt8FDMyONcg44fbapWeFMcHvW3K8yUyYEdn
         pIsxqVAbzbjvQ6gmWGuLZnKztNupf1yWuKkRbv3QO5NnU6LAaD2gqrk6PfpJEUBtMtL+
         vYfg==
X-Forwarded-Encrypted: i=1; AFNElJ+v8d00Qpl6El7vQKVzoVwVeQWg6VLsM1x0RyHoGJQV5iWu4lpTdrjWjrN0mQQB/pgqlfN7g4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fGnco+vdYhi69OGcVwtfyHqa02w4AAAyvpMBtFPuZU1+cZ6f
	sEsnKi2KG7GOI31gZ5ANR2/ng/fB2jh/XEtE4BYG5sDo27+PsvmK4NrvqLew5w==
X-Gm-Gg: AeBDiev6LCDwJogssOGEcv9eJBr1S0Ne9Jr7LGjihUmtP72l7rnVZL2fLxnEQYp5sis
	T/stV/BF/RjCryO2i8RF/ndlk1ImYj0F81svE6bZCeG/sAqzXPBPzsvwmOE4xO8y3uoVU+OG+Uq
	jsLiPHKJNiRyoeLGZmLFYbW7GKq1I47R5RV3inAnexFZ2Xs8KBPXB7/73I7lr9ymndEwdMuQvvE
	VPklp6dagXtmRJ8eHRW7D/wgyJM+ZG1y5Pruq6EJfmsX9k7jQMOUcgWhsHBNly/JaiXhbIcFLNy
	eO6aEyhrUWK+A8wzFCc1pPtKBwMDUk+KKXwkIMCB2r1h3YVVaMq9xhuAkDce10MQWl/v1q8LB4+
	3xAmHZ4VoP73VNY4Bblua5NlXtvoLGRIuthz6rqYiKCfljU9jahNDqbceeCyXVFXHM938EsjMTI
	Um9OS8Y8mpXyiEVEQy7l8zpFP7693b+/WP
X-Received: by 2002:a17:903:1988:b0:2b4:5cea:f618 with SMTP id d9443c01a7336-2b5f9e7823fmr164463225ad.3.1776736915460;
        Mon, 20 Apr 2026 19:01:55 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3b4sm149129515ad.2.2026.04.20.19.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:01:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: Matthew Wilcox <willy@infradead.org>, abuehaze@amazon.de, alisaidi@amazon.com, blakgeof@amazon.com, brauner@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <aeZ0Kp8dBqjsyWki@casper.infradead.org>
Date: Tue, 21 Apr 2026 06:46:19 +0530
Message-ID: <cxztt8nw.ritesh.list@gmail.com>
References: <ldenszsy.ritesh.list@gmail.com> <20260420163328.22104-1-dipiets@amazon.it> <aeZ0Kp8dBqjsyWki@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[infradead.org,amazon.de,amazon.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240021-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E5FF4355D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Apr 20, 2026 at 04:33:28PM +0000, Salvatore Dipietro wrote:
>> I have submitted a v2 of the patch based on Ritesh's suggestion.
>> https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u
>
> ... but without linking back to this thread, so nobody who was exposed
> to that thread for the first time knows about this one.  That's poor form.

Yup.
Also, given the Maintainers (willy, Christoph, Dave) shown their
dis-interest in taking the patch in it's current form, the right way is
to get back with performance data with both the approaches (which we
were discussing) and first get the consensus from everyone, before
proposing this as a patch :).

Having said that, we do care if a genuine performance issue gets
reported. In that context, I wanted to understand your setup a bit from
memory fragmentation perspective. Are you trying to simulate memory
fragmentation and then benchmarking? Or was this problem hitting when
you run simply run the reproduction steps mentioned in your cover
letter?


BTW - I was following the other thread too where PREEMPT_LAZY problem
was getting discussed. And from what I understood, you mentioned [1]
enabling THP on the system made that problem go away. Also it looks like
enabling THP is the right thing to do for this kind of workload. Does
that also mean enabling THP fixed this problem too? Do you still hit
memory fragmentation and/or similar throughput drop w/o this fix after
you enable THP? It will be good to know those details too please.

[1]: https://lore.kernel.org/all/20260403191942.21410-1-dipiets@amazon.it/T/#md88ca4258766e897e432df85874d197db476c7d1

-ritesh


