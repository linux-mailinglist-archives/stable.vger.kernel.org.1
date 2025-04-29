Return-Path: <stable+bounces-138421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E8AA1839
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43F13A7AB6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4821024DFF3;
	Tue, 29 Apr 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gkvl+4pk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052962B2DA;
	Tue, 29 Apr 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949201; cv=none; b=jBekPVXP+GF44K8e9RqVeadg71DWHGxlW3XZOS/KZ6OIihDg4knBh0SP241/wlZ9jSBLNNxq6Yq3Or6jgFqhck9c+NguxGLCFAYUxeOGM6j+yRW0bh3fJoprvGocQ2t9eEuJs0Uc35oSS5/W6PjyFEG5GASXfCcv0Zm4O0k+eEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949201; c=relaxed/simple;
	bh=PtYj6urQWA7XV+0nVgQ+JJPviaNnz4jJcVptHtTpMCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVt5/roEEdAuh9Ri38Mtfs9j/w1V+OSa6L7WUzN+/iNmGZukgftUBkO3oWJeAKYKnyiD9/fp44XrR8WKw7+Y17qO9H3gBdbr8+mrkao7GbsWKPr6Hg18Qbl3nMIGEA/+19Lt6fSjqn54wgwl5QL+HCVX97/QzyilycF+MTHjhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gkvl+4pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD15C4CEE3;
	Tue, 29 Apr 2025 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949200;
	bh=PtYj6urQWA7XV+0nVgQ+JJPviaNnz4jJcVptHtTpMCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gkvl+4pkoZD2NQw7nVeG0tku5ovwr6grYPvww3nCMsAsxrTtF+DyuYaktMBiGIh8B
	 ZAx9AkFnKucZnMjyvUNYHGA7D9yvxFMZkLJXFnN3DJT1BnuCydUZ4bFLakTD0ZRxkG
	 rHJhITufwHmXuIp4QA3W8N1QHPhKuGywxNfCgVKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WangYuli <wangyuli@uniontech.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.15 243/373] MIPS: ds1287: Match ds1287_set_base_clock() function types
Date: Tue, 29 Apr 2025 18:42:00 +0200
Message-ID: <20250429161133.125314672@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangYuli <wangyuli@uniontech.com>

commit a759109b234385b74d2f5f4c86b5f59b3201ec12 upstream.

Synchronize the declaration of ds1287_set_base_clock() between
cevt-ds1287.c and ds1287.h.

Fix follow error with gcc-14 when -Werror:

arch/mips/kernel/cevt-ds1287.c:21:5: error: conflicting types for ‘ds1287_set_base_clock’; have ‘int(unsigned int)’
   21 | int ds1287_set_base_clock(unsigned int hz)
      |     ^~~~~~~~~~~~~~~~~~~~~
In file included from arch/mips/kernel/cevt-ds1287.c:13:
./arch/mips/include/asm/ds1287.h:11:13: note: previous declaration of ‘ds1287_set_base_clock’ with type ‘void(unsigned int)’
   11 | extern void ds1287_set_base_clock(unsigned int clock);
      |             ^~~~~~~~~~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:207: arch/mips/kernel/cevt-ds1287.o] Error 1
make[6]: *** [scripts/Makefile.build:465: arch/mips/kernel] Error 2
make[6]: *** Waiting for unfinished jobs....

Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/ds1287.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/ds1287.h
+++ b/arch/mips/include/asm/ds1287.h
@@ -8,7 +8,7 @@
 #define __ASM_DS1287_H
 
 extern int ds1287_timer_state(void);
-extern void ds1287_set_base_clock(unsigned int clock);
+extern int ds1287_set_base_clock(unsigned int hz);
 extern int ds1287_clockevent_init(int irq);
 
 #endif



