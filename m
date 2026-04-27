Return-Path: <stable+bounces-241288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIrWF/4772mD+gAAu9opvQ
	(envelope-from <stable+bounces-241288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:35:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE947115B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECFD3302CD32
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F33B4EB6;
	Mon, 27 Apr 2026 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9IUSJxa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259013B52E1;
	Mon, 27 Apr 2026 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285829; cv=none; b=sIRjdTzy6i9mcO+FChwrOqY4ejhUGli8+bdHaTr7p7d7eci5VRVA5bDwIUvfFfsZ8Gn8MPIXKIjFNt4jEAGykOv81DzuWmq5AGSI5MXI6khiKefiN1J/iG8zd8wMgHwa7uUkZHI1/6Wx/ZSmlsYhNVy4Vga5O19epYQp/7mIuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285829; c=relaxed/simple;
	bh=mzRri+UwfqSsBPQWcw+cLA0FA4jDpn8RGhgxNrI8duA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irPh0odRrZurQEiI91N1JJ68p5ScDHYaqOrqOxCtX0N9WBJo68q3K8RSsFmqaPblNgjyfP0adAkQmdrud5R70h1gfiOgEHA1UKh3tp//GERBFEoNzKIXtchC+hafvcCrRd8wBdLC7dn2AZgNqO4jXyzmK6zV1sqK4IdfGECJDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9IUSJxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB5C19425;
	Mon, 27 Apr 2026 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285828;
	bh=mzRri+UwfqSsBPQWcw+cLA0FA4jDpn8RGhgxNrI8duA=;
	h=From:To:Cc:Subject:Date:From;
	b=j9IUSJxa+vLM7gSJjHIkyQS5qcRj7/1wFC0h04EoTG0O6DruiX/As7RBsLLHAr2iH
	 J4uP+4uKEXKAtO8+9zSpPBHQ/AI5LgBrguSpvpcII+KnrLXUxsIcIMtZVKS4G4wMtu
	 ihoRyv36dcSFMfYGU00+hGifN0pFxL3Cb3ilyCoBqDskW7CeQZ7P48Wo+RlgqRrdEu
	 SdVRwDRAAEx03xY3mWkeKmv626rhUNavHO/3lF/Lytr8GUJRbXsEaLnVlijfp8E/hI
	 6k9zlEgwemDfXOhAmUkgCL0bgOyq6jzBeYQ3ZbMkWnkPcq7rk2+3Dmsvi6dFTfLiGF
	 9tFEjfZC6rgHw==
Received: from johan by theta with local (Exim 4.99.1)
	(envelope-from <johan@kernel.org>)
	id 1wHJEO-000000000b2-2p5p;
	Mon, 27 Apr 2026 12:30:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] driver core: reject devices with unregistered buses
Date: Mon, 27 Apr 2026 12:28:52 +0200
Message-ID: <20260427102852.2174-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCCE947115B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241288-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Trying to register a device on a bus which has not yet been registered
used to trigger a NULL-pointer dereference, but since the const bus
structure rework registration instead succeeds without the device being
added to the bus.

Reject devices with unregistered buses to catch any callers that get
the ordering wrong and to handle bus registration failures more
gracefully.

Fixes: 5221b82d46f2 ("driver core: bus: bus_add/probe/remove_device() cleanups")
Cc: stable@vger.kernel.org	# 6.3
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
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


