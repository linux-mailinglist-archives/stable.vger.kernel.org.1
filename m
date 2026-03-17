Return-Path: <stable+bounces-225856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALeQF+FAuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:54:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E32A9494
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89B1C307E87A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C33AEF2D;
	Tue, 17 Mar 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE6goX9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5A3A3E97
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748193; cv=none; b=a5kkJTEU+d/rB1nPzdiHrEoPgepK616XItBAIggUZ08D+mq6Hw4RFzR+mvoLAXI5h0TEkD9/WNdA9wyMXyIyP3QwPUv6gUQ0yHDgcT/ah34806BFQVjzLQc5lhTRJRwu2s9i2u+1ozj5BIVA+T1R+E2SaOQEpln4fcz626m2Dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748193; c=relaxed/simple;
	bh=KH790p5pPaqEBmDna6ldtjooQ7WzjI6RuktLQYY6JB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZEFmIYqFiMMXUGTVoI7ExGSLkEwNxczqo/maW9PqK96rw00m1fvWk4w4dzvmETvEG4y8JFXrYqZUiSz2Y2XNamCOI15pwgx/uYzGKvPBQgHQiH9X3fw4rF0Bb48gFsvtRMrJ3GTGnWCVP8OnEy+5KoV69tdH6Y65EG4r/H05g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE6goX9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD876C2BCB0;
	Tue, 17 Mar 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748193;
	bh=KH790p5pPaqEBmDna6ldtjooQ7WzjI6RuktLQYY6JB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE6goX9PKFUlauMtXGPWe+ut3EkTiL7J5OJwGD+A8eZpIA5n0YC4ipV4DTEKMeRKo
	 SufFnxntIbSit6nYra/jV212iYHO3algKeLJUPRujXqD+c45s1A46+/IHdkMLray4u
	 5idBDc8RQsmKiCDJQs+s69Dg/kdj7HPNz7b90SBFmE4Q7LkyHQc7jqxjtJK3lOVucR
	 kZbu3OlHcYdQKRqyvtAaIVddX45495i6vm3/niPEtUOy/ICCxqBSabbkm2t0cEfD8z
	 bRyOVOZ+DnCbb3c9ngffbcEzOggO8AvZId3/DWHS+rMVrbvP/hJVyVklIIG/ow+E/I
	 A0Tl4RQug93aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Pierre Ossman <pierre@ossman.eu>,
	Russell King <linux@armlinux.org.uk>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] mmc: core: Drop reference counting of the bus_ops
Date: Tue, 17 Mar 2026 07:49:48 -0400
Message-ID: <20260317114949.126875-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317114949.126875-1-sashal@kernel.org>
References: <2026031713-defeat-mobster-d0a8@gregkh>
 <20260317114949.126875-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225856-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ossman.eu:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: EC2E32A9494
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit e9ce2ce17da626d930812199568bd426b2832f57 ]

When the mmc_rescan work is enabled for execution (host->rescan_disable),
it's the only instance per mmc host that is allowed to set/clear the
host->bus_ops pointer.

Besides the mmc_rescan work, there are a couple of scenarios when the
host->bus_ops pointer may be accessed. Typically, those can be described as
as below:

*)
Upper mmc driver layers (like the mmc block device driver or an SDIO
functional driver) needs to execute a host->bus_ops callback. This can be
considered as safe without having to use some special locking mechanism,
because they operate on top of the struct mmc_card. As long as there is a
card to operate upon, the mmc core guarantees that there is a host->bus_ops
assigned as well. Note that, upper layer mmc drivers are of course
responsible to clean up from themselves from their ->remove() callbacks,
otherwise things would fall apart anyways.

**)
Via the mmc host instance, we may need to force a removal of an inserted
mmc card. This happens when a mmc host driver gets unbind, for example. In
this case, we protect the host->bus_ops pointer from concurrent accesses,
by disabling the mmc_rescan work upfront (host->rescan_disable). See
mmc_stop_host() for example.

This said, it seems like the reference counting of the host->bus_ops
pointer at some point have become superfluous. As this is an old mechanism
of the mmc core, it a bit difficult to digest the history of when that
could have happened. However, let's drop the reference counting to avoid
unnecessary code-paths and lockings.

Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20210212131610.236843-1-ulf.hansson@linaro.org
Stable-dep-of: 901084c51a0a ("mmc: core: Avoid bitfield RMW for claim/retune flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/core.c  | 89 ++--------------------------------------
 include/linux/mmc/host.h |  2 -
 2 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index cef46bae60b6a..dda6ec423e9e8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1388,63 +1388,13 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 	mmc_power_up(host, ocr);
 }
 
-/*
- * Cleanup when the last reference to the bus operator is dropped.
- */
-static void __mmc_release_bus(struct mmc_host *host)
-{
-	WARN_ON(!host->bus_dead);
-
-	host->bus_ops = NULL;
-}
-
-/*
- * Increase reference count of bus operator
- */
-static inline void mmc_bus_get(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	host->bus_refs++;
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
-/*
- * Decrease reference count of bus operator and free it if
- * it is the last reference.
- */
-static inline void mmc_bus_put(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	host->bus_refs--;
-	if ((host->bus_refs == 0) && host->bus_ops)
-		__mmc_release_bus(host);
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
  */
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
 {
-	unsigned long flags;
-
-	WARN_ON(!host->claimed);
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	WARN_ON(host->bus_ops);
-	WARN_ON(host->bus_refs);
-
 	host->bus_ops = ops;
-	host->bus_refs = 1;
-	host->bus_dead = 0;
-
-	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 /*
@@ -1452,18 +1402,7 @@ void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
  */
 void mmc_detach_bus(struct mmc_host *host)
 {
-	unsigned long flags;
-
-	WARN_ON(!host->claimed);
-	WARN_ON(!host->bus_ops);
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	host->bus_dead = 1;
-
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	mmc_bus_put(host);
+	host->bus_ops = NULL;
 }
 
 void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
@@ -2260,32 +2199,15 @@ void mmc_rescan(struct work_struct *work)
 		host->trigger_card_event = false;
 	}
 
-	mmc_bus_get(host);
-
 	/* Verify a registered card to be functional, else remove it. */
-	if (host->bus_ops && !host->bus_dead)
+	if (host->bus_ops)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
 
-	/*
-	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
-	 * the card is no longer present.
-	 */
-	mmc_bus_put(host);
-	mmc_bus_get(host);
-
 	/* if there still is a card present, stop here */
-	if (host->bus_ops != NULL) {
-		mmc_bus_put(host);
+	if (host->bus_ops != NULL)
 		goto out;
-	}
-
-	/*
-	 * Only we can add a new handler, so it's safe to
-	 * release the lock here.
-	 */
-	mmc_bus_put(host);
 
 	mmc_claim_host(host);
 	if (mmc_card_is_removable(host) && host->ops->get_cd &&
@@ -2356,18 +2278,15 @@ void mmc_stop_host(struct mmc_host *host)
 	/* clear pm flags now and let card drivers set them as needed */
 	host->pm_flags = 0;
 
-	mmc_bus_get(host);
-	if (host->bus_ops && !host->bus_dead) {
+	if (host->bus_ops) {
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		host->bus_ops->remove(host);
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
-		mmc_bus_put(host);
 		return;
 	}
-	mmc_bus_put(host);
 
 	mmc_claim_host(host);
 	mmc_power_off(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1c7b716c96f30..400556db06cb0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -403,7 +403,6 @@ struct mmc_host {
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
 	unsigned int		claimed:1;	/* host exclusively claimed */
-	unsigned int		bus_dead:1;	/* bus has been released */
 	unsigned int		doing_init_tune:1; /* initial tuning in progress */
 	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
@@ -435,7 +434,6 @@ struct mmc_host {
 	struct mmc_slot		slot;
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
-	unsigned int		bus_refs;	/* reference counter */
 
 	unsigned int		sdio_irqs;
 	struct task_struct	*sdio_irq_thread;
-- 
2.51.0


