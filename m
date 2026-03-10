Return-Path: <stable+bounces-223809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAjSK5Tfr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:08:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72706247F3C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E58930BC13B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4644B696;
	Tue, 10 Mar 2026 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz3ZRYwt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6243E4B8;
	Tue, 10 Mar 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133330; cv=none; b=phS/WjAHjxovPnnUlPZkYbTVgm31VSt5Zd5C1Z05bwDw1iJQOmQkGUKLrA363M1oqoLgY0Z3nUSZeohZSStVW6V4LlrNGPWNpjVW/hXn1xRvd1GNqkmmavAlQDSGW5Ifk7O1sGP2X5VwEB6CG2u/yQGDh7MrXQFWaroiv+/6hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133330; c=relaxed/simple;
	bh=V870Fjn81zA8yB5HaZNIHH8mBMjWxvboo4YRoIuwroY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuhbLLHJ+xTkvrZUPZoVHxmy7ffMgQB7ir7tMfvZYXT1aNrmEyqtWFRUGRtu3Gvzde0u0MPfF0gHYDr5r/+Ffqzymyj9cA2ocbv5jfgsUw+B9V70QQu2i9S4EyL0C0yIIJkOYqe+CjNnlSLg9dV7r4gmmhw4V0boECRVbsPriiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz3ZRYwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708DAC2BC9E;
	Tue, 10 Mar 2026 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133330;
	bh=V870Fjn81zA8yB5HaZNIHH8mBMjWxvboo4YRoIuwroY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qz3ZRYwtY6kWZfMAXnwhKa0d8dkX2q9XMXXW9qsSy6kYUVUg9SZAVsoYCmx03Nmo/
	 cfnXQCbeTJPx+QjJzI4rB+v6yWAByQhTCF8NxmvPRAwtoKoupjgZ+Hp7Asi4mKc3FD
	 3hARRzsBi2D7zWzfYFT1oXVerZKLn0iF1UVM0ngwQ4q5Ex8hUo42D2BvpHPynL+Zt5
	 WJMU1oVfIgGkaudUDj5vyaHYoMCnmNuV6HjvMFkPxicbiJHtrMvgZiR1yaIfvIDTAz
	 U2579wGn0YDB7yO0f//qLPOOo9V1HpdcfH2bIzGAiR1u15ZzdrlnadvECIoITLqDvE
	 FpPowiDece8bg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Romain Sioen <romain.sioen@microchip.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] HID: mcp2221: cancel last I2C command on read error
Date: Tue, 10 Mar 2026 05:01:16 -0400
Message-ID: <20260310090145.2709021-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310090145.2709021-1-sashal@kernel.org>
References: <20260310090145.2709021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72706247F3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,suse.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223809-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Romain Sioen <romain.sioen@microchip.com>

[ Upstream commit e31b556c0ba21f20c298aa61181b96541140b7b9 ]

When an I2C SMBus read operation fails, the MCP2221 internal state machine
may not reset correctly, causing subsequent transactions to fail.

By adding a short delay and explicitly cancelling the last command,
we ensure the device is ready for the next operation.

Fix an issue where i2cdetect was not able to detect all devices correctly
on the bus.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me summarize the analysis.

## Analysis

### What the commit fixes

The MCP2221 is a USB-to-I2C/UART bridge chip. When an I2C SMBus read
operation exhausts its 5 retries (meaning the device didn't become
ready), the function `mcp_i2c_smbus_read` previously returned the error
immediately without cleaning up the device's internal state machine.
This left the I2C bus in a stuck state, causing subsequent I2C
transactions to fail.

The fix adds two lines before the error return:
1. `usleep_range(980, 1000)` - a small delay needed by the device
2. `mcp_cancel_last_cmd(mcp)` - sends a cancel command to reset the
   device state and free the I2C bus

### Is this a real bug fix?

Yes. The commit message explicitly states this fixes a real-world issue:
`i2cdetect` was unable to detect all devices on the bus. This is a
functional bug where failed reads leave the MCP2221 in a bad state,
breaking subsequent operations.

### Pattern consistency

The fix follows the **exact same pattern** already used in two other
places in the same driver:
1. `mcp_chk_last_cmd_status_free_bus()` (line 225-226):
   `usleep_range(980, 1000)` + `mcp_cancel_last_cmd(mcp)` on error
2. `mcp_set_i2c_speed()` (line 244-245): same pattern on error

This is simply adding the same established error recovery to a path that
was missing it.

### Scope and risk

- **2 lines added** - extremely small and surgical
- **No behavioral change** on the success path
- Only affects the error path after all 5 retries are exhausted
- Uses well-established functions already present in the driver
- Low risk of regression - the alternative (not cancelling) is already
  broken

### Stable criteria assessment

- **Obviously correct**: Follows the same pattern used elsewhere in the
  driver for the same purpose
- **Fixes a real bug**: I2C bus gets stuck, preventing device detection
- **Small and contained**: 2 lines added, single file, single error path
- **No new features**: Just error recovery

### Verification

- git log confirmed this is commit b4664742e46dc, merged recently
- Read the full `mcp_cancel_last_cmd()` function at line 204-211: sends
  `MCP2221_I2C_CANCEL` to reset device state
- Read `mcp_chk_last_cmd_status_free_bus()` at line 216-230: confirms
  the same `usleep + cancel` pattern is established
- Read `mcp_set_i2c_speed()` at line 232-249: confirms the same pattern
  in a third location
- The fix is self-contained with no dependencies on other commits
- The `mcp_cancel_last_cmd` function has existed since at least v6.1
  (introduced with the read refactoring), so it's available in stable
  trees
- Author is from Microchip (the chip vendor), adding credibility to the
  fix

**YES**

 drivers/hid/hid-mcp2221.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 33603b019f975..ef3b5c77c38e3 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -353,6 +353,8 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 				usleep_range(90, 100);
 				retries++;
 			} else {
+				usleep_range(980, 1000);
+				mcp_cancel_last_cmd(mcp);
 				return ret;
 			}
 		} else {
-- 
2.51.0


