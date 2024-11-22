Return-Path: <stable+bounces-94631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64DB9D6466
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62141160E50
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC61DE4E4;
	Fri, 22 Nov 2024 19:07:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AD249E5
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302450; cv=none; b=OjAtUJnRfWbf+In/bdgG9hB1VNNFkFsWoKkNzy4mMZlxMJDQ/i3vFoTlPjDqoNVdfWvRmVA87ZVrAypr5W3Mf4i2y8oWDsO3hICKgH9rpHX+FIapI6z8jLgFIYAvF9A4z3oIKxBgiN9eBRIaJoL7a4hWMGFTw5veljToGNJURaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302450; c=relaxed/simple;
	bh=edDutg54hQaRUddLob3swdTqVFFl6O6F9VXR+LtXj/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UoP+9DfHrtkJe6aLYUcH0V5zb+3EXEbdFgWqX69LouAE8soVpUZY8WlFLAL8NrbAPu4Gsew7nz57D7J1G4AP/DGD5ewBinoC834BLVfhwybDqv1+snNarp785fph45wyPXgaDY1xlcleMGX7J269pfsCCqIMbaJBTw/3j7qDPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 918C1233A2;
	Fri, 22 Nov 2024 22:07:18 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] scsi: core: Backport fixes for CVE-2021-47182  
Date: Fri, 22 Nov 2024 22:07:01 +0300
Message-Id: <20241122190702.230010-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch titled "scsi: core: Fix scsi_mode_sense() buffer length handling"
addresses CVE-2021-47182, fixing the following issues in `scsi_mode_sense()`
buffer length handling:  

1. Incorrect handling of the allocation length field in the MODE SENSE(10)
   command, causing truncation of buffer lengths larger than 255 bytes.  

2. Memory corruption when handling small buffer lengths due to lack of proper
   validation.  

Original patch submission:  
https://lore.kernel.org/all/20210820070255.682775-2-damien.lemoal@wdc.com/  

CVE announcement in linux-cve-announce:  
https://lore.kernel.org/linux-cve-announce/2024041032-CVE-2021-47182-377e@gregkh/  
Fixed versions:  
- Fixed in 5.15.5 with commit e15de347faf4  
- Fixed in 5.16 with commit 17b49bcbf835  

Official CVE entry:  
https://cve.org/CVERecord/?id=CVE-2021-47182

[PATCH 5.10.y] scsi: core: Fix scsi_mode_sense() buffer length handling


