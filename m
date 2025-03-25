Return-Path: <stable+bounces-126605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C1A70932
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9BF1892C0E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1791E633C;
	Tue, 25 Mar 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+RoZ4gw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953C1E2838;
	Tue, 25 Mar 2025 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928146; cv=none; b=etn3di4c7wKc4IJJMHdVjTWt2KjoZ0xJFTtG8hCSHB6ZxUtjbOJXfCfasKC1eVh28p2A6yBbeEMhYW/auPY1ofQC7Z8Koe1+n26OIFi8R2DNBQRoY30sgNko8tDwRkPq0dOjzTpi/MHIn05BNLouPdokoZVIhpU9z+WPFRcGcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928146; c=relaxed/simple;
	bh=b0ElTFIwXwNHL7nzondQmJSf/3QVUkxQFYvSen+AJuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHdbJlBjstPxuk3CysCQL8nGBOayTi9BYwCjEvpViB6zDAqTH+gIXDmVdEJkm/gDS75KX4J8c9FHn5LW8nRS0jyqriOGG/bU2n1KezAVKKUo4jfKVw0n723/8HlnR9WogEyJzroBCh1IR9AmA3PmaDC7ZqGz9vcn6s/IG2EIZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+RoZ4gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E4C4CEE8;
	Tue, 25 Mar 2025 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928146;
	bh=b0ElTFIwXwNHL7nzondQmJSf/3QVUkxQFYvSen+AJuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+RoZ4gwzM+hs4BhA4c0uK8/Fca4sucW0GHmNTbbtwdhNSHqXaiYyzNBnpEdRA7qm
	 lKijRNUrKd+NWzpEz7PO3CEMWZpylNufpZnzIkjY/D+NkPBrleaLBbLlbKsiUj6ii8
	 aHhxYv/hzQnu4Fed8poUyL0+TNJn6FFRhfVL6oWT3tg5OCjg/KcTKMGrrLRPrfkJXJ
	 qB53KRmg0gR1SGaM/n1mpw/IzPXJv1wY7ipPDAJ4a0oII7eds9RWM0flkj35Pj/QIF
	 S2AuG+jV8024s9gJ4PrwmjtCM0Xe+xabDHg9vCclDmgvSIr3fCyHL64h/HKqdmMdw5
	 WE7EHVCnUDSqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 4/7] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:42:12 -0400
Message-Id: <20250325184215.2152123-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184215.2152123-1-sashal@kernel.org>
References: <20250325184215.2152123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.8
Content-Transfer-Encoding: 8bit

From: Tasos Sahanidis <tasos@tasossah.com>

[ Upstream commit 815f80ad20b63830949a77c816e35395d5d55144 ]

pwm_num is set to 7 for these chips, but NCT6776_REG_PWM_MODE and
NCT6776_PWM_MODE_MASK only contain 6 values.

Fix this by adding another 0 to the end of each array.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Link: https://lore.kernel.org/r/20250312030832.106475-1-tasos@tasossah.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index fa3351351825b..79bc67ffb9986 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -273,8 +273,8 @@ static const s8 NCT6776_BEEP_BITS[NUM_BEEP_BITS] = {
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c, 0xb0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
-- 
2.39.5


