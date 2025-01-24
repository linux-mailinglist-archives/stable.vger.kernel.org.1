Return-Path: <stable+bounces-110354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F74A1AFE3
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 06:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F420316D731
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 05:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154BC1D89F7;
	Fri, 24 Jan 2025 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ONZ0oqjz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD180034
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696797; cv=none; b=TTBCNYHx+uLR7ctnFI4zfeuoi4nsAQn65PKWMBzD9fGUEY3sIq8jTJe2y74QBBGzGcIMeXxtWtp7Nb5r33/bLozZWriDveldMHQeC0jF6bZKOaT9HJQc8DEfrvOMqYISJTh8lChmSQK8RsxjKEaTKURH+/Z5pEVW35CtpBan8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696797; c=relaxed/simple;
	bh=kfxJO7UryXOc2hUzcpX+Luo/YsLXqyKZVOcrkmyU5fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYA8diF/L84QoAh5Aql5BRju7UvmU6o7Op32gmZrBhDGhPNqjiTi64r0SRS9bNI/Yl6287uLI9JEy1nRl0YwC9lUyp5u8VARsDZZrglIE2SyKtnS+4KgvytV4mHioczGmEHaW9+Em9lscto41F8DjuZq+atANxoS8VGReClJR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ONZ0oqjz; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f33d67e584so179677eaf.1
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 21:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737696794; x=1738301594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7CHOhjlbqLmPqr3LdrpbxR4OF4uKkVOK28XhR8E+RE=;
        b=ONZ0oqjzh5RC9q3gwlhxGKy+Kmb65T2taJq9+iVQaEnKMRPXmHqw77mYGeKIHKwlP7
         8uhZSZmLaIv0H95X/g3ZngWla53LjqSONUgOEHwgfDb+kpdwkGxPvarvJ0Hhh15f/GL2
         TGLAI13Qqr0hLz78kmMgc3bvOxKtjkQGnmubg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696794; x=1738301594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7CHOhjlbqLmPqr3LdrpbxR4OF4uKkVOK28XhR8E+RE=;
        b=PpsemKZi7oUvnc63dnO7i+/9xCy3Pw6CTDGy8x1taFRAnzRzNAVzuudHLBTQqVGNI1
         u9dU4tj+zsJG2MXxjXwIfjwBEOTj/U/PiuUDQPSLrm0VeDss/P4gmSXIA7KkIMaHyOrJ
         W/OUUrHK2tjPMHb8jH24oUSZX7W4oZFRq3Y/vrOG8nCHHp7lDT9TapRt45nDmqUMyZEk
         A6b3UlGpTAZCrpIJS8UeyzTPk6++nwSU/gTC8gdwmBeEQVG5Zn7neXaDXGCmemgL7IK8
         umZPx0iWmB6rP7V01XUDLqre2NBU6jQL9KHkneNQdVb4LrxuOsxl4pkcTH/pCUMPmA15
         wtnQ==
X-Gm-Message-State: AOJu0YyDbCWFFBBBu0tefgRLkWoFpL29x227KItYyL/4lr8tSkK1zqVs
	JK22Y60yx7AJjLzxNtQndvDcyfpBBROMNASl0vo07wATLw6PQTx5CnrQ2BceWl+aRMcIE+9/n3o
	5zITHvj0kVnniu8TEIuBJuIZKDlt3e5aUWr2Sq7/iXJmhqgyEg57Y7iXiwMsfpbILnjBRuSLlNu
	kdCTrJ1I8s7Jtfoy8xrejI7aKEQPkDO8xoAJfZ38tZ4I9UT0mtT5XeqFykcg==
X-Gm-Gg: ASbGncuakx0gHWbyuugqxFz9BWldVygSDfdx9Pd+nuhgdQ2ENxHM1jXyMMWb7JfL80H
	PXy1LDlwm/XyRmYMmJ4ioFaUsPaCJCT/24mVSmmaNDC5CRSePBMbfoqSQl1fEwIpWXbqr6NE8oH
	uX7Qs2+KAeFAjtaWmruHVHcNGMuzP0rApocuqfwo4UpNXNvaXgtiMwBeaAOKAXGjoIF3e2SLYO/
	SQQu4ykFO79nRMiH4+V/brw1U5cK/b5Upiv54z6XV+djdMtHytKSjv3M88zmPLmGz/Ei1oUyC6Z
	bCLIWCcAjits3N5uSbIMca45VsyVLGJz0Lq0hHJ0Fuyv9WCs
X-Google-Smtp-Source: AGHT+IGQxRrOihs5beELdvoOVX38HRb2136cNTduZLSSsPZwJtu5RxrcKh5Os+r1YzEkrCqDpPxjCw==
X-Received: by 2002:a05:6808:30aa:b0:3ea:f794:a5b with SMTP id 5614622812f47-3f19fc08ac4mr6705396b6e.1.1737696794267;
        Thu, 23 Jan 2025 21:33:14 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm270795b6e.37.2025.01.23.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:33:12 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.15.y 0/2] Backporting the patches to fix CVE-2024-35966
Date: Fri, 24 Jan 2025 05:33:04 +0000
Message-Id: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diff from v1:
Adding a dependant patch [PATCH 1/2].
Link of v1:
https://lore.kernel.org/stable/2025012010-manager-dreamlike-b5c1@gregkh/

Backporting 2 patches to fix CVE-2024-35966

Luiz Augusto von Dentz (2):
  Bluetooth: SCO: Fix not validating setsockopt user input
  Bluetooth: RFCOMM: Fix not validating setsockopt user input

 include/net/bluetooth/bluetooth.h |  9 +++++++++
 net/bluetooth/rfcomm/sock.c       | 14 +++++---------
 net/bluetooth/sco.c               | 19 ++++++++-----------
 3 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.39.4


