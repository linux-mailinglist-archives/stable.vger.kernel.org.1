Return-Path: <stable+bounces-230038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGSCHxPewWnxXQQAu9opvQ
	(envelope-from <stable+bounces-230038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:42:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58D2FFE21
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B8730A04CA
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2834D4E4;
	Tue, 24 Mar 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXtQElxL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188D346AF1
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312800; cv=none; b=FCoPqW5GVKuJx8iKBbhhmG2ppfkBhYsYaisPK3KpIJc9kS+c2oG5bEdQr9+3az/3GcQcMDRP+CfUtZWPVox8dzwwbINMupvGt5v+ew2KjGjRbkbvLLYQ9zkkPNL8GmFoe5Ih2taR5s6t+gVJ6suUdcolQwALBWFmbeHpmzxoonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312800; c=relaxed/simple;
	bh=k7sHMW4gg0o0qIJMt9ltjJ4WtnO4WFu/L7mwYOnZn+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sRCSwD3FNHh1O6T79p4Fx248x657chAje75fpLWgiAB/33De56unQExIRgxYm9RHkQKNLCDYohB2ghaIviXGCcrAtRL70GN8zflZZ8zskKF4vZh92NJ3ga3cpii4htTfDk6L92P9Ze6Pv4Z36SjW11++it5nXsJtfQMtgebEEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXtQElxL; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c0d36f3888so3358150eec.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312798; x=1774917598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Pn7J7KNNIQST5/lUfvga5BnMqTjXD5cWPJOt1fdVH4=;
        b=AXtQElxLBdSwJWN/DaChIeOlwTxP0dUA3RGebxKdmShEVLhUkGwzWfpY5YP6GY7yK6
         UE0qfeI/jOiR6ounBCQF9Zd8mSM7Y8l1KjB+5d9PpvMBa7kJ3Y8Ruy4wTrPI7K58UYID
         Ji0+RQtSiQrcDu1DgaeFMaAdzav6BW/SpNNDuo8T7lRt0HcqouQF4ClwkxXQoSE18kzT
         VHJKVvhcJDpMcLItadWSZtqrrhTnnhQ0ZUazwIcgTvuPCHIofB9NmbExUQLaXFZ1cb0c
         PlK3Ngl8K10mJ6SmivEpkj1JtHE4esurjWpjhre1A8tmcTfuzzd0qJaF1H3SOx3o7TK6
         M1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312798; x=1774917598;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pn7J7KNNIQST5/lUfvga5BnMqTjXD5cWPJOt1fdVH4=;
        b=AInpknu+3T3BZTkEcMJ0c3jhrb4b2cIEeyhCnWBLpsPD85uI1ywjX+T6LSXLAPrGMi
         Vy3YOeNnrJ9luGd6PNicGatzt58trFZTw6zWfb3aXGpjXzSKt6sqJR+OBlH/pjG8KPCP
         1E5OmSKhrgjmq89LnrflCIk6rcgXnkorIkGreVanqQfZurk94ztxWq35XaKtcYDh7l4m
         Sd9uLZwNMvhAM11fEE3kdmjujEJ6cxwyxhbJ4VNdNppKWdprGrTgJlZyBPvb53/+ez9/
         2Wmy2pNVwPND8rvu9NaO2Bmh78Nbq4FCBxJ42ORtqjF84QpOCelU9iY1ONn0pLmTO0pd
         CbkA==
X-Forwarded-Encrypted: i=1; AJvYcCWqUlq+EyH9bF0JStCajO5tzO706xRgP26J2EHgIyu+gvgMnkclK+JTgu8c13XiGRxhd0H7hRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJbXMHtnI5h+PFC5NGtDizeJ0AhxHEGOYWsm5QnDnHBm4/jDv
	XmbQp7ddrgVQ6FltM62I81N9lYHVciBEk+TY1rEH9U/hKb2HsTKGdRXA
X-Gm-Gg: ATEYQzyxCJ4E45t0bxbh3GWqpYEZtemAvauUhj/5ePvvIj2en1m+plvJF+CT9l+K7OV
	RL4hBJNoG2Jnh9AxbGZb/JgK4k7rQ6w/EQUijiQQidMLNyzeF8VordDYhlv1x+6Ya2vdj0OXJa9
	ArLAKKfQ1T5s7RK8CJNSi3XhmGemK5wzHBym3B+TG5td9oZBcFhOqBe+O5+xJKh4TDp+4xa+ZI9
	jQtSt7VgiJS2UBNDk/2kR+SEz7yEsXWAE1ST2FaEnANTH0S8KTmp2PVLV3dO42PU80zbbRNJ3Wz
	p1kfKiOrZPK4Wvl73CqHJTZm/3QFLHVCihn1m9l+QZwKH5GigZQJb2/dGPW8rA0W6uMltn7ZsR6
	TqfeI7aPhAfyjtVyVuaKTZW0IaFWL8skEPJI0KCKHOt2txccZ1bTw+ZY4O5bPt+BkbYEsX23+Ju
	xWC76XqIKthDlaJx5w5mjVfcj+Ejchix+0Gkc458Xpr41rnKjGPBJG0t5bZ2FcZ7AP3X36i8xDf
	tvMF4wCqpxYWlw=
X-Received: by 2002:a05:7300:a2cd:b0:2c1:27c:75c3 with SMTP id 5a478bee46e88-2c10961a7e5mr6039314eec.10.1774312797948;
        Mon, 23 Mar 2026 17:39:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm17543148eec.10.2026.03.23.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:39:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] Fix handling of GPIO keys and LEDs on geode
Date: Mon, 23 Mar 2026 17:39:36 -0700
Message-Id: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEjdwWkC/x2MQQqAIBAAvxJ7bkELI/pKdAhdbS8pa0Qh/j3pO
 AMzBTIJU4alKyB0c+Z4NtB9B/bYz0DIrjEMapjUqA0miYnkejEkjuj5QaPNPFnvrTMOWpeEmv6
 f61brBxS7d/pjAAAA
X-Change-ID: 20260315-property-gpio-fix-51586cffcd5d
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6826
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230038-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linuxfoundation.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D58D2FFE21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series deal with breakage on geode caused by a recent conversion of
the board to use static device properties for configuring GPIO-connected
keys and LEDs. The issue was that PROPERTY_ENTRY_GPIO() would create a
temporary structure on stack for GPIO properties which would later be
discarded.

The first change patches the behavior using existing in kernel APIs so
that the bug can easily be fixed in stable kernels, and the other 3
improve the API and add safety checks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (4):
      x86/geode: fix on-stack property data usage
      software node: allow passing reference args to PROPERTY_ENTRY_REF
      software node: verify that property data is not on stack
      x86/geode: use PROPERTY_ENTRY_REF for GPIO properties

 arch/x86/platform/geode/geode-common.c | 24 ++++++++++++++++++------
 drivers/base/swnode.c                  |  9 +++++++++
 include/linux/property.h               |  9 ++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)
---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260315-property-gpio-fix-51586cffcd5d

Thanks.

-- 
Dmitry


