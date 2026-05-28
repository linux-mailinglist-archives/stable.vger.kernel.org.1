Return-Path: <stable+bounces-254986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDGwDs1GGGr5iAgAu9opvQ
	(envelope-from <stable+bounces-254986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:44:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F915F2EDC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA68E301FFA7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F63E9F95;
	Thu, 28 May 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwdebgNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04233C09FC
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975521; cv=none; b=Nn4mypBtcPVMlryyr+DPwxD/rnQJRb2cBtpmPS+GvHWEu2tXAkkRAbGesB3mhpPI1QwfYQ9XQ4A0UDFAUK3IwH2QgX9RyJzH7awURXI9D3LQdZvQkGDF42FsS6WEXEJldtU+407DGCC1TLBd1mvEYpsdRuwZw7bcX3V8kuY8ZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975521; c=relaxed/simple;
	bh=GE0BA00llIN8elbGMCBIA+nnCuYrPMEvYBxiVrVnukQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L5Vnl7hJ9GwNM/VUJuFfLEfMaMJZSTxCJbSGN0RlNxNUWFaubtI1vRX4GgQOFVJBXPrZfACRovMcMkORhh4ETATy/YY6DECuldxNHUGpDhqLRcz+ofauotrHkN4qF5I6Ngk9qCOrWRofFmSu5ids0Lmo3JgzMp3WplBqseGhCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwdebgNM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AA31F000E9;
	Thu, 28 May 2026 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779975519;
	bh=dmpr/FTpLwj90LmN5QgUAONAzPGE2o82ikUoTVSoYLY=;
	h=Subject:To:Cc:From:Date;
	b=xwdebgNMwkIH+psUMJretWfi0I3zjPTkeNlxV2INVJ2teDYl9G26L1kRWctrKn3ja
	 KphBwhhjPapLJLhAE91n6PoJ88siDF6/kH/okDhNJ5VZHH9nVcbk3IIcHM9sRBJoI8
	 RWEd73YFbH4D2jVs18f5q73+FstwX+SbUrHfwc1c=
Subject: FAILED: patch "[PATCH] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with" failed to apply to 6.6-stable tree
To: abdurrahman@nexthop.ai,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 15:37:46 +0200
Message-ID: <2026052846-kinswoman-crushing-8acf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254986-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nexthop.ai:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 89F915F2EDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1dd8f9491eb840cbea7ffdf4cad031e25f8ae0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052846-kinswoman-crushing-8acf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f1dd8f9491eb840cbea7ffdf4cad031e25f8ae0 Mon Sep 17 00:00:00 2001
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:31 -0700
Subject: [PATCH] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with
 pmbus_lock

adm1266_nvmem_read() is the reg_read callback the NVMEM core invokes
when userspace reads /sys/bus/nvmem/devices/.../nvmem on this chip.
On the first byte of every read it does a memset of data->dev_mem,
walks the device blackbox through adm1266_nvmem_read_blackbox()
(which issues a chain of PMBus block transactions), and then memcpys
the refreshed buffer out to userspace.  None of that runs under
pmbus_lock today.

Two consequences:

  - The PMBus traffic the refresh issues is not serialised against
    pmbus_core's own multi-step PAGE+register sequences.  A paged
    hwmon attribute read from another thread can land between a
    PAGE write and the paged read in either direction and corrupt
    one side's view of the device state machine.

  - The NVMEM core does not serialise concurrent reg_read calls, so
    two userspace readers racing at offset 0 can interleave the
    memset of data->dev_mem with another reader's
    adm1266_nvmem_read_blackbox() refill or memcpy out, returning
    torn data to userspace.

Take pmbus_lock at the top of adm1266_nvmem_read() via the
scope-based guard().  Patch 5 of this series moves
adm1266_config_nvmem() past pmbus_do_probe() so the lock is
guaranteed to be live before the callback is reachable from
userspace.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-7-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 0eef58dd69a6..5ddca5701032 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -400,6 +400,8 @@ static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t
 	if (offset + bytes > data->nvmem_config.size)
 		return -EINVAL;
 
+	guard(pmbus_lock)(data->client);
+
 	if (offset == 0) {
 		memset(data->dev_mem, 0, data->nvmem_config.size);
 


