Return-Path: <stable+bounces-204229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A11CE9F7A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE38430036DE
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C12FD665;
	Tue, 30 Dec 2025 14:46:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE562DEA6B
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105967; cv=none; b=Re4bue3gYlNOq8d55wbI+yEtKLBpy2ZmedKzEjlI5dCqKF+z+dOYclwuCm+FVNAyQJCYXb4GnbjgHSkTUGamKgHZxpwLoidwo5hg0WnLqUxAN8YpjhjJlQwvnKIG7AbUGwdSIhtCmi1YmmCGM7PJsCvlemrfNo4eFKtzuX8FM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105967; c=relaxed/simple;
	bh=jDml9xbfvsMVK3isIvRKeuFOsSwnZnxeaDgwogvglAQ=;
	h=To:From:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=T096aMnrOspLjD9iRVsWZUQnnsFzr9gzyZeektoQJX0+5gbRiSpX/BJ3cqRQNPos2FkCjyq9BMACYhy0RhmZd4OSGKk+Fnj9P9U+EVE+rZC2P8ZRQ9lK2/fkOpZtOHhGqswDqb2xpJnkazekN8aK6d6NYMpl8nPncdJR51OUdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07ecd7.dip0.t-ipconnect.de [91.7.236.215])
	by mail.itouring.de (Postfix) with ESMTPSA id 1D68A3E49;
	Tue, 30 Dec 2025 15:38:35 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 1E76D60137083;
	Tue, 30 Dec 2025 15:38:34 +0100 (CET)
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Cc: Fernand Sieber <sieberf@amazon.com>
Subject: Please add 127b90315ca0 ("sched/proxy: Yield the donor task") to
 6.12.y / 6.18.y
Message-ID: <04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com>
Date: Tue, 30 Dec 2025 15:38:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi -

a Gentoo user recently found that 6.18.2 started to reproducuibly
crash when building their go toolchain [1].

Apparently the addition of "sched/fair: Forfeit vruntime on yield"
(mainline 79104becf42b) can result in the infamous NULL returned from
pick_eevdf(), which is not supposed to happen.

It turned out that the mentioned commit triggered a bug related
to the recently added proxy execution feature, which was already
fixed in mainline by "sched/proxy: Yield the donor task"
(127b90315ca0), though not marked for stable.

Applying this to 6.18.2/.3-rc1 (and probably 6.12 as well)
has reproducibly fixed the problem. A possible reason the crash
was triggered by the Go runtime could be its specific use of yield(),
though that's just speculation on my part.

So please add 127b90315ca0 ("sched/proxy: Yield the donor task")
to 6.18.y/6.12.y. I know we're already in 6.18.3-rc1, but the
crasher seems reproducible.

Fernand, please correct me if I got the explanations wrong.

Thanks!
Holger

[1] https://bugs.gentoo.org/968116 starting at #8


