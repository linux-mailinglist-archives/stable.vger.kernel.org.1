Return-Path: <stable+bounces-235883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGbaDgJo3GnoQQkAu9opvQ
	(envelope-from <stable+bounces-235883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:50:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F83E7062
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF54300D968
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534A37C11C;
	Mon, 13 Apr 2026 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzQcat7V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CE2D592C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052219; cv=none; b=SMSjuMLZrTj9LvtLK2LCjeHsg7MlHCnKE6+06viRSW8tiYr3OkC++SMjubAoOZnmlEBVQVH5ofVYIBTBr5ejNdc5nZOdiAHlxKgH72VG6qk27p4Zk6/ExuDRIuZyHayl58F9p74xNTLeJS7peq/TvypqKch67OsFTXw2OU6BEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052219; c=relaxed/simple;
	bh=sUgTRHI/W3UUd+iU8UhxjC6qCu++A+/ABGXJUyI6gHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPnfqn/U/UbO0zmoc1HPwEjR6neBdXXY1VFqLHGwaQdH2p93oTyblm34XAladykxXfYYydeULcBpmW0IJQ/7NP5dMN/mH7PUa8Nwk18oqh4DjblCwt1wu5R2nOEP98HL2kGkjkhH3cHNSLzXeGDGK2UjL2hDk5Iffu7YFIXvTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzQcat7V; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2461600a91.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 20:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776052217; x=1776657017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxEeQY9im1AmCCM45HxJN6Bh41heW0/mNFDoxVPaN+c=;
        b=FzQcat7V1elonExQrhMM2et6FUpjr1PjOUO7JUOU58aWU4OhCORhvKgFGUyUjqBopE
         yR05auKX+WdZRgo4YR7xdYZBHTf0CMeJXyGACUGJ3COnFH4348tj52lWHtyB1rChXNHn
         GE8cbgWcCM7zfNpFWmjSzoua8zkmCSXg02fd3rrAo+wipXyisCqtqEODSmslgllVobNJ
         bLwie3mKiFg7NzQIkTWJ83MIDa1XG8DO2xHuHs7DqH47Vgsag+8XVBT95fgIApoK8UyN
         RUAnUNkYtg3cJEzIxG43x2JA6XN8t8Wxga2L17MESuBWdCw698pv7R9QbequovqdLd5h
         PScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052217; x=1776657017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxEeQY9im1AmCCM45HxJN6Bh41heW0/mNFDoxVPaN+c=;
        b=ZGvJ/9lDtCJhGEfWUYpYpGQt5V3pQur1UI91BrGG3ypS/WtmYEot2lVq0J8y/ZUmlU
         1NdncVDRgRjUQYRIysRDECSquQ40SplDGUOrSD/zIaXx6vWmQuZOhm30tIHHtzbW5sJh
         xFujvIg6bkncxQ37sv4/ZtsU9mhNXJz7rMOksCuIQM2dDofOVeiwUFxYK3YTJdtuIfNC
         aIJC9x1zLnPyhYoiI0V8ahvqSvQ7W68Qep/clt+tCSZosFTgkGi+TtQ78TC6GhjZCQYT
         wtzNYMgkECuLFltJvOgRcn4TrvKW4lgoRwxeaeUT+o4itO7v0TESS3JDXkLHh3k1JEzC
         JmXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8d0msUMeuDl6qCfMQA1dRxNZKtyv8Zn60TQRGnBVi4QnpoIDtlcEG5wotI8ZCtbmXtKCDOoWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDnHOa6f6r6zW4nZ/NZuClqVaTv9tuyo9TT/K4ajUGvFOfYQa
	KeBFuR+d8EQyL48cmfyEC0I+cMj7U9FjzlMZhvP3ZN/HEzaI9npjJ4/w
X-Gm-Gg: AeBDieu8ScZSNwBM3zhIpVDJdDgNHeXZ4WUvpRF+byyVNo0CpOC44sK3faUqD5DW8gu
	SKsX0WxgGQK+la6QqwbHu42JtSYvyfpPt9K66WN05QBaSjMuRxtBMJiH+lni1zQHk4+0P+iRDIQ
	W68JemkXQBWDfDPbI5EidKrB9ZXvSc/kc94m5OTjMkoIeOA+xwih1m+UzP+tw3QfJ+klkbL52Gh
	5f3sTZtMTrtaj4+EmfMuPz3znP131coJZGVydGlCVjOFDnVTWorN3aXCbrvxipmqTfGZMW7GZHH
	n3t+5OI9kD0872a5OrVudQ1Y0nQcaOXi2rUffwfsRGT9kKxQo7IsLGAfi8V0xoDVr3bZtiJoDwr
	7dwxGF3nYkwIjAuUzuJnV5K1eKIAVdA1JAGaeZVkU6ur5GK5+LRP4K6JuouOU15YFYjqdaKoNrh
	C09wkLyv3Q7MLZ1H3VnKiF41s7vqYFCv88tm8IJq0nnC309rLBmF2dhtqxdT0NtiAZOP1wa2eIE
	Q==
X-Received: by 2002:a17:90b:4ccf:b0:35e:3aec:718b with SMTP id 98e67ed59e1d1-35e4281c516mr11022514a91.15.1776052217523;
        Sun, 12 Apr 2026 20:50:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:6580:9cc0:8700:96ae:8c3d:9c98:97d9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4e2dbf47sm7030644a91.0.2026.04.12.20.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:50:17 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: zonque@gmail.com,
	tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreyknvl@gmail.com,
	stable@vger.kernel.org,
	Berk Cem Goksel <berkcgoksel@gmail.com>
Subject: [PATCH v2 0/2] ALSA: caiaq: fix UAF, double-free, and USB refcount bugs
Date: Mon, 13 Apr 2026 06:49:39 +0300
Message-Id: <20260413034941.1131465-1-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235883-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,perex.cz];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6B2F83E7062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two bugs in the caiaq USB sound driver, both
reachable via a malformed or malicious USB device using
raw-gadget + dummy_hcd.

Patch 1 adds a missing return after snd_card_free() in setup_card()
when snd_card_register() fails. Without it, execution falls through
to snd_usb_caiaq_control_init() on a freed card (use-after-free),
and the caller then leaves the freed pointer in usb_set_intfdata(),
producing a double-free on disconnect.

Patch 2 takes a proper reference on the parent USB device in
create_card() with usb_get_dev() and drops it with usb_put_dev()
in the private_free callback. It also removes a usb_reset_device()
call from that callback, which was both racing against an
already-freed usb_device and inappropriate in a teardown path.

A related stack out-of-bounds read in init_card() was sent
separately and has already been applied; this series is the
remainder of that investigation.

Tested on 7.0.0-rc5 arm64 with KASAN and lockdep enabled.
Reproducers require CONFIG_USB_RAW_GADGET and CONFIG_USB_DUMMY_HCD
and are available on request.

Changes in v2:
 - Correct "Fixes:" tags on both patches
 - Remove null check before the usb_put_dev() call in card_free()

Berk Cem Goksel (2):
  ALSA: caiaq: fix use-after-free and double-free in setup_card()
  ALSA: caiaq: take a reference on the USB device in create_card()

 sound/usb/caiaq/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1


