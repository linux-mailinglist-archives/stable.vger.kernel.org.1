Return-Path: <stable+bounces-12989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5476837A67
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26789B2AF8A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98F12A159;
	Tue, 23 Jan 2024 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbbV6/Ny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE973129A63;
	Tue, 23 Jan 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968740; cv=none; b=rhx7Vh13aySWGMseekgA84sbrJ60KUJyigggyk1KmTMrwMbojzh7A6c9bpnXLpgrfaVb7Sjglaj5pbGit64BM9O2IhCMpPqIHdi0O/VtHAn3Yecs0mnVeBq0fJ1Fh+nMyl9meNxxmpXbmMAznbr7POl3qJLRPqt9WM9zI5MVyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968740; c=relaxed/simple;
	bh=xEuujTfw8EYK+6BVZP9YTwRrAmmoGmzqu1qd5JcfeKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvQhMeekKaoxCdS/epaGTlYefSneejrXJwT/6svLo73wM1wnEda1AXaNxHADcwM8NUOP3+b6cPmKGsWCxmLR+vgerNJtE0/P7ZoL7aaN8KuIHxN4ZONLAJGHlPkW65/Zhbik5TC/WzaJVFY3+aGUl/DjZK8JatpFhPmJnOo6ezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbbV6/Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C83C433F1;
	Tue, 23 Jan 2024 00:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968740;
	bh=xEuujTfw8EYK+6BVZP9YTwRrAmmoGmzqu1qd5JcfeKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbbV6/NycpoZJoAhfF+jLADc6lasYg0G2cb8X8vv0WB/AuCkyszs4AtTTm6gc/YpU
	 JMznXRB7MgsNglXmOLFnoxIpc/7K2XgFKhmomRZ76eRIfkA07etpAzoTzwx+aaPyij
	 KpdHy4MX+fm1OxH2lnee21Q4NrlWuvHPO81ataBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shang Ye <yesh25@mail2.sysu.edu.cn>,
	gurevitch <mail@gurevit.ch>,
	Egor Ignatov <egori@altlinux.org>,
	Anton Zhilyaev <anton@cpp.in>,
	Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 024/194] Input: atkbd - skip ATKBD_CMD_GETID in translated mode
Date: Mon, 22 Jan 2024 15:55:54 -0800
Message-ID: <20240122235720.261748766@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 936e4d49ecbc8c404790504386e1422b599dec39 ]

There have been multiple reports of keyboard issues on recent laptop models
which can be worked around by setting i8042.dumbkbd, with the downside
being this breaks the capslock LED.

It seems that these issues are caused by recent laptops getting confused by
ATKBD_CMD_GETID. Rather then adding and endless growing list of quirks for
this, just skip ATKBD_CMD_GETID alltogether on laptops in translated mode.

The main goal of sending ATKBD_CMD_GETID is to skip binding to ps/2
mice/touchpads and those are never used in translated mode.

Examples of laptop models which benefit from skipping ATKBD_CMD_GETID:

* "HP Laptop 15s-fq2xxx", "HP laptop 15s-fq4xxx" and "HP Laptop 15-dy2xxx"
  models the kbd stops working for the first 2 - 5 minutes after boot
  (waiting for EC watchdog reset?)

* On "HP Spectre x360 13-aw2xxx" atkbd fails to probe the keyboard

* At least 9 different Lenovo models have issues with ATKBD_CMD_GETID, see:
  https://github.com/yescallop/atkbd-nogetid

This has been tested on:

1. A MSI B550M PRO-VDH WIFI desktop, where the i8042 controller is not
   in translated mode when no keyboard is plugged in and with a ps/2 kbd
   a "AT Translated Set 2 keyboard" /dev/input/event# node shows up

2. A Lenovo ThinkPad X1 Yoga gen 8 (always has a translated set 2 keyboard)

Reported-by: Shang Ye <yesh25@mail2.sysu.edu.cn>
Closes: https://lore.kernel.org/linux-input/886D6167733841AE+20231017135318.11142-1-yesh25@mail2.sysu.edu.cn/
Closes: https://github.com/yescallop/atkbd-nogetid
Reported-by: gurevitch <mail@gurevit.ch>
Closes: https://lore.kernel.org/linux-input/2iAJTwqZV6lQs26cTb38RNYqxvsink6SRmrZ5h0cBUSuf9NT0tZTsf9fEAbbto2maavHJEOP8GA1evlKa6xjKOsaskDhtJWxjcnrgPigzVo=@gurevit.ch/
Reported-by: Egor Ignatov <egori@altlinux.org>
Closes: https://lore.kernel.org/all/20210609073333.8425-1-egori@altlinux.org/
Reported-by: Anton Zhilyaev <anton@cpp.in>
Closes: https://lore.kernel.org/linux-input/20210201160336.16008-1-anton@cpp.in/
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2086156
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231115174625.7462-1-hdegoede@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 46 +++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 7e3eae54c192..380221dbfc19 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -715,6 +715,44 @@ static void atkbd_deactivate(struct atkbd *atkbd)
 			ps2dev->serio->phys);
 }
 
+#ifdef CONFIG_X86
+static bool atkbd_is_portable_device(void)
+{
+	static const char * const chassis_types[] = {
+		"8",	/* Portable */
+		"9",	/* Laptop */
+		"10",	/* Notebook */
+		"14",	/* Sub-Notebook */
+		"31",	/* Convertible */
+		"32",	/* Detachable */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chassis_types); i++)
+		if (dmi_match(DMI_CHASSIS_TYPE, chassis_types[i]))
+			return true;
+
+	return false;
+}
+
+/*
+ * On many modern laptops ATKBD_CMD_GETID may cause problems, on these laptops
+ * the controller is always in translated mode. In this mode mice/touchpads will
+ * not work. So in this case simply assume a keyboard is connected to avoid
+ * confusing some laptop keyboards.
+ *
+ * Skipping ATKBD_CMD_GETID ends up using a fake keyboard id. Using a fake id is
+ * ok in translated mode, only atkbd_select_set() checks atkbd->id and in
+ * translated mode that is a no-op.
+ */
+static bool atkbd_skip_getid(struct atkbd *atkbd)
+{
+	return atkbd->translated && atkbd_is_portable_device();
+}
+#else
+static inline bool atkbd_skip_getid(struct atkbd *atkbd) { return false; }
+#endif
+
 /*
  * atkbd_probe() probes for an AT keyboard on a serio port.
  */
@@ -744,12 +782,12 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (atkbd_skip_getid(atkbd) || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command failed, we check if we can at least set the LEDs on
- * the keyboard. This should work on every keyboard out there. It also turns
- * the LEDs off, which we want anyway.
+ * If the get ID command was skipped or failed, we check if we can at least set
+ * the LEDs on the keyboard. This should work on every keyboard out there.
+ * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
-- 
2.43.0




