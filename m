Return-Path: <stable+bounces-18876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E784AD6D
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 05:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BB6286530
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 04:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20C74E22;
	Tue,  6 Feb 2024 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYOPkg05"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4000745F4
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193458; cv=none; b=tOpJTOkE6ynot7j3AIQ6IZdXZLtcdhrySsIDKcseHfxg+52tGVtKhFEn0uf/z5yPd5wkhPU3oLc06WiommLhigUQ6VSUhwJMoaswB382F7A/z+ODp170jM2eY89N2zku5O4ATa9J9YVpds/vKLEI5+Ub9zUY8ntNvZtHZvBl/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193458; c=relaxed/simple;
	bh=BBcuUm0bjeZDYFp/nFXayMV+2jioo7Z2SXcSObhkE/0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LSWZk6YPvjcFr3o+dyJJBlNVroaCcI5W6zCFE1vQJVyKgs6L4hiJqLQkaOY9w+Hd8kSgwF5QT12FAiONXiPJ9LpCtCjaO2plXRbM8BJC0+mIpmu/8LENbAKCYLO7m3YKNdL6VJBN64U7qHfCmh63Mw1fQb6fJmlUowPIsxZzAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYOPkg05; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so8550559276.0
        for <stable@vger.kernel.org>; Mon, 05 Feb 2024 20:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707193455; x=1707798255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LzWbdYel3aT7imRL2l+83QFH5wg8/SRc2R/DFZ/44Sg=;
        b=DYOPkg05PyWTDjrw2ceopkyrpCRBIr3yqoXhyFVrCIeW4x4U7h3MEJ/Zf0e2Z3pyIV
         2nYAhUGGyApnGZ1oeFsSSzfOiURFOF5Payq7kNWxlC5gpuOm79V4JF7LaEbHj7vHMQZ7
         JmM4/ZWyW/J5IpjoK/AOue0Br8/IpR6FRzUEkI3ZpHby/QazfmROxCGnVR9xPa+JzXiV
         e0UXLEl4oyVrMk9kBn5HEw5eYFgAHnPFOPCNzLAMLFB5GfptyDlScUaC6F1fzJD54+Hi
         S474GT2f11D1dJIGZF0qGzD67hxY96RmRvRkNHbiBz4N0wP+FWDu9ZZwVC+Ny32RTH9R
         jChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707193455; x=1707798255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzWbdYel3aT7imRL2l+83QFH5wg8/SRc2R/DFZ/44Sg=;
        b=Li+T2bE4kmdabcz1RQUvXseuQSrM6QggBKAzXSC0vNI1dVkiIpgjSioJF/VfWb8yZ+
         R/cePUbDmjZEJOtQIZ28ZDKUEecxKivVcgee0f6XzDT52Zg48mJwaaxzJbtvBCduh7lR
         BQiDFl0tLh4T24N1AlznTFl15BvqJpaoMlQVfzaDrSVrFy0W0HpMV23qAyQnX7HFmR6a
         PNOouyY0e/g6uo1AhW/7krKQrGk2SrpiNeKxh3LkS/HZUwwtpCHKlH0eJyOZiBBPE4Ii
         Yh6E8LjaKQX/blX1QvMmj1+tlSjrx/U9LU+dF1oaEpWTV0exRIQKadNmYk1qYXkzWeZc
         RtVg==
X-Gm-Message-State: AOJu0YzqhueQEmDg6okObbelfP+TUuCUGhv0WAFu+GXS+UI6g878DTY0
	uOOL9CH/BIoBNf2YSRRzBL1Dp4gfEg5D7L6aqEvKllq/RjuLlWmCzsF4KrCUkZ2nJwwC+Pd9CnV
	eOFLujTWVag==
X-Google-Smtp-Source: AGHT+IGj2YpbzVhNfVvKI0DNc53QduvGrdnSOTjgYa/3exVdHLgeuMkS/Flk/JrpWsM2ibE1yyo6/SxpceTuxQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:2485:b0:dc2:550b:a4f4 with SMTP
 id ds5-20020a056902248500b00dc2550ba4f4mr162784ybb.1.1707193454844; Mon, 05
 Feb 2024 20:24:14 -0800 (PST)
Date: Tue,  6 Feb 2024 04:24:08 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206042408.224138-1-joychakr@google.com>
Subject: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

reg_read() callback registered with nvmem core expects an integer error
as a return value but rmem_read() returns the number of bytes read, as a
result error checks in nvmem core fail even when they shouldn't.

Return 0 on success where number of bytes read match the number of bytes
requested and a negative error -EINVAL on all other cases.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/nvmem/rmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 752d0bf4445e..a74dfa279ff4 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
 
 	memunmap(addr);
 
-	return count;
+	if (count != bytes) {
+		dev_err(priv->dev, "Failed read memory (%d)\n", count);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int rmem_probe(struct platform_device *pdev)
-- 
2.43.0.594.gd9cf4e227d-goog


