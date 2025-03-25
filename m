Return-Path: <stable+bounces-126616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FCFA70952
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFF43B2A00
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69961F63F5;
	Tue, 25 Mar 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdrn68Ud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C21F5850;
	Tue, 25 Mar 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928177; cv=none; b=dNaZRbg2nRHSMCW26wEPilCwSyaZndV/RNiCjg314RaZ21NkHdTFR+iuugCbfypOC5lvZUp622SGldo9SFlLRAx0NcYVXUWF4+Kim/eJfYHQPulnArOU05FX19lrOzf9c7BhD1hYFkIa45pmgbGxZNi9j9JCSVIOqjyq97JIMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928177; c=relaxed/simple;
	bh=l/WlSBPbgeikRatvuWUrCIvA8q+Wqd1bhbZrL6hGL7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njtC6FZ9xkUU7SjIwox5LtwgtUXlfRCEnkiNgUclOWwY7ZLaXWiSYflgy9o4Uf25Y9cRta5QbYM8ddwPHbo2UdquxGJtbWQhh23qzxgpeWgEVmnZwmNH7LaLsVrlUOhIW0uVuMoLNDSRi/ap2GN8o348AduF5jaAqZynPWI4dOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdrn68Ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B90DC4CEE4;
	Tue, 25 Mar 2025 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928177;
	bh=l/WlSBPbgeikRatvuWUrCIvA8q+Wqd1bhbZrL6hGL7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdrn68Ud0z7X4kjKppyOm28nPYFskG6FjvhL5JuuiakRlK//lC5YMX4ljHQlsqY/O
	 cAXR2yh8Inco47at405Q1/G1G4kEqwosnkNEKii6G4gwT+fzaCngM36FrXFXOG7jFc
	 jxQO7T+SAqS1FiThv6VB6JWD8JR/i+X/CRaqXNUl5fe98XuyhJ4l682BY4RdE9EFdT
	 aqeT4oVIDhfTl+StQAq3Jjdck5ShK6S1nKubVQLWNCeOZnQzyfUISHpX3LKzvrsgUQ
	 NT6pQpZm93yuP1K3TqU4z69SU6SpVjPbrOQLANtjFQ2nD9vFraLIPTZqEG3DvsBMUS
	 L6e4T8XjR24+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 3/3] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:42:48 -0400
Message-Id: <20250325184249.2152329-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184249.2152329-1-sashal@kernel.org>
References: <20250325184249.2152329-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.84
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
index 16f6b7ba2a5de..da4c3425d2d1d 100644
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


