Return-Path: <stable+bounces-204301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A37CEAF4B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 01:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 003B8300FA0E
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30E5FDA7;
	Wed, 31 Dec 2025 00:16:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-57.mail.aliyun.com (out28-57.mail.aliyun.com [115.124.28.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A431DFF7
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140201; cv=none; b=NIaDyPjDa1NQoOTR2DcRMf9UiJlus8vaK0i88TbShqIlfO+xnM6KY0yFDl76P3IjVkRswL88lEB6EtZ4ThCuPh450fcfJU/OeY6cM2FQpJRBB05inzX55qpqUJBcInUaNXd+saR/s/KXkDZGb6AYXuvAtApBYZsBPrUV7AfGKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140201; c=relaxed/simple;
	bh=cGPiFRsGnGe6pQMZmqA+UFqZ8dPYV+Iz+mw3RT6qpqc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=QWHdcPdS0MTXDzHEj3jxowrE/B+10KBEgsCsEksfQdwOSNA7vP4HnTOJhM2UaSJraFx6uAqC1FWe99Hikh+CbTDpTXuc/xOiIu2tJ0lP+CptphfRmvnc5ki/7UMVUN5TuMIuHUQJS2MGPijV7PgxeVhCHZkDAOxo/t23TYX8bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.fwkMib8_1767138342 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 31 Dec 2025 07:45:43 +0800
Date: Wed, 31 Dec 2025 07:45:44 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Holger Hoffst?tte <holger@applied-asynchrony.com>
Subject: Re: Please add 127b90315ca0 ("sched/proxy: Yield the donor task") to 6.12.y / 6.18.y
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Fernand Sieber <sieberf@amazon.com>
In-Reply-To: <04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com>
References: <04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com>
Message-Id: <20251231074543.64FC.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi,

> Hi -
> 
> a Gentoo user recently found that 6.18.2 started to reproducuibly
> crash when building their go toolchain [1].
> 
> Apparently the addition of "sched/fair: Forfeit vruntime on yield"
> (mainline 79104becf42b) can result in the infamous NULL returned from
> pick_eevdf(), which is not supposed to happen.
> 
> It turned out that the mentioned commit triggered a bug related
> to the recently added proxy execution feature, which was already
> fixed in mainline by "sched/proxy: Yield the donor task"
> (127b90315ca0), though not marked for stable.
> 
> Applying this to 6.18.2/.3-rc1 (and probably 6.12 as well)
> has reproducibly fixed the problem. A possible reason the crash
> was triggered by the Go runtime could be its specific use of yield(),
> though that's just speculation on my part.
> 
> So please add 127b90315ca0 ("sched/proxy: Yield the donor task")
> to 6.18.y/6.12.y. I know we're already in 6.18.3-rc1, but the
> crasher seems reproducible.

Failed to apply 127b90315ca0 ("sched/proxy: Yield the donor task")
to 6.12.y, because  the 'donor task¡® is a feature of 6.13.

commit af0c8b2bf67b25756f27644936e74fd9a6273bd2
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Oct 9 16:53:40 2024 -0700

    sched: Split scheduler and execution contexts

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/12/31




