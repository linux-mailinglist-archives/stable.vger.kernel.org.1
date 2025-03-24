Return-Path: <stable+bounces-125896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C95A6DE87
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB35A16AC95
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786E262819;
	Mon, 24 Mar 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSsxW11M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB3262803;
	Mon, 24 Mar 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829790; cv=none; b=LHN7mVK0N+j2yPvnw+nxH7wYR7eBEEDPOrPvx9TzFuSOs9paJ8XErARGdJvbeAnrDpnAPl/Rzewgvs/MGTx6JD/hIMdTAGJE4viGQz7wjMXv4xVGWi9F+3jvJgG3LJAn82dfmaYWJfjYXXE2C0bZfVxesnavy/cXXiNbTVaZCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829790; c=relaxed/simple;
	bh=Y+VRdVpwOlC73AoQoXEyIDCA/Ok0ui6Sh1G1sOPmJxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3zyOfkX+3mJcPDy/1qy4z/dnw6v6iOk1qZKLOkgvwXOfhoek1eYApztkk0Y7+JxxM9HDxB4nSpQt2nfql9685r+9Zqn2sTdMsLQJcnHEK22w83AoUT6Gs0dgc05PEhDLZmPSLApewDwydTpX+JD2zVqAnm6U5ngc0rirTBYjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSsxW11M; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e90b8d4686so38974266d6.2;
        Mon, 24 Mar 2025 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829788; x=1743434588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aq+e0nVBUfZDGO12W2xzeQN6WR8rPyJfLm4xkEeaFh4=;
        b=cSsxW11MRmxGF7AChIhsLfOJc9LsdsA6K5brTSgw4t8JgGPNeaJqQMpniVZSh5/yYV
         CKzKdi5XXBC3Awfw8cbkwDQ28zX9IYvf51EUwSpcSthZJZsv92R7bvYqmodPMytJwPRt
         yYEJoYseimrzUMXKJoyfR7rrZkSMe5nTAd6mhao+b0NWlpzxcvvJkWiQYBmjS/5AJIKJ
         dVcVwR/vnoYwglE087ZYErtyIXrhXroAGwof+jgj7TIyb96rxFM0OmAhoLR9NOBZhSZ0
         kNcK73ENtExLYUlm7V4MpOMS5IpknXvt2WL7Eiky87B/B346jehImk6t0G6cX64Ry/rz
         44Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829788; x=1743434588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq+e0nVBUfZDGO12W2xzeQN6WR8rPyJfLm4xkEeaFh4=;
        b=IAuWqsZO8yd6LUh23m7JoTChfQ7ato+BWsYl2PVsWhMoQnJNNnhiZerRIK5CRrajqr
         qMABTVEvddKhvtcPGQzhT5DWU00s8IlBzDc/M2xoTw5FO3/6qys/+qz/kcPdvDb4gkVB
         I73hLQ3zvh1VRSdJxX3RYUld1SnfBKQh1ibCjrBAbNZK5F+miHikJHKkpvyOFK0fxHJw
         7TvVsQ9B/NLX5qrSJl6IqBhIcHmIr8zsF/ijGQe1tM0otezOFJB3b/7Zdx23OTs2Jgcm
         0ICSXud76eEovwkGBHhDKDEU2/TofQGY8OXXaJ6BHeloDybWtH2rYO0p+siJtaJimqhP
         VD1w==
X-Forwarded-Encrypted: i=1; AJvYcCUN72hVKj/d4sIcb6/1Em3MoSqJT+MvnJrdcN5NLtP5rh4Qsbnh/CqGjZlSkf0HcAK3N/pn3f0cmmbuUQq5stnoIK2NOw==@vger.kernel.org, AJvYcCUeGlMFIShZC7npXOQgA3lIrnaORrh9CnfZguJk7nRBWvT3poDTgrhX+UrKpQ+JdeQCxSirxZvq@vger.kernel.org, AJvYcCXxE/Hj3JbWb9LHrIttmuAcDDrDzrFj5E0IXOWIPgjNcXYjKnysYVrbDqU1o84uCcboeF9Y1HHqrcRk6Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXH4Elro8baQ53bclVJqieVUcRkceF3KPboAE0H4L612oO5utU
	LQ/KSDU0ymjmP7gKFBWDjlaoHoLx+LWlRt2Nt5LHI89UZ+r6BjpiPK4qlIQR
X-Gm-Gg: ASbGncv8lLrkRXVteQt6Qu1laJMAUDD3mqKgjNxqF29IsVX0OsvkmwoFgSleaKszOPN
	J/09mtdjy/+vdm1HF8LOUnrM6mZ/mypVacxhcxVoxx15DQE4rvfs5STJz1SvgZ37OAWuzn+gfcX
	GLU9HvuSx59JHZ40SQSK9DDW+hFC604anrFjvgmTh+YFKYK1IjRTdQdz6eGfoq92PyzGRnUsHhp
	qXOgpATnGjJoWok4tMtXLrxAVbcHvVfnmN/eVIQk1BjjB5Pj0q0MmgjrjNLKWKcFf0mV0vhM4t2
	xhCsj1/TnLbIOrLiumXR621Dv6KvVaLaT3vT3dVE6TcsXQ3vBesUjIZ9zyU3jXHh1xY0FAv9/Ea
	p9APp94LLFjDLKNq+
X-Google-Smtp-Source: AGHT+IFQuygfgUW9Jk9gPam5XKOoHmIVZjqt+AxtwMSiNCDBATW+TtjWKumzOzDQl3cfAPFVoP8ZGQ==
X-Received: by 2002:a05:6214:2504:b0:6e8:ea29:fdd1 with SMTP id 6a1803df08f44-6eb3f27ef5emr198766886d6.3.1742829787510;
        Mon, 24 Mar 2025 08:23:07 -0700 (PDT)
Received: from localhost.localdomain (pat-199-212-65-32.resnet.yorku.ca. [199.212.65.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5b5sm45582896d6.35.2025.03.24.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:23:07 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>,
	Vlastimil Holer <vlastimil.holer@gmail.com>,
	stable@vger.kernel.org,
	Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Subject: [PATCH v3] platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560
Date: Mon, 24 Mar 2025 11:24:42 -0400
Message-ID: <20250324152442.106113-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>

T495, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
fang_handle and fanw_handle are not NULL) but they do not actually work,
which results in a "No such device or address" error. The DSDT table code
for the FANG+FANW methods doesn't seem to do anything special regarding
the fan being secondary. Fan access and control is restored after forcing
the legacy non-ACPI fan control method by setting both fang_handle and
fanw_handle to NULL. The bug was introduced in commit 57d0557dfa49
("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support"),
which added a new fan control method via the FANG+FANW ACPI methods.

Add a quirk for T495, T495s, and E560 to avoid the FANG+FANW methods.

Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219643
Cc: stable@vger.kernel.org
Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Co-developed-by: Seyediman Seyedarab <ImanDevel@gmail.com>
Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v3:
- Reordered paragraphs in the changelog and made minor adjusments
- Reorded tags
- Added Kurt Borja as a reviewer
- Removed Tested-by: crok <crok.bic@gmail.com> as crok didn't test
  the patch

Kindest Regards,
Seyediman

 drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d8df1405edfa..27fd67a2f2d1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
+#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
+	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
+	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
+	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8874,6 +8878,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	if (quirks & TPACPI_FAN_NOACPI) {
+		/* E560, T495, T495s */
+		pr_info("Ignoring buggy ACPI fan access method\n");
+		fang_handle = NULL;
+		fanw_handle = NULL;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
-- 
2.48.1


