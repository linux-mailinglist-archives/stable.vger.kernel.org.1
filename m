Return-Path: <stable+bounces-148674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFAAACA587
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452EC171961
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE4309079;
	Sun,  1 Jun 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlf4Q9Db"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52A309075;
	Sun,  1 Jun 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821074; cv=none; b=DOjmqrzOhhCbtX67ZlEqKTN55nFdfghgIMBnjMOFL4XdmiEiY8kduYjJg8Lj/3tykqfms68iPG6fFmlydD5dts+9dsx1P+TAfCLSDWGNuOIbSlHgTTPCAdeJtIMCjjVgUz5udOQkuhdHzjkAIOp2w0SYPTU7we/ZzRkcKrcp8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821074; c=relaxed/simple;
	bh=oKZnUoB8V8ofoWzhkl/5BUoCMmCopf8CnGJ9r1Dj9s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/Li+H49jgm7/gNXNTYAyvGIY9RZG9ktzuc7OMlJuyHpU6XHMCEa1QOXYapd9qOfDvf1xJgvTBYSfYdtXU6RePUAmnTpRcaM7jpnro5iS/MEmnzhyQz7v9iBixdyyiDOoP9hbQaPyl8l0qDk2ClXtlzSNSjom3eAztk3f+dzGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlf4Q9Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01313C4CEEE;
	Sun,  1 Jun 2025 23:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821074;
	bh=oKZnUoB8V8ofoWzhkl/5BUoCMmCopf8CnGJ9r1Dj9s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mlf4Q9DbqzIbLl2iOxU6o2WJM6hIqb2PCmO30WIznEh+4IqA9Tg5+trCW3dI2GgqK
	 PrMXqzf2ogOOUuRJq9eUEhsj+cCNDH8cvugDvHdl6n6llwxFxbmpuKmtCbdUR9GPyp
	 iv0enMiKTSP0zlJ5zNvgN055DkWJ8P4rrkhohqK6bvLfCoFRLkvZP+3fz7wFni7ND9
	 cazCWB8doCaFznCEDLuSl7S/icz/b1KKpyF6okUyi79epTZX6n2vjph8g+fZX91fYp
	 Uk3uzZWTmSbr6vYiZUbIkyTuccq40FfosAjrAqbtHiarWk/BH1++c8EulxAnBmrH0z
	 3vzfnQ+T8dPGg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	jani.nikula@intel.com,
	imre.deak@intel.com,
	lyude@redhat.com,
	suraj.kandpal@intel.com,
	abel.vesa@linaro.org,
	andy.yan@rock-chips.com,
	arun.r.murthy@intel.com,
	mitulkumar.ajitkumar.golani@intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/66] drm/dp: add option to disable zero sized address only transactions.
Date: Sun,  1 Jun 2025 19:36:40 -0400
Message-Id: <20250601233744.3514795-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit f0ddbb1eed1898286d2bd99fd6ab64ca9700d267 ]

Some older NVIDIA and some newer NVIDIA hardware/firmware seems to
have issues with address only transactions (firmware rejects them).

Add an option to the core drm dp to avoid address only transactions,
This just puts the MOT flag removal on the last message of the transfer
and avoids the start of transfer transaction.

This with the flag set in nouveau, allows eDP probing on GB203 device.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@nvidia.com>
Reviewed-by: Timur Tabi <ttabi@nvidia.com>
Tested-by: Timur Tabi <ttabi@nvidia.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees for the
following reasons: 1. **Fixes Critical Hardware Functionality**: The
commit addresses a significant bug where eDP displays cannot be probed
on certain NVIDIA hardware (GB203 and others). The commit message
explicitly states: "This with the flag set in nouveau, allows eDP
probing on GB203 device." Without this fix, users with affected hardware
cannot use their displays - a core functionality issue. 2. **Low
Regression Risk - Opt-in Design**: The code changes show this is
implemented as an opt-in feature through the `no_zero_sized` boolean
flag: ```c /bin /bin.usr-is-merged /boot /dev /etc /home /init /lib
/lib.usr-is-merged /lib64 /lost+found /media /mnt /opt /proc /root /run
/sbin /sbin.usr-is-merged /snap /srv /sys /tmp /usr /var 0001-Fix-
Clippy-warnings.patch 0002-Enhance-inference-prompt-to-utilize-
CVEKERNELDIR-whe.patch 0003-Update-to-latest-version-of-clap.patch
Cargo.lock Cargo.toml LICENSE README.md analyze_merge_commit.sh
dpp_rcg_backport_analysis.md io_uring_analysis.txt ksmbd_analysis.txt
merge_commit_analysis.txt model prompt src target test_gpio_cleanup.txt
test_patch.txt @no_zero_sized: If the hw can't use zero sized transfers
(NVIDIA) model/ prompt/ src/ target/ bool no_zero_sized; ``` The
modified behavior only activates when this flag is explicitly set,
meaning existing functionality remains unchanged for all other hardware.
3. **Minimal and Contained Changes**: The code modifications are limited
to: - Adding a single boolean field to the `drm_dp_aux` structure -
Wrapping existing zero-sized transaction code in conditional checks: `if
(!aux->no_zero_sized)` - Adding a special case to remove the MOT flag on
the last message when the flag is set 4. **Historical Precedent**:
Similar commits addressing DP AUX transaction issues have been
backported: - Commit #2 (drm/nouveau/i2c/gf119-: add support for
address-only transactions) was backported to fix display regressions -
Commit #5 (drm/bridge: analogix_dp: properly handle zero sized AUX
transactions) was explicitly marked with "CC: stable@vger.kernel.org" 5.
**Affects Multiple Hardware Generations**: The commit message indicates
this affects "Some older NVIDIA and some newer NVIDIA
hardware/firmware", suggesting a widespread issue across different
hardware generations that stable kernel users would encounter. 6.
**Well-Tested Solution**: The commit has been: - Reviewed by Ben Skeggs
(nouveau maintainer) - Reviewed and tested by Timur Tabi (NVIDIA
engineer) - Signed off by Dave Airlie (DRM maintainer) The commit
clearly meets stable kernel criteria: it fixes an important bug (display
functionality), has minimal risk due to its opt-in nature, doesn't
introduce new features or architectural changes, and addresses a real
hardware compatibility issue that affects users.

 drivers/gpu/drm/display/drm_dp_helper.c | 39 +++++++++++++++----------
 include/drm/display/drm_dp_helper.h     |  5 ++++
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 851f0baf94600..830c27cc8a637 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1896,14 +1896,17 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 
 	for (i = 0; i < num; i++) {
 		msg.address = msgs[i].addr;
-		drm_dp_i2c_msg_set_request(&msg, &msgs[i]);
-		/* Send a bare address packet to start the transaction.
-		 * Zero sized messages specify an address only (bare
-		 * address) transaction.
-		 */
-		msg.buffer = NULL;
-		msg.size = 0;
-		err = drm_dp_i2c_do_msg(aux, &msg);
+
+		if (!aux->no_zero_sized) {
+			drm_dp_i2c_msg_set_request(&msg, &msgs[i]);
+			/* Send a bare address packet to start the transaction.
+			 * Zero sized messages specify an address only (bare
+			 * address) transaction.
+			 */
+			msg.buffer = NULL;
+			msg.size = 0;
+			err = drm_dp_i2c_do_msg(aux, &msg);
+		}
 
 		/*
 		 * Reset msg.request in case in case it got
@@ -1922,6 +1925,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			msg.buffer = msgs[i].buf + j;
 			msg.size = min(transfer_size, msgs[i].len - j);
 
+			if (j + msg.size == msgs[i].len && aux->no_zero_sized)
+				msg.request &= ~DP_AUX_I2C_MOT;
 			err = drm_dp_i2c_drain_msg(aux, &msg);
 
 			/*
@@ -1939,15 +1944,17 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	}
 	if (err >= 0)
 		err = num;
-	/* Send a bare address packet to close out the transaction.
-	 * Zero sized messages specify an address only (bare
-	 * address) transaction.
-	 */
-	msg.request &= ~DP_AUX_I2C_MOT;
-	msg.buffer = NULL;
-	msg.size = 0;
-	(void)drm_dp_i2c_do_msg(aux, &msg);
 
+	if (!aux->no_zero_sized) {
+		/* Send a bare address packet to close out the transaction.
+		 * Zero sized messages specify an address only (bare
+		 * address) transaction.
+		 */
+		msg.request &= ~DP_AUX_I2C_MOT;
+		msg.buffer = NULL;
+		msg.size = 0;
+		(void)drm_dp_i2c_do_msg(aux, &msg);
+	}
 	return err;
 }
 
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 65d76f9e84305..2c8838f3adf6a 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -454,6 +454,11 @@ struct drm_dp_aux {
 	 * @powered_down: If true then the remote endpoint is powered down.
 	 */
 	bool powered_down;
+
+	/**
+	 * @no_zero_sized: If the hw can't use zero sized transfers (NVIDIA)
+	 */
+	bool no_zero_sized;
 };
 
 int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset);
-- 
2.39.5


