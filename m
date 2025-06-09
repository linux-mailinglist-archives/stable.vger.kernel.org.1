Return-Path: <stable+bounces-152144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C0BAD1FD1
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A9F189039C
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3AF25C829;
	Mon,  9 Jun 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqGTwKzw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D978BFF;
	Mon,  9 Jun 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476875; cv=none; b=VQf9wcbGLFC2ygyJiFO9MhEwNY8FWkZnQdi6nXRtxMX4CNaV/qp2cljTIHRVkxoox//yga6r4jVi+5tRiugsdzkFQsv3KD/j+lJsn8EQrtuvoTAvLggfB1QRIrZhJlHux7CPb8H75dHsjyLIJb5cYecEZN1xRWS0KO6iOcasqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476875; c=relaxed/simple;
	bh=k1bS3hIyYcVofQjC3Q+Fo5wNL1PYIgw7bImeIE2tINA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlXqwb9TxKYUfkbq1kHm7r1HAnOFLMmgh/G6FdnIRGGr73fxC1nYSdkfbIAFQzZ6BIgL0eXqH7x3BQGshPb+ue3FzCzDoms6Eo+VMEzWmY3YvE80cGnyH1UITqoLUSHi/l+MthwnLbeiSsyQjJ+b7qVSCnCTYn00ItvsGoldSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqGTwKzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACDFC4CEEB;
	Mon,  9 Jun 2025 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476875;
	bh=k1bS3hIyYcVofQjC3Q+Fo5wNL1PYIgw7bImeIE2tINA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqGTwKzwJmnFP88q4dX/W77gC6is44Y6iY/N6BtUIw4menuYOJ8J6hs+uwZDOG5xy
	 Fuiv2h/h4aK8tuFYoqSEbHsJ05j47aPVgZnPv0h5QoseiOPotlbNriiigMwSjtSYSa
	 fSOxWMPrjzz2SSB2DLYIRdkckmheJ8HMQIk2Q/2wM2cbRAU9W11hFbrXHv+3wgqPFJ
	 oQ8+qFsszyJplyH2Y325hQXo5N2ZCrfnC83UkHFwD/ybqGQ3GcFsOb2QGQXALWOjK2
	 y2JhrTba4kwhkm0cXmB9xEQNnEErVKa10ZfIGvwdH7/dLYmEY1oUjPDnPwwHnzreaB
	 dc/Uy4Wn/zPFA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/16] usb: typec: mux: do not return on EOPNOTSUPP in {mux, switch}_set
Date: Mon,  9 Jun 2025 09:47:25 -0400
Message-Id: <20250609134725.1344921-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134725.1344921-1-sashal@kernel.org>
References: <20250609134725.1344921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.141
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 0f7bbef1794dc87141897f804e5871a293aa174b ]

Since the typec connectors can have many muxes or switches for different
lanes (sbu, usb2, usb3) going into different modal states (usb2, usb3,
audio, debug) all of them will be called on typec_switch_set and
typec_mux_set. But not all of them will be handling the expected mode.

If one of the mux or switch will come back with EOPTNOSUPP this is no
reason to stop running through the next ones. Therefor we skip this
particular error value and continue calling the next.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250404-ml-topic-typec-mux-v1-1-22c0526381ba@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

This appears to be a recent Linux kernel tree. Let me simulate what the
issue would be by looking at the original problematic code. Based on the
commit diff provided, the issue is:

**Original problematic code:**
```c
ret = sw_dev->set(sw_dev, orientation);
if (ret)
    return ret;
```

**Fixed code:**
```c
ret = sw_dev->set(sw_dev, orientation);
if (ret && ret != -EOPNOTSUPP)
    return ret;
```

Now I can analyze this commit properly:

**Analysis:**

**YES** - This commit should be backported to stable kernel trees.

**Detailed Analysis:**

1. **Bug Description**: The commit fixes a functional bug where multiple
   USB Type-C muxes/switches connected to a single connector would fail
   to be configured if any one of them returned `-EOPNOTSUPP` (Operation
   Not Supported). This is a common scenario in modern Type-C connectors
   that have separate muxes for different signal paths (SBU, USB2, USB3,
   etc.).

2. **Specific Code Changes**:
   - In `typec_switch_set()` at line 217: Changes `if (ret)` to `if (ret
     && ret != -EOPNOTSUPP)`
   - In `typec_mux_set()` at line 381: Changes `if (ret)` to `if (ret &&
     ret != -EOPNOTSUPP)`

3. **Problem Impact**: Before this fix, when `typec_set_orientation()`
   or `typec_set_mode()` were called:
   - The functions would iterate through all mux/switch devices
   - If ANY mux returned `-EOPNOTSUPP` (which is legitimate - some muxes
     only handle specific modes), the entire operation would fail
   - This prevented other muxes that COULD handle the mode from being
     configured
   - Result: Type-C connectors with multiple muxes would not work
     properly

4. **Risk Assessment**:
   - **Very Low Risk**: The change only affects error handling logic
   - **Minimal Code Change**: Only two lines changed, both adding the
     same condition
   - **Backward Compatible**: Does not change API or behavior for
     successful cases
   - **Well-Contained**: Limited to the USB Type-C mux subsystem

5. **Stable Tree Criteria Met**:
   - ✅ **Important Bug Fix**: Fixes functional issues with Type-C
     connectors
   - ✅ **Minimal Risk**: Very small, contained change
   - ✅ **No New Features**: Pure bug fix, no new functionality
   - ✅ **Clear Side Effects**: No unintended side effects beyond fixing
     the issue
   - ✅ **Affects Users**: Type-C devices with multiple muxes (common in
     modern systems) would malfunction

6. **Evidence from Mux Drivers**: The examination of actual mux drivers
   like `fsa4480.c` and `gpio-sbu-mux.c` shows they legitimately return
   `-EOPNOTSUPP` for unsupported modes, confirming this is expected
   behavior that should not abort the entire chain.

7. **Comparison to Similar Commits**: Unlike the provided reference
   commits which were mostly cleanups or minor features (all marked NO
   for backport), this addresses a clear functional bug affecting real-
   world hardware configurations.

This commit follows the stable tree rules perfectly: it's an important
bugfix with minimal risk that affects users with multi-mux Type-C
hardware configurations.

 drivers/usb/typec/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 941735c731619..a74f8e1a28c21 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -214,7 +214,7 @@ int typec_switch_set(struct typec_switch *sw,
 		sw_dev = sw->sw_devs[i];
 
 		ret = sw_dev->set(sw_dev, orientation);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
@@ -421,7 +421,7 @@ int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 		mux_dev = mux->mux_devs[i];
 
 		ret = mux_dev->set(mux_dev, state);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
-- 
2.39.5


