Return-Path: <stable+bounces-83621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205B99B999
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4501C20C90
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC331459F7;
	Sun, 13 Oct 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQCUyUTB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E6144D01;
	Sun, 13 Oct 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728826170; cv=none; b=O8+BHBpHuFjUIWZ6cQ438sknngdZtK/DQJWDwgV6TbcKUBegFn1BTaXAp27BCayvXWKD0Vp1BeUOqhr7r0FPyJSejs0fbUPlnOBszXPjctzu+s91x5iSGZeHeq51Yr4YzksPaxIYZqLF0P4nvc1kqo7iGOE9+LmHYmJrVUYuq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728826170; c=relaxed/simple;
	bh=SAEC5JBEGvTQMw649wbR32F7xQSAMSlWb1WlKc8U8S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QwKN6pqamUJq1YrTa2sieSOQnavpiofN460Lz0cJD/rxJQ94q+qd2otTsKUxrdc7zHgaGF9Pgkx/1Z/m5LYSQOrBaWd2oyjeNM1AUEeXKACD+uly2Qqd9lZe1kX7uFySU7EUSqrNwr3kEIBzO+zh62iDW6TGscOFy6uLgji/ZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQCUyUTB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so2615403f8f.3;
        Sun, 13 Oct 2024 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728826166; x=1729430966; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGlXEzSiP5z6yP6nCSdenZ8uyY+JlklNBTVpENkMXes=;
        b=NQCUyUTBNe9ASVRFRuQC9+n+noQ9GtcIPboOV5qgbxAsFD1wKFzmD7t1EP5Omyp48N
         QR3Uqh4CIHtd+FfxHUgEvr2NPHeaUYgVNssY7lmeQTOJBHkwR9FoFNcMYa/tbOS5mN/6
         GShaja0lWB9/9ezQCDtUSbg5/t8NzVPgO47mv53FHb3Q8vxzXYA0a0M0y7oaYDdJvJZ9
         xcbTZgFuxaI/d5MCFqazqrqYlijoCvbuXXSHqkUZFBPKKD6Uy4PbvuMKdqPgwSB6IWcR
         A2hvK6RmWzGfLxYkBdSElc5ICXAxm2lXODLkii5N7Dp28Y7vVTC0w9NmoLT0eKjo49Nz
         pOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728826166; x=1729430966;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGlXEzSiP5z6yP6nCSdenZ8uyY+JlklNBTVpENkMXes=;
        b=AtuxcYnnz8jutUPEzJ77HgVeqqCdJAylm1Wpj//UpLr3aJU2nHBNpBvd7vPZJfeXOP
         CyiKmfyrZpvJ5X9jMQD5mSklw7csmSG9wkyV3ZDBH2sjW+6Zmv5rOhSV8LdlblPoqpIl
         qDc1C3e6bqmqToXYiMicFxo85Ggzg5COQTsPukCjq/X5JLg9iJLj1e73oA/u9rTHudpH
         8Zwt059XUAkMgmXWx5CnkEPVUFtAihJnMwHdcye2tNcKc341cJWOucz1Xcd4qbF5W0Gn
         x1e4gENsBAl3m8tD6oRT14PZodnAP7qvOyz8L+cqXTXkWfRmWbylH8ngjCYlKuOYkMvo
         8VNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe+qlnxFL9uSItfRpfbec6DSQ0VXbb2a5imlFaQbK1UdhuRmTsakaA+v9yrP9keuqqd6MxY8DW@vger.kernel.org, AJvYcCXmOybpsj3tPW7Nx38McMjmKrKJnnCWGLF7zo0j43idrj5KylULMKxdE4iAorbcGIHSoOk3u+jqGtGU65E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwUc0LBXMurZPA75QjE2vvLv2XApAHqPZ5WaCeJ0tpl6Sdza9
	FiAqWTkD+V55wu9TYAixxm9OtTuGzEju1vp8KEhVwqiUopL/TZP/
X-Google-Smtp-Source: AGHT+IE8fC2geMshENVGb1hea7AhB6LAexPh3d8xXlpLs/ktse8QKUVqQH3fLCN/Mpne6NvatqohrQ==
X-Received: by 2002:a5d:6a42:0:b0:37d:4cf9:e08b with SMTP id ffacd0b85a97d-37d5ffa36e1mr5005643f8f.31.1728826166513;
        Sun, 13 Oct 2024 06:29:26 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a034-352b-6ceb-bf05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a034:352b:6ceb:bf05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190f7sm8655165f8f.114.2024.10.13.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:29:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 15:29:17 +0200
Subject: [PATCH] soc: fsl: rcpm: fix missing of_node_put() in
 copy_ippdexpcr1_setting()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-rcpm-of_node_put-v1-1-9a8e55a01eae@gmail.com>
X-B4-Tracking: v=1; b=H4sIACzLC2cC/x3MTQqAIBBA4avErBP8qUVdJUJKx5pFKloRSHdPW
 n6L9wpkTIQZxqZAwpsyBV8h2gbMvvgNGdlqkFx2ggvFkokHC077YFHH62Q9Dh32qxNScahZTOj
 o+ZfT/L4fhLKd9GIAAAA=
To: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Li Yang <leoyang.li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, 
 Biwen Li <biwen.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728826165; l=985;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=SAEC5JBEGvTQMw649wbR32F7xQSAMSlWb1WlKc8U8S0=;
 b=Tzw1jc++TZAlsNFa2eLf/X1m6vznngoB7tdjupyfxfOzpZpnbegGJ4VkNZYJOxkT0Cb1leguC
 4SfKNsaEQt4A+fLcXtT7kBPAK+pcVcJPdx+ZMr699dS8TLODbjBzgk3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

of_find_compatible_node() requires a call to of_node_put() when the
pointer to the node is not required anymore to decrement its refcount
and avoid leaking memory.

Add the missing call to of_node_put() after the node has been used.

Cc: stable@vger.kernel.org
Fixes: e95f287deed2 ("soc: fsl: handle RCPM errata A-008646 on SoC LS1021A")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soc/fsl/rcpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index 3d0cae30c769..06bd94b29fb3 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -36,6 +36,7 @@ static void copy_ippdexpcr1_setting(u32 val)
 		return;
 
 	regs = of_iomap(np, 0);
+	of_node_put(np);
 	if (!regs)
 		return;
 

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-rcpm-of_node_put-5e94e5bf1230

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


