Return-Path: <stable+bounces-238431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gbDOApPZ4WkXzAAAu9opvQ
	(envelope-from <stable+bounces-238431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:56:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5C41797A
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1285A301DAF0
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416436CDF3;
	Fri, 17 Apr 2026 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuSOQ0Kl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB732720D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408826; cv=none; b=XnSQx8/pEfJpuMvcDCCNsmKr3P1y7OPU0SPjJbA1IMlNaaQiXjzY6Vidd23mNQJ65/SNERh8JHfnfKNoasXqzZaKtO1i2fOMxy3oO07qYiPAh0bAnnyB2NIjUyf3DLzsvv3UZrwNl8ANL5N9sYs1p0KB7IuCa17K5ae6xnYicz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408826; c=relaxed/simple;
	bh=uZBkgnwy12Z6S+MN3Nh7ARIhFyFzyr3YpSPDxdevAWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cr8M6kNiRI5ekOKtMayAgVb1RWpA+MpOI5gGRzT7SMEpEkBCiEVEgC6paOOFzPdPTYAvlj/80zcFI+M4XN7GfX3VzQ7PVn8/HwpUNvrtBiJ60qHvhvSFqx4QdKDsUTzibIYefAcUOn5Lo9yn9M22i8OKEIiXLE5gwjp8Liwdgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuSOQ0Kl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35e576110adso251862a91.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776408825; x=1777013625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dz2TbEulj/LIiFp5mSvpOE3UlRqu5LHEOaLq1tYoI6c=;
        b=HuSOQ0KljIGWqvU2uwQS3GR8tKCbQtjGxLouP/eeHZ7XSXdmBuNaiWnkjqLKbxyt3r
         B593F0VZUHMhfld/UrSTBBMvgqHr1ZHbZtLlWyCWGPQitMtJEvDe2+zuw7w8w+dVddrx
         /cOJSvWzJTdR2SrgEE1GuJnM96l/8NmkwDYpqNutE4j9bBMIe6TD4Exh5a8eaEjs9yaA
         Nc8VBQpLHU5JGakiABXJvnHLsXMT/UlSa1V1kFHQai94E8iSW07CKY3r90liU2okjX3d
         wY/iriSU7+NAqnjJKAi3ku839HdBga1hKWOPlfWjj2PJQaKTTbhopPoRLHTtNGTzpcy0
         zB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408825; x=1777013625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz2TbEulj/LIiFp5mSvpOE3UlRqu5LHEOaLq1tYoI6c=;
        b=U9gDy1tXmV/81KT3H0NaQKrjqI5ZZJOhmmfxfylCqeTHgccn2cL1fOsr7cuo3lL2jS
         OLi5m5FBDP/oCFe2dop281ZG9QTyrCtwBiQbOq3+EfhUxjKZLolx/ByMb96mBcCxo6FL
         nVlpm6NXMoQ3blQAEjr7Q4FRBDEkHlyTu93P2/yVNmQAWJXoUBV+BPC7FIBYmSHprw/4
         1jIV4rvgyg10g/i6ixFafUXDyXIkAV9X8NL7kmhWxQGfEpXiQBOaw+LE2LpvWQZFnVOo
         m/t9olAPbj9tDb0hn7UWzmWLI6rIZ1s3Mjrof85ykKoPPxr324KKxoZeFHRsgcCraOql
         AvUQ==
X-Gm-Message-State: AOJu0YwMViG/YDzAj/T7UYoL/aPHCynRGcGszMMJDBkdIhfkbWD6l4dA
	xZQgwk+q6aTYca7agbL9rIAy6uJaQ1H6CJnojtuzUs2erOKRH39Tn/ok
X-Gm-Gg: AeBDietd4K44i4qt7Ek5PeVA1LXlk/pnlmlZYqMKVNvnU6HXNPL1PS01R3bovWtvgQE
	4FyMdqUpHLlFZMuHaWdCvLzV9cG1KrcrZdBnWR/PAozwhr+7P3Z+CLtnd5W8sRXqX5LMOUOX2/J
	awnCkwmNswe5ROiLEvx5LcnEt4DYjghJnS9hQnMn6kGTH3+9gjZATFDHVZKOv4nKY3IuAAw9L7s
	DIgngSOE27V3Q7B8FWlpf5GRjX3orCAjmmrQN+SBq+Tz1/4A5CBa+QGkbY3a1dDQDeeII2gwJpV
	5QrM8ncfJdPo3z/kegSNwMVh4RROfxcAU7W206AI2xBEoFXglffMuayEsORy5JG3aCrRJSLAmi5
	p7IwkOpjZIpUkNMbot5hxTvTFHoLERngfXSjtNE5uktb1A19hI2P/XeL0krHpYWoxeCVD/F/N7I
	ETrTWs/Jda1RrYEyRXkLLVseu0Fzc9sD2Vv1cz74zLkg==
X-Received: by 2002:a17:90b:3d02:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-361401ec4b4mr1280969a91.5.1776408824736;
        Thu, 16 Apr 2026 23:53:44 -0700 (PDT)
Received: from lgs.. ([2409:893d:1140:1e34:335a:efd9:dc2:f12e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bafa9sm978644a91.15.2026.04.16.23.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:53:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] media: marvell-cam: fix missing pci_disable_device() on remove
Date: Fri, 17 Apr 2026 14:53:30 +0800
Message-ID: <20260417065330.4032892-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238431-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,lwn.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 53C5C41797A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During manual code audit, we found that cafe_pci_probe() enables the
PCI device with pci_enable_device(), and its probe error path properly
calls pci_disable_device() on failure.

However, cafe_pci_remove() tears down the controller and frees the
driver data without disabling the PCI device, leaving the remove path
inconsistent with probe cleanup.

Add the missing pci_disable_device() call to cafe_pci_remove().

Fixes: abfa3df36c01 ("[media] marvell-cam: Separate out the Marvell camera core")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Fix subject prefix to use "media:" as reported by CI

 drivers/media/platform/marvell/cafe-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/marvell/cafe-driver.c b/drivers/media/platform/marvell/cafe-driver.c
index 632c15572aa8..22034df6cba9 100644
--- a/drivers/media/platform/marvell/cafe-driver.c
+++ b/drivers/media/platform/marvell/cafe-driver.c
@@ -609,6 +609,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 
-- 
2.43.0


