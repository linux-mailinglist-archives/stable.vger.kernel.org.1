Return-Path: <stable+bounces-220666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLXyDVg+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D99651C6B54
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 011083135DC2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141F48BD51;
	Sat, 28 Feb 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceIKT+f0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238893F3254;
	Sat, 28 Feb 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300548; cv=none; b=KxxPklSMcXXJVrMd5d/TzzjRfPi1Ri15LhOarVY7yJJGq2gguqUiwqsnoIUySzSUthw0UQLq5kN1HuCjtpCcWmOlpWxOQ71H8LDZX8Sn0dPHcbc6aOQW+D59x6v7iearCW0rrL8Lz6f+9uO+9xQVW7bpFNyT+IfSkA+3kPxvfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300548; c=relaxed/simple;
	bh=b6WhtVEP2p+gcJPlwCLcllZp1eYEWxVNgELP2T2BLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXR1wj6GpJxwm4F3UHALhvXHFdW6NnTJe2+y+ZSfCgKzwjGEX53UkpIwlz/EcvXDHa3Y/XRvJxBj50PzQrOP+XhkfHgzi9RQfXBatZDNtjtDVYShsb//tqdQf2DMCuKMCWAn0fZK1iSTU7AND39kQ8lOt8bQpIjAZZ6jtNpzig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceIKT+f0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB49C116D0;
	Sat, 28 Feb 2026 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300548;
	bh=b6WhtVEP2p+gcJPlwCLcllZp1eYEWxVNgELP2T2BLQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceIKT+f07I0QBPrr7OnFB+c9pydBw3DqDhwTj3cz61rDOUlhXjhxxB3hC+9N5lrd4
	 Rz9XEOpZ3rFPMfkG83v6LF3ZYCH1jEjYor/bNbcjxYCHjXKzK4acvSOGytq89pnxRk
	 l7dbT8NEhk4MUisAuy/Tq1ogbwjOm5dhBMWgk7FyoTCmYLZhRuKjFzxsanBIMG4qGm
	 LixF7nPOv68xkOajxfifObb5zMybQv4FX3BlrglGWZLZ1Vpjvf7wQ2YAtzl1DeeZxK
	 kmtkOlumiOGqDHIOUD+dqUO457mn1A/pDF5uHlFGfTt2xphfx9IIdRrhSG2byXB6RL
	 FKcMFKLlHyh/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Plowman <david.plowman@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 587/844] media: i2c: ov5647: Sensor should report RAW color space
Date: Sat, 28 Feb 2026 12:28:20 -0500
Message-ID: <20260228173244.1509663-588-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220666-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,raspberrypi.com:email,ideasonboard.com:email]
X-Rspamd-Queue-Id: D99651C6B54
X-Rspamd-Action: no action

From: David Plowman <david.plowman@raspberrypi.com>

[ Upstream commit f007586b1e89dcea40168415d0422cb7a0fc31b1 ]

As this sensor captures RAW bayer frames, the colorspace should be
V4L2_COLORSPACE_RAW instead of SRGB.

Fixes: a8df5af695a1 ("media: ov5647: Add SGGBR10_1X10 modes")
Cc: stable@vger.kernel.org
Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 191954497e3db..c0f1121b025e5 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -508,7 +508,7 @@ static const struct ov5647_mode ov5647_modes[] = {
 	{
 		.format = {
 			.code		= MEDIA_BUS_FMT_SBGGR10_1X10,
-			.colorspace	= V4L2_COLORSPACE_SRGB,
+			.colorspace	= V4L2_COLORSPACE_RAW,
 			.field		= V4L2_FIELD_NONE,
 			.width		= 2592,
 			.height		= 1944
@@ -529,7 +529,7 @@ static const struct ov5647_mode ov5647_modes[] = {
 	{
 		.format = {
 			.code		= MEDIA_BUS_FMT_SBGGR10_1X10,
-			.colorspace	= V4L2_COLORSPACE_SRGB,
+			.colorspace	= V4L2_COLORSPACE_RAW,
 			.field		= V4L2_FIELD_NONE,
 			.width		= 1920,
 			.height		= 1080
@@ -550,7 +550,7 @@ static const struct ov5647_mode ov5647_modes[] = {
 	{
 		.format = {
 			.code		= MEDIA_BUS_FMT_SBGGR10_1X10,
-			.colorspace	= V4L2_COLORSPACE_SRGB,
+			.colorspace	= V4L2_COLORSPACE_RAW,
 			.field		= V4L2_FIELD_NONE,
 			.width		= 1296,
 			.height		= 972
@@ -571,7 +571,7 @@ static const struct ov5647_mode ov5647_modes[] = {
 	{
 		.format = {
 			.code		= MEDIA_BUS_FMT_SBGGR10_1X10,
-			.colorspace	= V4L2_COLORSPACE_SRGB,
+			.colorspace	= V4L2_COLORSPACE_RAW,
 			.field		= V4L2_FIELD_NONE,
 			.width		= 640,
 			.height		= 480
-- 
2.51.0


