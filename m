Return-Path: <stable+bounces-220436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE8kItM6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2C1C6782
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49F9331EBD19
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7913B4CFA;
	Sat, 28 Feb 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFJ7xapw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D73B4CED;
	Sat, 28 Feb 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300326; cv=none; b=UTutuvb1IoUJazXqHqBReH3elDqh+E87F95xP9PYzJBz79KXxYiRGMSu+vIkfoWOqKOB3zc4UnWOMsho5RHkZzBS44reVSdf6rzwlHPiBZ5mB5kOphR4SKaZkStrFttBseM4KRDjYLWs/lyrH3HrsBuDYhLEJGmZOVquYJpqQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300326; c=relaxed/simple;
	bh=/xayTRITuOFmRiReUOG1S0Z7no1I7nxm+HbPt9IU6NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkXGTvRGy/Vgo/wEYRgPvN8pHNlY+548GYD2iDJlKWDKl9Wniz7aedZReqOZjyvDO/Xctv+U1VF0CrQ9EWPM8W4LDGpe9vyV4ABWV3p716PlUW38FQL+y9fbpYqPvMa/V604DK9qfmzMN97vTBoc1z6SOiA0atd2kzIoEevQCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFJ7xapw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF99AC19424;
	Sat, 28 Feb 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300325;
	bh=/xayTRITuOFmRiReUOG1S0Z7no1I7nxm+HbPt9IU6NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFJ7xapw0Sd8NRcdsiA891uGwqvdpV4mwMCIlbYgufhQgV4Kgip2FcW16L+dZqj5a
	 xR9jyeE0u8C0y7zKIhVADzr+yAqPKM9nuDETMQyqnDJd1ZnDjUMXnTOoCjpNBX14L7
	 k/nVVGNt7fuhxbuV7g7051B/upLCY7H+EEqrOH9VIO4xyiJY6wSi1peuEAB6bSFvAC
	 3eoXR7sZe0jdkrw+884WNUAwQtalTsI+7P6cOPwkiXRUZgz7+xcfL+tfRSPCY8hQBl
	 HzRLzx4MZW7SSeIuEJQVpEH8DQugVfkxWBWAgj4jCvnvL3+QjxmI6j9A5DSIcpgqbD
	 Nnvhttuuy5Mkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 357/844] remoteproc: mediatek: Break lock dependency to `prepare_lock`
Date: Sat, 28 Feb 2026 12:24:30 -0500
Message-ID: <20260228173244.1509663-358-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220436-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: B1B2C1C6782
X-Rspamd-Action: no action

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit d935187cfb27fc4168f78f3959aef4eafaae76bb ]

A potential circular locking dependency (ABBA deadlock) exists between
`ec_dev->lock` and the clock framework's `prepare_lock`.

The first order (A -> B) occurs when scp_ipi_send() is called while
`ec_dev->lock` is held (e.g., within cros_ec_cmd_xfer()):
1. cros_ec_cmd_xfer() acquires `ec_dev->lock` and calls scp_ipi_send().
2. scp_ipi_send() calls clk_prepare_enable(), which acquires
   `prepare_lock`.
See #0 in the following example calling trace.
(Lock Order: `ec_dev->lock` -> `prepare_lock`)

The reverse order (B -> A) is more complex and has been observed
(learned) by lockdep.  It involves the clock prepare operation
triggering power domain changes, which then propagates through sysfs
and power supply uevents, eventually calling back into the ChromeOS EC
driver and attempting to acquire `ec_dev->lock`:
1. Something calls clk_prepare(), which acquires `prepare_lock`.  It
   then triggers genpd operations like genpd_runtime_resume(), which
   takes `&genpd->mlock`.
2. Power domain changes can trigger regulator changes; regulator
   changes can then trigger device link changes; device link changes
   can then trigger sysfs changes.  Eventually, power_supply_uevent()
   is called.
3. This leads to calls like cros_usbpd_charger_get_prop(), which calls
   cros_ec_cmd_xfer_status(), which then attempts to acquire
   `ec_dev->lock`.
See #1 ~ #6 in the following example calling trace.
(Lock Order: `prepare_lock` -> `&genpd->mlock` -> ... -> `&ec_dev->lock`)

Move the clk_prepare()/clk_unprepare() operations for `scp->clk` to the
remoteproc prepare()/unprepare() callbacks.  This ensures `prepare_lock`
is only acquired in prepare()/unprepare() callbacks.  Since
`ec_dev->lock` is not involved in the callbacks, the dependency loop is
broken.

This means the clock is always "prepared" when the SCP is running.  The
prolonged "prepared time" for the clock should be acceptable as SCP is
designed to be a very power efficient processor.  The power consumption
impact can be negligible.

A simplified calling trace reported by lockdep:
> -> #6 (&ec_dev->lock)
>        cros_ec_cmd_xfer
>        cros_ec_cmd_xfer_status
>        cros_usbpd_charger_get_port_status
>        cros_usbpd_charger_get_prop
>        power_supply_get_property
>        power_supply_show_property
>        power_supply_uevent
>        dev_uevent
>        uevent_show
>        dev_attr_show
>        sysfs_kf_seq_show
>        kernfs_seq_show
> -> #5 (kn->active#2)
>        kernfs_drain
>        __kernfs_remove
>        kernfs_remove_by_name_ns
>        sysfs_remove_file_ns
>        device_del
>        __device_link_del
>        device_links_driver_bound
> -> #4 (device_links_lock)
>        device_link_remove
>        _regulator_put
>        regulator_put
> -> #3 (regulator_list_mutex)
>        regulator_lock_dependent
>        regulator_disable
>        scpsys_power_off
>        _genpd_power_off
>        genpd_power_off
> -> #2 (&genpd->mlock/1)
>        genpd_add_subdomain
>        pm_genpd_add_subdomain
>        scpsys_add_subdomain
>        scpsys_probe
> -> #1 (&genpd->mlock)
>        genpd_runtime_resume
>        __rpm_callback
>        rpm_callback
>        rpm_resume
>        __pm_runtime_resume
>        clk_core_prepare
>        clk_prepare
> -> #0 (prepare_lock)
>        clk_prepare
>        scp_ipi_send
>        scp_send_ipi
>        mtk_rpmsg_send
>        rpmsg_send
>        cros_ec_pkt_xfer_rpmsg

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20260112110755.2435899-1-tzungbi@kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/mtk_scp.c     | 39 +++++++++++++++++++++++---------
 drivers/remoteproc/mtk_scp_ipi.c |  4 ++--
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index db8fd045468d9..98d00bd5200cc 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -283,7 +283,7 @@ static irqreturn_t scp_irq_handler(int irq, void *priv)
 	struct mtk_scp *scp = priv;
 	int ret;
 
-	ret = clk_prepare_enable(scp->clk);
+	ret = clk_enable(scp->clk);
 	if (ret) {
 		dev_err(scp->dev, "failed to enable clocks\n");
 		return IRQ_NONE;
@@ -291,7 +291,7 @@ static irqreturn_t scp_irq_handler(int irq, void *priv)
 
 	scp->data->scp_irq_handler(scp);
 
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 
 	return IRQ_HANDLED;
 }
@@ -665,7 +665,7 @@ static int scp_load(struct rproc *rproc, const struct firmware *fw)
 	struct device *dev = scp->dev;
 	int ret;
 
-	ret = clk_prepare_enable(scp->clk);
+	ret = clk_enable(scp->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks\n");
 		return ret;
@@ -680,7 +680,7 @@ static int scp_load(struct rproc *rproc, const struct firmware *fw)
 
 	ret = scp_elf_load_segments(rproc, fw);
 leave:
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 
 	return ret;
 }
@@ -691,14 +691,14 @@ static int scp_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	struct device *dev = scp->dev;
 	int ret;
 
-	ret = clk_prepare_enable(scp->clk);
+	ret = clk_enable(scp->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks\n");
 		return ret;
 	}
 
 	ret = scp_ipi_init(scp, fw);
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 	return ret;
 }
 
@@ -709,7 +709,7 @@ static int scp_start(struct rproc *rproc)
 	struct scp_run *run = &scp->run;
 	int ret;
 
-	ret = clk_prepare_enable(scp->clk);
+	ret = clk_enable(scp->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks\n");
 		return ret;
@@ -734,14 +734,14 @@ static int scp_start(struct rproc *rproc)
 		goto stop;
 	}
 
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 	dev_info(dev, "SCP is ready. FW version %s\n", run->fw_ver);
 
 	return 0;
 
 stop:
 	scp->data->scp_reset_assert(scp);
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 	return ret;
 }
 
@@ -909,7 +909,7 @@ static int scp_stop(struct rproc *rproc)
 	struct mtk_scp *scp = rproc->priv;
 	int ret;
 
-	ret = clk_prepare_enable(scp->clk);
+	ret = clk_enable(scp->clk);
 	if (ret) {
 		dev_err(scp->dev, "failed to enable clocks\n");
 		return ret;
@@ -917,12 +917,29 @@ static int scp_stop(struct rproc *rproc)
 
 	scp->data->scp_reset_assert(scp);
 	scp->data->scp_stop(scp);
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 
 	return 0;
 }
 
+static int scp_prepare(struct rproc *rproc)
+{
+	struct mtk_scp *scp = rproc->priv;
+
+	return clk_prepare(scp->clk);
+}
+
+static int scp_unprepare(struct rproc *rproc)
+{
+	struct mtk_scp *scp = rproc->priv;
+
+	clk_unprepare(scp->clk);
+	return 0;
+}
+
 static const struct rproc_ops scp_ops = {
+	.prepare	= scp_prepare,
+	.unprepare	= scp_unprepare,
 	.start		= scp_start,
 	.stop		= scp_stop,
 	.load		= scp_load,
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index c068227e251e7..7a37e273b3af8 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -171,7 +171,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 	    WARN_ON(len > scp_sizes->ipi_share_buffer_size) || WARN_ON(!buf))
 		return -EINVAL;
 
-	ret = clk_prepare_enable(scp->clk);
+	ret = clk_enable(scp->clk);
 	if (ret) {
 		dev_err(scp->dev, "failed to enable clock\n");
 		return ret;
@@ -211,7 +211,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 
 unlock_mutex:
 	mutex_unlock(&scp->send_lock);
-	clk_disable_unprepare(scp->clk);
+	clk_disable(scp->clk);
 
 	return ret;
 }
-- 
2.51.0


