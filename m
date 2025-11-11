Return-Path: <stable+bounces-194499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E9C4E95E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6FA14F65F8
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0942F39CC;
	Tue, 11 Nov 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWX/RDHh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3ROkid8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FD2F3610;
	Tue, 11 Nov 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872213; cv=none; b=DJr2jIlIf9ULQIeerkV861iJUKQ0tCmrAruxT8snCuLgNIeCPWWhqeFFwTK9Fs4XI7NEkKnoNYtK5TTOHhm+ttVHoW3NGZBiec3ypZIvXy2gIieTYG+7NGd3+PTECqQ2GsU/LCD+hsZxj2Kv2iGK8HvSRYHqIaf7wTFn2ZBbZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872213; c=relaxed/simple;
	bh=UKPYL0rFgTbY8us1oEAUt0GFwuXyJHqXkERE8/YE0Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M96+eHbb/w6cRf0P14r7T0Lg3XnTzejcmbcsHs2zQTVH9+gArukjzcjsT1rV4E8Gm6Z4lIdg6KiytJDHSxWTDw+83UacLz9xpQmpT8GkermDFgODnLSnR6Oj1G5rXZromB/VXnfQVBRhRwHLT0uPkjufLnoWuuIfrLE9EucovBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWX/RDHh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3ROkid8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762872209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yG2T38VD+7YpgZZ8qSQvE9nfHKbMTt0P5ilrk/4/P5I=;
	b=NWX/RDHhkgpdiv5gkf0EjdjoA7zgrhUh4v++yWOAeTs16rUCrt6qB9cHaK1qU7+1JkwRfw
	36BwE3vX3zSV0rXVuNY0w1kN81uNTSrxubkmAHMD4KcvmYupPq/lqA4EWKs3bO5ex454jV
	mzLGapE9Cli3bq9ObIEA9A2VbzhbGGDYR24iVcinw1oZ6b42kKjV8wdgCHRKX6d8TBB26v
	kw760sBr70WH9Ly/PMAv7ii0JYEgy6PtCCXc2nk+8ntqgkDEdqSmKqdyci9sJ9Va04of8i
	Gcf44ff5vdaUT5wWUDJ2G43JTBSbDXU9DIigb8Ba+QAcM7QfeGctbD/j/CnX+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762872209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yG2T38VD+7YpgZZ8qSQvE9nfHKbMTt0P5ilrk/4/P5I=;
	b=r3ROkid8M9lEzL9zYnrmuROFdlk3InTeVU22qdbBmWJfW9BIfKTYx1GV7Q+0nsddQxhH07
	yan9VeqkVW7e9HDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH printk v1 0/1] Fix reported suspend failures
Date: Tue, 11 Nov 2025 15:49:21 +0106
Message-ID: <20251111144328.887159-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There have been multiple reports [0][1] (+ 2 offlist) of suspend
failing when NBCON console drivers are in use. With the help of
NXP and NVIDIA we were able to isolate the problem and verify
the fix.

The first NBCON drivers appeared in 6.13, so currently there is
no LTS kernel that requires this series. But it should go into
6.17.x and 6.18.

John Ogness

[0] https://lore.kernel.org/lkml/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com
[1] https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com

John Ogness (1):
  printk: Avoid scheduling irq_work on suspend

 kernel/printk/internal.h |  8 ++++---
 kernel/printk/printk.c   | 51 ++++++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 18 deletions(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.47.3


