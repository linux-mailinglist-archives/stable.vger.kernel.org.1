Return-Path: <stable+bounces-249092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKlXOBfICWropQQAu9opvQ
	(envelope-from <stable+bounces-249092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 636035614CA
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47AFB30048F3
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A70826A0DD;
	Sun, 17 May 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcMyu/Yi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC11A9F9F
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025941; cv=none; b=FDD2fkFNwHZHbIXEb1o53/4+eY1h52r3ODYWBs04j30xnYWadVgeiB4Ur5tNTMos26VwHNza1u+4VrzYTvstSpmfLEKq9npEoFKvs2O5rsUYzG8gWYZ7p1JEPnm+E+/d7yRQon4VQzext/g4YYGk0dnd5YH8gbhsp+tObWKZ6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025941; c=relaxed/simple;
	bh=h9wtCFyFzLcO5jEPh6ZyLGnKzsR9VPlqSRMjF9S/Z5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKakzwqe5gtk9gyWqSJGPmWXwHN5ZoQuhsx4oRDgTJQTQi6j+pylyW24l98zGDaqCHZnJK0pktYWo8+DbEwe9fh4OpHkxL04+lZS+fulLoUTakC2uXoyFkyOO9hDVuFjge9KR6dyBQnrMuHkyykxROHAIokPP/toyyA5cNJ5YSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcMyu/Yi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bd80b3aa13so8253315ad.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025939; x=1779630739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgCyM9TX/SDLwUVzAsJaESZmJB2eQmJkR2yeVp3A4iI=;
        b=AcMyu/YiHnuv8UHNrshBKcUHaBruU8r/Mcv/3mpYinz4ZnZkcwnmbwP78k3L1nLOSG
         mRUHngbLMUiR180OjGSjLSqJYRNF2nBMo97GMLTN/Cbb+W3U3gePvaFnZgQp2UFdCf9r
         hvFv/NHudjvZj4PhBnn2qtnuVZXEKbwfhJFsmHA78qYpHnG8vci8Vxo0ODMyg3S85l3H
         ZA780cCPO1PtW/9nMoQ2RCSVynehZSsDATBhIRkKKylV1Zl8upVup62sVXpBi7GRlWUj
         8nOT/6B0JoVivvnwsKYOtVCGv/FdH45N1h37KBikvyWr9QupLmiJOdQW0ZcoVNaiazCe
         lj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025939; x=1779630739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgCyM9TX/SDLwUVzAsJaESZmJB2eQmJkR2yeVp3A4iI=;
        b=ddBpWf+zPSINu35u1q0rEnNDX1mqQ71e3T6HhAkrj/V1MJUPSobklOkazuxvDIbUes
         vkAiDrhEX2lVzaFuFOpyw6XLcS6HlH8NfSDJ2iibeKYY5+rAfdBc72PrmbAje753Jiey
         vDt7kMzxZjAVAkIK7M7gB/aS8vRfdHCN97C1YkPxI36UbDOnx/VKPXKj+F1jVlXrq2I2
         mxZdW4LBGpuEQA9Z+D8qhmP56K1HH6CqJ3t9NOwx39THwDxCOZBBHECBOih7FcFYDTQq
         vSpmG+wlJOWKxTZqtX3ENPbJL6/ZvlZRKL9SZxJ/kCRjF/y9K+Bqlln+7+wKuiYjDMpL
         UaUg==
X-Forwarded-Encrypted: i=1; AFNElJ9/EYD16hHKtLeFOpiXV0GAC7qpb3CqFreVgH3a+arsXNvnCyQnNFYYZXVb/8gWKAOODyQ05pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tfEd5RM4/pJLA68OR1irIrQ+Vf3dpn6eXTZxK0ght0W0PPFU
	Ahaonun6+RqBy4gj9pUumbXOdTViBoeWQvjCoCbIENyU6gHmV7YTbaH2
X-Gm-Gg: Acq92OFJ7t/S5nWCGe+xtoIjPBefWLv5q3YVnjl9pedkwqszoLnX/75G3PTRYICYXom
	CIZGcH9mHveFvclF9HuMOydDTj9inc7C25XTjmdq4+KwYHrLBfI/mKGeGq+U7fh+VlTJsR6gFXN
	0VFK9nZMc0vEZlxWtGagrQM4WeK14AKKI+1zprlMJ/NDqPivNvCuJPVST+0FkFw2LGyrW4kkAfl
	BWPfHhcnXWzhABld5BOtWaNtCJj1o2vj0Ms4MQ4LSnYZzdpuOs1ke+HFKMGqA6UNiq0VgOAzODS
	KzUnUjx2eBwDCqPqmH+VVw9xlN8FdiZYMn8KCrzFEbWVi0tQk1E/VdhcgitSJMC0fdrp7yRregd
	au62yd33MKeXvQi3eaEyrb+PrSPVmloDodROssY0/eQ0Kt/u69LX59J5KQMuj6Fxu91VldmfZHL
	Blbm0UnKbR4lCDVu3uiEC4sTv7ZiAXHFTstoRZEFYbMPubepUT
X-Received: by 2002:a17:902:8303:b0:2b9:f8e9:70e2 with SMTP id d9443c01a7336-2bd7e782ec7mr93513875ad.8.1779025939377;
        Sun, 17 May 2026 06:52:19 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:19 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 0/4] HID: wacom: add report length validation in irq handlers
Date: Sun, 17 May 2026 22:52:11 +0900
Message-ID: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 636035614CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249092-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Several wacom IRQ handler sub-functions access fixed offsets in the raw
HID report buffer without validating the buffer length. wacom_wac_irq()
receives the length from wacom_raw_event() but does not validate it
before dispatching to the sub-functions, which do not receive the length
parameter.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Note: this is not mitigated by the recent HID core bounds checking
series which validates actual_size >= declared_size. An attacker
controls both the descriptor (declared size) and the sent data (actual
size), so the core check passes. Driver-level validation against the
expected hardware report layout is still necessary.

Tested with KASAN on Linux 7.1-rc3 (slab-out-of-bounds confirmed) and
verified kernel panic on a production device via uhid.

Jinmo Yang (4):
  HID: wacom: validate report length for PL and PTU handlers
  HID: wacom: validate report length for DTU handler
  HID: wacom: validate report length for DTUS handler
  HID: wacom: validate report length for 24HDT and 27QHDT handlers

 drivers/hid/wacom_wac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.53.0


