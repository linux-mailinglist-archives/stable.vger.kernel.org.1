Return-Path: <stable+bounces-83750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBF99C43F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699541C22266
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F0155CB0;
	Mon, 14 Oct 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky/t0jVT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B6155C8A;
	Mon, 14 Oct 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896214; cv=none; b=lABP4zRKteG1gXuEv9DYI3SzXxZ+Hq+AD4hiWkZY+MEfWHZG/LVTbN/5xlLgiIu0ciZhKdzSL1ADhhIxPR04CSr/pfwugxrGjtr7kidaPjF1VMPaAfXdqQ6GiMtGE1murVbxoaPJqclzyP6T6dRCMd+e4PCXA34pQ/FgiRfLQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896214; c=relaxed/simple;
	bh=deoA6W7KISJU4Lqs4NPTSSLQ+sPbpJvu3bhsGmcntkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DGIcu6UJdPyk60bwNQhd2IyTgUhBJaHwsnSFsBNeHwLvy7Ef476j9caGoapeW2vZK9PLOYDHkvo0RbgO44G35yVYYpHrXNrzfKbo6DS/gj0lqgWPfe2s0e79eH8zKmKQyjkuhDACEonapQYjgtHv1NbtoYOnJJmXqJoE0XdAc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky/t0jVT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso5319989a12.2;
        Mon, 14 Oct 2024 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728896211; x=1729501011; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bka1XtdhEywlqdYAZ4vAB5CJJ60IdylXCrsQgeEz6GI=;
        b=Ky/t0jVTQBIkiIcdDpZ5EFB1bQbpkXBnZHMwyk8dVR/9yvt2CfSIMJrtNHHz+wM4zv
         lzRYmKcRGmLs5mR9+VGYtnpp5HpzKHT6rLlpfUcdc7Eh+D8NIOxPOS8AELl3F0n2HILV
         OApsZALUrFFKZzs9uMiVj/xKQckb64PioAEseHGNKlQsBfNXvgAAfgijDMupEOuxpYYl
         4tqKXJ02zRbv94yxiRc/tyiEQlg43e+X5+pWHYVa4OIuXJSRIBHXm2fgxGmylmMdo+7o
         S2+WnFWnjJ89a4M3+hTB+T2OBU01CRjd9y/BfFqd2HJmwESYooFSuUTKjSw5iqarKtxy
         Ahkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896211; x=1729501011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bka1XtdhEywlqdYAZ4vAB5CJJ60IdylXCrsQgeEz6GI=;
        b=Su2tjmk/MPFwwxXoWDocOTNyXieaX24aa0d//DC6evdIOfmDZnz7jqy7RqxjFAqPnz
         D2OmnH1zeMz3YUQB6MI+yvKAR0aXLPV5TF4gAVtiLQQPfNBeD18fq+3cx26jVCl0eMMI
         r2x4rGMfBZt5PddYqQkb0zSE6HM1WRKRxgBjT1DXh0uteTYizzt9VOILZZAXuk76EXlD
         itbuKdUEYTPjMoP4fyseC4eJo/5RJoV4rBulntRnpcGtEuwrjpCFkGMgkKLDGYQrEb6c
         09j6aZJ+3dmG31MsDQPb3r9i7c+jf2oVysj/m5FwzI/h+8DEqmsQXQuJzRQfSryrqUX2
         DEcw==
X-Forwarded-Encrypted: i=1; AJvYcCVfziOxqkmNZt16WCabispSqrby88+ZPn106059EoZC9rcA/xYJKYy1InvImWqUBFRxf9n4IZy+@vger.kernel.org, AJvYcCWoWgw3kWw9ZnI8mymD76+sl7cdJUMuuaL8WFdTJ/8OMOsV3pDpkp4xWA2bUbQ4j6NrzC9LrWC66MTD30U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAu5rubgNNYgHIl5pzcS8b9+9WPlSnITgWL0HurgEzkkx71Hb
	8P28uD7czHo4ZLBkFftLtmJXrCZfY+HaRzlmceirX6xBUkFFV7F70zAnAPN6
X-Google-Smtp-Source: AGHT+IGDJQrFJVmLNzaOGm//MX2LnTO5StHI/IaPJSK+vM3ey2DDnOs01a7EiS7Ktr8Rdy6PAFN7xg==
X-Received: by 2002:a05:6402:354b:b0:5c9:488b:1dd9 with SMTP id 4fb4d7f45d1cf-5c95ac416b3mr4767381a12.24.1728896210311;
        Mon, 14 Oct 2024 01:56:50 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2296sm4635091a12.15.2024.10.14.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:56:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] staging: vchiq_arm: Fix missing refcount decrement
 in error path for fw_node
Date: Mon, 14 Oct 2024 10:56:35 +0200
Message-Id: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPcDGcC/4WNQQ6CMBBFr0JmbU1bERJX3sOQZqRTmEQotthoS
 O9u5QIu30v++xtECkwRLtUGgRJH9nMBfaigH3EeSLAtDFrqWkl1Eqkf+WkwTMI7M3tLZnmtopF
 4JkR0tpVQtksgx++9e+sKjxxXHz77TVI/+6+YlFDCtfqusaG6tfI6TMiPY+8n6HLOX5kF3Ou6A
 AAA
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728896207; l=961;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=deoA6W7KISJU4Lqs4NPTSSLQ+sPbpJvu3bhsGmcntkY=;
 b=ziGzncipHzJsiNZ8mCCJaD/J81b7kY8naAZ9Qg/cp3Ux6cTrCppMq5petwUtH9bPQ44NEESyJ
 KiKLKjJ7rhRDIKMtTtOTTTMGWfjbCpneZwkkSC2TLJ4z0EnR3mYoK0H
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series refactors some useless goto instructions as a preparation
for the fix of a missing of_node_put() by means of the cleanup
attribute.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Refactor vchiq_probe() to remove goto instructions.
- Declare and initialize the node right before its first usage.
- Link to v1: https://lore.kernel.org/r/20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com

---
Javier Carrasco (2):
      staging: vchiq_arm: refactor goto instructions in vchiq_probe()
      staging: vchiq_arm: Fix missing refcount decrement in error path for fw_node

 .../vc04_services/interface/vchiq_arm/vchiq_arm.c     | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-vchiq_arm-of_node_put-60a5eaaafd70

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


