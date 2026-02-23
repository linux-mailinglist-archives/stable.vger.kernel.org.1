Return-Path: <stable+bounces-217717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHIMGEwpnGl1AAQAu9opvQ
	(envelope-from <stable+bounces-217717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:17:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3D174B4E
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927B3301F9A4
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03235B62A;
	Mon, 23 Feb 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh3iRqk1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327D34EF0C
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841862; cv=none; b=SlRUAuPUphLn7EPsrnV+FR5PjvIJkGU/YsW/acUxzg88NYaEPreaXTl4/NO4/ONABy69rfAoMN8wxGUGn+lztEz8G1ekFFEyW6oRdx+JSe7t+idGsGTxWvnVf0dwstkBI9SauNv0RygYx2PtwYlkYT4k7CBjHRQiGkyyhYdYe/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841862; c=relaxed/simple;
	bh=O2p17sybAuVHCdv0KD+mnYK4AM2+zGcs2jOJFiLuGDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAZK6yEcUya7n/uXirMU7vrp7Uq3RG8bt8wrSqJ8ePiRIMwizBLjvntAXJR4lXdj4Jx6eQdF0bn0H4cHgUpPsLAsCmEqNLNjFOD0951kaDZD7ekAnTfQNswAQGWlrMxFVP00vLCpkEFa8ubYu0IvyX72s+o/+Hyk06I+6tzG96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh3iRqk1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7d98c1879so26688825ad.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841861; x=1772446661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48RL7VeEp2klLp0X3X13j82DHjMKhg6nQjIVmjSYm8g=;
        b=eh3iRqk1OfRRjLJW/FjG/VngrkFCT0kXgjjOsxmEDGH3OSSr+lqlZVZGEJ2bgED90H
         wja7lW0pGS2t5ih+7C3Cg1MpRXKiNDaToRPda9HFy5lsOF3LAWGT6SPJFr7Wh0PVmSvG
         kJjz37JluHOSsTvR/RBv2Q4xoVnJAu2U2lt7D4gwSHLyKh3Qi29MiHjBYyqU8mMx45hi
         ufEequ9CKx5tlxfOz8c7bZKkg5TrDukNIXSgV/Si4+xd2L2HayGf74D1DpjOGjBedpgB
         Uwsw4+9eTXhJZPgd5QooBFuQLG3im8ISG2jP+rxJ1OP73LM5IHY1IL0iVGLV5HWDQsWj
         Lpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841861; x=1772446661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=48RL7VeEp2klLp0X3X13j82DHjMKhg6nQjIVmjSYm8g=;
        b=h1sG2RM5kKWK0/alZDioXAElS+gK048gZqntnrJB0qUmcXxKbtT+d7qGxrTajMZ8OP
         GLCHRSKnHtPik6wJA/3OC221Nk6AlwdCMQlPJ/9dtGftHYtgs5FnJQ0papYSmQCZiwk9
         EAzyMrVPMfITy6BMS52vSwjFZukGiSaVrT9eAiJG2RXJKkEe7m50Lhsiy9lBGM1ADE2K
         D0pkmGNnEKkiLPWOvJJzXM9y1QcwBEJBwkE8bkB88Yp/AqGM0K+ktLc67n8ODQrmqox+
         hBKqBzOkh5tLLia8dQSALuvYO/cOhxYdP+7ue+kcGS+lFtqOVU1RyblUkm4QwDaxTWTV
         0UCw==
X-Forwarded-Encrypted: i=1; AJvYcCUXKv9oWRjrnOovSfHXD9UDLCMG9h9qa1JZcVZ/g7t/boMG2bixNB12aEaRYvepdaPFOGkMZ38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4TinL5caucFQNYnOGISgdeLi6xs69yGmV2/yDtP9gt8WOyxL
	UG2wl6NVoAFv8N+sC7KNEaxD4eN0bA+dtsBoTlXecwlZtGIMaGJoqxaM
X-Gm-Gg: ATEYQzy02vikGPzjE4O7NEoFSUbQHDWJGhOnFTAcUVIQwUgnRgcXG37695Wo0QXJeRJ
	wmJ4OKtYAqg9w+Jv7K1p7F9fLzlLjhvgAdso77XqAzMkZM4XV+9eQt7JXGLiKKGl4czDeFHGmzo
	spUL3M9kWV9LRfP+8f4I7+zqxoG15s+Mi3kPjtqlWBt2A/aQ4UM1ruLjc8BUApjObjbZAp/F5NN
	R3t2oYWuZGXBkgvY7Ll8D83y5LrEJuX0Z9CByvyenJmi14LMhsdpPR3180iUNcE8njth6/X+185
	iBAFLGoF+LCeywI3L62Fn/Y4HlZZazTykjp4Ma7UuU0sFLo8Jk9bBPTfUDqPta+rLNM1KY9sNTA
	KSZ1y8mNnknugJ22RfhtSCbp55gG5o6YBca2swt+5IjUXg4Nta0npn/DYe5ggOw4UDuTsPjUXUl
	kP2oO1Tr631c6NZR6uj6po7mkC3cc3FA==
X-Received: by 2002:a17:902:cec3:b0:2a8:7814:47cc with SMTP id d9443c01a7336-2ad744649b5mr63594245ad.16.1771841860595;
        Mon, 23 Feb 2026 02:17:40 -0800 (PST)
Received: from c6dfb3cc7c9a ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3425dsm66574795ad.16.2026.02.23.02.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:17:39 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumarvs@gmail.com,
	sanjaikumar.vs@dicortech.com,
	tudor.ambarus@linaro.org,
	stable@vger.kernel.org,
	vigneshr@ti.com
Subject: [PATCH v3 0/2] mtd: spi-nor: Fix SST AAI write mode
Date: Mon, 23 Feb 2026 10:17:16 +0000
Message-ID: <20260223101718.89-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220094236.28-1-sanjaikumarvs@gmail.com>
References: <20260220094236.28-1-sanjaikumarvs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-217717-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,gmail.com,dicortech.com,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dicortech.com:email]
X-Rspamd-Queue-Id: 56A3D174B4E
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

This patch series addresses two distinct problems affecting SST flash
Auto Address Increment write functionality:

1. When writes begin at odd addresses, a single byte is programmed first
   using byte program command, which clears the Write Enable Latch. The
   driver fails to re-enable writes before the AAI sequence.

2. When the SPI controller lacks direct mapping support, the fallback
   path uses a probe-time operation template with standard page program
   opcodes instead of AAI opcodes.

Changes in v3:
- Patch 1/2: Use local boolean 'needs_write_enable' for clarity as
  suggested by Michael Walle
- Patch 1/2: Improved comment explaining the fix
- Patch 1/2: Added Fixes tag

Changes in v2:
- Split fixes into separate patches
- Added detailed commit messages

Sanjaikumar V S (2):
  mtd: spi-nor: sst: Fix write enable before AAI sequence
  mtd: spi-nor: core: Fix AAI mode when dirmap is not available

 drivers/mtd/spi-nor/core.c |  2 +-
 drivers/mtd/spi-nor/sst.c  | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

--
2.43.0


