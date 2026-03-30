Return-Path: <stable+bounces-230993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEl0CSvmyWlC3QUAu9opvQ
	(envelope-from <stable+bounces-230993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:55:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E421354ED7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A5B30398BD
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546939151B;
	Mon, 30 Mar 2026 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXaEvoXX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BB34CFCF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774839165; cv=pass; b=KyoVyQXi4wvx4O2sdo/XveNN1GTB/MmkFlD4HLmIr03pLwa9rxBJ5KCol7Wrd8kW1R6kDwKoIULMPF1aEv9FFI6U1tcQZL93aV40hAW5f1dyUIbyc8uDW8dSuM6DonpVPVDqPEGGbmAsoGo0nr0YjScIiIyjlATfzeBuXP2JL8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774839165; c=relaxed/simple;
	bh=SfrGjdlcRjT4L4uWuViBvdklEQoncEmijAAgKf1l1bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsTDswUK1P50DIcYKloS5vZzRIN8jSu8Z7k2LMbt5WzYBQaSCEY+BWpYvsCzIc9pG6vhsGu8MVUodFMgeETJiXCBQF9EIyu0AulW7oyn3Wm/m/A4OAIRo8pszgwNzb0MVu7PJ/JRolvNM3NdeBXKPqz1/K88FzZYwZF6yOtmv8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXaEvoXX; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6500040f128so3050435d50.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 19:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774839163; cv=none;
        d=google.com; s=arc-20240605;
        b=Gxur4ycNhCxlnIFdVTOixlJ3sISimjJe2qGkwMiNDxNgslsBpJbAMVMa82cqAjcDtf
         oQRWKl6H0VoOhN+gpclu6rLnDnVZiyt4OgutRz+5i3syuIrHkLaO3F/9haqR/ED/Nczw
         k5iXrx0U1lYnbelCftyNVOwgtqV7zMyo92YTrFkjY3SO5i0JlYAvF2z0AN/k35Go9VmN
         Q0ScOOFStSX9WvEvlRwsCnXsIAnTwaSLci93xz/YxxxCFxLdB5hVCdJgkgp/NB7QU6gD
         EwhVe4YeGjzWlahAgf+PF1qUcWtznzW6t4TLq+3g8UGtAmSftMXsSchXSolDrMJiPuco
         qxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lrXg6QpqOaU442980eJaCWaSPNp0oMwMQIp4gID6wto=;
        fh=tLnlX5/QOFdg2bWfglq/VAeklsJUMGfTV8B4l7dV3e8=;
        b=S4B3Nwzv57VFrze9VVhKvjDaXJczBh6mMHl+ONs/BjgE/OXOtwYYpVeA4YSIyT4gi0
         ngIAWYn6e0L/JlCshmtPrM1pATIR0qoaJjh10uYBl3yXUoKFszwxeyaQitE4OJHUHz7R
         ds9sQLar1qWDaEhzOpUCaAWIC5CJYTKWz1mZDxjcwMlK+jUkLzAoKODHKWafqd25M08v
         bb4JOk6UkphpU5wesFHbds43BuIHuMxbyX9QbAEiy+n8VlKKAyauHSPb/rHElnrAiJwd
         NLmmseDPXOwR7WNPQss9dThxOBwKfM+50xzF3kICo9Pcf0n8UYpuSvGJbLFlYpfwoaWF
         7jsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774839163; x=1775443963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrXg6QpqOaU442980eJaCWaSPNp0oMwMQIp4gID6wto=;
        b=YXaEvoXXMGg/3CCAHgSmBegPGDEncGe0pQwhca1mnQE+0r/x3eRtxtHIvhw0RwUW3Q
         ukoynh96PEO4+n58HY9IEN+jUcixPyGAfhz+MzJ8U33f45R3NIFCK96XHJetJSKm368J
         2kyp1CkOnzqslt/f455H0nXu/HNHlO8Bei7I6HSOzsrBCEP/83bmFPWc/2reB/WmvuII
         9ROX1faVug//Qf7morf/T5q7td3BU8UYoPDmKSnU59/sFcZP//l8nxQXiPZ3xlZnNqbE
         KY1XTb9kP/QaXdzqBImbgeTKw6W9zCBkzRTWR3KDpQSopZbrdcNg8+CY3jxbznB4n6Ab
         Wvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774839163; x=1775443963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrXg6QpqOaU442980eJaCWaSPNp0oMwMQIp4gID6wto=;
        b=dYUYiXjffxTSZPS6kNB/cJDIcIWhlSkApFEre3aH5N9G/eFo1FLZI6Qsr4XLdUfcxF
         l/HvhjF1rz8QGnvGgyzQ9qLrwg2gaXgFxKlgGLRIfWLVl5E5m/2ZLe0sk6KsnXH9+vk1
         FNb/PULgdz9lTOnGWDR5T97bl+8q7io/rokhhBYqZ7Hv5JZm3CGf1dqPvjRAF6myCFzi
         lkFwIe7nM1MbCXyLQpSl6RZBJnHs/5pRRsJgEzK0hPqsYyiW3EizAwYNwIZRey/m7Hd0
         gxvIbO2ZCnlKIXhqxX22alimlSC0RPQgzyKdcEYSek//FIiNDIe2OjbNGYrG67uGuUA/
         fQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCXBTMBooW6zueQJQU5OCL/+pJjtlH4P16iXTtHwgpN91gBmWDYZhNtMNChv3akKOM557HxGFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZzB3VSUA0rAVyQ7xessxo9rVcXeyLiwp9uy0NfS6mtML9pJI
	uzsXOlxLz5EeifpUL3/RZ0wlUtn6TswNn/TUGQ9u/xqjBrP9d6e/q43MQ9CiSezBw3vzRLuAHad
	pAX8hgB6wXU61irBpSWw+Y/XE/uQL6VQ=
X-Gm-Gg: ATEYQzwFjUbAzCLHxJhVSWsU1OS+mbWswCLQstd4BL7rz5WugfTJKmP60qBzJ05FKzj
	cYiyr+iyP6F9xcdcs7+OdwzHgEL30BrbGuDCmM8EIirrgpvVLi3hC1faE31C2PnvoBTt5HkBHLz
	EPTx8XiwSfBQAhmoJrZGnx6fUeKaol/BsNbYVOq1mwSDm6aStMKS/kSDT+2I5mhKHmlA3d0TJZr
	uubvHETsO8g2O4dAppblrjnuc36/YZRcGvdf+um7qwyMKml/r9JLpIW1INFg2w5v8rlSUdT3E8u
	3xcR0w4ocw==
X-Received: by 2002:a05:690c:f13:b0:79a:b879:bdf0 with SMTP id
 00721157ae682-79bde0fa2bbmr109572217b3.46.1774839162876; Sun, 29 Mar 2026
 19:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327131152.155617-1-zzzccc427@gmail.com> <acnJMhFpp42bdW93@dread>
In-Reply-To: <acnJMhFpp42bdW93@dread>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 30 Mar 2026 10:52:31 +0800
X-Gm-Features: AQROBzDgkko_b5X2k_jPUm3cQ0Tz68mTMbkE5KDOr-P3gm_XEs-Ju4vtpIrupOk
Message-ID: <CAFRLqsXH3dBk_s8HmvLMaineikWneZpE1PHsH_oJzAfLxyvmOA@mail.gmail.com>
Subject: Re: [PATCH] xfs: annotate lockless b_flags read in xfs_buf_lock
To: Dave Chinner <dgc@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230993-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8E421354ED7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dave,

> No. READ_ONCE should not be used to annotate a benign data access
> race. data_race() should be used because all it does is turn off
> KASAN for that access, and unlike READ_ONCE(), there is no code
> change when KASAN is not enabled.

Thank you for the review.  You're right -- data_race() is the correct
annotation for a known-benign race.  READ_ONCE() adds an unnecessary
compiler barrier and, without a paired WRITE_ONCE() on the write side,
is not the right pattern here.

> But, in reality, the race condition here is more than just the
> b_flags access.  There is a big comment above the function explaining what
> the check does, and that the buffer pinned check that precedes the
> b_flags check can race with journal completion, too.

Agreed.  The atomic_read() on b_pin_count is already KCSAN-safe, so
only the b_flags access needs a data_race() annotation to suppress
the KCSAN report.  The commit message in v2 now acknowledges that the
entire pre-semaphore check is racy by design.

I'll send a v2 using data_race().

Thanks,
Cen

