Return-Path: <stable+bounces-47547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BA38D128D
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 05:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F39284116
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 03:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C0168BE;
	Tue, 28 May 2024 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2nQCujp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122632563;
	Tue, 28 May 2024 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867143; cv=none; b=MiknGawno85JSsbdO1KanYalcuO92O/I/rlXoQC0y+EwfIDdFo5E3TUo4sqW2pJH1evRsL6hrkYS1tIvMog8QjyIuMVdfk3aKaaO5ZWEgLtuSlYw/ZSAk0DAs/wlLzbdgMX7jD6TwRMupP2R/+lZydYFKR9ApNonhFnrqTOK+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867143; c=relaxed/simple;
	bh=ny8m4xCBhnV/0UIeJvOKqCsXclSGkQHmtW+lTaQqHV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmsT7trDr9xa1+/GCDuvsZf/ihnwXXedu58xLvEJoUgbKOq7GfIjBFqs+xqOvIQrCV/mZIot0WBUgKP0sXwENbV7KAfuVw/K21FEwNOWqewwRtLehD9hyR6dy/Pmxc2MP7xEGNouvqRuucfk07sMORnJu1/R5PBBJTsTRIOVdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2nQCujp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6fbd713a4a1so5815b3a.1;
        Mon, 27 May 2024 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716867141; x=1717471941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdqVzW0uYQzAgGRGuUdCNdfOkC+1NS25yKoubiH4Tn0=;
        b=Z2nQCujp2wTqltCY7sHV4JJuz8YhlWZj4qXZBe6POKXuDdq9mMIPTPh7/ks3MaYND5
         p90GSWyxjiP5qDAvXR6GDhthD+/jBl5+YDxcAOKo/31GpfCtYhp6JQxesU+KtElJih2W
         STMrXoPNGyFGg1jP7AM5/YQ2lHOhbNzXLxxdTWbnAYZxYtXcqADxrW7s3lV9YUgglVS+
         qch51sTmcZmHv20HX4lbHA3yk4aM4ozSxOBbDepq9m+Voqwa9BrkzZmWliw7S0aDsYW4
         LsrvYblgEtmlYrODr+7kv0f1y2Igela0PKlD2OkvzlXeugwhnFg6oU1Tuks8DMFGn7Pk
         8GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716867141; x=1717471941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdqVzW0uYQzAgGRGuUdCNdfOkC+1NS25yKoubiH4Tn0=;
        b=n2Yvq6u2/9r+9SOVA7X1U5x8BMqeDc4EixHu6gHiZW9yOZhGOKcabQK/qslvrFE/q6
         SbSGbTX+k3PwX/Jg9J8dKW6qACXLqM3UCgRcLe2JK6K1MTM0rWvgLQaUsxIa0i6N6vdC
         h7ErwH8tvMesjCqk1zCuIoDyHf/WfKJaCgGfwvl7GVZVtDgKAZwDU6LbsEcg/cbhTAAP
         PWtf19OZ5VUrmRsyMvULsa4PNty/p2lWvPKnCWR+A3vFej1w9Kx0VblnXCrifnRpkoFy
         tH0f21Yv1N0gY3SqGN96FXHAeYbpyF6hbI+z0Lz9JTMdBJLTLEs3KYGEC85mx+HzVQGd
         o8pg==
X-Forwarded-Encrypted: i=1; AJvYcCWMn4gC0MTwka2qZbrtJu9b03IcgfCpZsATPAQAlLbf2a8DMMZ8Y5SZM0nXJP8IbZlwH8/yqstF7G5Iu4Qni/37uccsol05Z+gZP5wwIhMJjQ98Fs6a8pG2x8EnS/M+J/14Xb9g
X-Gm-Message-State: AOJu0YxdmURmWNowNlG8ZL9mpFd/fqXtzAC9RyGTLmwowY7OPD8kKFQk
	19C+V0h7exLF4EsuRIuDKF/cqIyzgek14/+QD8pFxNA2ludVJIIq
X-Google-Smtp-Source: AGHT+IHrcNbVZgElQpq35gSfeTumdbcaSXxticMkDbkmuD8NrdmPjwtGDqQ1qdz2uJUgC3TvjUkgaA==
X-Received: by 2002:a05:6a00:4a10:b0:6f3:e9c0:a197 with SMTP id d2e1a72fcca58-6f8f184be18mr11713794b3a.0.1716867141321;
        Mon, 27 May 2024 20:32:21 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbec62fsm5909651b3a.133.2024.05.27.20.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 20:32:20 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] xhci: Apply broken streams quirk to Etron EJ188 xHCI host
Date: Tue, 28 May 2024 11:31:35 +0800
Message-Id: <20240528033136.14102-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit 8f873c1ff4ca ("xhci: Blacklist using streams on the
Etron EJ168 controller"), EJ188 have the same issue as EJ168, where Streams
do not work reliable on EJ188. So apply XHCI_BROKEN_STREAMS quirk to EJ188
as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
Changes in v2:
- Porting to latest release

 drivers/usb/host/xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b47d57d80b96..effeec5cf1fa 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -399,6 +399,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
-- 
2.25.1


