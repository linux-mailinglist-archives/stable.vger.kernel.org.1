Return-Path: <stable+bounces-158963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB2AEE0AF
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 16:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C0B7A2E4A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C95B28C00E;
	Mon, 30 Jun 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ9Nxu1q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5428C005
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293665; cv=none; b=AkHRuUH4yq1MEHikkCTZeHSPwEfypR6z80RcoH8jNSyxG3StZa5uF99LvDOo7p/G6NU6Tqgu9N6EvUAfXbScdDJfKnRPXHcz9Ub0iReoE7Y34YXQ6yY+gNF+PJ9qAgYIJ3NgIGhee0h1Mg4dcS8pvJpyBoLR7CjbQXeGbihc0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293665; c=relaxed/simple;
	bh=4BwrmB39jxfPik6LGKsILbO35wsW1RW1VnJRHdXYRfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNYaUhZ9uSyk3fITnfcmJlz/41x60wK4YWdzfIqalqEyNUH7R00lVhXSqoLPvX7GPlLl0aiGk9v24XXtIsPG5WIvhW8oZoQHKLR+6UYjGVo36nPvE/23vg4cMnJvVQpBD3OM2d9eTuujfRZN0QDdGWzx5Lt5nhHat5POd9TDcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ9Nxu1q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ab112dea41so1079987f8f.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751293662; x=1751898462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pgymszMlzA/NGtV72uiUav7nmxj4cJ0thLj3a1qVEDM=;
        b=CZ9Nxu1qjKUVBHgTJGlOcMBKsd/Spq27Q8lWXdbu+0IXG6DaIcYF4M9Amhi0sJdcNl
         KHKmh8kniOcPPG0ZHKQhZD5c3U2FGbp6iiTMqbscnHR/f3i0qjz7fLAMyyH7Tu2R+Ai0
         WkXN5Pa3OxeSdb2him931JIcieTBNknegp1PGJWwYo7nymlA+WXfR/DguubIZG/gWMHi
         RlClV0y6MhyPOQzIAjh9XQnSLv2B7qBDFTjzbAa+6jhwEbNkDUeQec22LkopsM1Luklc
         wemi1PY+FZiPU3XlfeXvz0FEwKoWqmQiPrsgKavwMmH3fPbR/BokLr5suO3DvrE+aUbv
         XBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293662; x=1751898462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgymszMlzA/NGtV72uiUav7nmxj4cJ0thLj3a1qVEDM=;
        b=VNIwgQsvg3xlAqahhO1YMTt9OK3JEfJ6N7hvrauIR4Mn0hfLifbLYS+J0B7drn+duj
         olMM+iRpFFYxBsNGV8hSM08TTRvH+OMxFs0SHQgqfflTRUryspYSuTNcSCCy1eL8NpfS
         fwx1CMH70PkfX/xWgT+G7soI1VDTgtGnXb4+Bo2PpMjUhoqVbkCCh5qhLAKjpqKml537
         8f5BS5IjlHeUxVZoIv2AtyCp9jlW8XUKmWsRkn0gcy1fD5n16TH5lyCjHdQP2vg7oBqS
         nmsGu7/eSkpqZ9MDlFi1UXCGlcn1Qf3Dsh7XPYM47GOpyiUYkvzkbOXktNmMRa7pi19H
         cIjQ==
X-Gm-Message-State: AOJu0Yz3PkGnpmcq9fUi7Y6tmMFjQ8iQtZ9d7fdvOTu7qbbyiBwBaZ6o
	RvaWi+mmap3E0hOCPyDe4xw7NBroM510oqfJbLX3VlW37Gbi/L6SM8av8T1IUw==
X-Gm-Gg: ASbGnctdy5Uw9r7idSsxgnw8KQRMR7kdcB/eK8AGQcmjx82NmSKDcWP3qTIdmCAoO6N
	DtMaqpJaPj14sjjHpOHniCA+r5KlVv/AMEx/t1IaXWJX7v9MQ/Hi++Zk40Hh1DXJXa0vb++8nYg
	v7xP3Kuyc997foVT2Q4dQu7uS81coV7tmoQ6KfByQNvtBMwC3pEKQJScQA3LI2egUelKODSyILV
	PeqEofF2hyeGyarMpgNaILLaLg8iw6wyG1jeY5Megl7Td5JnL5gLpdO16QfhrZS9PtL03Cm1WhM
	vs7OQXsEfgbnsHNc4VpTVO134wONrb2ESKWngjV3cQ5cCeRJw/A94lAfWR3CpzMdZZQ21MEoO1+
	QPLkXJZORHtAzTc21No/eBw==
X-Google-Smtp-Source: AGHT+IGM5CJcopjgL4nm/8+2DrOl02fYiD11C2YChK2s49XJnhGDJD0PHtnZvsFgp46ZkMzqYFzbQQ==
X-Received: by 2002:a05:6000:4211:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3aa34f4d5e9mr8640360f8f.37.1751293661857;
        Mon, 30 Jun 2025 07:27:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm165871905e9.10.2025.06.30.07.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:27:41 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: stable@vger.kernel.org
Cc: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: [PATCH 6.12.y 0/3] r8169: add support for RTL8125D
Date: Mon, 30 Jun 2025 16:27:13 +0200
Message-ID: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Tortuyaux <mtortuyaux@microsoft.com>

Hi,

This backports support for Realtek device 0x688 on Kernel 6.12.y:
* Tested in Flatcar CI w/ Kernel 6.12.35 on qemu (for regression): https://github.com/flatcar/scripts/pull/3006
* The user requesting this support has confirmed correct behavior: https://github.com/flatcar/Flatcar/issues/1749#issuecomment-3005483988 

The two other commits ("net: phy: realtek: merge the drivers for
internal NBase-T PHY's" and "net: phy: realtek: add RTL8125D-internal PHY")
are required to add support here as well, otherwise it fails with:
```
$ dmesg
...
r8169 ... : no dedicated PHY driver found for PHY ID 0x001cc841
...
```

Thanks and have a great day,

Mathieu (@tormath1)

Heiner Kallweit (3):
  r8169: add support for RTL8125D
  net: phy: realtek: merge the drivers for internal NBase-T PHY's
  net: phy: realtek: add RTL8125D-internal PHY

 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++---
 .../net/ethernet/realtek/r8169_phy_config.c   | 10 ++++
 drivers/net/phy/realtek.c                     | 54 +++++++++++++++----
 4 files changed, 71 insertions(+), 17 deletions(-)

-- 
2.49.0


