Return-Path: <stable+bounces-222425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ll3+LSXzo2mvSwUAu9opvQ
	(envelope-from <stable+bounces-222425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 09:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB9F1CEC31
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 09:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF6530158AB
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6872C2363;
	Sun,  1 Mar 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TR+bvSPH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BA1F0991;
	Sun,  1 Mar 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772352288; cv=none; b=GUtA0RcXforFX+J8IffpNrkYNH8XIUOOioyX98ih+Yl/2FhJpUhycKPYTykORw6YcXVGNOFmoCWepsZrpVRgbuEQjXz7TpfPbj6BJw6xmD9PnnVY3mCtSVl+5qGWQSW3x+8nE0yhTOlWhrxcNa04iJv/tgWf+H2C8WZK+m7Y5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772352288; c=relaxed/simple;
	bh=yK1mC8/8gSUCjTZMFSdFFafgLJiAyb9LXIZv+olLYnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWA9it7fGuxawAZBls2JxuVqEV8tQxuniTZNXPFm87Z+LF2UG8IikJicvC87vp3szW4tB3kUUtlSY+7RUINtA6uIH71RuFHmMiYUoNHvR8LGPy24NHkI9B+V1HaU0iqBBFfF9qOLzjqzR2fpwmFjNFCZHbBBsRhDrbnqSSz9+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TR+bvSPH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772352287; x=1803888287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yK1mC8/8gSUCjTZMFSdFFafgLJiAyb9LXIZv+olLYnc=;
  b=TR+bvSPHJFv3eSGPldTppXytAUQmlK5M7Foz0bEvEHc1ia/RJ8VVH0IS
   kxwx0433ViN8ifORKNfufJCPkdpP0x2HupC2t7NHIjj8hxMqT4Aa5GsQm
   s1WmpEfK4tAqazWlrJnMPIWT5KmrWDvjINYbkhL9S5qHPoQ+r4WRupEtH
   nlQ6A4wKXqvFlF/H3VLGp+7Okk8B0EC0nILLhfZ1oJqkvg2/geJmIpulJ
   aUkIgvVuYmQO0riffpB+ecYOBsGGcGzXPmZuclgXwivdE438cTS/7tsTy
   BkaIbMfCOIQuRuQnjjoLNy/MNeJzHvVP/59hVM2vN4XatcECx44IYeV7D
   Q==;
X-CSE-ConnectionGUID: rdALzvBJSU+trOIALUxp6g==
X-CSE-MsgGUID: YcDcGcFDS56NHXHXnPeyYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="77254093"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="77254093"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 00:04:46 -0800
X-CSE-ConnectionGUID: f0JPd/yGSXeHPV9gjF3LjQ==
X-CSE-MsgGUID: nM/TUN3MTGOjeaPGXN8dSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="221952569"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 00:04:44 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Menachem Adin <menachem.adin@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [char-misc] mei: me: reduce the scope on unexpected reset
Date: Sun,  1 Mar 2026 09:46:21 +0200
Message-ID: <20260301074621.2084367-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222425-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alexander.usyskin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: CFB9F1CEC31
X-Rspamd-Action: no action

Avoid false-positive detection of unready hardware by
triggering link reset only when we have driver in ENABLED state.

Cc: stable@vger.kernel.org
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221023
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Fixes: 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpected")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index d4612c659784..1e4a41ac428f 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1337,19 +1337,13 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	/*  check if we need to start the dev */
 	if (!mei_host_is_ready(dev)) {
 		if (mei_hw_is_ready(dev)) {
-			/* synchronized by dev mutex */
-			if (waitqueue_active(&dev->wait_hw_ready)) {
-				dev_dbg(&dev->dev, "we need to start the dev.\n");
-				dev->recvd_hw_ready = true;
-				wake_up(&dev->wait_hw_ready);
-			} else if (dev->dev_state != MEI_DEV_UNINITIALIZED &&
-				   dev->dev_state != MEI_DEV_POWERING_DOWN &&
-				   dev->dev_state != MEI_DEV_POWER_DOWN) {
+			if (dev->dev_state == MEI_DEV_ENABLED) {
 				dev_dbg(&dev->dev, "Force link reset.\n");
 				schedule_work(&dev->reset_work);
 			} else {
-				dev_dbg(&dev->dev, "Ignore this interrupt in state = %d\n",
-					dev->dev_state);
+				dev_dbg(&dev->dev, "we need to start the dev.\n");
+				dev->recvd_hw_ready = true;
+				wake_up(&dev->wait_hw_ready);
 			}
 		} else {
 			dev_dbg(&dev->dev, "Spurious Interrupt\n");
-- 
2.43.0


