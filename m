Return-Path: <stable+bounces-72381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C203967A67
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE07F1C20A5A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDC181334;
	Sun,  1 Sep 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGlkMapR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37711DFD1;
	Sun,  1 Sep 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209737; cv=none; b=ATo7HbyyawjX7LoW+P+fiFq9tF+Lbh7KGurSNu4nLbSUXvOnt2MfQumu5zayJLqEQyN5mbH6fKCodaUQ2xqh2Z+kiF3iwj61e+EPNJn/feJSSNZwbPjhHBtX2sQJXAo+j6q42MSAxtV4kKrmA8JtG15ZuBFSrpFV9UAP/JPCYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209737; c=relaxed/simple;
	bh=2xeqNPZV+PbB9wT6/a2FLfD2Y7erUWa8IUq5/zws5K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olsRDHswBQ58QKMGi+r3uIHh0qFQsCR6iaOuFL+/CrGAVh/3k0+C9IW8bjOxddvPVZe66OT+DlsBwr7NVbbtL/cg52zgxYNsbrtT3wBqNT8rrtiRXN9DNfvy1Kji2JzU4j0IT0YMcOKKTFpTvj2w4Gv5UOAKgC2v5eLEMwOvo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGlkMapR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF4C4CEC3;
	Sun,  1 Sep 2024 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209737;
	bh=2xeqNPZV+PbB9wT6/a2FLfD2Y7erUWa8IUq5/zws5K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGlkMapR0DKOjQD9FaMNZWtlSWPCWvGZUCAbHIOZts7fkbS5Vdrwg0T8hFEbc3VrH
	 5511tP8WlX+ybYEauyPKaARlqnKfVmsZFKfpOVNlJ5FwmN+dS6zWG34gMFNS9yAnyi
	 j9xMfluNisY6oJ9qCL3OR7c7qPj+7hMEAP5Avmt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Saeed Mahameed <saeed@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 098/151] net: dsa: mv88e6xxx: replace ATU violation prints with trace points
Date: Sun,  1 Sep 2024 18:17:38 +0200
Message-ID: <20240901160817.801375829@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 8646384d80f3d3b4a66b3284dbbd8232d1b8799e ]

In applications where the switch ports must perform 802.1X based
authentication and are therefore locked, ATU violation interrupts are
quite to be expected as part of normal operation. The problem is that
they currently spam the kernel log, even if rate limited.

Create a series of trace points, all derived from the same event class,
which log these violations to the kernel's trace buffer, which is both
much faster and much easier to ignore than printing to a serial console.

New usage model:

$ trace-cmd list | grep mv88e6xxx
mv88e6xxx
mv88e6xxx:mv88e6xxx_atu_full_violation
mv88e6xxx:mv88e6xxx_atu_miss_violation
mv88e6xxx:mv88e6xxx_atu_member_violation
$ trace-cmd record -e mv88e6xxx sleep 10

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Saeed Mahameed <saeed@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 528876d867a2 ("net: dsa: mv88e6xxx: Fix out-of-bound access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/Makefile      |  4 ++
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 19 +++----
 drivers/net/dsa/mv88e6xxx/trace.c       |  6 +++
 drivers/net/dsa/mv88e6xxx/trace.h       | 66 +++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/trace.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/trace.h

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index 4b080b448ce74..1f7240e0d6bce 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -15,3 +15,7 @@ mv88e6xxx-objs += port_hidden.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += ptp.o
 mv88e6xxx-objs += serdes.o
 mv88e6xxx-objs += smi.o
+mv88e6xxx-objs += trace.o
+
+# for tracing framework to find trace.h
+CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index b5580042250ff..1a4781a44e0d7 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -12,6 +12,7 @@
 
 #include "chip.h"
 #include "global1.h"
+#include "trace.h"
 
 /* Offset 0x01: ATU FID Register */
 
@@ -435,23 +436,23 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
-		dev_err_ratelimited(chip->dev,
-				    "ATU member violation for %pM fid %u portvec %x spid %d\n",
-				    entry.mac, fid, entry.portvec, spid);
+		trace_mv88e6xxx_atu_member_violation(chip->dev, spid,
+						     entry.portvec, entry.mac,
+						     fid);
 		chip->ports[spid].atu_member_violation++;
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
-		dev_err_ratelimited(chip->dev,
-				    "ATU miss violation for %pM fid %u portvec %x spid %d\n",
-				    entry.mac, fid, entry.portvec, spid);
+		trace_mv88e6xxx_atu_miss_violation(chip->dev, spid,
+						   entry.portvec, entry.mac,
+						   fid);
 		chip->ports[spid].atu_miss_violation++;
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_FULL_VIOLATION) {
-		dev_err_ratelimited(chip->dev,
-				    "ATU full violation for %pM fid %u portvec %x spid %d\n",
-				    entry.mac, fid, entry.portvec, spid);
+		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
+						   entry.portvec, entry.mac,
+						   fid);
 		chip->ports[spid].atu_full_violation++;
 	}
 	mv88e6xxx_reg_unlock(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/trace.c b/drivers/net/dsa/mv88e6xxx/trace.c
new file mode 100644
index 0000000000000..7833cb50ca5d7
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/trace.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright 2022 NXP
+ */
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/net/dsa/mv88e6xxx/trace.h b/drivers/net/dsa/mv88e6xxx/trace.h
new file mode 100644
index 0000000000000..d9ab5c8dee55d
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/trace.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2022 NXP
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	mv88e6xxx
+
+#if !defined(_MV88E6XXX_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MV88E6XXX_TRACE_H
+
+#include <linux/device.h>
+#include <linux/if_ether.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(mv88e6xxx_atu_violation,
+
+	TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		 const unsigned char *addr, u16 fid),
+
+	TP_ARGS(dev, spid, portvec, addr, fid),
+
+	TP_STRUCT__entry(
+		__string(name, dev_name(dev))
+		__field(int, spid)
+		__field(u16, portvec)
+		__array(unsigned char, addr, ETH_ALEN)
+		__field(u16, fid)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, dev_name(dev));
+		__entry->spid = spid;
+		__entry->portvec = portvec;
+		memcpy(__entry->addr, addr, ETH_ALEN);
+		__entry->fid = fid;
+	),
+
+	TP_printk("dev %s spid %d portvec 0x%x addr %pM fid %u",
+		  __get_str(name), __entry->spid, __entry->portvec,
+		  __entry->addr, __entry->fid)
+);
+
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_member_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_miss_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_full_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
+#endif /* _MV88E6XXX_TRACE_H */
+
+/* We don't want to use include/trace/events */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE	trace
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.43.0




