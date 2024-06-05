Return-Path: <stable+bounces-48224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328D8FCEA3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 15:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D341282B4F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83841922C3;
	Wed,  5 Jun 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G/5FfIjC"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C419D8BF;
	Wed,  5 Jun 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590694; cv=none; b=JtXPueJTivFrbexGB6ho6n/BlzminXhECwfP0+I6yhLNS+44EF/F5wEnzLVKeLDnAa5GWwUIdvywd2bEegEIhzBiBzVW3x0iZWSAsOXcp2MDAfKBcIqe1tu4cQ5RnZZvFuIo5FLIHUsOJ4vibFUyI3zE6k4vRPecOvPy2kEnKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590694; c=relaxed/simple;
	bh=8wCbswTUyjgATJQMZFOcOQSj2SvgCR9t7N9JPOs+xYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pz4uWMMElc1dB1HKnZE3FGzzGU6KHnI8WxJ//GueSqUD24495tjarNv6316RSxUF+uR9lJYj8UNyWHMEro9N/SLnjelpYlYsQyV63wDI7TDK6haVoF4ilzOw2zWN2VDZmV14iWnpZKx4O8dK77BZHfW4mYrh4ToN1GYCyDwtQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G/5FfIjC; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E2BC6C0000FC;
	Wed,  5 Jun 2024 05:31:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E2BC6C0000FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1717590692;
	bh=8wCbswTUyjgATJQMZFOcOQSj2SvgCR9t7N9JPOs+xYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/5FfIjCvzy5t0lK/3DHgtuIAOoreDNAzXzTaZpEhe0IQfBxdLgye2c3qow3o1oPt
	 /tPGCytNO/h3tTzRZS4GNo86uDMKGfLqp0etZ061o1ssHV7gE7xLkvURwNCUsLCtz1
	 93bhgEi6qGHnmdwWkY3RQAQuPxg/n+Hg5HYRI/f4=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B8F2B18041CAC6;
	Wed,  5 Jun 2024 05:31:29 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Christian Brauner <brauner@kernel.org>,
	Hao Ge <gehao@kylinos.cn>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Helge Deller <deller@gmx.de>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list),
	kapil.hali@broadcom.com,
	justin.chen@broadcom.com
Subject: [PATCH stable 6.1] scripts/gdb: fix SB_* constants parsing
Date: Wed,  5 Jun 2024 05:31:28 -0700
Message-Id: <20240605123128.3524629-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605123128.3524629-1-florian.fainelli@broadcom.com>
References: <20240605123128.3524629-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6a59cb5158bff13b80f116305155fbe4967a5010 upstrean

--0000000000009a0c9905fd9173ad
Content-Transfer-Encoding: 8bit

After f15afbd34d8f ("fs: fix undefined behavior in bit shift for
SB_NOUSER") the constants were changed from plain integers which
LX_VALUE() can parse to constants using the BIT() macro which causes the
following:

Reading symbols from build/linux-custom/vmlinux...done.
Traceback (most recent call last):
  File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/vmlinux-gdb.py", line 25, in <module>
    import linux.constants
  File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/scripts/gdb/linux/constants.py", line 5
    LX_SB_RDONLY = ((((1UL))) << (0))

Use LX_GDBPARSED() which does not suffer from that issue.

Fixes: f15afbd34d8f ("fs: fix undefined behavior in bit shift for SB_NOUSER")
Link: https://lkml.kernel.org/r/20230607221337.2781730-1-florian.fainelli@broadcom.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Cc: Hao Ge <gehao@kylinos.cn>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 scripts/gdb/linux/constants.py.in | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 08f0587d15ea..0ff707bc1896 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -46,12 +46,12 @@ if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
 
 /* linux/fs.h */
-LX_VALUE(SB_RDONLY)
-LX_VALUE(SB_SYNCHRONOUS)
-LX_VALUE(SB_MANDLOCK)
-LX_VALUE(SB_DIRSYNC)
-LX_VALUE(SB_NOATIME)
-LX_VALUE(SB_NODIRATIME)
+LX_GDBPARSED(SB_RDONLY)
+LX_GDBPARSED(SB_SYNCHRONOUS)
+LX_GDBPARSED(SB_MANDLOCK)
+LX_GDBPARSED(SB_DIRSYNC)
+LX_GDBPARSED(SB_NOATIME)
+LX_GDBPARSED(SB_NODIRATIME)
 
 /* linux/htimer.h */
 LX_GDBPARSED(hrtimer_resolution)
-- 
2.34.1


