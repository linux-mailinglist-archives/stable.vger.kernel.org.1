Return-Path: <stable+bounces-83118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642C995C20
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 02:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B441C21E9B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FC801;
	Wed,  9 Oct 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z98Tdieh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0236D;
	Wed,  9 Oct 2024 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432819; cv=none; b=TdfUzDVNkGJdYFcy15gwkpfDLNJEcnhxafB2sTuL8U7tjIzE/J0VVkGwQUdpjmOjup9B7GberdOJCqbPbrENGtO2VBjoB/syny+sw+8JXc/nteAKamYRh9RIuV3lqNDJKdSVynDp03HDFOHJGZI4Wr2Cel9o5h7I4azg66L5S64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432819; c=relaxed/simple;
	bh=vXzqY+YmGl+wu9XK3ngPJRVROGgLtUdeSl89qbBhxVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrXDfNnykW/lCgo0VFf2fWpkkA8VYfjXoge3n+h5aC0vRLAjKjMCaunkGx1+SoLNZofOkqCXp2l5122psjBelZs/o2Ax5bZd5WFzRJeCYoO2U2XSgOnnWVvG1jjs/hRf0elfmfC4ctrRitr9zFPHLK8Ou/5KPSNlvgEnBA2aVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z98Tdieh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e29f671dcbso226251a91.0;
        Tue, 08 Oct 2024 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728432817; x=1729037617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4zc/nDZMEoMGVJDHVfAq6hyQML2MOQDaBTZK68tFnU=;
        b=Z98TdiehJbNdJazVaCprHTZ5UhsBJ3fGIcULoyN+mDnnpgwXaKX2M8nrV1xAY0Ffl3
         uWaqtBwLkUdHi+ffwiig93f+PV5kjHR3Qetr/vBDt6SgqkWaT2KBt1RRnrWKtOIzBuUq
         nC5oqa8O17dhowmUTtDyZ3+aFLCFcQGgTrtF6wC5E9wMx5PEDwHbEfXPUxrTWkED2QWd
         ++HKTdIdKTtiPBk8ImYiF6q/re4qXm3aHbwRLIb3OexPdCaaGYsYRgfwmoM8ITdS+BbS
         PV6qw9KPEdELGKIy+h0DMIvIWE0/T5Ykpetmr6uiYwF0VMZjwW1VefCpld3e1T7sOjd2
         OtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728432817; x=1729037617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4zc/nDZMEoMGVJDHVfAq6hyQML2MOQDaBTZK68tFnU=;
        b=BIHXba/dseT72wXlk2jPuOutW9QwEj6G+79Nuo0vkfNNk/giaZvac2f4bazgNZGdeD
         zER8cs9YDhBXP7PPy2p/AGig9qM6LkHO09JOtVqtqaxBF+QHtQkk3W81kox5yguMIVh5
         wyCVBQXGG+afeJuDB6xLn4DxojDdUVS1vkYRYF+z7J99SIslY36lpNykwBVs2hcR8TCZ
         HK6sCEr/NG9WxIh+cybNgTnvswN5Piyv4XDiXo4e7VgLm+Cd8oIvzWe6oIMEjlY3laAN
         5hKkXNPORpYX344cpfeDr6Wuc0vLK8S7Zoye+s73I106RJ+8weiEpXwKpUABUMK0Kqge
         o92g==
X-Forwarded-Encrypted: i=1; AJvYcCVzOAFA42uDwbrW8WczQ7n6edFtOJxNO0vUwIIsEs1fJSOc3qT3gFimVaCcY3HQSCi6LVXZWYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZ0LM7eipJKqMWcSDPinYSnDUbGai38UgDOQPsMmo6Af2jVnp
	V5yncXV7cgCxZQRFzacS85YC5H6jVTaCEFvjGeYk0V36TRHEMJbmRCmgBA==
X-Google-Smtp-Source: AGHT+IGicfGCKBle1q/Q/g89yOKHo+zwmrRvrBKXc/eAq2cEcKbDufyz4I6unfGKRP18sSWhjNX/3Q==
X-Received: by 2002:a17:90a:e657:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e2a07a3e7fmr1194288a91.11.1728432817110;
        Tue, 08 Oct 2024 17:13:37 -0700 (PDT)
Received: from localhost.localdomain (75-164-192-68.ptld.qwest.net. [75.164.192.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a57078f1sm200321a91.19.2024.10.08.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:13:36 -0700 (PDT)
From: "Gerecke, Jason" <killertofu@gmail.com>
X-Google-Original-From: "Gerecke, Jason" <jason.gerecke@wacom.com>
To: linux-kernel@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>,
	"Tobita, Tatsunosuke" <tatsunosuke.tobita@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: wacom: Hardcode (non-inverted) AES pens as BTN_TOOL_PEN
Date: Tue,  8 Oct 2024 17:13:32 -0700
Message-ID: <20241009001332.23353-1-jason.gerecke@wacom.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gerecke <jason.gerecke@wacom.com>

Unlike EMR tools which encode type information in their tool ID, tools
for AES sensors are all "generic pens". It is inappropriate to make use
of the wacom_intuos_get_tool_type function when dealing with these kinds
of devices. Instead, we should only ever report BTN_TOOL_PEN or
BTN_TOOL_RUBBER, as depending on the state of the Eraser and Invert
bits.

Fixes: 9c2913b962da ("HID: wacom: more appropriate tool type categorization")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 59a13ad9371cd..413606bdf476d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2567,6 +2567,8 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 		/* Going into range select tool */
 		if (wacom_wac->hid_data.invert_state)
 			wacom_wac->tool[0] = BTN_TOOL_RUBBER;
+		else if (wacom_wac->features.quirks & WACOM_QUIRK_AESPEN)
+			wacom_wac->tool[0] = BTN_TOOL_PEN;
 		else if (wacom_wac->id[0])
 			wacom_wac->tool[0] = wacom_intuos_get_tool_type(wacom_wac->id[0]);
 		else
-- 
2.46.2


