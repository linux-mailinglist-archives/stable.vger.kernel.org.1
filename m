Return-Path: <stable+bounces-89600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539199BAE17
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 09:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B6C1C21156
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F8D189F5F;
	Mon,  4 Nov 2024 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="oYMZYNrt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA2A50
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709070; cv=none; b=VUVb1uvrV/kpPmL39LtVkaiQaZZwFkt2gEGFhB+hlG0EUs+jKbqF5gb+TP73pMOIrzLDA8UvYL63LQa5p0zYQf/Ic8q7RkNGa+PUKkOAZsXDl17cf8xdaxWXmKJWOpnjZlMhrahPWRI3mHHGrps8UXErD7QilbYy7QNj3MLLT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709070; c=relaxed/simple;
	bh=m7bNrzT64LR4aULd/xQ7bLyaKGR9MRRBFZeqco8jZCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N7WQJWdgF7t/Mxip6vYml52UywgHMDIdAv9XLUmgWuPUhkFj02Zgc+MjGZ+bGpj3mfR4JtqsxCpCnQQg9p7StEI8ou//Yn0FOwhHTQSNGmr7yFbsGjEeK3nBCb9aj54b0dylz92vqDds58i8u4vqJIoOM2/ZG6WQjcu/NS+ZbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=oYMZYNrt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e681bc315so2712962b3a.0
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 00:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1730709067; x=1731313867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDtl/CUWwg6aUbky7XDXGE1CPeuCpGLMrN6Io2cHBfk=;
        b=oYMZYNrtcLdkdmNZIt2GAVq3AY52yKt9E51/rJgTI0nCk4F1b7knu4JO2WJ1LScA8h
         OrCiQhFXqd0fTAAZRbKy8uO563fUAJXluvwwqYG9ZKW39pR/JWmX5iIjDfBi1+ZYyl3r
         C05GSw2Hzcf3iodN31fO9BeoP+fUEAk5J7b7iyhnCCbcHWoYjlwwPWdM3dFs0gPdK9z4
         sstm7eckw1Jo0MNliW4HJhk9Ud+L4y5HAzV76YqWRceeQMZVw9BO0aaKcl+9m8ZkXl78
         b8usE1l18bI4QuO4DilIuaDFFc91HCL5e/linNxe719OHoyNg9GAoNPsRarhH+5mIQZj
         3Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709067; x=1731313867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDtl/CUWwg6aUbky7XDXGE1CPeuCpGLMrN6Io2cHBfk=;
        b=Q50LYqgxO+Sc2PUk44PIFJbfBTD/aPcOV9hhKtqGiZIOX1jK5ref6zNGjPSpnmkozN
         dJp+eX0bl6ibqgEhr7cIERhj6oU3aaMohG6x1y8XTLiwGG6QdJTUpPTQY93vKO9+lN8H
         vo7QgllcY3E0v4+aR8zvigPk1S9dtqU+FLCjSFlxS5ENJfZ+roR4fSVUrFbo/Y0rkSts
         HDixp1ck7w252Gqmkc2QoPGfukbBEh/L6iy5+ch/NchTHvgGkOAiXpD1aES8pXoPQfqt
         7yP76/j+nzeELAVCAUMKmaD86Is9uU44aopM13TDrnidoKpJsSzqEtKHLO70O/XOoI7r
         B0MA==
X-Forwarded-Encrypted: i=1; AJvYcCXQj818gQukdljOYdMzaZGOra9FCSTvh0ecdJP0SS2M7kz6mwODUEd0QoLXpvRRR+jy9xTPgZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrCEXu73gbn2xUaPdogSq+lra0so6yOVZCuUXwyu088Pqr/gf
	U9hhnUjiDzJ6G56RISIw/ZT+xf4wtdC+A9LIfJD+/K9eG2GD6oLc3EHCYDgn9jU=
X-Google-Smtp-Source: AGHT+IHLD2ra885kPSAdddYY3WSLtRoo3oMZMuztSbqXZ6K6njxEOeePMT6F3coH5lzlcImsTnBWKw==
X-Received: by 2002:aa7:92c7:0:b0:71e:7174:3a6 with SMTP id d2e1a72fcca58-720bc39e4f0mr18540982b3a.0.1730709067131;
        Mon, 04 Nov 2024 00:31:07 -0800 (PST)
Received: from localhost.localdomain (133-32-133-31.east.xps.vectant.ne.jp. [133.32.133.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5625sm6872011b3a.53.2024.11.04.00.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:31:06 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: Drop reference to a fwnode
Date: Mon,  4 Nov 2024 17:30:45 +0900
Message-Id: <20241104083045.2101350-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In typec_port_register_altmodes(), the fwnode reference obtained by
device_get_named_child_node() is not dropped. This commit adds a call to
fwnode_handle_put() to fix the possible reference leak.

Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Add the Cc: stable@vger.kernel.org line.
---
 drivers/usb/typec/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 58f40156de56..145e12e13aef 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2343,6 +2343,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 
-- 
2.34.1


