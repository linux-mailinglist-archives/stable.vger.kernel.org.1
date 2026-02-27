Return-Path: <stable+bounces-219896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLvODOQOoWknqAQAu9opvQ
	(envelope-from <stable+bounces-219896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:26:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D10841B23CC
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 761C330B3103
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2F32548E;
	Fri, 27 Feb 2026 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RePI658p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F1324B17
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772162782; cv=none; b=GJlJWvQDXFl2MIeUsuYrUbg9hhYnuXtF0xdQ0JSjo5oT0BE7I/SsWEpsxYKFGbNlP5vEpakx0DUAIAlh+CHv4HiL6tjME+gScuYy7bsqYQBNVa1J6SwQWjIhMoO+i7jmK0BE7owMGW4rWKNsHI1zcOlPNrOnqV88hwvogh/5OW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772162782; c=relaxed/simple;
	bh=QWLWSQDE2DlrRwx+dqEKdl3/Tl9WTFbrGA0f4dFKP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAX5EAT1hPrZysUNoqI1kIedof4LfRb+5PNAgUAgazlB6T0jG+ao05xMeE/SVRdgQVd4EWkLfG+x4uqM7HeWLM/rIhFNiz0+vKwPW6ZD+Fstuvq8REdyQc2doFmrjq9NRV85Cdd/aWh8TIiZ3k480l8SkdylZIapqrL+X8zjMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RePI658p; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so1376850a91.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 19:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772162779; x=1772767579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm2AcOtnsuA4yjZovdWg5px8aIMhZ3rKhw+QF/SygYI=;
        b=RePI658pxkXlB5qI6MyYp7qj0wNj2DbXsTdLwWj55e+jT/bVK201o9wnn6a9Y8DTjn
         WwIBS/WePlXl/gClEw+set8M++pAoIACZVv1fzZdm6o+ARmEGrvFjLUQk6rUPfAzTsas
         YOUuQ6Z/o741fuos20dYlZ3HJLmNMgRwRNNcnLJfr/AMMUNpqYQUlXyG9fgJSbPFAsHb
         ljP/OAWsz0tu5bkjDRQDY00KO9pSezplKYnL8cL/Vj2A1vj5LsUNdFhMPl6F8OGyoeI2
         iBFqpF0722rskBR7pdwWydUJgzXnJ7CeoZfkwv5i6kE68SCyEN5L0Da0HLdco3ihot7X
         XA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772162779; x=1772767579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm2AcOtnsuA4yjZovdWg5px8aIMhZ3rKhw+QF/SygYI=;
        b=O2o4uq1/pGZcZb3qdlettfvftitbtOLHnYWiUnW5l5mm9kvlisVkPf51DGFa5pN6wZ
         LYVRDAinSN2jO5BaYB820xUiKsYqAWr2FnCgyXdbSIijevnTvezXNOkausyH7ZGPLyCm
         c2cVEpYl+TcG/5k9Gy/xU1vV3Ff3nkWZZZ25fkWsYDbPVSe7CnenKHpyrqnj+o3XQFnU
         YepyQNDl9Vkke6yRke4i5l8U0MC11YmLSufRYvcyUEDr2gsPFOsCdrCmKGoYT1BpHhFj
         KDRFIbBJSHpfxk4dwuy4NWtLG4c/2dBzpo0FirWIT/bb14s96tUfBRatTn27wkgaaybg
         CaQA==
X-Gm-Message-State: AOJu0YwgzUYYDJ+hExVhfjoTjMYiglaBHU/hvyxVczLRLJYWNxD2MXKG
	ZDJ9NjViDLwGEsbKkvnKiZTWU4uSritYC6UMvB3KJCjSEeuUP2+QZ/mBJvs/PQ==
X-Gm-Gg: ATEYQzxXxzcERwT871sUEQV+F5qSHbOMU/MQ7ZUgv7phtaQGVIklNmKVFRSQC0ugWjg
	boRRfoFNpYq6wqi9jPtlAySvaQNgLal4UheqNZ880e8WsojGmemYhDU0Pj9KljinQKkx/VstuSu
	w/z+AVZPEXKu1S5zsII9sjmPcNj9Tjtb0iEs5zX9RfAwn1O5vJ1TogWjOKOrhp/Wi1YSgni3CD3
	FZrT+iPo5Mnqa8pgI4y15EwEUcAsIUhpr0yEwL48GGZ+TvfHRGy1rRKyQBqXzDuutxlxxRv3vHW
	oQNGz4vSR6gNmwalevuA4NJhAT/cC3vrCUPJkg1sBsZ0XbHxnLObfkJ2zbDNe2NWyL9/uhkVj91
	zcbdTbTkC50EX+oFjo0YBeiioEMf93aZIdKffIDxqj6T8jAcgJdXc/u9R75gkBZ9hHuKcS2Qkx3
	TIwHv9suNCrNBwqwK52Cmz14boxY9zWC3ZB8XDcWAhPXhAGywWPQ==
X-Received: by 2002:a17:90b:1d4e:b0:354:999f:1b27 with SMTP id 98e67ed59e1d1-35965ce1427mr1089567a91.31.1772162779536;
        Thu, 26 Feb 2026 19:26:19 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([175.201.112.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm4501887a91.2.2026.02.26.19.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:26:19 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.12.y 0/3] drm/exynos: vidi: fix various memory corruption bugs
Date: Fri, 27 Feb 2026 12:26:12 +0900
Message-Id: <20260227032615.108139-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219896-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D10841B23CC
X-Rspamd-Action: no action

This backport patch is for 6.12.y only and fixes a bug in the
Exynos VIDI driver.

https://lore.kernel.org/all/20260119082553.195181-1-aha310510@gmail.com/

Jeongjun Park (3):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer
  drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 64 insertions(+), 11 deletions(-)

