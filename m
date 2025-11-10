Return-Path: <stable+bounces-192925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7288C460EE
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88B144E9B7D
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5573074A7;
	Mon, 10 Nov 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTOlzGjk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AC306492;
	Mon, 10 Nov 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771858; cv=none; b=NZ8Hi19N8EBNuQ00KWUWcvqRyA/RzK7qz7MO0jG/SNt/kYxCzfvb1zXgowKAxmdH05gtQWvyRNS2oY9Z4W0/yt+iOD0q4KexxGPrYOtFe3FWkt5lrLQVw+VLGKgymzzlPDf+UIwxHhZXLB9wFHMI569o9IExuRX5TsH5FoyGqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771858; c=relaxed/simple;
	bh=SxLpJRCLNbGRJQQxfNl9Sjq3Ybg28Uj5WOePADjH8Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QxRqBLdFIDcylHD/vZJuAHYTEsfTpeu4vUJc8ZI6Q9VnBaDqOFI3/shmtRcZ9eVvR2B5lAXuFf4qlV2wts6bcya+/0uYX2pHfWr/c2XORBRQnew3KXOWi3ec0Ij0NFzzKWCxQ1jJBhQolpmbbZ43iOZxkp/VB3nsEsvFpmOQGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTOlzGjk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771856; x=1794307856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SxLpJRCLNbGRJQQxfNl9Sjq3Ybg28Uj5WOePADjH8Jg=;
  b=cTOlzGjkAPqNHFRl2Q7zUCsZK/6qHlCv0bnY2Y3INl+sAfF1Du78IDPp
   w+dXehF81ja1a06yo3IdSGuPmmrasqM9pgP05daFDzU5Rvfi96K/PbE+8
   WQ9K2LhCHhB80OdqbJOjXWZZ/C8w7SF/hkgNFnqriizIduBNIZehJtjSp
   fbPL8rr+Pq5zkZFNmn+EQDCI1dOZMCCb6K4ZqNaUWDTaBJeKfRBkp+QRo
   wPxtx1P4+PeQ0+jeKjuuG1/uFYpzqvfOra/xhqieQtBaEU0tex+mfx3XF
   7pl6aamyrC5AZE8gXDz4DRonmA4SGqCnPn0oTo+5KoNig7zyYz/8T0R5N
   Q==;
X-CSE-ConnectionGUID: VYAapwTyS2S5Vk5lYBVndg==
X-CSE-MsgGUID: GXkB9cDqQnqV9Bp2vSE8ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75925574"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75925574"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:50:56 -0800
X-CSE-ConnectionGUID: LLRhveABRwWVw52PFBWn2A==
X-CSE-MsgGUID: QReF50qTSe2FD+S9BQAV2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188286919"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:50:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Alex Davis <alex47794@gmail.com>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] serial: 8250: Fix 8250_rsa symbol loop
Date: Mon, 10 Nov 2025 12:50:43 +0200
Message-Id: <20251110105043.4062-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Depmod fails for a kernel made with:
  make allnoconfig
  echo -e "CONFIG_MODULES=y\nCONFIG_SERIAL_8250=m\nCONFIG_SERIAL_8250_EXTENDED=y\nCONFIG_SERIAL_8250_RSA=y" >> .config 
  make olddefconfig

...due to a dependency loop:

  depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
  depmod: ERROR: Found 2 modules in dependency cycles!

This is caused by the move of 8250 RSA code from 8250_port.c (in
8250_base.ko) into 8250_rsa.c (in 8250.ko) by the commit 5a128fb475fb
("serial: 8250: move RSA functions to 8250_rsa.c"). The commit
b20d6576cdb3 ("serial: 8250: export RSA functions") tried to fix a
missing symbol issue with EXPORTs but those then cause this dependency
cycle.

Break dependency loop by moving 8250_rsa.o from 8250.ko to 8250_base.ko
and by passing univ8250_port_base_ops to univ8250_rsa_support() that
can make a local copy of it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Alex Davis <alex47794@gmail.com>
Fixes: 5a128fb475fb ("serial: 8250: move RSA functions to 8250_rsa.c")
Fixes: b20d6576cdb3 ("serial: 8250: export RSA functions")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/87frc3sd8d.fsf@posteo.net/
Link: https://lore.kernel.org/all/CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

in thread -> v1:
- Changed prototype also in the #else block

 drivers/tty/serial/8250/8250.h          |  4 ++--
 drivers/tty/serial/8250/8250_platform.c |  2 +-
 drivers/tty/serial/8250/8250_rsa.c      | 26 ++++++++++++++++---------
 drivers/tty/serial/8250/Makefile        |  2 +-
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 58e64c4e1e3a..e99f5193d8f1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -322,13 +322,13 @@ static inline void serial8250_pnp_exit(void) { }
 #endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
-void univ8250_rsa_support(struct uart_ops *ops);
+void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops);
 void rsa_enable(struct uart_8250_port *up);
 void rsa_disable(struct uart_8250_port *up);
 void rsa_autoconfig(struct uart_8250_port *up);
 void rsa_reset(struct uart_8250_port *up);
 #else
-static inline void univ8250_rsa_support(struct uart_ops *ops) { }
+static inline void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops) { }
 static inline void rsa_enable(struct uart_8250_port *up) {}
 static inline void rsa_disable(struct uart_8250_port *up) {}
 static inline void rsa_autoconfig(struct uart_8250_port *up) {}
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index b27981340e76..fe7ec440ffa5 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -75,7 +75,7 @@ static void __init __serial8250_isa_init_ports(void)
 
 	/* chain base port ops to support Remote Supervisor Adapter */
 	univ8250_port_ops = *univ8250_port_base_ops;
-	univ8250_rsa_support(&univ8250_port_ops);
+	univ8250_rsa_support(&univ8250_port_ops, univ8250_port_base_ops);
 
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index 40a3dbd9e452..1f182f165525 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -14,6 +14,8 @@
 static unsigned long probe_rsa[PORT_RSA_MAX];
 static unsigned int probe_rsa_count;
 
+static const struct uart_ops *core_port_base_ops;
+
 static int rsa8250_request_resource(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
@@ -67,7 +69,7 @@ static void univ8250_config_port(struct uart_port *port, int flags)
 		}
 	}
 
-	univ8250_port_base_ops->config_port(port, flags);
+	core_port_base_ops->config_port(port, flags);
 
 	if (port->type != PORT_RSA && up->probe & UART_PROBE_RSA)
 		rsa8250_release_resource(up);
@@ -78,11 +80,11 @@ static int univ8250_request_port(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
-	ret = univ8250_port_base_ops->request_port(port);
+	ret = core_port_base_ops->request_port(port);
 	if (ret == 0 && port->type == PORT_RSA) {
 		ret = rsa8250_request_resource(up);
 		if (ret < 0)
-			univ8250_port_base_ops->release_port(port);
+			core_port_base_ops->release_port(port);
 	}
 
 	return ret;
@@ -94,15 +96,25 @@ static void univ8250_release_port(struct uart_port *port)
 
 	if (port->type == PORT_RSA)
 		rsa8250_release_resource(up);
-	univ8250_port_base_ops->release_port(port);
+	core_port_base_ops->release_port(port);
 }
 
-void univ8250_rsa_support(struct uart_ops *ops)
+/*
+ * It is not allowed to directly reference any symbols from 8250.ko here as
+ * that would result in a dependency loop between the 8250.ko and
+ * 8250_base.ko modules. This function is called from 8250.ko and is used to
+ * break the symbolic dependency cycle. Anything that is needed from 8250.ko
+ * has to be passed as pointers to this function which then can adjust those
+ * variables on 8250.ko side or store them locally as needed.
+ */
+void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *core_ops)
 {
+	core_port_base_ops = core_ops;
 	ops->config_port  = univ8250_config_port;
 	ops->request_port = univ8250_request_port;
 	ops->release_port = univ8250_release_port;
 }
+EXPORT_SYMBOL_FOR_MODULES(univ8250_rsa_support, "8250");
 
 module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
@@ -146,7 +158,6 @@ void rsa_enable(struct uart_8250_port *up)
 	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 		serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_enable, "8250_base");
 
 /*
  * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
@@ -178,7 +189,6 @@ void rsa_disable(struct uart_8250_port *up)
 	if (result)
 		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_disable, "8250_base");
 
 void rsa_autoconfig(struct uart_8250_port *up)
 {
@@ -191,7 +201,6 @@ void rsa_autoconfig(struct uart_8250_port *up)
 	if (__rsa_enable(up))
 		up->port.type = PORT_RSA;
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_autoconfig, "8250_base");
 
 void rsa_reset(struct uart_8250_port *up)
 {
@@ -200,7 +209,6 @@ void rsa_reset(struct uart_8250_port *up)
 
 	serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_reset, "8250_base");
 
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 513a0941c284..9ec4d5fe64de 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o
 8250-y					:= 8250_core.o
 8250-y					+= 8250_platform.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
-8250-$(CONFIG_SERIAL_8250_RSA)		+= 8250_rsa.o
 
 obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-y				:= 8250_port.o
@@ -15,6 +14,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
+8250_base-$(CONFIG_SERIAL_8250_RSA)	+= 8250_rsa.o
 
 obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 

base-commit: 719f3df3e113e03d2c8cf324827da1fd17a9bd8f
-- 
2.39.5


