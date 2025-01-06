Return-Path: <stable+bounces-107137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC790A02A64
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21C61881574
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE7156238;
	Mon,  6 Jan 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaYCn/t2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1086325;
	Mon,  6 Jan 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177567; cv=none; b=GiM9dL46z5/n55ALTm2kVBUtTzC++bY+uR3JYK3oMpXFJX0l5OUYRrXtLqm5aIlObH3IE4i6mm2S18fqXXZ0r2RLe3IVf+R8FVgPwO1rV6vylgg3WNMnA74T65UC5EwPROIZg70v79WdhY86vvi/zJUrbKKH+C1PDwapb+lPpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177567; c=relaxed/simple;
	bh=4y57RBcFZXzTh83Ca+C/ROETB9QGFtUKj6xI/rib+ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlrZ05YLJnmgtKbJuzdE7aO+K3pZXaJfdEuAsjWdlFO5mrvX21cwf3YYz26ON2DMglXDWn/gNuDUpWc/+wn1iP+GRTe4/H3JOiROVpS+QswKfQU0FlOGT/8gmDducuIq0DQurDdlZOF3lxQxRofOQLZL8o5edcfYfY4oE8Kr9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaYCn/t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B44C4CED2;
	Mon,  6 Jan 2025 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177566;
	bh=4y57RBcFZXzTh83Ca+C/ROETB9QGFtUKj6xI/rib+ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yaYCn/t200rLIq0PozzSBvv3LbyqJU1pP89DoiIaUAeIZbDoFM4g7WQpbznXXxtIw
	 K4yIh8THraNE2ag4zssZgtsg319sR7PmwmmA6mMRoYVCxg/lGAnJGLh+HPWx9xpJzP
	 gMfFWErJME6TpS77e7VGxFpsomcaawmXfom8RyJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Evgenii Shatokhin <e.shatokhin@yadro.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.6 206/222] pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking
Date: Mon,  6 Jan 2025 16:16:50 +0100
Message-ID: <20250106151158.564875747@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evgenii Shatokhin <e.shatokhin@yadro.com>

commit a37eecb705f33726f1fb7cd2a67e514a15dfe693 upstream.

If a device uses MCP23xxx IO expander to receive IRQs, the following
bug can happen:

  BUG: sleeping function called from invalid context
    at kernel/locking/mutex.c:283
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, ...
  preempt_count: 1, expected: 0
  ...
  Call Trace:
  ...
  __might_resched+0x104/0x10e
  __might_sleep+0x3e/0x62
  mutex_lock+0x20/0x4c
  regmap_lock_mutex+0x10/0x18
  regmap_update_bits_base+0x2c/0x66
  mcp23s08_irq_set_type+0x1ae/0x1d6
  __irq_set_trigger+0x56/0x172
  __setup_irq+0x1e6/0x646
  request_threaded_irq+0xb6/0x160
  ...

We observed the problem while experimenting with a touchscreen driver which
used MCP23017 IO expander (I2C).

The regmap in the pinctrl-mcp23s08 driver uses a mutex for protection from
concurrent accesses, which is the default for regmaps without .fast_io,
.disable_locking, etc.

mcp23s08_irq_set_type() calls regmap_update_bits_base(), and the latter
locks the mutex.

However, __setup_irq() locks desc->lock spinlock before calling these
functions. As a result, the system tries to lock the mutex whole holding
the spinlock.

It seems, the internal regmap locks are not needed in this driver at all.
mcp->lock seems to protect the regmap from concurrent accesses already,
except, probably, in mcp_pinconf_get/set.

mcp23s08_irq_set_type() and mcp23s08_irq_mask/unmask() are called under
chip_bus_lock(), which calls mcp23s08_irq_bus_lock(). The latter takes
mcp->lock and enables regmap caching, so that the potentially slow I2C
accesses are deferred until chip_bus_unlock().

The accesses to the regmap from mcp23s08_probe_one() do not need additional
locking.

In all remaining places where the regmap is accessed, except
mcp_pinconf_get/set(), the driver already takes mcp->lock.

This patch adds locking in mcp_pinconf_get/set() and disables internal
locking in the regmap config. Among other things, it fixes the sleeping
in atomic context described above.

Fixes: 8f38910ba4f6 ("pinctrl: mcp23s08: switch to regmap caching")
Cc: stable@vger.kernel.org
Signed-off-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Link: https://lore.kernel.org/20241209074659.1442898-1-e.shatokhin@yadro.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -86,6 +86,7 @@ const struct regmap_config mcp23x08_regm
 	.num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.max_register = MCP_OLAT,
+	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x08_regmap);
 
@@ -132,6 +133,7 @@ const struct regmap_config mcp23x17_regm
 	.num_reg_defaults = ARRAY_SIZE(mcp23x17_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x17_regmap);
 
@@ -228,7 +230,9 @@ static int mcp_pinconf_get(struct pinctr
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
+		mutex_lock(&mcp->lock);
 		ret = mcp_read(mcp, MCP_GPPU, &data);
+		mutex_unlock(&mcp->lock);
 		if (ret < 0)
 			return ret;
 		status = (data & BIT(pin)) ? 1 : 0;
@@ -257,7 +261,9 @@ static int mcp_pinconf_set(struct pinctr
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_UP:
+			mutex_lock(&mcp->lock);
 			ret = mcp_set_bit(mcp, MCP_GPPU, pin, arg);
+			mutex_unlock(&mcp->lock);
 			break;
 		default:
 			dev_dbg(mcp->dev, "Invalid config param %04x\n", param);



