Return-Path: <stable+bounces-25313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1886A457
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 01:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482471C237A8
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED0363;
	Wed, 28 Feb 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wgm1Q/ej"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E724210D
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079551; cv=none; b=FrE08thmJg8dl1r6jqcN3sULFa+z+D1/7Gvrx6PNDCTvFYLTk9Ol+SXrmknODMoohvXuDHVDt/G/f3SmCtaK+5oAF4FW8mOTDQHo3dfiWI1xBZGt5+OP6PLwhdZNkLB9kXrz9LPchV8kAKNy71XzUWzx1vSGZq0PyQjTAa5hiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079551; c=relaxed/simple;
	bh=j5Rz9witw9DFiiGNFw7bHEa/CoGSxtGq6qJE7xkOgTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4gZSDo8LdaH4KbWZdVqvL42iyk712NFmvrEmpUbaB4xmwSZjPf1W8RpBQhSq2elouNkRgqL2c7WAkW9NIPrpU98S1nLGaYQJXkAOzar5OsHwgXv9I6iQ3r9xFzupmGXycTlR5A+qDgXXmaq1ubYN0cfs9BumQwhQ7lEUgfkutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wgm1Q/ej; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbd32cff0bso37555515ad.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709079548; x=1709684348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Rz9witw9DFiiGNFw7bHEa/CoGSxtGq6qJE7xkOgTk=;
        b=Wgm1Q/ejrl/pTeN1X56UwwZr98W88gSdVVLqa+5ziXBRE591O2r/buMYzxPpEIZS7o
         SsiE7KhBmo3L9UFF8IE3cqXtTwuQrGapAAsEchopq1BKaFBXxAE/rJq53wtkhEZRT3Cg
         2L4DZv5OIPgPzFB3EJbbDy0zW6ERpYZDkRYXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079548; x=1709684348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5Rz9witw9DFiiGNFw7bHEa/CoGSxtGq6qJE7xkOgTk=;
        b=tt/rjPAqLINhdvnZdW//ARyFjc/rme8DRtwCaA1S9GpNdksc0BJigD1a8Uv65jyVVk
         iqCsZsrSAVRW1YTA7c8e5ZsOEwOUCk/nHWtYJCRPgDWpX/Z1c3vznf+1Y73H75b5/4xi
         42jIZpxNpoDILBNiaLXz3BQG0Us9yqUUKOaUMIQXKRlUpO2pmYiMpjAjBqvQLM4m6IYu
         litIwNJEt1gTMeGNaskiUcpo4oFqZdICLUVAdpjGUJbUDUsFX12J1W+dw/YOI694zwjs
         l7fd/tFo4CYIzIUhe4sXIL2rnbdEuZInGO8AOenZQoqhMCeOGFuEgGK02p/ow6o3bHtu
         VRxQ==
X-Gm-Message-State: AOJu0Yy9HWHAdV7ZmlyI8DAeyXY5yG0GQzxtC6fIYlTxwBb0evvTllwQ
	cz8oKM4PPHgcozCml/z7MfHLfiSsx55nYX3eRmqWbA4xZdQRexH+gKJ7xutqLUS8CMo8IWkiGUW
	Oz9ObYvn8izEmt8L+DPhTHWPwwcxxtvONo3UYQjzIxZKRDEf512ETICq+FS1v3/60PsB4gMMdyo
	YuAQ658qxbK4PZaMNBhDmkPvl1tX1dYcoXALo+iJIUwsCgCjENUTqnH9Q=
X-Google-Smtp-Source: AGHT+IHwobVDYZ16IGSaZiROsNB8NQfGfacykwpIn7j2X9S03xEkZe9CQg13ZNM9ynokRJ2Kei7bRA==
X-Received: by 2002:a17:902:f804:b0:1db:f372:a93c with SMTP id ix4-20020a170902f80400b001dbf372a93cmr8708337plb.43.1709079548045;
        Tue, 27 Feb 2024 16:19:08 -0800 (PST)
Received: from patch-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902821200b001d949393c50sm2086719pln.187.2024.02.27.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 16:19:07 -0800 (PST)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: stable@vger.kernel.org
Cc: phaddad@nvidia.com,
	shiraz.saleem@intel.com,
	ajay.kaher@broadcom.com
Subject: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
Date: Tue, 27 Feb 2024 16:15:06 -0800
Message-Id: <20240228001506.3693-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi stable maintainers,

The following patch in mainline is listed as a fix for CVE-2023-2176:
8d037973d48c026224ab285e6a06985ccac6f7bf (RDMA/core: Refactor rdma_bind_addr)

And the following is a fix for a regression in the above patch:
0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 (RDMA/core: Update CMA destination address on rdma_resolve_addr)

To my knowledge, at least back to v6.1 is vulnerable to this same bug.
Since these should apply directly to 6.1.y, can these be picked up for that branch?

Regards,
Brennan

