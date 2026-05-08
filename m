Return-Path: <stable+bounces-244759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAsFNSro/WkPkgAAu9opvQ
	(envelope-from <stable+bounces-244759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:42:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DD4F73A6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A5A30CAF91
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FF3233F4;
	Fri,  8 May 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d33cSOfo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E033E2764
	for <stable@vger.kernel.org>; Fri,  8 May 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247198; cv=none; b=EVL9IDPwhZbC8MAowKV0DA4OX/21j2+andMqW3a2JwFVqEfgEfnr3ju/piMvaPzoHhh8wro4icHnwCzmjOu+Hveu7hAUW/mur9KdgO2rra/GQRytSe8KF/bbZo2oRgFge+PFsPJKULtNNVsIxcGK+VfyQGxOFDXlzoEff9n/SWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247198; c=relaxed/simple;
	bh=8n0yehS13iNVaDAZix93kasE52ngYyCUKVYh25E7r34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2DdCOSbkVpZ+rf3LNJ71nDMv/XXHhNX1vUDFiqHIuPeZy69gAEcsypykIBaD0X6TA+uGUWKjaPpdaG4h3BZ1gCTb4H5HFFr4vgwdDtQtSPdznDFLKju+XkiTrSUrdatrFY5hBWjdlVkMU0xajU+Mq5qa+pn5yuxSmSyVXdgrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d33cSOfo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36643b96b99so880371a91.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247194; x=1778851994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZd1eUiorRwFr05rMbeKoJFFzjjS7oQqiyJO7dMlyuI=;
        b=d33cSOfoNeMDrnnZMZH3o85QGUXPZwl3oSsBZbu8P2QYcYtj3wZFrqHiU0atDlX4ce
         PCHduBenEFvXPQsCXMvMGSxVLZVNSCAISf6YZ1Y46DQ5sBEZi7qYA057JnUKmpGCG4fH
         +jGjwPoINgTrkerf+E3jGsqDuzgFmxzfawmC8DqGlfDJk22MQU2ipriwnZ8Sg4TRecpX
         HDQhwBi+9svT14sxHy4h9FZzEc3Nt/qZWJgA8i+H4bONkmMg2mlp7+V37m5mc/9U7q6+
         q+v0Tek8/XrugWv0M567hlox6m8kL+0xB8AZo44hjBWyQHamS0JoyIaCG4Abxtg5W0ZL
         iSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247194; x=1778851994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZd1eUiorRwFr05rMbeKoJFFzjjS7oQqiyJO7dMlyuI=;
        b=Eqri9lJ9X8cWcED43Ywogh+EY5KfWDXGQsIjA5yMoSbfPM/Pq+fw/1qDiGbfoewDb7
         /VC+nBcvJkQkJ4ewWAUzBvAN8tE+Vk0gL1RZvaLG7YbFZJy7Y7yHvZMG5/xK6ygTkrU9
         7xQsFb++7Ll9Us27rsc/4JVqBS4/RnkR+haPMV5HTHLsu7gUh3uPguIgo4AqFjeMemIO
         EmQk5GFTefPObyOt3ejczPD4Hr7qSy0FFz/Yxl/xXPGKUmopLNzuv80eXRveteGeWLYe
         XPst7eMQZrYTCz9RranN2P6YDH2oOQxD1NrUQPBPaoZMxr48IeTN9I0YOuke6jizvmsa
         1eQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Z6MludY4XwdqAQaH2i3rhl/PatVth+Jjq30gZ46B72vramOKO3lfkvZ9vSYEbYk3U+40KFiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3zTmrEFHTkm5HdKIgidC2aYc8ngrgtY4+h49X/NxXE9tz64y
	Y+DxXHtsDBxZdtGZmgEJdfIOLB0s9dFNVOdEKXINRAHRl8V0sx+TnYkTkycO9LNW
X-Gm-Gg: Acq92OG5TEtTxweznmLHKGLEgN3AjfxsuQQ+vb7II7avDCdZffSQX4LrwEXOSSfuaMB
	5EnvD8oyQEGCOKi9AR+1Wy3rttkjiSEBmeMsqW86cO2Y+kjOu/VsUMdZMmYp6/EIMB0Zy3+gGR0
	4bw8vEgieLnHhayFzS06UfYIdCj+V2LFeg+U6SZxnWma/3vTZlM+cpS3405EGSO6aFR8dC/vw5l
	jTfjgbCX1MENf7JZkL40XgnPUaPDM5JNj49/b9+WgjFLp1ewUgPOmUw9I4SJL0+z1xcrNvL1CYc
	1mOdBKD7Gfu4wT8V1/Ko1Is+Wh2flCAhpSFGCh0zmJ941wI0R/7APXKRNENM6mA0lTIr0Gz5OKn
	n/u2uxhnrrth9Qq+FOiGmT861lab6+/mKI0yVLNCuGpKmL46A3HhJUWJISN2hEgbheK18O7OXfP
	wfh5AFY639GBpkABP7kgP7x+N83Ag=
X-Received: by 2002:a17:90b:4b87:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-365ac76bae1mr13243292a91.24.1778247194322;
        Fri, 08 May 2026 06:33:14 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664d936a44sm2377149a91.0.2026.05.08.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:33:14 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: marcus.folkesson@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH] HID: pxrc: fix slab-out-of-bounds read/write in pxrc_raw_event()
Date: Fri,  8 May 2026 22:33:11 +0900
Message-ID: <20260508133311.3995013-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C4DD4F73A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244759-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

pxrc_raw_event() accesses data[7] without verifying that the buffer is
large enough. A device that sends a report shorter than 8 bytes causes
an out-of-bounds read (priv->dial = data[7]) and an out-of-bounds write
(data[7] = priv->dial) on the report buffer, corrupting adjacent slab
memory.

This can be triggered from userspace via /dev/uhid by creating a virtual
device with VID 0x1781 / PID 0x0898 and sending a short UHID_INPUT2
report.

Add a size check at the top of pxrc_raw_event() to bail out when the
report buffer is shorter than 8 bytes.

Fixes: a2dccedac664 ("HID: pxrc: new driver for PhoenixRC Flight Controller Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 07e20ff6018e..f2524547c7a1 100644
--- a/drivers/hid/hid-pxrc.c
+++ b/drivers/hid/hid-pxrc.c
@@ -53,6 +53,9 @@ static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
 		 u8 *data, int size)
 {
 	struct pxrc_priv *priv = hid_get_drvdata(hdev);
+
+	if (size < 8)
+		return 0;

 	if (priv->alternate)
 		priv->slider = data[7];
--
2.47.0

