Return-Path: <stable+bounces-163353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C64B0A07E
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2701F3AADB4
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FE29E0FD;
	Fri, 18 Jul 2025 10:20:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5F126F0A
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834016; cv=none; b=NFBLSy1vHB35bcCX9jVJuVuJhxK1ag3E6cjKhJIsAPKtHwxKSriGbUWp0UCFKZqcG5nHKJU5ugfuUqoWobgxxyuT2GY/okvuaYWOqqGWhfI+ZoPcEQTBPodJ2+K52aE2IV3wyMqefwi1Nvvu1/7IZTFo6FpASKlEKFTBTGn3oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834016; c=relaxed/simple;
	bh=X32dOqZIwozh+pW8ZCywmZmk3cynNEQgw/qO4RHIxfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnyg+dmdQy010o+xKpCr837Im/lcYWSM4FaE0esZocpQAuUC2WOpF6lUzLJ1McxjEnAN8lLYT2sxtHbdrXTfJmnadXJjQ/+JDWKrGkJaBqHERRMmaDJIRAxROvwAoB7mK5sLqvfvwoQKP/bqygPjWn9sRpKJ2tnJ+4tHBr2se9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: stable@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Subject: [6.6.y] ipv6: make addrconf_wq single threaded
Date: Fri, 18 Jul 2025 10:16:04 +0000
Message-ID: <20250718101603.5404-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR - please backport
  dfd2ee086a63c730022cb095576a8b3a5a752109 "ipv6: make addrconf_wq single threaded"
to 6.6.y (only).

When testing the stable and LTS kernels this week I noticed one of our tests was failing on the 6.6.y kernels and passing on both newer and older stable kernels as well as mainline.

It is not a perfect test. Running the test in a tight loop, it would occasionally fail on other kernels after thousands of iterations (6k-10k).  However, on 6.6.y it usually fails on the first or second run, so I thought it was worth digging a bit.

I've bisected the behaviour change back to:

 86bfbb7ce4f67a88df2639198169b685668e7349 "sched/fair: Add lag based placement"

The regression is later fixed by completely unrelated commit:

 dfd2ee086a63c730022cb095576a8b3a5a752109 "ipv6: make addrconf_wq single threaded"

ie. a change to the scheduler caused the change in behaviour, and changing ipv6 addrconf to use a single-threaded workqueue seems to have "fixed" it.

The original test is creating three tap interfaces, binding a socket to each and sending a packet on each. It's a simple test just to check that binding a socket to an interface works with our API.

I wrote a simplified test, which just:

- creates a single TAP interface, disables DAD, and brings it up
- times how long before a single IPv6 packet can be sent without error

These are the results for the commit (e0c2ff903c32) before the change:

2025-07-18 07:01:33-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:35-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:37-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:01:39-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:40-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 2306 tries (0.00296s)
2025-07-18 07:01:47-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:49-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:01:50-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:52-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:53-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:01:59-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:02:00-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:02:01-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:05:03-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:05:05-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 2042 tries (0.00266s)
2025-07-18 07:05:07-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:05:09-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:05:11-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:05:12-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00004s)
2025-07-18 07:05:15-00:00 6.5.0-rc2-00017-ge0c2ff903c32 8 bytes sent after 1 tries (0.00002s)

ie. sending mostly succeeds on the first attempt after TAP creation, with occasional outliers.

With 86bfbb7ce4f6 applied, it's not so good:

2025-07-18 09:25:00-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2184 tries (0.00285s)
2025-07-18 09:25:02-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2597 tries (0.00336s)
2025-07-18 09:25:03-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2579 tries (0.00332s)
2025-07-18 09:25:05-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2045 tries (0.00261s)
2025-07-18 09:25:06-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2333 tries (0.00305s)
2025-07-18 09:25:08-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2847 tries (0.00355s)
2025-07-18 09:25:09-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2267 tries (0.00306s)
2025-07-18 09:25:11-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2731 tries (0.00343s)
2025-07-18 09:25:12-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2506 tries (0.00327s)
2025-07-18 09:25:14-00:00 6.5.0-rc2-00018-g86bfbb7ce4f6 8 bytes sent after 2554 tries (0.00338s)

If we apply dfd2ee086a63 here, we see:

2025-07-18 07:06:19-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:06:22-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00005s)
2025-07-18 07:06:25-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:06:27-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 44 tries (0.00013s)
2025-07-18 07:06:32-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:06:34-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 42 tries (0.00013s)
2025-07-18 07:06:36-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:06:39-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 32 tries (0.00014s)
2025-07-18 07:06:41-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:06:43-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 67 tries (0.00012s)
2025-07-18 07:06:45-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:06:47-00:00 6.5.0-rc2-00019-gdf3c40c549d8 8 bytes sent after 44 tries (0.00013s)

6.6.98:

2025-07-18 07:09:58-00:00 6.6.98 8 bytes sent after 2107 tries (0.00273s)
2025-07-18 07:10:03-00:00 6.6.98 8 bytes sent after 2597 tries (0.00350s)
2025-07-18 07:10:05-00:00 6.6.98 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:10:07-00:00 6.6.98 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:10:10-00:00 6.6.98 8 bytes sent after 2714 tries (0.00343s)
2025-07-18 07:10:12-00:00 6.6.98 8 bytes sent after 2635 tries (0.00330s)
2025-07-18 07:10:15-00:00 6.6.98 8 bytes sent after 1939 tries (0.00247s)
2025-07-18 07:10:17-00:00 6.6.98 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:10:20-00:00 6.6.98 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:10:22-00:00 6.6.98 8 bytes sent after 2688 tries (0.00343s)
2025-07-18 07:10:24-00:00 6.6.98 8 bytes sent after 2586 tries (0.00334s)
2025-07-18 07:10:26-00:00 6.6.98 8 bytes sent after 2526 tries (0.00335s)
2025-07-18 07:10:28-00:00 6.6.98 8 bytes sent after 2411 tries (0.00311s)

6.6.98 with dfd2ee086a63 applied goes back to much more consistent behaviour:

2025-07-18 08:29:52-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 81 tries (0.00015s)
2025-07-18 08:29:55-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 46 tries (0.00013s)
2025-07-18 08:29:57-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 54 tries (0.00012s)
2025-07-18 08:29:59-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 44 tries (0.00013s)
2025-07-18 08:30:00-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 71 tries (0.00014s)
2025-07-18 08:30:02-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 44 tries (0.00014s)
2025-07-18 08:30:04-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 73 tries (0.00013s)
2025-07-18 08:30:05-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 46 tries (0.00014s)
2025-07-18 08:30:07-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 73 tries (0.00013s)
2025-07-18 08:30:09-00:00 6.6.98-00001-g9a37684fd14f 8 bytes sent after 46 tries (0.00013s)

6.12.39:

2025-07-18 07:20:21-00:00 6.12.39 8 bytes sent after 100 tries (0.00015s)
2025-07-18 07:20:24-00:00 6.12.39 8 bytes sent after 54 tries (0.00014s)
2025-07-18 07:20:26-00:00 6.12.39 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:20:27-00:00 6.12.39 8 bytes sent after 53 tries (0.00014s)
2025-07-18 07:20:28-00:00 6.12.39 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:20:30-00:00 6.12.39 8 bytes sent after 56 tries (0.00013s)
2025-07-18 07:20:31-00:00 6.12.39 8 bytes sent after 1 tries (0.00003s)
2025-07-18 07:20:32-00:00 6.12.39 8 bytes sent after 94 tries (0.00012s)
2025-07-18 07:20:33-00:00 6.12.39 8 bytes sent after 1 tries (0.00002s)
2025-07-18 07:20:34-00:00 6.12.39 8 bytes sent after 60 tries (0.00013s)

mainline:

2025-07-18 06:57:42-00:00 6.16.0-rc6 8 bytes sent after 1 tries (0.0000s)
2025-07-18 06:57:44-00:00 6.16.0-rc6 8 bytes sent after 31 tries (0.0001s)
2025-07-18 06:57:46-00:00 6.16.0-rc6 8 bytes sent after 70 tries (0.0001s)
2025-07-18 06:57:48-00:00 6.16.0-rc6 8 bytes sent after 69 tries (0.0001s)
2025-07-18 06:57:49-00:00 6.16.0-rc6 8 bytes sent after 3 tries (0.0000s)
2025-07-18 06:57:51-00:00 6.16.0-rc6 8 bytes sent after 68 tries (0.0001s)
2025-07-18 06:59:31-00:00 6.16.0-rc6 8 bytes sent after 1 tries (0.00003s)
2025-07-18 06:59:35-00:00 6.16.0-rc6 8 bytes sent after 34 tries (0.00014s)
2025-07-18 06:59:36-00:00 6.16.0-rc6 8 bytes sent after 1 tries (0.00003s)
2025-07-18 06:59:38-00:00 6.16.0-rc6 8 bytes sent after 1 tries (0.00003s)
2025-07-18 06:59:49-00:00 6.16.0-rc6 8 bytes sent after 73 tries (0.00014s)
2025-07-18 06:59:51-00:00 6.16.0-rc6 8 bytes sent after 52 tries (0.00012s)
2025-07-18 06:59:51-00:00 6.16.0-rc6 8 bytes sent after 50 tries (0.00012s)

As dfd2ee086a63c730022cb095576a8b3a5a752109 is a single line change and clearly brings behaviour back in line with other kernels we should backport this to 6.6.y.

Cheers,


Brett

