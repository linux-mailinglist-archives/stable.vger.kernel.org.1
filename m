Return-Path: <stable+bounces-247221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JzoLDzgBWpJdAIAu9opvQ
	(envelope-from <stable+bounces-247221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:46:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625BB54368A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D07530F340E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC607421A13;
	Thu, 14 May 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqUct4S1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E542188D
	for <stable@vger.kernel.org>; Thu, 14 May 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769486; cv=none; b=Bm+naul9iA1ib8RjwgjhmxaD1c/G0D2js4Y0kxDMQYlvTpemECsPVhppFTTBXl2+uii6vvh3g2UbObhWU+Yn4lw79ZOB22CYbddG/dAHbrKE0uOIueV4R7n9OkwHQkgkzB+FQtSJ4Vn98RvYs7ABAWn1gbJaAlc5uxvHRhZxPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769486; c=relaxed/simple;
	bh=fXqG8OJzQq5/BhN1LGFZ//RGLMM3FroFMnJgxeGG3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RT8bcn7rOoh3i3LFJXMV9d5gIorrQ4d/wZ3xQBXu2f4ZnxSilgzpQjBUTHopPlMrrSqwXqJLskaxDJmDPjZQqt0uwIuPRp/oLOk/GyVB52ipwtps3LJ1W5h2KDw3aBPbXtfdjv1hbjuLt0h65brihoWy4ovVMA3wSq00e4nSJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqUct4S1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8ccfcbb3fso428189e87.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769483; x=1779374283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cs4yqTv2hqMjvDUgaOCK+Wz9d4rTDlvDlNK2Zth6ZoA=;
        b=GqUct4S1XOzhDhPEe5ySf3bE4hKJBg7K+e2jVUEd9rGrW/QBvMlL84bq9HwwM43+rw
         SQXci+chk1lIz6Mpkb5gI4/Cal6FsAJX+uQkpeWYndwv9X43rKpRInhcD6rzJiEzLKnA
         X2Jn9EQjIyCgnjAq2zeAUOrSUmlM5eg8B3NdlzqVFB7xjGIxIiBZhmSipDIc3OH/8JXh
         1WIn4jbssv10mWD+0Z6KMr1mv2b6e+XzqA4gC3BaY1gStlFfZPU0usYk67mfM12vdcW9
         1haUT0LJ5UX+SgJCy2xjO4yi9MNEb/NWIe4uEm4ROsAEnBqVxqibaw2U/8EW7K8fWffI
         gO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769483; x=1779374283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs4yqTv2hqMjvDUgaOCK+Wz9d4rTDlvDlNK2Zth6ZoA=;
        b=o5rql3bKp5G0TRDWpEcfV0uQRIgpv45pkkkFpHIhu61UGp0PvFX2pEWcG3M9K6p6Uh
         2bTK67vkmU6Os8Y/gBIszSroXDQbZ4AVWrcN21OeujMvoOv2p0VLNtgOXZLKR76T8S0w
         +Q0PxSzhmv9YF2KOEvk9/+jbvuGDFs/Gi74NsrBfU84xInInqo/PsqYPstqMh1fR2dKf
         8gAh1Rmi1sMEqynHw6d6o6ocy4XTQjmPwiGc54A7L1bH0qemD0uTnmckDc+8O1dN1MXW
         iIk0AdNybGzDGGU2a3JTMtHNqDvHNEZOSer/4aD++94iGpvGNwnp2DMWjzWO36v9G6mn
         kZ2w==
X-Forwarded-Encrypted: i=1; AFNElJ+OvoLL7lq5cecnbljrfm38iAkIV4V9LPPkcodqzWy0+R+f6Sbc2oYe1Wqucvu31g6zrimGDF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJMd8+cMMu6DZ9cPHz/6+neUoMneuCjaNJ7xNhq5WCZUa1IvL
	/ukhzXlrkiaZFOfTj8nS1g+AqmDdbwBQUzyhwBwUonp2hLXzOBl5sgv+
X-Gm-Gg: Acq92OF1ioHsHW2Itd+qG0Rz0TOG9TbS2kpdgFiaOTn0ZnPE5LuCJCCTT1NkJRiyMLn
	HO7fgzlOhTiYnytLWg+NQu8Gc5jtvLa8CqUxxv2KfNSzh1j5P8TYU8A3CphYxyJY7t77JKAnWJr
	QP3g7qQ9ZUrs+I+4cuV9iS4sTtZC8lW5cmvr8MKAbcopFqxoo/b2OKdP2ar7X2TwQMtlfrNyn88
	Baqm13PX1+YmaIgraCJgdENiFFxsGW2nHmsN2XZ/LtUPEgUtmzcF3/p5Uv8qxltdMmX4XkMNTSg
	feafYSdfCTxObupP6Lpk8GT+hEdtKD4NB9ravIbb8i0gky/Il75oe2AjksmmoA8Vtdw1KrH9Qnz
	nprwl6j9Jby6yID9Th0S42F3GHMiNoUnToKa3Q66Reem6Y/Uu6h2biEHD1mebrU5pm/yPdF9Enu
	R03c81nAQX69ZEVwIAWAh6UMs/REqdmGgNYUpy6wxN8zKX97Jo/HuzCzcKug==
X-Received: by 2002:a05:6512:33c9:b0:5a1:30ec:427c with SMTP id 2adb3069b0e04-5a8ef9b3cbfmr944428e87.6.1778769482482;
        Thu, 14 May 2026 07:38:02 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm518716e87.12.2026.05.14.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:38:02 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH 0/2] serial: 8250_dw: clock-notifier cleanup
Date: Thu, 14 May 2026 19:37:44 +0500
Message-Id: <20260514143746.23671-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 625BB54368A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-247221-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,linuxfoundation.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Two-patch series addressing Andy's review of the leak-fix on v1.

Patch 1 keeps the same single-line leak fix as v1, but with:
- the correct "serial: 8250_dw:" prefix (underscore),
- a Fixes: tag pointing at the original clk_notifier introduction,
- Cc: stable@ so the fix gets picked up by stable branches that
  still carry the notifier code.

Patch 2 drops the clock-notifier infrastructure entirely from
mainline, as suggested by Andy. The notifier was introduced for the
Baikal-T1 SoC (shared baudclk between UART ports) and has no other
in-tree user; Baikal-T1 support has been removed from the kernel.

If a future platform needs the cross-device baudclk-rate notification
pattern again, it can be reintroduced in a more general form.

Stepan Ionichev (2):
  serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
  serial: 8250_dw: remove clock-notifier infrastructure

 drivers/tty/serial/8250/8250_dw.c | 79 -------------------------------
 1 file changed, 79 deletions(-)

-- 
2.43.0


