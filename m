Return-Path: <stable+bounces-175198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD8B3670F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C6D1BC8332
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4C350D52;
	Tue, 26 Aug 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/1XfuBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828F299A94;
	Tue, 26 Aug 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216400; cv=none; b=KmthsrIlkQz0BSTObMhk5f8HGJGGK7akNPgHNZd7/sHpM4ddU62iifx02NyfGtcVJ+lKBWNbxa6VPiA/A1eqE27HfyPMrhVtc7h8AGr+GaGyMRjoIb/1nLcEBq0TGKcG6v7cxqRUQRwwXw9uDZ0UpgB9UEnidJhkHv6FV0TKpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216400; c=relaxed/simple;
	bh=bHwNT7kO5f4EC/hIuUObZ8IzohljjdJ7FZIr89MmcFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN2L/x7JltGEbdFpzHjYhAa3X9mR+0g8NJ74L568NcQitdAApSmLrNUQPCN+R1uspSg8d0wPjfWzNcqMK5XiKBfmkCuHhLDG7Gci7lSmYE7JXsoVSmRQBkXHmHHVIYBhUnmIhUEDNTtfELlCP5YzQ/LHrc1avZ8mMVQva6w/Kr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/1XfuBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313B5C4CEF1;
	Tue, 26 Aug 2025 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216399;
	bh=bHwNT7kO5f4EC/hIuUObZ8IzohljjdJ7FZIr89MmcFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/1XfuBDP281BdXwNKDSIoe+CjUgUqoJaOsxYLyhjp5cAAp1rBW+cj/yVhdjj5TP2
	 cdFNWTNPANLmZI9pc2ggY+WVPpnrK0SUJPj+Kd9FVs9G1T7HaZS4KCCPTA9oHWx7wi
	 d1Hdx8Yy6DMcATiqJnmavBKoQsUT4qwysasN11R0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 353/644] s390/stp: Remove udelay from stp_sync_clock()
Date: Tue, 26 Aug 2025 13:07:24 +0200
Message-ID: <20250826110955.145394291@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit b367017cdac21781a74eff4e208d3d38e1f38d3f ]

When an stp sync check is handled on a system with multiple
cpus each cpu gets a machine check but only the first one
actually handles the sync operation. All other CPUs spin
waiting for the first one to finish with a short udelay().
But udelay can't be used here as the first CPU modifies tod_clock_base
before performing the sync op. During this timeframe
get_tod_clock_monotonic() might return a non-monotonic time.

The time spent waiting should be very short and udelay is a busy loop
anyways, therefore simply remove the udelay.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index f0a1484ee00b..58cdd4119f45 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -576,7 +576,7 @@ static int stp_sync_clock(void *data)
 		atomic_dec(&sync->cpus);
 		/* Wait for in_sync to be set. */
 		while (READ_ONCE(sync->in_sync) == 0)
-			__udelay(1);
+			;
 	}
 	if (sync->in_sync != 1)
 		/* Didn't work. Clear per-cpu in sync bit again. */
-- 
2.39.5




