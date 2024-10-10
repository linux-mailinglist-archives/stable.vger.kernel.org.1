Return-Path: <stable+bounces-83403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0F99959C
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98CD1F24E0D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9291CF5C3;
	Thu, 10 Oct 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDwoJQ2A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC514D6F9;
	Thu, 10 Oct 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601875; cv=none; b=XHYGdkCpT2mI+GiYb7xS8D2fomBfQQ0TfyFYiB1183h/twf8WHCEq6mMmUpSWXRgdfmByUDUYLK/xCCj2pG7NEqsggBK7vCSPMQXSYV1vAarV0AxKYvTzQ2LD7Pybo/9zVkFRCWbdaJXlFZbe8NbZmH7deng8Nw1cbuqs56nL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601875; c=relaxed/simple;
	bh=VNQYeYjPOiXX6573OnZf1sNGyADS0plJBR+e/AYTBeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cLVZhBzU/oDspcTP/BI4Ql6OLWtMCyoh4/1GIveUep4OAL6XHNW/qn5v/CDxRzbDbrlxYPoMRzGoZgkLI+ZgC+ZBa/gkzKuLiBym4rvR33I5XMoO5mM+WWOxzZf/b/W8gQ049aCHrwZDaPx9j6YS2OquRxOvfrPGI8IQshNxKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDwoJQ2A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so12398495e9.1;
        Thu, 10 Oct 2024 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601872; x=1729206672; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjPwcfBnpMXxgtR9zYeG1f69L8F4e63LO0DXGyPpc/k=;
        b=cDwoJQ2Ad3UlOvEgGTO+cq5rf374lNsxGWn/M1wOhod2VLQs7SakxCBiWVPmyRfQ70
         mTeL+TAUiKZPqj+QphbR/jKvYXpkXAmaVTuDcEzzcLks6+YcgDKb22UeT2ylJjAG1N5i
         0YjtnVMJiP/a+G8Ppcp0gEiQg1+Weuf2pJfD6dOcWcF4Tvfir5P7nEv108l4t7FnGqJL
         Y36j5XofsPgm8v1+zSmB/blum/EiWW287Fl9grM11s2/62eaDcHzpErzz+bRAcsixq5h
         eGbtrvMbMs118KkV6i3wc7hW24IUZ6JVC+WsRFElpgmlMw4Zbfk43IlA+HbgKMdoytMu
         wyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601872; x=1729206672;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjPwcfBnpMXxgtR9zYeG1f69L8F4e63LO0DXGyPpc/k=;
        b=hJ6Emu2dTcXF0mSc1P5wcmOnu4RoRiNCmxc7L5KLFXW9WC5J6wArQPn4mKZmpUsysN
         3NwEWLOgxA/9P5XP+QyfV6Pi8wXdHRk3dQv0LGrMlJ18Rr5B+BClPes8Dp/r24CeSMb0
         qeVy9Izw13yvpijlRa2MRPV5ThjFkBUp7tQ+Y4q6Jr+fdV9d7lFCyj0+YIZIEgTFY5yH
         eYHHeDYQSjtMtXFhBdCyyecDrhMAlEjtQbfmYIngBnKfsNK+oWicT6ge5aHUrz7sLhTH
         g2mSJYhuBW3RKuByEgWKFx007VKYCEOxhOyd6aLRMD92Gqo9RZ2dtqrHOlYcMNRmo7io
         /NDw==
X-Forwarded-Encrypted: i=1; AJvYcCVgBS6/jDVp+1eEuJ/4oK7DegRfS4RR4z2wlcWm/ZUCqYu3CUfUBU7QKWc7fpr+f+o2W9mSjh+/vW7NGCQ=@vger.kernel.org, AJvYcCX+SVxyg17jS71Vo6CzXaJBUB35i1RsDkPRAYBk/mnrKPr1mkx43XNsL4caDrTicOSwDlGABCqt@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqtiP8kSuuxlMLiAPq8V510Sso48Xeb1epL/Gkh3vRaUKLSRv
	tyKxxDRnDDb8t0xM+xSCDJZl979Oi9N+RLx8tBfr5wo1FFN6tp/H
X-Google-Smtp-Source: AGHT+IEpM3FDRoQJpalgDZzsnqUCeD2Z17cikYAZ7GmGRPUG4jbEdx8yLOvV5OmP2FAMNR0g/DCR5w==
X-Received: by 2002:a05:600c:4446:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-4311dee6f7dmr3658365e9.19.1728601872026;
        Thu, 10 Oct 2024 16:11:12 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3d08-841a-0562-b7b5.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3d08:841a:562:b7b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7934sm27465325e9.3.2024.10.10.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:11:11 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] drm: logicvc: add of_node_put() and switch to a more
 secure approach
Date: Fri, 11 Oct 2024 01:11:07 +0200
Message-Id: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtfCGcC/x3MQQqAIBBA0avErBNGCYquEiE5TTUQGlpRRHdPW
 r7F/w8kjsIJ2uKByKckCT5DlwXQMviZlYzZYNBUGjWqNcxCJ9l1uDnaMFkfRrbbsStHFTmDtWn
 QQe63yJNc/7vr3/cDYQvZzmsAAAA=
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728601870; l=1658;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=VNQYeYjPOiXX6573OnZf1sNGyADS0plJBR+e/AYTBeg=;
 b=ESFH/s/wMpa38hE2jm/d+8n6IRGkNNdS+6hN83gW3qtCCKAaEXP+0IGwN8vCPrCAMvbuHqdnQ
 FoaL9XfhmVDD44TTf2HAZdOFxobmcBArO5PXkHZKBhN2tcTIlncgXTy
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver has faced several issues due to the wrong or missing usage
of of_node_put() to release device nodes after they are no longer
required.

The first implementation was missing the of_node_put() for
'layers_node', and it put 'layer_node' twice. Then commit
'd3a453416270 ("drm: fix device_node_continue.cocci warnings")'
removed the extra of_node_put(layer_node), which would have been ok if
it had stayed only in the error path. Later, commit
'e9fcc60ddd29 ("drm/logicvc: add missing of_node_put() in
logicvc_layers_init()")' added the missing of_node_put(layers_node),
but not the one for the child node.

It should be clear how easy someone can mess up with this pattern,
especially with variables that have similar names.

To fix the bug for stable kernels, and provide a more robust solution
that accounts for new error paths, this series provides a first patch
with the classical approach of adding the missing of_node_put(), and two
more patches to use the cleanup attribute and avoid issues with
device nodes again.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      drm: logicvc: fix missing of_node_put() in for_each_child_of_node()
      drm: logicvc: switch to for_each_child_of_node_scoped()
      drm: logicvc: use automatic cleanup facility for layers_node

 drivers/gpu/drm/logicvc/logicvc_layer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)
---
base-commit: 0cca97bf23640ff68a6e8a74e9b6659fdc27f48c
change-id: 20241010-logicvc_layer_of_node_put-bc4cb207280b

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


