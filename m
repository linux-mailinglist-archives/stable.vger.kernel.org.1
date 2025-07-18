Return-Path: <stable+bounces-163376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B378B0A5E2
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DB8A818D8
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F82248A5;
	Fri, 18 Jul 2025 14:10:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0D14F9D6
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847846; cv=none; b=MMSTwFUCtls6klT/LfJLKSg01zPDjbNqbtjdhNQaQX+Cby2Ujz0rWJJDxfrGxt5+WZzp2Idq4+J3FyK+N1tjRk+lc6WIjaWeiYmaClLbYpm8eRvRZqtjY47Do3zKyWb3gSAooshVApts2hLo3009YcV2mLXZXupMpqQi8xIWh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847846; c=relaxed/simple;
	bh=+48ZuLnQQDfcff+3Q1WG9rWaO/RgR+3yDvssbMs14/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W+F7mVQ/WVThdmFup/DLj7QgSfwWmWY98lWIgIsQXhzwtXnEosFKd/zjFCK61y+XAn0C3MeBVFZ4gssKezk4G5T1WQtDgA2qrXBbDmk7NZV7ul+EiN6JMUrukwLoEgr/XKnYND/hz7lF/OOm4jmeZQAl4d6n1dpy+4r2L1UZ9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c823aba3;
	Fri, 18 Jul 2025 22:10:34 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 6.6.y 0/2] regulator: pwm-regulator: fix boot hang issue
Date: Fri, 18 Jul 2025 22:10:14 +0800
Message-Id: <20250718141016.312952-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a981ddf5ed703a2kunmb1387368da79
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0kfVhofGRkYSx0ZHU9OGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

This series backports the merged series:
https://lore.kernel.org/all/20240113224628.377993-1-martin.blumenstingl@googlemail.com/

The first patch has been backported. Backport the remaining two patches
to fix boot hang issues on some Rockchip devices using pwm-regulator.

Martin Blumenstingl (2):
  regulator: pwm-regulator: Calculate the output voltage for disabled
    PWMs
  regulator: pwm-regulator: Manage boot-on with disabled PWM channels

 drivers/regulator/pwm-regulator.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.25.1


