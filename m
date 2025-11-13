Return-Path: <stable+bounces-194704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA8C58C17
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC34E3619AF
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E687355806;
	Thu, 13 Nov 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYnAiZvT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OsM2QT/M"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B390307494;
	Thu, 13 Nov 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049835; cv=none; b=dttDYiiH2ncrdjyaZJkl0nbYrQw0o/RZz6nlc2o3lJ2o+mj1p0ZA4hUAftkW7wbvL6Qr/i1W2y26pXFlxsCcqYs0UvEJXkyIToqwBRr8IK8E626vG0KSSpTD156vQ+/1t2hbrHxclR4GAMD4zeznyTh/Cz/EqhRQr0441Vqtn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049835; c=relaxed/simple;
	bh=sNeYjFyeepM+Uuw9qC6g3oMXihUOPhg6vjjlQrql67A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhpFfQbNovTOZpUjRQCqggJayNUFfLh76nKO4oc44TWHxVxcmPc+eMiALVFY+/lu8CAsiK5TNPkzNfgxSSo1xaF3X1ZHV1bB573O4D5NU2l66ABZw4IcAbb8NYO60sX20hwOYSIvu4OQbRbwks7SvKpwXpVWDAaICWtYif5eWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYnAiZvT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OsM2QT/M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763049832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSu3isrQsKKlplmGivpvBB81XULmt4zSr8+0Mpy6yXU=;
	b=gYnAiZvTynWXQFp8OuRLi/kyDmqSuCNnX6TnRnVJY3gi6GwCul4QPCxf62V4tz20maQwK/
	UvaGnJjARyk3Cc2fY1qkj4hdJWb4gl3cBI6I6rFUN5QBBk26psSaNHUIL2gzNy9aGNXejv
	oMqqi1sl1U/arkUa3BNhh8rr+2EnSkN5j2hn4zKyivZYvRbIzVgsPJRnjuwJSv1UORHfqO
	Q4tgpARaAgN+CoKdaJRUXXttWQjjKgQlkj2SdlJsfLom8+Q0y2p68F/lzs3YH6qmaF7GUo
	RDkTzvHDvBm0kTlcMCVZ2otDHCRNvB+jeRvkzzuSaLGSSKvRQG1AL0TeWSbWUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763049832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSu3isrQsKKlplmGivpvBB81XULmt4zSr8+0Mpy6yXU=;
	b=OsM2QT/MSSgJ8ZOiRJS+kRJ4JRZt29+VJci5MO3RNLSaqUA5WquTHSnfmDzxPqVjb4EIVZ
	vifGv9MSx5QNyTCA==
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
Subject: [PATCH printk v2 0/2] Fix reported suspend failures
Date: Thu, 13 Nov 2025 17:09:46 +0106
Message-ID: <20251113160351.113031-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of a series to address multiple reports [0][1]
(+ 2 offlist) of suspend failing when NBCON console drivers are
in use. With the help of NXP and NVIDIA we were able to isolate
the problem and verify the fix.

v1 is here [2].

The first NBCON drivers appeared in 6.13, so currently there is
no LTS kernel that requires this series. But it should go into
6.17.x and 6.18.

The changes since v1:

- For printk_trigger_flush() add support for all flush types
  that are available. This will prevent printk_trigger_flush()
  from trying to inappropriately queue irq_work after this
  series is applied.

- Add WARN_ON_ONCE() to the printk irq_work queueing functions
  in case they are called when irq_work is blocked. There
  should never be (and currently are no) such callers, but
  these functions are externally available.

John Ogness

[0] https://lore.kernel.org/lkml/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com
[1] https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com
[2] https://lore.kernel.org/lkml/20251111144328.887159-1-john.ogness@linutronix.de

John Ogness (2):
  printk: Allow printk_trigger_flush() to flush all types
  printk: Avoid scheduling irq_work on suspend

 kernel/printk/internal.h |  8 ++--
 kernel/printk/nbcon.c    |  9 ++++-
 kernel/printk/printk.c   | 81 ++++++++++++++++++++++++++++++++--------
 3 files changed, 78 insertions(+), 20 deletions(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.47.3


