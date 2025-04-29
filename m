Return-Path: <stable+bounces-137268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B201AA1278
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC29E4A7547
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0A2522A0;
	Tue, 29 Apr 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="soZ23cHg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D0215060;
	Tue, 29 Apr 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945563; cv=none; b=Izca4QyI67CYE03oaCVVEqhW6dA/Ob/Dw3kCu9C6tFEMyajDiE9N+748iwP1oWWlvRUnd2jJWVdjMT/TdjtuzaMQDIladC61YSf9S3L4SfagMnYe5pUN9LDIUbsrTUQmhNTmXxNQQcmnn1Id/hQ2Fxb2eLWhuhs7ocTzBh19vus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945563; c=relaxed/simple;
	bh=7bQW4V55G8gJeBepH8slSrRJOfKtoZeJs5i/LR/k1ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggYN9z7XwvljBqNKU6MK96Wx2erH2xSMNTnWxYSJRj6kfcJZqVdlg6l/Uh6aLfeBhKnThYmJ0tbtQW1qByLkctlBoxTKL3miX0Yvf0H5d6P754w8qgIVj49GVj5pncjn5E/72cLttjy279/t32hCVDLUGU67oiNgTrTikT0rEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=soZ23cHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41278C4CEE3;
	Tue, 29 Apr 2025 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945563;
	bh=7bQW4V55G8gJeBepH8slSrRJOfKtoZeJs5i/LR/k1ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soZ23cHglA/IqXnvwXTLRKmnn1dL8vzhQyaTRCpogP+k6W/1yHH5sISIcqNrZJYzY
	 o8Zx6iD0zyT4XPjM/Kx5uyXUaJZthpdXBq+Z8v6P2LgI5oGca4D7LALnGMd++9uCNW
	 BCZ1dn8F9t64ryPmEybmc5kPrsM+OuNtkjbOU8m8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WangYuli <wangyuli@uniontech.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.4 125/179] MIPS: cevt-ds1287: Add missing ds1287.h include
Date: Tue, 29 Apr 2025 18:41:06 +0200
Message-ID: <20250429161054.453023004@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangYuli <wangyuli@uniontech.com>

commit f3be225f338a578851a7b607a409f476354a8deb upstream.

Address the issue of cevt-ds1287.c not including the ds1287.h header
file.

Fix follow errors with gcc-14 when -Werror:

arch/mips/kernel/cevt-ds1287.c:15:5: error: no previous prototype for ‘ds1287_timer_state’ [-Werror=missing-prototypes]
   15 | int ds1287_timer_state(void)
      |     ^~~~~~~~~~~~~~~~~~
arch/mips/kernel/cevt-ds1287.c:20:5: error: no previous prototype for ‘ds1287_set_base_clock’ [-Werror=missing-prototypes]
   20 | int ds1287_set_base_clock(unsigned int hz)
      |     ^~~~~~~~~~~~~~~~~~~~~
arch/mips/kernel/cevt-ds1287.c:103:12: error: no previous prototype for ‘ds1287_clockevent_init’ [-Werror=missing-prototypes]
  103 | int __init ds1287_clockevent_init(int irq)
      |            ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[7]: *** [scripts/Makefile.build:207: arch/mips/kernel/cevt-ds1287.o] Error 1
make[7]: *** Waiting for unfinished jobs....
make[6]: *** [scripts/Makefile.build:465: arch/mips/kernel] Error 2
make[6]: *** Waiting for unfinished jobs....

Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/cevt-ds1287.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -10,6 +10,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/irq.h>
 
+#include <asm/ds1287.h>
 #include <asm/time.h>
 
 int ds1287_timer_state(void)



