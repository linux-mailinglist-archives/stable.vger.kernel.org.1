Return-Path: <stable+bounces-100466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CD9EB74F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C13618857E2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BBE2343C7;
	Tue, 10 Dec 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZraJkHl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D802343B2;
	Tue, 10 Dec 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850092; cv=none; b=oahTLT8fNV/K9Ax/wbkG+GKfiusgpGee2TajRIhTuukRLsyiVQLnBqFj8xlHIv2Kts7Dk0Uuh1joVUAagtEs1Qwo3ZFY0NgjERBfhPqK8w+VIE6DNfu3GyNoT4NHpNNauQLmsIpaOLZPldMpcqKmADDjT99O940LHLPaDbQB6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850092; c=relaxed/simple;
	bh=mm797VLLclLeTXWrwP+BE1WcPEE0w5px/U8Ti5uzt0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CetRgBe+Tk6K/PU7wThAuWGlCjUn16XiK2UKix5dZWKQgaKf/6dGu7g2ZfNtoKGz2xpvASVgyefWu1T3y9JrgbaRJf85azXZfme4WQE4Jjg8LIaOZ5MfCJQfNbbGl7oSxuEv6Ciowqr4BEiLadcS8AqqwUX6tILXOzUFQYX5hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZraJkHl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733850091; x=1765386091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mm797VLLclLeTXWrwP+BE1WcPEE0w5px/U8Ti5uzt0c=;
  b=WZraJkHlo2B0W1oUcZBOU5gsJdN/QWf/WGjlc4JDT6FBfQQoMMcbVqmx
   fKYNLHgg1Ah2agAQbBJDXeW03pLdRRXcYidABffYZxNQdDYXmsxWJuzjK
   hmuaZsLAdzbMxR712bFDEPXtdfHTsYfJ0dwbKT0OIvnJpoK0PGSEyWQI3
   ib6tm8ogQlZYTc51yFGB6kKHNvKvu4tGnv0Y31rPP/JnNKL11E2KyuHFo
   kdmSv9mq0wN7gUE/JzUgDVkiTyqVyWVIwovolUGNqGR0dZR96uMVErpcc
   tzV8uVlBrMsrx/OOoVy6xrXMxGUe6FOfLII2eTcFqZ+b8+90kgV3oDBwS
   g==;
X-CSE-ConnectionGUID: S8EiuTuBTIOcsbbvll5GwQ==
X-CSE-MsgGUID: RwP32CUgRu+Q/5eK/+UAtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44677705"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="44677705"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 09:01:30 -0800
X-CSE-ConnectionGUID: ikSGikKxRnK9sH1BZXOOSQ==
X-CSE-MsgGUID: 2V8mswXgQxWurh/hShNgrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100532132"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 09:01:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] tty: serial: 8250: Fix another runtime PM usage counter underflow
Date: Tue, 10 Dec 2024 19:01:20 +0200
Message-Id: <20241210170120.2231-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit f9b11229b79c ("serial: 8250: Fix PM usage_count for console
handover") fixed one runtime PM usage counter balance problem that
occurs because .dev is not set during univ8250 setup preventing call to
pm_runtime_get_sync(). Later, univ8250_console_exit() will trigger the
runtime PM usage counter underflow as .dev is already set at that time.

Call pm_runtime_get_sync() to balance the RPM usage counter also in
serial8250_register_8250_port() before trying to add the port.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Fixes: bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
Cc: <stable@vger.kernel.org>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v2:
- Added tags

 drivers/tty/serial/8250/8250_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..68baf75bdadc 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -812,6 +812,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart->dl_write = up->dl_write;
 
 		if (uart->port.type != PORT_8250_CIR) {
+			if (uart_console_registered(&uart->port))
+				pm_runtime_get_sync(uart->port.dev);
+
 			if (serial8250_isa_config != NULL)
 				serial8250_isa_config(0, &uart->port,
 						&uart->capabilities);
-- 
2.39.5


