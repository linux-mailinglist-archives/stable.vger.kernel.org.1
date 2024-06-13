Return-Path: <stable+bounces-51302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCAD906F38
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048151F23626
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F03145B15;
	Thu, 13 Jun 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj7cV27f"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627E1459FB;
	Thu, 13 Jun 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280898; cv=none; b=RbDuXaezJh7jWjRvM3IpgBs4EViUrJhMpNhH3Pcf7ERYtStti760hZfT7CLnhXeYAZoqWWXBkLkTF/hcNfEY8m3IpsPaR04ovEZ2nK5c8LZA9FglrluJ9E7NKtGIGGuEyyVSSf1d4RzDyQAIXqKiraHodrV/xE/9Iz9MSn3s5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280898; c=relaxed/simple;
	bh=Ughm9l3G5ckH3Jnm36S6wz8bPjQrkCbc1vToYq+2KW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lztoc039/6M2V4sZCdfVrBcVAi6qj/9FRUa8/1EcltuFngXFH301JTikYhcHBZK6vZrr2e78Jx3m/thNCZ2mO/UCWt0ibgCP/DmxddyWoF7JsVcRQ+YYcuXvGDsf0UZKyBD4yqtxgqt5x/TzEcIIDS602Dtt7ZGCniDXKqhbtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj7cV27f; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so976003a12.2;
        Thu, 13 Jun 2024 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718280895; x=1718885695; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjivG+XaKe4Am+Fx0XOt/e28iXIYWa1P+7zK1ifd1rw=;
        b=Mj7cV27fLwEF366zUY7dfm+PClIVDclW+jD1efBXuRtkrlt/loXAgBBWDqYWF2HoIb
         tE5LlLc/4+YSBM7k//vIe+Hq/WbK9MDQyAluPmirb3pigypC+GytV2xyL/1NfvybZc1R
         Dxhvk264pqTgFJO3XMEQXrc/ZGuPSYGh2LiZp/y+iqo6MYY4v3OR37NpjOYmgPl/0vez
         sByUmwZSZFWfkqWq9KYREkWFgoKv4411/MmyZpPnG6YDF7WLxwQG+Ml4d2ds5Y87rt/m
         ENlXpH68RLKWEgQEligWooBqp14y9JULBPXiVSXFyAnF9o9yW6sS9mJIaQwv3josQidc
         vv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280895; x=1718885695;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjivG+XaKe4Am+Fx0XOt/e28iXIYWa1P+7zK1ifd1rw=;
        b=tRmIdBxhZqrbQUa6xRFmkcNAl8a10kzH3GoWstH1vevZW+mPdMuMZEw7+ZmLYRhhAI
         iBPY2EdN0w0cHRwFlQv/tjq5pZD7398qEGy0oIdVLlX6areqnKePDoGs8cOvU2+AqDSH
         3WR+E1oungKuAn9MYIFiBJ/UKVK7nngaVMbJcEv/UN3Rb9f76tE5nxRNiaJ8a00LrnPL
         IOKI2iBFGwLZ7SrZjcGVvwFhCrcn/dLL4+XCrnqN8f1YIJaWZveKDz17qUl4e9vsWpYW
         u4iGaUV+1ZsquGXfxcxzHyHRRSrpwYfytvTdtxfbMzwttYRIPCxeFZW1kkyXDSBy7y6j
         mCVw==
X-Forwarded-Encrypted: i=1; AJvYcCW53tTSalVLUjvn6oPmEbeaPU4N466TRudkgWkLrFKKiPVcaMwLJ1SfFvnmqeoJrA5Z8u2+pUUeXPE1e//+o1IG2KnFYQX0h05xzbDi/Jo0lEJzCs8vS6Cyjp0XsylhMFeytRyP
X-Gm-Message-State: AOJu0Yz0LF1xsVxKFoN6rVFlYyKBLpP2Bj8nNf6PWmUtHw4/4QpPgtPc
	s1n5vp3ulNyUJUcDQzDf44g4WpUvSm98NPthw96Jvc3u1x/LLUA1
X-Google-Smtp-Source: AGHT+IGzyxg4N9X/04QjUk81mzMKs4lvDIGYdWaRPWHzvvEjA+WMsslAg9qHkv+RapswAaEsqS6raA==
X-Received: by 2002:a50:d65a:0:b0:57c:68fd:2bc9 with SMTP id 4fb4d7f45d1cf-57ca9749636mr2961850a12.3.1718280894903;
        Thu, 13 Jun 2024 05:14:54 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da82fsm815747a12.32.2024.06.13.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:14:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 13 Jun 2024 14:14:48 +0200
Subject: [PATCH] usb: typec: ucsi: glink: fix child node release in probe
 function
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-ucsi-glink-release-node-v1-1-f7629a56f70a@gmail.com>
X-B4-Tracking: v=1; b=H4sIALfiamYC/x3MwQpAQBRG4VfRXbs1g4RXkYVmftxoaG6k5N1Nl
 t/inIcUUaDUZQ9FXKKyhwSbZ+SWMcxg8clUmKIytS35dCo8bxJWjtgwKjjsHtxOzrS+sbBlQ6k
 +Iia5/3M/vO8HLZq5tWkAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718280893; l=2414;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Ughm9l3G5ckH3Jnm36S6wz8bPjQrkCbc1vToYq+2KW8=;
 b=YDgrSVBahWgrzOAC3FGi+0YtUEAsHFh5ocCyy795FfD+LmURtA0lSth9sMHj8hkjA4QByq4zv
 yDBQaF49grEBxzAgRYmYa5SAIFi+RLhcFhvCjs2NfZi0pMRhzgoJ7Pr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The device_for_each_child_node() macro requires explicit calls to
fwnode_handle_put() in all early exits of the loop if the child node is
not required outside. Otherwise, the child node's refcount is not
decremented and the resource is not released.

The current implementation of pmic_glink_ucsi_probe() makes use of the
device_for_each_child_node(), but does not release the child node on
early returns. Add the missing calls to fwnode_handle_put().

Cc: stable@vger.kernel.org
Fixes: c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This case would be a great opportunity for the recently introduced
device_for_each_child_node_scoped(), but given that it has not been
released yet, the traditional approach has been used to account for
stable kernels (bug introduced with v6.7). A second patch to clean
this up with that macro is ready to be sent once this fix is applied,
so this kind of problem does not arise if more early returns are added.

This issue has been found while analyzing the code and not tested with
hardware, only compiled and checked with static analysis tools. Any
tests with real hardware are always welcome.
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index f7546bb488c3..41375e0f9280 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -372,6 +372,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		ret = fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
+			fwnode_handle_put(fwnode);
 			return ret;
 		}
 
@@ -386,9 +387,11 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		if (!desc)
 			continue;
 
-		if (IS_ERR(desc))
+		if (IS_ERR(desc)) {
+			fwnode_handle_put(fwnode);
 			return dev_err_probe(dev, PTR_ERR(desc),
 					     "unable to acquire orientation gpio\n");
+		}
 		ucsi->port_orientation[port] = desc;
 	}
 

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-ucsi-glink-release-node-9fc09d81e138

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


