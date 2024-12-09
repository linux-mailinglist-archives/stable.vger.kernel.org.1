Return-Path: <stable+bounces-100112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C359E8F28
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FFD282170
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9322165FC;
	Mon,  9 Dec 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JNhvSLH3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F5216380
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737773; cv=none; b=kFxK9RSHDhCHJFh+VsFnc1DDzy4xXtORuB45buZUZSP8LjFg9cGtK6hvTxmjBGv8sZDhaiS84IIGIQ3KQIn9zNJUoa1KFrwNmeXTODVh6IKKwgiVyI4eCN9x4IxRrAxdh10GDLJ+lLkLuCcwDqInENeI41sgja5l8rjnsuDq5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737773; c=relaxed/simple;
	bh=vtzyGlW/khfK1HakE0DMVBSf8t7RHYNcSIPv2NOiti4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACN5pOeea7d74mNhYmTohIK8+6xJ+Bj2DloOqboBPSfJRJqG55SmvR0R1ttuzFMvp4/eKf7dmXsR1h7OSBHLsnyx5LJx57CohYbuykD1upH64WF/A9k8LzrxXWVHAmAAErlVxZiX9cxba1uZVOzmq846ue8Dpx0ytudyMsR36PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JNhvSLH3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6c54037eeso158808285a.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733737768; x=1734342568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EDuUMhlmnYK+wM/JuvYjnlnvtaYqlg7DBKQ07VIjqs=;
        b=JNhvSLH3wBaa72a3cebfMZRcJx3c9IAQPEgy+rqTqsIHPrCHocMMLEntdOHfLvAJD6
         NjQOIdARLSblWw8H1ilhCYHd8oUiK5egilGsZOX3KyX22x3jKoj2OBEovKdSOI8YXZdm
         mTiLoIuJp1M+WBBh96RyismGVsCfJDqb4Vx+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737768; x=1734342568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EDuUMhlmnYK+wM/JuvYjnlnvtaYqlg7DBKQ07VIjqs=;
        b=Iw5CEmQ2nrjZ1r7Zc0/09NKHvoBxKwEU26493awHMl7rgQZa/IQBJfOB9uNmZwLpDy
         N+a6NSDh8PicOiQyRqC2OBI8rXZPQZyDF7h+EE9FpD3PDzBkIm6l8rkH2rMCUVNS3H3l
         chOZKFz0DfYcKJ9QF1JKT/jweo6w45VoJFAjFHJ+xj4R5Bw0uSPm9aj6ZK2Ng3Pj7vjm
         Mlw0e864m8PHWr0r8WwQotv6OtYXDGGTzsOiGOOcrwz7QPUhCEvAnA2rmMZM0TGUvMa7
         TQUebwv0GeOb4NIcGAQ3eu6+bjz7OjofUDt8tRdeGWuDKm6DKyCbdTTjBtY83CPXw6r8
         r7dA==
X-Gm-Message-State: AOJu0YwLhhqemVMDGqPNBKQnD46urry7x2LkPkk6U5gU4x0QDlMoR88H
	RXycECEAMBs9XRHRTlMs5Qu/pLPrV+vZV6CqQrXXbw60BkvPmZKYJIe/AFGmSKLx8e/Bs69XQ2D
	5M6VhbJlsjYoyQQqN4rq18twPRbw/wQM5N++jEuZVQkbKEqsZM/2Hh6Hu3O31n8JV5K1ArPbGjq
	gP0bmpYgwow4WvFW/q/m+75DmxzifbEVqibF+rpFL9
X-Gm-Gg: ASbGncvsfYzgvSTgaMpmNpsEMCVuo1TW8rRLzfHezoae15D9AFUuhu8t+8pyIWegaYp
	2cfTBIzMrtZg38rnh6IUt7siY7SyIx1WJJC0WcDTyiLlAT358Rd7YrZS9BDi3NPOSbaT0bmXmp2
	VSaQgC98Y25sRDw705ZJqir/+1r0xm6wM5/LGoXDzQJ+2zlsCOWMErMvwydeiOBHXuswz+f6+M8
	suPdPj8BcJACksr4TkpvMGPpV0u4sqqVNugBk6XQ3lHVIMaCzPhMyKlWiCtl0/3bMY/nYnqK6yW
	Xi8=
X-Google-Smtp-Source: AGHT+IGDirteSvb5DALYHWHfiDyNjzV8hd+4Qsw6aBhUE7dWDiM8ElQadmrnt8I6rCPmsaGeC+aonQ==
X-Received: by 2002:a05:620a:454e:b0:7b6:6e7c:8efd with SMTP id af79cd13be357-7b6bcb982dcmr1967606585a.58.1733737767733;
        Mon, 09 Dec 2024 01:49:27 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d2147ff2sm128409085a.70.2024.12.09.01.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:49:26 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: zack.rusin@broadcom.com,
	thomas.hellstrom@linux.intel.com,
	christian.koenig@amd.com,
	ray.huang@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH v6.1.y 0/2] drm/ttm: fixes for vmwgfx when SEV enabled
Date: Mon,  9 Dec 2024 09:49:02 +0000
Message-Id: <20241209094904.2547579-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm/ttm patches for v6.1.y to fix vmwgfx when SEV enabled.

Zack Rusin (2):
  drm/ttm: Make sure the mapped tt pages are decrypted when needed
  drm/ttm: Print the memory decryption status just once

 drivers/gpu/drm/ttm/ttm_bo_util.c | 13 +++++++++++--
 drivers/gpu/drm/ttm/ttm_tt.c      | 12 ++++++++++++
 include/drm/ttm/ttm_tt.h          |  7 +++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.39.4


