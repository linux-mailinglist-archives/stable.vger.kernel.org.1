Return-Path: <stable+bounces-242060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFxGCE4e82kvxQEAu9opvQ
	(envelope-from <stable+bounces-242060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:18:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120C49FBCE
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF46C300A62E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E939B95E;
	Thu, 30 Apr 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klmbMQK8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5D36827E;
	Thu, 30 Apr 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540680; cv=none; b=nZLaPytBJzBD39FjrthM+DnqKkFEpEmlS1uTaxl2F3VpYnksAFPl52L/pJ9C69iUMBfGhalmvTvvFn2Ey5iNZR8ta2aWSyxgk0TtcAWjISbE7HTuTHfTGONsrgLc1VH7SJcpQABItzYkkkXOo8Qv2O2PLBaaATKI0Qxqomex95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540680; c=relaxed/simple;
	bh=Y1IqjaKgqBrIy/QgUYgru/+YxC+AuARpeUSdDcOtnk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI3Tf+eFumpIW8PjMHuFfUKpLa1qipyx6CBjnbBmwLXy1zykMmSV68mlIP1bqvdjuQ+V9D3tUW+aW//pO6e0CNEjjN3JtdTDihROAI4vY8+wKuVvrb6S9yHrooxrPXRIu9V33bIpHRK6XKmH9gqkHQ6sB+aZMu4dqjyofWkQ/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klmbMQK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199CC2BCB3;
	Thu, 30 Apr 2026 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777540680;
	bh=Y1IqjaKgqBrIy/QgUYgru/+YxC+AuARpeUSdDcOtnk4=;
	h=From:To:Cc:Subject:Date:From;
	b=klmbMQK8qMylNbonHELEWr1HvtdLV+lyPnA22PYwMCjUIsc5UBK5X0ObFiMKxOieT
	 PmaCSZqd2aVm119RH1BA06UgrdTZiTvg6mpoQOVwO+Qh/X3gsNy4NDSzJzzCLJWpQ1
	 LXQVQ5DkivLL+2g5ysgkYhgsEK0gnBLSD93lF9/+iPSgF563dsaRKa6V/6yyyhxt3J
	 FaUy2mHACQwHoFq6S1s/dxzPLiL2BZCK3bbGUDlsT19mt8dqzoDzvYgeAM9qqZd5AQ
	 4ERi8vrpEnR/SqeY4S1MAmUq0fv/O48jVAH+3b5jBGL3swfskksbj66Fipz+lWG5cV
	 709iPBLeimTUg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wINWv-00000000xuJ-2rja;
	Thu, 30 Apr 2026 11:17:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael J Wysocki <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] driver core: reject devices with unregistered buses
Date: Thu, 30 Apr 2026 11:17:18 +0200
Message-ID: <20260430091718.230228-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9120C49FBCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Trying to register a device on a bus which has not yet been registered
used to trigger a NULL-pointer dereference, but since the const bus
structure rework registration instead succeeds without the device being
added to the bus.

This specifically means that the device will never bind to a driver and
that the bus sysfs attributes are not created (i.e. as if the device had
no bus).

Reject devices with unregistered buses to catch any callers that get
the ordering wrong and to handle bus registration failures more
gracefully.

Fixes: 5221b82d46f2 ("driver core: bus: bus_add/probe/remove_device() cleanups")
Cc: stable@vger.kernel.org	# 6.3
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - amend commit message with implications of the device not being added
   to the bus


 drivers/base/bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8b6722ff8590..d17bd91490ee 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -544,10 +544,10 @@ static const struct attribute_group driver_override_dev_group = {
  */
 int bus_add_device(struct device *dev)
 {
-	struct subsys_private *sp = bus_to_subsys(dev->bus);
+	struct subsys_private *sp;
 	int error;
 
-	if (!sp) {
+	if (!dev->bus) {
 		/*
 		 * This is a normal operation for many devices that do not
 		 * have a bus assigned to them, just say that all went
@@ -556,6 +556,13 @@ int bus_add_device(struct device *dev)
 		return 0;
 	}
 
+	sp = bus_to_subsys(dev->bus);
+	if (!sp) {
+		pr_err("%s: cannot add device '%s' to unregistered bus '%s'\n",
+		       __func__, dev_name(dev), dev->bus->name);
+		return -EINVAL;
+	}
+
 	/*
 	 * Reference in sp is now incremented and will be dropped when
 	 * the device is removed from the bus
-- 
2.53.0


