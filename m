Return-Path: <stable+bounces-61883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A180793D508
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A91B232D3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1EA101C8;
	Fri, 26 Jul 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZmZYn/8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A54C8C
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003779; cv=none; b=KaI77oPLWVkQpr+fitmurL7amfsrsJMxzh0G7Ypz2lJe/SD7gz5iPndr96A3hwnLcM8q0uWWbNZSFoGd5hvpULreAoVautfbKQgF5dPgT7pky/W9AVWsbvH7fADFNy8I0gfiMqWyiMjn26ICxM3P5pXXyfIGhiHeHmUFWCQNoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003779; c=relaxed/simple;
	bh=Pruvkh8HPP7iSqWx/Dcrp99qasjLgI2dUzT04+3A4m8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tEM17Fgyyghl5tKTPaE5cR+AUJuFE8SSbwSR2ojpaHKfh/JySyixeWtA6eqWY5zfHF73QCru80V8atlzr0pFJG6et02K6zkOsHhSEpJkNL4ox4cOkslo77i+sHKlrdaVAwyoc/XLggLGBA/vQwj00QkPEZ4EvjNHWz+YqawoFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZmZYn/8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efa98b11eso214027e87.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722003775; x=1722608575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pruvkh8HPP7iSqWx/Dcrp99qasjLgI2dUzT04+3A4m8=;
        b=mZmZYn/8zX2oG731wDw5Jdg6fVKeOvZ5ghVLGJlGuUgnzsBBlNCJyhf7px6qdcUT6h
         3aaUSHJeTLK84ATNdwY/Zy3SrFhJ1SDghDIpCBwMR2soV7qlBXFSuKm6SiIQsWPwTYqp
         nEzxbMTa1ZJJWyPene875I9xmfZq5gbLyfa3NRXdjOSa7ZvZ+6TH0T6Z5lBTruloscMB
         J8t0NEkOVzqSD4NNo5xDqiNbYz5CXBQfa91f8U0T8xv1Xv9gAId/4Whn6nNhSsJ1x7Hs
         Sb1uPa12i/uQtK+38tjbbdCzhqFPZ/5J6E/399c6LS3bO4fWLWhHTkNGQWRH8oNajY7S
         rY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003775; x=1722608575;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pruvkh8HPP7iSqWx/Dcrp99qasjLgI2dUzT04+3A4m8=;
        b=lWTIkznO8UIPtKh5xnD9Bw8MXqMPq9YqMPvVhQ0WBBh9pvtfgWeTVZPrDrTsil89Ar
         3rYKGcuumg7OnA9nKxPLiKKOr0FkHppeUk4q+hNP85PezLSAMFMAs8+dQwklbB/DUVzh
         cvpoyDtydcPWLxPZY+ZxSzMFMzvstDFSrVsCHgNC1HuGTrh0QkiXLlEnMGCKaDEtowVZ
         WMNtyjjPgYZ3g4d5zhkzaL0Q05r+l97lZVa3HLPHcbTTOtCmnfju2ehGF9lumykCgYfE
         zfHOGuacwTRQPmrPaskdweNfLhlay6fuZA696XNodggp5JyDwhKqd+yBBtlTUUtL4P0A
         mE7g==
X-Gm-Message-State: AOJu0YzIB6UykIYptf5q1lVciUzkzUD7CNMAZWFwWvToI1BUSGoQslrc
	K2rPPVnw0zIt7XyvJCTAL7uMjSIT4YIgSR/14czy0aYwAix6Tm5OpZ93k3+O4WcvsEh5BGk4dKy
	NiQ9IMWcTboiuDug1AesPlwxpxsaKLX4v
X-Google-Smtp-Source: AGHT+IH5RcsfZsWfXZ0OeN2Vit8dDu+eT/gl+nE6Kd1kbLoYpgesYLxx6biqaCn+m192HzV9kgyEx1pu89VXz0jXsjE=
X-Received: by 2002:a05:6512:33cd:b0:52f:c151:9a7d with SMTP id
 2adb3069b0e04-52fd526b933mr2652001e87.1.1722003774922; Fri, 26 Jul 2024
 07:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Jul 2024 11:22:43 -0300
Message-ID: <CAOMZO5DymKk1oJM-Q+a_7hKSSLcxSs8D+EM=jUbT+Bj2g_nXnQ@mail.gmail.com>
Subject: stable-6.6: Reproducibility fixes
To: stable <stable@vger.kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Please consider applying the two commits below to the linux-stable 6.6
tree as they fix reproducibility errors reported by OpenEmbedded:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/lib/build_OID_registry?h=v6.10.1&id=5ef6dc08cfde240b8c748733759185646e654570

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/video/logo/pnmtologo.c?h=v6.10&id=fb3b9c2d217f1f51fffe19fc0f4eaf55e2d4ea4f

Thanks,

Fabio Estevam

