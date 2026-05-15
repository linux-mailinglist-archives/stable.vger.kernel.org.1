Return-Path: <stable+bounces-247715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFh2HNALB2phrAIAu9opvQ
	(envelope-from <stable+bounces-247715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:04:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25854F05D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3C293044FBD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26315480DD0;
	Fri, 15 May 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="chRBhtyw"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6948033E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846249; cv=none; b=ddK7xTncPLZgfYUeDXq5vd2ozStHeAWH3XxlO8SEhoD2PYTnGgDhY6kwf1n65JuEkE0Tj0cbFHdjo1x1bDLSBLYmUMR2GDoA1uWEvU1+utX4kj93XNxt/EvkFK3uiNKQY634TkCSE5aO9MuMWhV49q1DKcTEG+lfFshLjaqAOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846249; c=relaxed/simple;
	bh=z8jbpUWWEvgPqHOtejaywzKMjTnwVZndHjoCM1Lhdok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z5CRcz/ZbbdtWzCfhA3IBSbD1umI+ybbzcP+jzBhdMZX4YGApJ0jmgIthgkF9vl16/d2yiiYJQUuYAOQ7PDGW/8XzMrFU2T/LvJdK/SI4Lt5wGouHTiLdTykKj0r2ZRBWf/lVQxhAwrcLQdTyrzZcuSvd+e+7cp8PxpV+hfcL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=chRBhtyw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9A59F1A35E6
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:57:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 543B3606FD;
	Fri, 15 May 2026 11:57:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 847A611AF8C52;
	Fri, 15 May 2026 13:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778846240; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=f5yytpSFcnfmDKqpRgOlbvLW0t4U1M5BBAeetjuPh1o=;
	b=chRBhtywL7LyLyOTKSqWg5uotPnHKS6eqjk2zRcuMtljy9GFy2rZWjtZ4/RjSE5DM8xCOx
	tjv6GFztu5a1e5sdn1rX57HlIwNs/d2U0oWE5lAYf/Xbka28GxplAsur3LwShpFCkeHpoS
	AAT31uSPCs00D5UvvCsWu3lsODOKbqInefKBb+oaTtkCPjFLkVucB9+nr3yn6s5dP8E6eq
	lLMbYtVvVX4Xh9s5z1LNZJipJbz+IHD+k1UhH8K+ZnjtYbVuvfO2FYRzYfryhwgiGU471b
	7i1hIYL4e24GFwPI10ux8QMa8WuFcKUV7eqMyQzmk2d/T9PM/WIsehIigDy+pA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 0/2] nvmem: layouts: Add fixed-layout driver
Date: Fri, 15 May 2026 13:56:55 +0200
Message-Id: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcKB2oC/33NQQ6DIBCF4asY1p0GiFLTVe9hXCgOdRKBBpDUG
 O9ebNJtl/+b5JudRQyEkd2rnQXMFMm7EvJSMT0P7olAU2kmuVS84TXYIc2EK7hs0YKhN06wDJt
 fE8haK9M2nI9GsQK8Ap73E+/60jPF5MP2/ZXFuf7Y5h+bBQi4GYV61Ch4Oz1G79NC7qq9Zf1xH
 B8RtKaLxgAAAA==
X-Change-ID: 20260504-mathieu-nvmem-fixed-layout-24c6f8500bf6
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778846239; l=1090;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=z8jbpUWWEvgPqHOtejaywzKMjTnwVZndHjoCM1Lhdok=;
 b=CIfyX4/hJcUcx/eHp85ad7ySZs8i7lo3VMKn+JejvJA0byRJy3p++nBSWQU9YQ7Fg/E5ihVp4
 nQHpLtrl13SDTx969p/pLLYV4SBYAHz1zCryKsVD9p/caikMg/kVxC1
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 0B25854F05D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247715-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Fixed dependency on core layout code with CONFIG_NVMEM_LAYOUTS
- Make fixed layout optional
- Link to v1: https://lore.kernel.org/r/20260505-mathieu-nvmem-fixed-layout-v1-1-7f6ecbce108d@bootlin.com

---
Mathieu Dubois-Briand (2):
      nvmem: layouts: Add fixed-layout driver
      nvmem: layouts: Make the fixed-layout driver optional

 MAINTAINERS                          |  5 ++++
 drivers/nvmem/core.c                 | 24 ++---------------
 drivers/nvmem/layouts.c              | 11 --------
 drivers/nvmem/layouts/Kconfig        |  8 ++++++
 drivers/nvmem/layouts/Makefile       |  1 +
 drivers/nvmem/layouts/fixed-layout.c | 52 ++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h       |  7 +++++
 7 files changed, 75 insertions(+), 33 deletions(-)
---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260504-mathieu-nvmem-fixed-layout-24c6f8500bf6

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


