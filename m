Return-Path: <stable+bounces-216288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AtwCTVnj2k+QwEAu9opvQ
	(envelope-from <stable+bounces-216288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:02:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90D138CA4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF1B43037C17
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91934285C9D;
	Fri, 13 Feb 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+/XLghw"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834126AC3;
	Fri, 13 Feb 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005740; cv=none; b=jR8tNUbhOGyqPz8J7hJRiIbPvPVFlmwfN6/237VHNUfVt/cLSB1epFHW7bVml2kXQbLBCccq24nEs44Mamw3Aj8fA8nHHsGb5wIgJMKRSjXXjJAETUPLSZ6w9T+ZAdt7RDLNmyXORt9N9I8IaGql4kfPbgYcxs0CXpQpheap3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005740; c=relaxed/simple;
	bh=T3H/rqZoAbTeAnPTNpF0gFaeTaj6/jZHM6Tp0VHclZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPgDMeWaIzTJyiBe5s8zGg+HL2VhZyjWCeqsrQLs+5tI6LcOpK7NjI0qhlLkN8a8ylBOFyB/4V+EfrWf7Ie2bT+OAxlZDWbUpRZ1Wpu7rfjhu3iqo+Bn8gRMQrm+Fv9kJpMEG5ugawFuTBaB0N+ylVHo+mRvrJjFZmZyUnQO6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C+/XLghw; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AF743C0009CE;
	Fri, 13 Feb 2026 09:57:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AF743C0009CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1771005424;
	bh=T3H/rqZoAbTeAnPTNpF0gFaeTaj6/jZHM6Tp0VHclZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+/XLghwxfchni9o8dMUhYYwk0qw2ObvRrQVl8z4qD9STw6vjzvHlbYowwZ3NPa64
	 R5UYhCKr/yY183iaJQbVAr8PDsMKBkbFLIOPnwrUdtVxHoNxThkDBnYZktjp/Z+ok3
	 Y9zYBCL3oa/PuHQtd2MQB9FySPnWGvpBJPLoxOMM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id D2B1EAE93;
	Fri, 13 Feb 2026 12:57:03 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 6.1 2/2] cacheinfo: Remove of_node_put() for fw_token
Date: Fri, 13 Feb 2026 09:57:00 -0800
Message-Id: <20260213175700.1964980-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213175700.1964980-1-florian.fainelli@broadcom.com>
References: <20260213175700.1964980-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[broadcom.com:query timed out,linuxfoundation.org:query timed out];
	TAGGED_FROM(0.00)[bounces-216288-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,samsung.com:email,linux-m68k.org:email]
X-Rspamd-Queue-Id: CE90D138CA4
X-Rspamd-Action: no action

From: Pierre Gondois <pierre.gondois@arm.com>

commit 2613cc29c5723881ca603b1a3b50f0107010d5d6 upstream

fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
For DT based systems, fw_token is set to a pointer to a DT node.

commit 3da72e18371c ("cacheinfo: Decrement refcount in
cache_setup_of_node()")
doesn't increment the refcount of fw_token anymore in
cache_setup_of_node(). fw_token is indeed used as a token and not
as a (struct device_node*), so no reference to fw_token should be
kept.

However, [1] is triggered when hotplugging a CPU multiple times
since cache_shared_cpu_map_remove() decrements the refcount to
fw_token at each CPU unplugging, eventually reaching 0.

Remove of_node_put() for fw_token in cache_shared_cpu_map_remove().

[1]
------------[ cut here ]------------
refcount_t: saturated; leaking memory.
WARNING: CPU: 4 PID: 32 at lib/refcount.c:22 refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
Modules linked in:
CPU: 4 PID: 32 Comm: cpuhp/4 Tainted: G        W          6.1.0-rc1-14091-g9fdf2ca7b9c8 #76
Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct 31 2022
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
lr : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
[...]
Call trace:
[...]
of_node_release (drivers/of/dynamic.c:335)
kobject_put (lib/kobject.c:677 lib/kobject.c:704 ./include/linux/kref.h:65 lib/kobject.c:721)
of_node_put (drivers/of/dynamic.c:49)
free_cache_attributes.part.0 (drivers/base/cacheinfo.c:712)
cacheinfo_cpu_pre_down (drivers/base/cacheinfo.c:718)
cpuhp_invoke_callback (kernel/cpu.c:247 (discriminator 4))
cpuhp_thread_fun (kernel/cpu.c:785)
smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3))
kthread (kernel/kthread.c:376)
ret_from_fork (arch/arm64/kernel/entry.S:861)
---[ end trace 0000000000000000 ]---

Fixes: 3da72e18371c ("cacheinfo: Decrement refcount in cache_setup_of_node()")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/r/20221116094958.2141072-1-pierre.gondois@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/base/cacheinfo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 54a66e4a3460..f41effceea7c 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -409,8 +409,6 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 				}
 			}
 		}
-		if (of_have_populated_dt())
-			of_node_put(this_leaf->fw_token);
 	}
 
 	/* cpu is no longer populated in the shared map */
-- 
2.34.1


