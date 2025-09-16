Return-Path: <stable+bounces-179756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45752B5A3DC
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 23:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465A97AC8CB
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490F2F9D84;
	Tue, 16 Sep 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iLi1snbH"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0B2EB843;
	Tue, 16 Sep 2025 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057831; cv=none; b=YwZP+w1fGpQhlx+cTkbK70JEw7QZELBxGpjICgG861Q1sb/eS2zYrKeO5FtVISkY/TX3nryiaVgdywu3G/o8w3uEup9hKNmOrw4aQrVT95+2iW20IMWI0H1BtnYOQKYrtD7Mrc/3pbjQltUEGtwqO9J9696Cf4TkUFDHN6xEDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057831; c=relaxed/simple;
	bh=qu5NPOoj4/tdb6Uw4LU8hdbQALqPg+iydidsVCdVyU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDUFjvP5j1vgmdl6mlk7IULfXKWx6WyW8sBRGV94JIT2hSrB7zkE2uo3A8Z9Jz8fgeSucWXmG8nyxsyWBYjm5YV4m79jfrdLnL05HhGgqSDAd958Ut0gW/i8WKQmzfWUZVPXP1CJrGr6eslWRBvHnGjrfR50rbJrYiqPaYwO1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iLi1snbH; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758057829; x=1789593829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhQYZdk1Wr9Ha73ThGSgmqGxgvkrHIGP/X4+XoRoivU=;
  b=iLi1snbHg/6Rl0km7mpm4yYAIRkb+hzU6qZK1l9eLWl4rqcJQTP5ajT4
   LvMjxpgkl6CSzfFoAKnyPsnnmP7NR9fJ3uJpkua845+nkg7+4ourtKELE
   3uNCtUvjd+/ayK9j7I/OG4iBlf1J6YjLH0qjucRxrFsq0F9xs07hxmfjQ
   BKJ9vdFXnE6w1IgNFjG++Kd1V9hyx6BLpyHTqX4Iu2H+T7c4CAznfh/JQ
   PpaoWqpknsr0h3UTKgP0m4fcaZCAmdCmfXY/YMqI8V3bO3BpfHeJ9kHzk
   IYPpMg5U7f+8FGDxX0IAO9O4SbObFnRt3k7yGkL4bCxwsJ6KKx5gMiG6X
   g==;
X-CSE-ConnectionGUID: TvlITz2xTJSLgvypSPnrxw==
X-CSE-MsgGUID: bIkHTJOSQCidMroP5cy/5A==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2110684"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:23:39 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:27889]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.39.25:2525] with esmtp (Farcaster)
 id be11a1b2-cf9f-4023-881c-87afa0491e77; Tue, 16 Sep 2025 21:23:39 +0000 (UTC)
X-Farcaster-Flow-ID: be11a1b2-cf9f-4023-881c-87afa0491e77
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 21:23:36 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 16 Sep 2025
 21:23:31 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>, <sj@kernel.org>,
	<David.Laight@ACULAB.COM>, <Jason@zx2c4.com>,
	<andriy.shevchenko@linux.intel.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-sparse@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, <stable@vger.kernel.org>,
	"Herve Codina" <herve.codina@bootlin.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>
Subject: [PATCH 4/7 5.10.y] minmax: fix header inclusions
Date: Tue, 16 Sep 2025 21:22:56 +0000
Message-ID: <20250916212259.48517-5-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916212259.48517-1-farbere@amazon.com>
References: <20250916212259.48517-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit f6e9d38f8eb00ac8b52e6d15f6aa9bcecacb081b upstream.

BUILD_BUG_ON*() macros are defined in build_bug.h.  Include it.  Replace
compiler_types.h by compiler.h, which provides the former, to have a
definition of the __UNIQUE_ID().

Link: https://lkml.kernel.org/r/20230912092355.79280-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f6e9d38f8eb00ac8b52e6d15f6aa9bcecacb081b)
Signed-off-by: SeongJae Park <sj@kernel.org>
[Fix a conflict due to absence of compiler_types.h include]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index abdeae409dad..e8e9642809e0 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/const.h>
 
 /*
-- 
2.47.3


