Return-Path: <stable+bounces-253974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1U3UN4wXEmo+vAYAu9opvQ
	(envelope-from <stable+bounces-253974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 23:09:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A15C0CBB
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B4D83012CC6
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE7A2DAFCB;
	Sat, 23 May 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/9jvAYV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C526F2BF
	for <stable@vger.kernel.org>; Sat, 23 May 2026 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779570569; cv=none; b=VMYzyXrKLUhx3HyofFTtJVha6j9DzMvOtkqyIrtu9nYOecy/Y5ip1Vo+OG554HGFJfVuX7h7TleA26dhYFnlky1cIPIcyjgBux3JtE+LSaRFrCxTjvooKJt2otlX4sI1ELW33KCuPHy4Ty7HAc+fqM/lFmCvUviNcxzt/aOPb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779570569; c=relaxed/simple;
	bh=KihGDAIxlG3pDPyysBwv9ghwlEO+2NxzDViWqAUay48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neuhr4wcOPByySzMQdb3LGour23/9kCZ2glDe5qTPb0xFPBeSoHblIRZnguLDZFgd1pw+rInKDCf6k4JskUZhMJCI7JYHBoNVvnUPTcKbw2vYYNpQ3qj6CibXrTap+chfwIqJQdCXXjQZklaRVJodapSUwHcRpNx1AP66aYMtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/9jvAYV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83ec36a13e9so4137391b3a.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779570567; x=1780175367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOrc7TUYA1VZjAj3FpFbAmZl2qMxqvGuE8h2aBD3LuU=;
        b=s/9jvAYV/uYm4eowdCWfXiWO15LTsZUI1xkL+o8wiahgjXM0igzSS9/nUsHdGY3YAR
         bPH+9BZFmM9ajFCN71WpceUlWqdHXB2vVtd+A4tDtu8VIabv6IerP1R7gHLBNAIV9QHD
         HdGDvtuzvmBwLWg1WREHYZZ6/pUpGodABa7DadW876YYrPW4FMEzFiDbbInBde9G2Zmw
         R3ckXz+pP6qWfn68LSWP/MoXAI3K7kQNRy3v/1hxtQPyH2Oce9YQwVHkz12qmPwaKWds
         J5+UZse25BFWoI7fTIGSm4sMxe+Xbe3XOsTFFcGtJxKDxBiyR8FdMesy8FHdyRFSyO6d
         vYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779570567; x=1780175367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOrc7TUYA1VZjAj3FpFbAmZl2qMxqvGuE8h2aBD3LuU=;
        b=miswVa2Q3N8/LhtZSXQg2JeiCJbUvKPkwuBkiF9sGXqcMnK8iwN/pZz2g0lWplnWp2
         VPBGD9iwmoN78vf5LfxyCQNOiuVEm6J6z9zgio5OrGdBh/H+hzNq2fQkxbOdjY+e+WH2
         OWeVr24WqhiHi6YshR6cAkAxLyUMntze9AR30B8fsyikjcV3uBtugrQLNaf6DgcSZ0WG
         lQkMbpV4HxlhxGyCjhDS7dOnNmSG28pRSyDla/diqD6bEmitAkI2tPRhBooEaVXr2abw
         zRlV1TbTKuOr4be1t6C5tGaqsEjqpnBwJP7BTxRjzaSnyJqv52gMZFmtCOZh50/paP1a
         FxEA==
X-Forwarded-Encrypted: i=1; AFNElJ+06wmeKHMrmGCIDrM0SGjOWPYx9Bmz5b1yH/NLJ0NvCx09htV+CiyoGPSCMRWGQ871PU1k41o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIpn6q9VPqGaE1jY8OwhU5aW+6+bb3jujk82Iioru1+p8Ek4bF
	3aSvIrrgaXWBNAkdlAidkfUfsf+ZcF+Mv58DLWNmBrQxqLizVGk70Y6/
X-Gm-Gg: Acq92OFLcyE+vJGzXhxpVP5+zlHRDi73YKWmxt8bXY5n7VYdoBz6jWCMg6SLmP8fcct
	Vz46Y3/7EJgDodBx+raMvafYVd2r5myTPWsqVbk0pSjJ7Zg7Ctd4Ea1gtPDo+CaoewacpkxQC/U
	Y88mEmcwa1q+jymCvOzSQ1y632kXcOKAP62/77XXp8obUrPMeGiKTzuTuAQQpDvbgk+0+ZU+DZE
	IZDvcFyKWF5BpqaLi9p3bNZGhSc/dpgp60cqXtwlDJDVq298re3bIriQx6naOlYq724DUTrYy1R
	Nsy1jMZnxdE898G/Bk8c3kiTTkz6QyKrMFwnjIllRWwVW8vEVJzaxUGHC7hTjRyBZqtNhErtMig
	gpdgmWPM44978LZpkE/MwVhy9Vbbw86Nj7QQkELxZSIF7GR11jsCxUlnnN5L902hgr9tVMvVJDI
	jMNcvEBEAxsfHaAsVCgMGIQqqrE3eRpGgCw5OBMdwF3e9oUVhYDqFSMmA8xF+teBrVHkMJ0ojIj
	QNaE62YSHGS4NjYhI4A6u+OCOZSeoEEr4koBPPT4zRQGS0tOyTcEXZ0XqYGvWEODdjxWjo3phoi
	u0GPthHN0dmiqUirdeuRNw==
X-Received: by 2002:a05:6a00:1f11:b0:82f:d34c:ccc6 with SMTP id d2e1a72fcca58-8415f1e0b31mr7824111b3a.10.1779570566997;
        Sat, 23 May 2026 14:09:26 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc646bsm5406884b3a.46.2026.05.23.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 14:09:25 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 0/2] accel/ethosu: fix two command stream parser bugs
Date: Sat, 23 May 2026 21:07:51 +0000
Message-ID: <20260523210840.92039-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253974-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 528A15C0CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While investigating the IFM region index out-of-bounds fix already sent
[1], two additional bugs were found in the same command stream parser
function ethosu_gem_cmdstream_copy_and_validate():

Patch 1: NPU_OP_RESIZE unconditionally triggers WARN_ON(1), allowing
any unprivileged user with DRM device access to spam the kernel log or
panic the kernel if panic_on_warn is set.

Patch 2: NPU_SET_SCALE1_LENGTH on U85 hardware assigns the user-supplied
length to weight[1] instead of weight[2], mismatching its BASE handler
and corrupting the software bounds-check state for both weight buffers.

Both fixes apply cleanly on top of the IFM patch and target the same
Fixes: tag since all three bugs originate in the same commit.

[1] <20260523195159.55801-1-meatuni001@gmail.com>

Muhammad Bilal (2):
  accel/ethosu: reject NPU_OP_RESIZE commands from userspace
  accel/ethosu: fix wrong weight index in NPU_SET_SCALE1_LENGTH on U85

 drivers/accel/ethosu/ethosu_gem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.53.0


