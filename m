Return-Path: <stable+bounces-217073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLV7FT7UlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5315054B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B755304810D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F69259CBD;
	Tue, 17 Feb 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yZ5qc5KR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633692DB78B;
	Tue, 17 Feb 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361332; cv=none; b=bj6p9UznJmfpY+fV3fAlvhg7NcnXmdO1gtmvaDlcA8afRUSLc2o/i3SKCRT81q47gn8MbancOwc6cpz6xLnJWvG6wb74S9sXYlb0oakzfz9Hyob97lP8YCBiVZvTL8F6MOd+ReSWCaJyDP9SI+eSclYWQeHamrPImLI+ISW6NRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361332; c=relaxed/simple;
	bh=Wels6kfcn0lPsCGjyiWC6+0ZNTheZK583zcaYVOOUwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCIri7t040lhB0TaLuk4ObS3VHaK3IfCV/pu3Ak5A5gZkYy11HTZy4IL6CELI8wdwPCwxq87R0JjjrwZiRkWG7eCb+3/J8XnME2r9v/+EubqzhVnL6NxE+gBPZfFKElnoJy9qhjoQhRQYwmFO5ZfRX3+hnnuMzeCjTg/4mIfsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yZ5qc5KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2478C4CEF7;
	Tue, 17 Feb 2026 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361332;
	bh=Wels6kfcn0lPsCGjyiWC6+0ZNTheZK583zcaYVOOUwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yZ5qc5KRVWHyLyXj7xuN8G4eiwpO0OrTkEm7+wM1HcXSErp5MHePVu5wBUFttn7vI
	 OvZ9pi10ah2pTguBlg7SlDH83FEag5KB4z3HxPbZN5YGci1LGTfugokq4yoDO4bBTl
	 XeRuRXec+wEWaaC1fx0/vMmQd9UIhsGZPqhSyPAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.1 27/64] cacheinfo: Remove of_node_put() for fw_token
Date: Tue, 17 Feb 2026 21:31:23 +0100
Message-ID: <20260217200008.540408772@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217073-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,samsung.com:email,linux-m68k.org:email,glider.be:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,arm.com:email]
X-Rspamd-Queue-Id: 10B5315054B
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/cacheinfo.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -409,8 +409,6 @@ static void cache_shared_cpu_map_remove(
 				}
 			}
 		}
-		if (of_have_populated_dt())
-			of_node_put(this_leaf->fw_token);
 	}
 
 	/* cpu is no longer populated in the shared map */



