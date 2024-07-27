Return-Path: <stable+bounces-61978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B961E93E092
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 20:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C340B214C1
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF11186E43;
	Sat, 27 Jul 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in74GW17"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C30288BD;
	Sat, 27 Jul 2024 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722105566; cv=none; b=pPuMcnOM7dn1t3084EIZYsUE5On3vB7x9TFo2HAOOFzt6RWEUjf4wnTRlBvGlk45MQqZYQRgSJaJ4MLlScXdae7AMsvYqROjYe9M9B+mZv/1SeqvelufLNnmWq4pwUYJRG0p000DP6h10Yr1IwE0wu3Br6fWi7boZQ4J7MdVO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722105566; c=relaxed/simple;
	bh=mqqTbeT3cQxsVumINcr8inDBGKCLmYlO+jG2QvMYj74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7sy07HB4NM/x9nQ7ZdbG5ICFG31BlLGzd22jlUaoFB/6f7g6Aj0SxpZ211LB/96nYc0e2I31Zos1bqCaWINpxJG84WB4iWHXK0mAEw8DBrQGcVKnXCuENyvl4oZ3pnbh9QtbLrEya08GDvaSvatRU7Mib/P+VU5o6PG0k6/moM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in74GW17; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd69e44596so11907685ad.1;
        Sat, 27 Jul 2024 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722105563; x=1722710363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tb01SeeGpCzCq1LvvFZXXuhnamF3QgcshPskKwvVvF4=;
        b=in74GW17K6oUtIdSAl87weIrbC8qEsPdm7QY8xi/ftacyT1yTYgpt8A5oZA14FbvS6
         Uxsb/1cZTkZF/QJELQvinire/qgTfKX7sU8PHGO9+VZurLhFBsc8tN2ZfsJBelcZVfPe
         IbAFgE6bg+3i4fsGdWtHFC/MaqCMxb65noUwsAZXp9YjoADjP25Q1nxOI1VOkiEnupWG
         7qKGd5B110UWvF5/QOoL/RXgTtNcXUnXwsa2Zuj6xBQdP0JVzguUNYtn2vauvmpyRat9
         RmsBxgMZ+je6qkDx9bZix0uMJn52TKpUZ50fLeiBus9Sp1T+Xi4IjgKVMaE36VB72BhV
         fCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722105563; x=1722710363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb01SeeGpCzCq1LvvFZXXuhnamF3QgcshPskKwvVvF4=;
        b=P9jHodRQa4nqd3cOi40MSBs8HHNOTxGOw2mFRKg7+4/XPfRm/NSXsjKbHnCR9PnLy8
         oaShIu/nK1TD4tlmWXmUhe2+QxpueaX5aq/S9ZgtF8GGnnAsQJCLSBWozLGYozGAH3Ee
         CwlRy8iJj8sfqSEIgW9S+Z/9X8QR38BeqRDblA8kAcArZCOndnUkdFSBMGMmbGtYyD3J
         LyQORsMDEdR2kSImBG2Hfmgx2AJwOuGOlTc1Xxnp9L+WVzGvrOfIP+diw0JJ0779pzNL
         ijxjYKyfnjgYFczeir0JDMOTpDFE+WwttB+rcTAhPFbymPJ82lzoyn387Q7Xq5tL6kvX
         N7vg==
X-Forwarded-Encrypted: i=1; AJvYcCXyA1PCDGJviTjkUa3GxXD70LKYWfWLjRYfHFZMLmUD1H4eKYyG8CJWCtmzpWQsVTnp+tVRCXoe0z8rdNBNyuWXDuTsyLahwtA7BRfPr/AkG+rz/Fy+BFgA22JtIXPwIqC4WP6nxkB4HqMheUZrkx03pcnRM4qex+diBP7l
X-Gm-Message-State: AOJu0YwXk5+AzyiIOj2BKTUpM40G/PjFc0ikinAjPIdxQCr6yziaynK8
	mFjGUH+2cely0ZSxYzGZiziN5M3Y9SV7icixErVxDoAF0KuCrTZJ
X-Google-Smtp-Source: AGHT+IEJ4IRHhYPrzjr/OjD23R9bp2YPKOjIQBf1Lw3E5OFbAgholhIYZ4qqgS0clYvxTh+5y6ZLkQ==
X-Received: by 2002:a17:902:d48a:b0:1fd:65ad:d8a1 with SMTP id d9443c01a7336-1ff04b01785mr52332705ad.21.1722105563425;
        Sat, 27 Jul 2024 11:39:23 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fbe1sm53831005ad.45.2024.07.27.11.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 11:39:22 -0700 (PDT)
Message-ID: <b2232e8d-275b-4e98-84fe-bbb33e3c6b7e@gmail.com>
Date: Sun, 28 Jul 2024 03:39:18 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_core: fix suspicious RCU usage in
 hci_conn_drop()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20240725134741.27281-2-yskelg@gmail.com>
 <9dc0399a-573a-40c1-b342-a81410864cd9@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <9dc0399a-573a-40c1-b342-a81410864cd9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tetsuo,

> Excuse me, but I can't interpret why this patch solves the warning.
> 
> The warning says that list_for_each_entry_rcu() { } in
> ieee80211_check_combinations() is called outside of rcu_read_lock() and
> rcu_read_unlock() pair, doesn't it? How does that connected to
> guarding hci_dev_test_flag() and queue_delayed_work() with rcu_read_lock()
> and rcu_read_unlock() pair? Unless you guard list_for_each_entry_rcu() { }
> in ieee80211_check_combinations() with rcu_read_lock() and rcu_read_unlock()
> pair (or annotate that appropriate locks are already held), I can't expect
> that the warning will be solved...

Thank you for the code review.

Sorry, I apologize for attaching the wrong kernel dump.

> Also, what guarantees that drain_workqueue() won't be disturbed by
> queue_work(disc_work) which will be called after "timeo" delay, for you are
> not explicitly cancelling scheduled "disc_work" (unlike "cmd_timer" work
> and "ncmd_timer" work shown below) before calling drain_workqueue() ?
> 
> 	/* Cancel these to avoid queueing non-chained pending work */
> 	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> 	/* Wait for
> 	 *
> 	 *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
> 	 *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
> 	 *
> 	 * inside RCU section to see the flag or complete scheduling.
> 	 */
> 	synchronize_rcu();
> 	/* Explicitly cancel works in case scheduled after setting the flag. */
> 	cancel_delayed_work(&hdev->cmd_timer);
> 	cancel_delayed_work(&hdev->ncmd_timer);
> 
> 	/* Avoid potential lockdep warnings from the *_flush() calls by
> 	 * ensuring the workqueue is empty up front.
> 	 */
> 	drain_workqueue(hdev->workqueue);


Please bear with me for a moment.

I'll attach the correct kernel dump and resend the patch email.


Warm regards,

Yunseong Kim

