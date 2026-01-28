Return-Path: <stable+bounces-212125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF79OYcvemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:47:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2EA468B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E4F312ECDE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDFC26ED48;
	Wed, 28 Jan 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AOmJT8gv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B142512FF;
	Wed, 28 Jan 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614477; cv=none; b=f2pWgnL8VlHFr7+IBNdBryCsGfPQEJ9cTXEHjo4tBq8dzwPqSzMDB+c/InA2hVR9Fi+aqd8wBRBLLdvr0GrPpKpyAu0tSlTq0IBz85O9b882IkXEfnwSWHJuS3hNvUEY8XiPzfHvIQTQr/aUE9ade54N8y31Ruy3YRzs8yeRemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614477; c=relaxed/simple;
	bh=hcSfOCpwLmYzW2mcW1tkWK9ZiO8ZJIw9W0KSu6KSVyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7Ux3yeXC1zup3Yk+lJy8P2Mz26fjgvuX9MvZ+49TkA4eg8evJxnPC7Mjd+2KisKVSN3syCmpyr68rg4xd2pMeleFkT8r29vbjeEfavS5gZJfSuL7J7fIzUM62Jc0yY+6oveU/CHzeCYLHe+Ov/1xBCFcVOnmF1scbK1Zr6cLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AOmJT8gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0925DC4CEF1;
	Wed, 28 Jan 2026 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614477;
	bh=hcSfOCpwLmYzW2mcW1tkWK9ZiO8ZJIw9W0KSu6KSVyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOmJT8gvLPlDEoIcmAnClbeTSTF413mi+OR/uQ/0oBoSYmWBNoIN8OMEzrvrXnZFc
	 dtglRaqegOiUVbX6ZHhGXI5vvGxZNKRIvt7OmxqCBtGNPza8uLIkwtRk2BsE9q1Tle
	 DdjEvZQvfEOeipvrB5Lf1hPV6KIih1Uft/Oj97OM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.6 149/254] platform/x86: hp-bioscfg: Fix kernel panic in GET_INSTANCE_ID macro
Date: Wed, 28 Jan 2026 16:22:05 +0100
Message-ID: <20260128145350.175135087@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212125-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 65F2EA468B
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 25150715e0b049b99df664daf05dab12f41c3e13 upstream.

The GET_INSTANCE_ID macro that caused a kernel panic when accessing sysfs
attributes:

1. Off-by-one error: The loop condition used '<=' instead of '<',
   causing access beyond array bounds. Since array indices are 0-based
   and go from 0 to instances_count-1, the loop should use '<'.

2. Missing NULL check: The code dereferenced attr_name_kobj->name
   without checking if attr_name_kobj was NULL, causing a null pointer
   dereference in min_length_show() and other attribute show functions.

The panic occurred when fwupd tried to read BIOS configuration attributes:

  Oops: general protection fault [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:min_length_show+0xcf/0x1d0 [hp_bioscfg]

Add a NULL check for attr_name_kobj before dereferencing and corrects
the loop boundary to match the pattern used elsewhere in the driver.

Cc: stable@vger.kernel.org
Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260115203725.828434-3-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index 3166ef328eba..6b6748e4be21 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -10,6 +10,7 @@
 
 #include <linux/wmi.h>
 #include <linux/types.h>
+#include <linux/string.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -285,8 +286,9 @@ enum hp_wmi_data_elements {
 	{								\
 		int i;							\
 									\
-		for (i = 0; i <= bioscfg_drv.type##_instances_count; i++) { \
-			if (!strcmp(kobj->name, bioscfg_drv.type##_data[i].attr_name_kobj->name)) \
+		for (i = 0; i < bioscfg_drv.type##_instances_count; i++) { \
+			if (bioscfg_drv.type##_data[i].attr_name_kobj &&	\
+			    !strcmp(kobj->name, bioscfg_drv.type##_data[i].attr_name_kobj->name)) \
 				return i;				\
 		}							\
 		return -EIO;						\
-- 
2.52.0




