Return-Path: <stable+bounces-120122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA2A4C79C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6841884428
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F924C69D;
	Mon,  3 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfm+qY8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D324BD1A;
	Mon,  3 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019448; cv=none; b=m09j0iKYCYRa+2FJp122DH6+dkjD5bSlYHgwDgh9/fcm3hzE4XpgOrt0167wtHD8ubQ2M9ZQhJ70XGwrQwwgM0QXV1E2LdNHsii+8ykOHfMdKWIDDO5LtMlWVmIDoDKf0DXREVbzl4pwpS6T3ZF/vt/QykG1AUQSehaw/Sbqh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019448; c=relaxed/simple;
	bh=kWMnwqFbpjLz79Bq1d2W52AJjEPoXPjTiAxNA0FiBOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T38BanRQjfAsSa2lROVoTQbC141Rr1iwby/8hAYMb9zJo+9/oOfpyqxncyHcVSkPAXlVJK/l4lJ0xCwiQ0IzlzroRF8KiIq5aDXc2++SdMWq/JSE2AGcqVoX1836lwhLfIja9IWQK2FJxy47j6vX5O/V6D/W54guerADMqGRHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfm+qY8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B82EC4CEE4;
	Mon,  3 Mar 2025 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019447;
	bh=kWMnwqFbpjLz79Bq1d2W52AJjEPoXPjTiAxNA0FiBOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfm+qY8nOjfTA4MLQPqKFoPsXbd9/hKUlfFjwjtQYrQsql9BCNI0PE1uFR6gZF/eK
	 fANR4ip18GU7+qUOZW1xIuHGpoP5XnXRtlLIHz7/d8ILCZfTdr2nSoH8/zCjM/fpli
	 weI9dP/FOrXS2kQAZLmjbVB6yE3hcZ0AZWNyiSdKRBS89ctwDgV9xdlSJA8IUficUA
	 juDGlTBNF1rojbuSsCb/YiCy6EN0xybqDEziIIgpn8JeBb3uCzRzZamqOqZwbbcMlp
	 EqibypDVEzqFcfZVs1O8i+if1zdtBnvXesIriZqJt0IGs6wyxAD46H+dyglGn5WB04
	 BOdFF9xQVYKzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 08/17] drm/vkms: Round fixp2int conversion in lerp_u16
Date: Mon,  3 Mar 2025 11:30:20 -0500
Message-Id: <20250303163031.3763651-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit 8ec43c58d3be615a71548bc09148212013fb7e5f ]

fixp2int always rounds down, fixp2int_ceil rounds up. We need
the new fixp2int_round.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241220043410.416867-3-alex.hung@amd.com
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index e7441b227b3ce..3d6785d081f2c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -98,7 +98,7 @@ static u16 lerp_u16(u16 a, u16 b, s64 t)
 
 	s64 delta = drm_fixp_mul(b_fp - a_fp,  t);
 
-	return drm_fixp2int(a_fp + delta);
+	return drm_fixp2int_round(a_fp + delta);
 }
 
 static s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
-- 
2.39.5


