Return-Path: <stable+bounces-198223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F9C9F319
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADD383489E8
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0052FBDE4;
	Wed,  3 Dec 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdoP35Ab"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06730DF6C
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770042; cv=none; b=LzL6fXLBDjGPCM1y9X0BeT3I2P6C1edrOusVmAVd7OGK+OWQ8agM0UZ45FE1Zu1EtDfItVeERVSP3YfmA8iO5y48SGH0bk/5sIxmeQAcPR6HEovhePifmjjgBMl6SAO2TRscvf+GtrDjJuyzUNHjZgHJrWC9KHZ8W9f3nAxYrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770042; c=relaxed/simple;
	bh=vMhda1+AxVHv3TrgQbdTvSItRk2i8ZQuMHNHAdy903M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUCGXL9Yt95oLcETCzqg8nn+Zu/FMfLquIkEx4/i4oXyQmakTDuvthw3RngzVohUD5oE4+/H1YwXw7ml9D6nxMSWVvoidmEBaBziUje4He7dKMaE0dOPlaov/LOSXwJqSzeMuLiGKVQiIYVafN8bvgCNmXXNxjAaVwj0z3vZ2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdoP35Ab; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477a1c28778so78384075e9.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 05:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764770039; x=1765374839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aioLnfL0bmSCseYA1z3bCzauxJY/fb2sxvmbPwmSqFk=;
        b=TdoP35AbQpGy6nTqpk4xTaaWx572rIhdgaXrFa93mJGDzNeu0lKDFllVEgg+BdBUMk
         wdA7INALVZEZ26m13PhN+xjmqhB4Bz6BFVE4whC+eo4CnpI/dC15BQOM6R2VTkITtCyz
         Wzrw1Zvk4izL7z9J4V4xVvaXicbeOntWwm0jJxClb9UtrIFOvDbty6/m5AgJVnp/bcMC
         f6LyvO/OkNAioNFhPzaNVKUc9JC94nAxulhgkfgy/qT49yXeXn7Pp3PjC9iFD2SCdK74
         x30OEQNPgjSMzheN99ui3YHYFHwN6g2wNigAUORM3/Dj1emenyrD0lkdIF2afFhwMGZC
         SNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764770039; x=1765374839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aioLnfL0bmSCseYA1z3bCzauxJY/fb2sxvmbPwmSqFk=;
        b=pFv71Oz6gDDksqjG5aA/Fe+UzDxjvDzTTwICOBAaFyAmPboHtnKcrG700cHEganfjN
         3zrRYg0kr2+t2uhHB303rmHnQ1bZBVcA+QZGbpYVW8YxWBnF81Rf6IDLyq8HtSqxxyeK
         UE87yOyrZDU+hJjj3CoPPJgdwPzvvVMKCJe8d1tUz4vBS7kFhqccrV1z0F+N/pRpMQmX
         50rfVlDsvox1m+rkgXLkpmtaPkLBeWwDmgmUmKbRP64pSUXNhRiaePWWqxGyJGF79YL0
         mOxx3VGl37s6kB+zjcwzUqak1BuUQJIVd43QJeT85d/1DjaE05B1J6c1obsQH70iQBQX
         U5kA==
X-Gm-Message-State: AOJu0Yw1+3POaiRWOc3/AlDFE1o/PmIwjj49wGYFUwU563Ej5Q/MzW4P
	25gHwiZSPHl2iaF6OMoyS/Y+W0EGqyGtzhkHr5FV7odJdXlB7jJTmvVJmH7EGw==
X-Gm-Gg: ASbGncvpUAjy5Es0OUt5U8biXPDXdbW6h+XJoBQhcl36Y/mtHcDrMwHDIFmPCnrholG
	2QLUbKXMF3Di/zWePIAnS8A0lYRDreKFoSwH1RfQDdvnNk4ROTN/6zPlz+KOmVqscxDs1W9n3Jk
	POD6Oo5+LXetS04P9mvsrCF8UJASmYkvFtto/0rxNAi9sieMoQ0NUTttcafXYkx3hFCsnGrWBNI
	zoDrWfLgjzXltbZg0ljtAUVSR1EHn6mtfuZwU4bxy8yteCdMLJzrBsi0jYlSylnVL78VMmY7FWb
	Ajtfbs/8h4PKa5Ph4ddaKRp2BSrr7254v2cv3m76L0ioNgaDUczLo5KgFbdLCKGjB6Gjumtv1hu
	cNE6wMK7YT2fIbDnd0nitSdVs5wKWw/+Fqg4KvnemdGEwAyhy5gpmA6opwtL0ME4Q66tEmoAHaC
	VsmkZITudLyfVVkJW6C0wZvP9HDum8/P8YYKzwcTrZIx16NcwOFZ+RTlL3fp8zB8y6El9MeRHeY
	yydBntl3qZRcFVNYwhzf/lDbGqr4jjky9tIhOP1Dg==
X-Google-Smtp-Source: AGHT+IHLG32qs9q4BIvUufo8fRRc6s9UdvNAPM7SZhhOitCuO55lRlGiuwa7xpNAuNetcMHEaEZUYw==
X-Received: by 2002:a05:600c:3111:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-4792aef705bmr26681805e9.15.1764770038569;
        Wed, 03 Dec 2025 05:53:58 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm40433575f8f.34.2025.12.03.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:53:58 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 6.12.y 0/2] Backport support for Telit FN920C04 and FN990B40 modems
Date: Wed,  3 Dec 2025 14:53:51 +0100
Message-ID: <cover.1764769310.git.fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
these two patches are backports for 6.12.y of the following commits:

commit d2b91b3097c693f784393a28801a3885778615df
  bus: mhi: host: pci_generic: Add Telit FN920C04 modem support

commit 00559ba3ae740e7544b48fb509b2b97f56615892
  bus: mhi: host: pci_generic: Add Telit FN990B40 modem support

The cherry-pick of the original commits don't apply so I made this
patches after fixing the conflict.

Regards

Daniele Palmas (2):
  bus: mhi: host: pci_generic: Add Telit FN920C04 modem support
  bus: mhi: host: pci_generic: Add Telit FN990B40 modem support

 drivers/bus/mhi/host/pci_generic.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

-- 
2.52.0


