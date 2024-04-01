Return-Path: <stable+bounces-35214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD18942F5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA7A1C21A75
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73914D9F2;
	Mon,  1 Apr 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2M0pOAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6C4CE0F;
	Mon,  1 Apr 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990669; cv=none; b=rnbp8QcZZ1zx3MncWXg3/Vr12nBA6UhWG088uaBJ9eW5mFbybjBWrLbAOlufoWFB6e2moA7uXag2377JDSaZxtKD52WDq8/eof086zXRYueH+FnYlXV1RbpDueUkjRtdpLsV4CPNJr/V9oMpzEkd55wEdePYQ/L/kGuQwNZh4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990669; c=relaxed/simple;
	bh=vbkcn7ZPVOFe+T0pbYnZICv7DaPwxmMe8trSubjm8H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjjGeIkUytv7bwU78p20geTe8CijbfyPjQdCkAtRrD/SEaBHQweK++e6y2IFk/pDcwjR3awbavx/EV7fbLoJqYQZi+zAmJxpCGFnRNuXXsBB/7CcU69hO0vU9xcrq9KlipUDsHWwkqGPUlptjfIZYRWG69vCA8J40f0zcXzeBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2M0pOAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5321C433F1;
	Mon,  1 Apr 2024 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990669;
	bh=vbkcn7ZPVOFe+T0pbYnZICv7DaPwxmMe8trSubjm8H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2M0pOAdoc1c7RLWntY2n3rdIgp9FuGwlnanKtZNoeDKftx+rfTv9zJYRo0HL+hdQ
	 +TACdnf6AuMZpW258RgQ+jwg3+LpemPBut1FyM3Eqr2Z1oNV0LtEMAIKHGGyOrrujE
	 02kkj/DfWYSxUZ0cYi4O1eyUf7bxzTtfUzlPx6o8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Igor Zhbanov <izh1979@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/272] sparc64: NMI watchdog: fix return value of __setup handler
Date: Mon,  1 Apr 2024 17:43:40 +0200
Message-ID: <20240401152531.298022528@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 3ed7c61e49d65dacb96db798c0ab6fcd55a1f20f ]

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) argument or environment
strings. Also, error return codes don't mean anything to
obsolete_checksetup() -- only non-zero (usually 1) or zero.
So return 1 from setup_nmi_watchdog().

Fixes: e5553a6d0442 ("sparc64: Implement NMI watchdog on capable cpus.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <izh1979@gmail.com>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240211052802.22612-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305c..fbf25e926f67c 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -274,7 +274,7 @@ static int __init setup_nmi_watchdog(char *str)
 	if (!strncmp(str, "panic", 5))
 		panic_on_timeout = 1;
 
-	return 0;
+	return 1;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-- 
2.43.0




