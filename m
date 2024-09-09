Return-Path: <stable+bounces-74077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ADB9721CD
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79BF1C22FF4
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E0188CB4;
	Mon,  9 Sep 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JznEekIz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860616D9AF;
	Mon,  9 Sep 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906314; cv=none; b=k7LnsaT99ppwOCdkC70U29Cxl0h3NLDeQv0trBJ5eoUVlkhgD1Xvq0VkyKsyVyjWJn34Pf86bYShH0dHab4rACgmNQm1WGwgwEWlRbZDiOzvoJ3naPHemV4Oo3CMsxDNMRfD8dQyIRIn0/WkbUNwPayuVYQsQRbvQfiRPlY3Bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906314; c=relaxed/simple;
	bh=//npHJP8p/o67/dP0oiWt+ZAVgKoUqtjoHah+Q8Wd+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbg+td3ay4IneI53910VpZtTXGR+J14yeWJCfsqikT+F74brYiuDT0/roSPEQPnZf4nuWxfytMnm7ZC7N+Wibj2PtcpF66a7P4IOzcto1n12rXDSLdW14ESPMqmcBHws7A1Wm1t284ZbHxV5h6shVUty9pZqfbgoTWXx7LHkK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JznEekIz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4582f9abb43so7674831cf.2;
        Mon, 09 Sep 2024 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906311; x=1726511111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYSSPy5jRspVj2s1A9OUknnHQ0G4VBS5Qr+5Hdt0kD4=;
        b=JznEekIzJw9kFdf7fKZ94VukBEHhrqZYdvSgIKSvBzWio9MzqF881dFwlVtAgT/rQi
         a0QGEX2yhmJSuT5QABkbzGW9jtNGEiZNATmyM84FdRR2bftb9bEvV3+9dDxHwTN3Rojb
         Hqa8ghK3fP51NbUeFYVUtq9zJ7gGvXrlSgZA1VLozXPUN6Z5+BNU6jcvG/f+ld0eJgFa
         JtxzCKcwAO02sJzK9pwN7gawaS+CL5BwxOO3BsVfE1yQrPGeUveZB2GPRwcfqsq3PAC5
         06rFaphAz856oDd5In/sCawWrVtsi3LToBhl6RLPwr4oyWGDlwqndTzpDiWHdHmoMout
         +hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906311; x=1726511111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYSSPy5jRspVj2s1A9OUknnHQ0G4VBS5Qr+5Hdt0kD4=;
        b=a+Zazh6bB2Ftwm5hTBwyTrxvAlft4RJPVlAZk6GzuTe2S833/R3LEJ+0b3UAfQ9O+I
         zUrH5SZ5MQZIz9cr4CtpgdgduA/e20lrCfpW6w59Dww1AJNgqFpSQeIer0dyhiSz0Os3
         Pl2z+4p1AILYhG9iT7w8rZba64DbyXjMii4o8WqlRqyeHEGcHRARWSD7zA/d8WCOZXpX
         YnoYDufukOvp97ONd1fYo03KN6xtvh1Dy/W1BvnkOxQssTJmUe+wtEtEG48rPUkY5uw9
         +rqRoHvjuIz+FxMUOdmosc3yeEP73Fo9ou8jGBDaCqpBHH+MzRVrQBU6it+jm/knKMl0
         4BVw==
X-Gm-Message-State: AOJu0YzWIXRa5MtFwadEId5Bg+PYjgx+nagyQE9RhB2NkAkBcWNtVcdb
	yuvM90fXICn0RwjWJgFM9YiYXajhwkb/3mUXz0giDSSUBx4lS17jJumetw==
X-Google-Smtp-Source: AGHT+IGJv++77O4EKR9iP8zvKflKQUopYIwqPW7O+Z1TM0oUPi+V9ILh1DQB9xgNtszAucWIbB5Wcg==
X-Received: by 2002:a05:622a:698f:b0:458:3154:4d0d with SMTP id d75a77b69052e-45831545284mr40054761cf.37.1725906311389;
        Mon, 09 Sep 2024 11:25:11 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e9b231sm22539071cf.47.2024.09.09.11.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:25:10 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	christian@theune.cc,
	mathieu.tortuyaux@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH 5.15 0/4] Backport fix for net: missing check virtio
Date: Mon,  9 Sep 2024 14:22:44 -0400
Message-ID: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Backport the following commit, because it fixes an existing backport
that has caused multiple reports of breakage on 5.15 based kernels:

  net: drop bad gso csum_start and offset in virtio_net_hdr


To backport without conflicts, also backport its two dependencies:

  net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
  gso: fix dodgy bit handling for GSO_UDP_L4


Also backport the one patch in netdev-net/main that references one
of the above in its Fixes tag:

  net: change maximum number of UDP segments to 128


All four patches also exist in 6.1.109

 include/linux/udp.h                  |  2 +-
 include/linux/virtio_net.h           | 35 +++++++++++++++++-----------
 net/ipv4/tcp_offload.c               |  3 +++
 net/ipv4/udp_offload.c               | 17 +++++++++++---
 tools/testing/selftests/net/udpgso.c |  2 +-
 5 files changed, 40 insertions(+), 19 deletions(-)

-- 
2.46.0.598.g6f2099f65c-goog


