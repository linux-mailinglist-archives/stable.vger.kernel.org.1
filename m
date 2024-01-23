Return-Path: <stable+bounces-14225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563F83800B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50732897BB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483326519C;
	Tue, 23 Jan 2024 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5FikxKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6964CFA;
	Tue, 23 Jan 2024 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971517; cv=none; b=JsUBdHHF19uEGsz/2/pPQJkIpeYa3ZMCdjGD8/qC8NG9qvnzo1iUxZE58Yu2Oon+3qt4Syxjwny4yud83I+EMLfzTzkLAT6tLF5MH410IvXHL0E5xSuswsLFnZZU8KMyAeujH0dKuJko32d+Ls1WXbPJJqRpW0B+5mdZz4Dgt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971517; c=relaxed/simple;
	bh=dDuGyux5xOgn63eU5LkWCt8Wi9pCQoZrF93N8COYXu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyVaxTiYorR5EVxJrRHMu46IglCr8eAwMJWkeMhfhb2oc1wswA5z5KbhVNRnt+T/AN5fON9KGnKSqP5/QYJeim9FT49ng7HzeEF0nT0tgPtWwDulSWVze+KNKiQqkJLc6kszzYvHhg50y4uMVZJIx3sJEZph55Fg9Jv816AKTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5FikxKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE24C433F1;
	Tue, 23 Jan 2024 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971516;
	bh=dDuGyux5xOgn63eU5LkWCt8Wi9pCQoZrF93N8COYXu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5FikxKBBZYTI0Ijx882BdlEqEpn+XhmtUA+g40V6hCAlQiSI+R3KeZkBAf8ghUtf
	 /+x48qX6RTpkuzpXPWWEH0Ug4PZsmkvoGu5OV1Q0yjhBYrwfBy2Guj2zXtscxkHCxb
	 vkKftXpNhIyk/TtIQZjuZLnPQFnVQqh/sAVmMOFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.1 256/417] clocksource/drivers/timer-ti-dm: Fix make W=n kerneldoc warnings
Date: Mon, 22 Jan 2024 15:57:04 -0800
Message-ID: <20240122235800.747631416@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit b99a212a7697c542b460adaa15d4a98abf8223f0 upstream.

Kernel test robot reports of kerneldoc related warnings that happen with
make W=n for "parameter or member not described".

These were caused by changes to function parameter names with
earlier commits where the kerneldoc parts were not updated.

Fixes: 49cd16bb573e ("clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_write()")
Fixes: a6e543f61531 ("clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311040403.DzIiBuwU-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202311040606.XL5OcR9O-lkp@intel.com/
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231114072930.40615-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-ti-dm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -184,7 +184,7 @@ static inline u32 dmtimer_read(struct dm
  * dmtimer_write - write timer registers in posted and non-posted mode
  * @timer:      timer pointer over which write operation is to perform
  * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
+ * @val:        data to write into the register
  *
  * The posted mode bit is encoded in reg. Note that in posted mode, the write
  * pending bit must be checked. Otherwise a write on a register which has a
@@ -937,7 +937,7 @@ static int omap_dm_timer_set_int_enable(
 
 /**
  * omap_dm_timer_set_int_disable - disable timer interrupts
- * @timer:	pointer to timer handle
+ * @cookie:	pointer to timer cookie
  * @mask:	bit mask of interrupts to be disabled
  *
  * Disables the specified timer interrupts for a timer.



