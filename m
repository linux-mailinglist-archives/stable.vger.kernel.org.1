Return-Path: <stable+bounces-254048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD2IIlNCE2qo9gYAu9opvQ
	(envelope-from <stable+bounces-254048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 20:24:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CBA5C363A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E16D130097C3
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426E30C159;
	Sun, 24 May 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1D89wyA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5830B521
	for <stable@vger.kernel.org>; Sun, 24 May 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779647043; cv=none; b=GM4SBZKgBf1DMJHxo217L6dzbmjPI2z9H2sIbrz/16fIbiHjnNErl7XaeU637O4DFmQ3u/fCxpjmXHfMmLvYMWFKJLjpdjgCWlWQYLaa9Kq+TH7+t9WYINQkuJDnPgmwICeylrzdcRrsVY17S7pVMaDj3vqMQoMhHhSgWGjHg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779647043; c=relaxed/simple;
	bh=R+ElcQoZlMTaMjyb0gfctea/sh4vXsBf0F0G4P4BLk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nE633orz/f32M7taSxQ9ZoyxTehd0/MPsmtt4+ECFLYfkSlIrCg/mWKSrR0GXWUSo7Ey9wqcJhhhUadcpIoNMFuH7vz5qXUHYdWlnUVd2ixwTTTk3kgLbxJSJMWmqpgPTBvxzZ/EwKt9FZPlNRfBVcyaw39Qh/gVifxlktMAP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1D89wyA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso1526148a91.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779647042; x=1780251842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/VRKGhpClL2qx91sk96jvJ7Ms8mqjpuQNfM6bhiFpk=;
        b=n1D89wyA/25OwTCi1uGLn0ssL9VXUNEDvgo35J+DfKldJiCnYSYmo0WcNJZ9FqmNzX
         ljfTdM25ncH33x4suzTW2Y4vCb9rhjj2PnAQx9eyCrPYhw452Y+DQxa/VUw7aRXrEJSg
         zoCl7b3BzkPJ1o1rV0sWkLI3bUvxCmci81kEfINfhP3lfFHcsWFfx0FL03fzAaY5Irre
         LLLKC6Foqd8w0kDmNDS7gclHj9wfG6nO4Orny5FP3P1nWDwpFghV4qf37pGcCJrqGNSr
         3q8NjxtwDnsa5m7X5QeiD8P6Ia8szOO08QTqeymbR7eNlEwqIjzrVm7NuaT7yDW4JEQx
         +8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779647042; x=1780251842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/VRKGhpClL2qx91sk96jvJ7Ms8mqjpuQNfM6bhiFpk=;
        b=EFGx3xtI5f32TOo1HvsmKL4nD8Z9h0pr2S31zLTAPMipaH1MlwygqV43b+dP3vjYMr
         TSVYLx3aU7Ny+W5bBLu/l0Pf1qFahOVZBr4q5ONNS2ql1N8NT8hJXVw3uXgm+TICjwMq
         kDqQQibyRMHCgNXGk1FmNVE0o8J0duvzY+hG7deb9/Q1aAUXdfoNKL7FCJbwUw6VJ5yL
         1qBfrlzFH/DygRXskK6uwEhPn9NdZR4KgpV+Uqu+dhpz/XhuAj/Vn82uRaCR+zOXHte0
         uAm2dLg/BuJ4m2BqsOaTUieUntzbHgXXbV66y7XM1PndVPTSzyTGb3uHRy7LMWSig+wi
         jc3g==
X-Forwarded-Encrypted: i=1; AFNElJ/HCoTME4fDSko8DV5Jmw2yRpMFN86FxNRpGgn+cOgq83O9pJDKWqrVdI57qQL3OQqDWHCTMPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLaiX/di3cduDNC0ZWluhjEU4ZWM4RAhCY1/pvS/4RTPm5qwm
	5sMYtRoPe/AmXw2iWPqgmunsx/Jl0WQm9qDjXk7F1WzVDjzsQ2siqVo=
X-Gm-Gg: Acq92OHWi9OvDZbEnencJELlHNqnxeLKj6AcGGNxKECWJkLq7bQuGuc9g/nIHVVAysf
	AJ4lCd9dpXcB1B168sOk26uNQDNqZTnZxpw9eUQEdankRWzPYfniM0ukVn6MjgJVGiGmYH1zV1f
	SYwZEaE3VQOjqS/UHE/tQPlZetJerocqcUghIiqPVUhUlQCxc9RXw2+n0Ke/H5e0erCnNVpEMin
	L8ycKRKyu5RRuJEB7kyD5ulPyYN5WcsNON5GfWxhRZi4rGLlfjQAKNxOc24lAfdVEJalw1yKTUR
	fTp/n9ggLpIsBPxzhG8e1qLDZ0Uf1HAEqdvq6+hIY92rIKR4y2dak/ykTFxt2SqbDrqvyeLt0U5
	yDaC4a9LUb+FvABNsBXHYN/GJU023mMd2Qk1tLmVMhAs1WlNCndYs/d6Ln2fwqcCuVcfdzI/Mtg
	EIZ7aEg+EedDlDv7XewxB6tUvCV7Q3IDdWwoEK/MWyMUgJ2eVtsZCnRDBdA55a/5iqV79IDxM=
X-Received: by 2002:a17:90b:5485:b0:36a:aeaf:ab2a with SMTP id 98e67ed59e1d1-36aaeafabf7mr3895058a91.19.1779647041960;
        Sun, 24 May 2026 11:24:01 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c7b4febsm4419208a91.5.2026.05.24.11.23.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 11:24:00 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] Input: rmi4 - release F54 queue on video registration failure
Date: Mon, 25 May 2026 03:23:45 +0900
Message-ID: <20260524182351.27658-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254048-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 27CBA5C363A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rmi_f54_probe() initializes the videobuf2 queue before registering the
video device. If video_register_device() fails, probe only unregisters
the V4L2 device and leaves the initialized queue unwound by neither
remove nor file release paths.

Release the queue before continuing through the existing probe error
path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 61909e1a39..fca7b9fec5 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -722,6 +722,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
 	ret = video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
 	if (ret) {
 		dev_err(&fn->dev, "Unable to register video subdevice.");
+		vb2_queue_release(&f54->queue);
 		goto remove_v4l2;
 	}
 
-- 
2.47.1

