Return-Path: <stable+bounces-148584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24CACA4C7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DEF3AC9AC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21D29C323;
	Sun,  1 Jun 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLpwMKdh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C126772A;
	Sun,  1 Jun 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820861; cv=none; b=Truss2jxthaqr8IsJyFBB/lgLUiCSH9j3LkhvHDFmriTh8VKgjMxrfj7ESDN4wgO5s0Oe7iArQHP7gpWgkT0l9meurS1RnS+re5/Z7cn00ki9G3TOvaQqTIKK/MmA7Gs76vR1Ezr6RyI1GAtmvekKYWH+QnyPO1IBeG9Qr4p7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820861; c=relaxed/simple;
	bh=1sFqwam7WYdIZngnkrd5IrGghJpYhTq/yt6S/J0w+WY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFUPwnKP2AGjtiHKERRqvMLJ4db/cZsvJ+ERQeZNTDyFmDOKdyNraJ42TxmZylbyGvpO39DSGlz9sOW1WeryER7DRYHhvERXTk9U2ruOwLYmLyO1EYdlXeF+BkDf5Vwmwg56D77gtpA8uVxJmdf9Ct2qfqL7g+dTeh0j10I6PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLpwMKdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03BAC4CEE7;
	Sun,  1 Jun 2025 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820861;
	bh=1sFqwam7WYdIZngnkrd5IrGghJpYhTq/yt6S/J0w+WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLpwMKdhcUT9HtNmgdYpndPkigHObpRsXGACFpNHMzHM4o+++NUcR2PxZ5Mpuvuuf
	 rWvhKeyfoGh9Hs6Co+HD8YDGsf8DOwZt3HMLdYIIjgXrP74ARTQWXs1ispOy+DOb06
	 ykq7Yd+/HKBEgeMhTOTzh4B4I5TResDbOmheMgiXtso1vYp6U3ZW/Xyfsm00Mez0r9
	 3rIoHDNIGYHeRQ3AlH4EK1QAB4ts2Tm69WnYwFgmmHBkFEJgIMWtXEsg8rmgsMmSeV
	 q7PoDtWdUkpGN4wzo3P7Jc3tsibFIZ0b3aL0MADGlguctqo21/4vlVNUBY/ABjoRPA
	 GWcg8y0pu1+BQ==
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
	arun.r.murthy@intel.com,
	suraj.kandpal@intel.com,
	andy.yan@rock-chips.com,
	abel.vesa@linaro.org,
	mitulkumar.ajitkumar.golani@intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/93] drm/dp: add option to disable zero sized address only transactions.
Date: Sun,  1 Jun 2025 19:32:33 -0400
Message-Id: <20250601233402.3512823-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
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
index 9fa13da513d24..15e9b867fee87 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1900,14 +1900,17 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 
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
@@ -1926,6 +1929,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			msg.buffer = msgs[i].buf + j;
 			msg.size = min(transfer_size, msgs[i].len - j);
 
+			if (j + msg.size == msgs[i].len && aux->no_zero_sized)
+				msg.request &= ~DP_AUX_I2C_MOT;
 			err = drm_dp_i2c_drain_msg(aux, &msg);
 
 			/*
@@ -1943,15 +1948,17 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
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
index 279624833ea92..c6b32920cdc9d 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -518,6 +518,11 @@ struct drm_dp_aux {
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


