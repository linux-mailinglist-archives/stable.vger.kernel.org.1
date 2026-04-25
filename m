Return-Path: <stable+bounces-241091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCq4LLJA7GlGWQAAu9opvQ
	(envelope-from <stable+bounces-241091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 06:18:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77502464EFE
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 06:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9CA5301D322
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388022874F5;
	Sat, 25 Apr 2026 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKY2cuXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2E14B08A
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777090735; cv=none; b=ODrj/CtmKGk9RR4pIpLC/+MHtBU25xxqdUXHgG5+uq/cmUXQ2xIJEbZuHYuPRcFRgoh7PFmJCfwMcigtb7JWePuKdXvu0VLv8IHmkSWsGKGOCGRLNX3aOmXAZp7E29DTJTfJr/Rw1IXZT6muHR8hflQCyj8YI844ueUbQsBGDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777090735; c=relaxed/simple;
	bh=yNpT5Ea2Wr3J9GcxT267OvWgxH4/6nsG8FyfORLoFis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prdsM+BW9/DguRWM8lweJGcn1jFN0/bAE2nxuRS/y+AUrl8P17/BPws2PO0qMI80KTFqFgzdTkxuLCdTzzXfbF9kCUi8NdEIvQNau4pSt2K+9h/btWsKkmAozJCDSul7LoaP674gOVymK4Iz5YeISgzUpFvhapW15GSnDv8C2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKY2cuXf; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c637089ccso9835578c88.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777090732; x=1777695532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gs44N4+hU1RqCbEeT+Y1cdqZ7dnhS0LUOUZ5KW9aaJ4=;
        b=qKY2cuXf4pXkQJTCi4pY68aJeCqEqVoQzjWR3x3DujQYZW1yRwByWMF6gvBG1R3MC2
         9M2nE3SUPN/3BaC2nWK053oSVRCSWhnF/BzfG0LZ81ETWshYsWA3/pPosAyQrZSc41UY
         HkyJGuMP3ZR7+cRtA9wFQjNamJDqQgxwGb8onwnhtAAp3ITd2L4PoRI2LnaP41AG2ntH
         +uYmrl57WYMoDeL3FWaEMTJmtNpD79EboGAUzmm7zrr1aQcN+f2q2jyfoYYMEhdBGZ/J
         GU9R+iU1F307qQY6O6KJpcjRnvQB4L3AS9ApqR/SRv9FnDT023miPwVr2Vxs1yK8Bxq4
         zIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777090732; x=1777695532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs44N4+hU1RqCbEeT+Y1cdqZ7dnhS0LUOUZ5KW9aaJ4=;
        b=RAeMq6EcbGkSEdSGqFy7jm0RkqqaxZbuAk0mS1i/5UCSlPBy3FvQuNCxRpgcPvFN2w
         p4rSI+Ov+jUm5rQ6YA18ouy5lt9E/YOgg60oxaPO9CmJglnlTmvKhR+qvnkC8CQgpJ1o
         x9DTCycX0cdMWjeZsAmF1jVoSizlosBR8ehkgwqPvUCnQ+VXojyiLJX8zNrcHsyul69t
         Op4S7U/IaTmHu3KiNryulCh0Gqtfixs5V/9NL6e2MJPWocMBh7OrheRLysO2DMWzP4uT
         P8QoEr/Tu9IfIoeBUxyVjXwjyX823fKOb+pwuocd/H8q5ZqGZBcg3jwjl3kHJsDoKJqm
         sfJA==
X-Forwarded-Encrypted: i=1; AFNElJ/+YSWDQJ1vS9Bh5BZZCM/aFjoBKAYbAIiCumPAr41hUtRkegplvmFc1wjSkgRRUT2ffOjEYlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO67ZZpAR8avCyO39tUyPJf11fPEzWPD5nzfiHZla8o2YrszQk
	cP347Jkq8dbeCrZpIdkA3dCSBWmv1npIEzsqV/FiFvIF/BAx1owmMh8k
X-Gm-Gg: AeBDietBF8Nr+92MSTG17K+//vqPSdaPQ2oRRQydAkuVkjAIZOdNG1bL4vbj2d8KUfn
	u9BNKSlJW4B+J4s2FmGZ9ENSIHnYlSspCKQ4HEfs0Cpn+KDNVgb9v/FgKvgT3tBfsz2Y9fQQk4U
	uPG4VQ6oJ2A0+vOdm9s4hOXldzXALUk4qADJJBxtH7tKgBjep0swKW0mCaNGt6lfhYE8UXjUBO6
	N+IMQmLMTrdbrzKejOsvImMeObNEvljtoaShIQ9Ra6Xx/mIwddENOCufQGzePQrPjavoCD18MBa
	76tVlWyYDGe5ACPY1a5Lv/zDBT6HFdk9uSM3nY8sDyf2QrjYOXqGz4Mzqcj2tgodA8KAXusvYg4
	Of/I/ZgUkaXO4ZRcevY5We/z5QEx3W7joSHtfW6WZxczjIJJyzcVIvC+XlFlX8w24jAJUzhXdLr
	BlHAZm1IF7wlbI46KogIm7aEwo0gWC4SGb9pgEmJtkZyrHGJNs3UeqP+T7XoqWKcGiqOETLrJoC
	jfCQtUPfD9X0S4BsOjQYU6lD2m5v0FTl6RPxp7iDkD5YDgGf0bk/rizF4zV6TVKMpx0AoGs2k4X
	Dgz50AO2F65Coex55r3QYNeJPrMw
X-Received: by 2002:a05:7022:ea2c:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c73fa3c01mr19002285c88.28.1777090731805;
        Fri, 24 Apr 2026 21:18:51 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm39678070c88.0.2026.04.24.21.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 21:18:51 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Yibo Dong <dong100@mucse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete driver as BROKEN
Date: Fri, 24 Apr 2026 21:18:15 -0700
Message-ID: <20260425041816.19070-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77502464EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mucse.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,ti.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241091-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

The rnpgbe driver as currently shipped in the kernel is incomplete and
has no useful functionality. It will bind to a PCI device and create a
network device, but that device does not function (its .ndo_start_xmit
callback, rnpgbe_xmit_frame, just drops all packets). This situation
means that users could enable this driver and have it load and attach
to their device but not transfer any data. To remove the potential for
user confusion, mark the driver as broken until it is completed and
explain why this was done.

Fixes: ee61c10cd482 ("net: rnpgbe: Add build support for rnpgbe")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/mucse/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..c37a90a6c808 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -3,9 +3,12 @@
 # Mucse network device configuration
 #
 
+# This section depends on BROKEN because its only child item also does;
+# see the explanation below.
 config NET_VENDOR_MUCSE
 	bool "Mucse devices"
 	default y
+	depends on BROKEN
 	help
 	  If you have a network (Ethernet) card from Mucse(R), say Y.
 
@@ -16,12 +19,14 @@ config NET_VENDOR_MUCSE
 
 if NET_VENDOR_MUCSE
 
+# This driver is marked as broken because it is incomplete; this avoids users
+# enabling it and expecting it to work.
 config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
-	depends on PCI
+	depends on PCI && BROKEN
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
-	  adapters.
+	  adapters. It is incomplete and currently has no useful functionality.
 
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
-- 
2.43.0


