Return-Path: <stable+bounces-77211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E06985A4F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1413B21438
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01A1B4C33;
	Wed, 25 Sep 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUpxYReD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFC1B4C32;
	Wed, 25 Sep 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264533; cv=none; b=LmEwP5ma5IjC5qpbZS7yxcNec4OERyC/bdw7XNCsHdjgzCsbVsO2jAZxbuOHZUToNC6qQcJhL+qsQrtaxOpW7CnCLhtsie1tw2JNF3h/iYgHLObvfwckDeZbzf7Us5iKFybjeWMxwJyN0qpFA5OCu79RGHMGeCpw4qCqN2Art88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264533; c=relaxed/simple;
	bh=/xV6SQJLI67BxldE8hVKjgn+weS7sgiPngv/pOHfy4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7iysuNXdtmoyMTgh0J07a/KHdXfp1YjzuIv4aCYgBDOc0MPD6clnMp7vsEz7NxoWnmTR87lnakpa2x041If6L+zfAWmGpH7SVBklvcy8Hc2xJEpxKZRddJxBlcPs8rtB6hNF9aKiDlNBJwQhl3P3TEjbW5DK+0f2SrkdlMC9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUpxYReD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E7C4CECD;
	Wed, 25 Sep 2024 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264532;
	bh=/xV6SQJLI67BxldE8hVKjgn+weS7sgiPngv/pOHfy4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUpxYReDSTEVhSpGbXRP4eijNB+6e8JpHVXylZnOa0Y8SEv1UMw7Dm99JG2nyIBDY
	 2zw/eMueFex4dpRf6SpZBKnrNs/CZfhzqWais5KmCyIRjMhxn/biF43b76tnnkWBEn
	 qAmNChW85PYulQbvxE2svsZt6WjwLG7TgMMJGLANWdSiOkDpITwUSF+3+HOLMcBaVg
	 OsSGQxEDquIwRz3VFntbZYNkNcw0ktkDT5kpN0CA9mfO7J47sI4UT+sbUf5eW5YFr2
	 EI8fCsV8V4tDoZGDYmRWcYaExgINRNkE0wTUXy2hPaa3ohpYOm0z59mWwQlEQzVkfx
	 z3HLHbKA27MNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Denis Pauk <pauk.denis@gmail.com>,
	Attila <attila@fulop.one>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 113/244] hwmon: (nct6775) add G15CF to ASUS WMI monitoring list
Date: Wed, 25 Sep 2024 07:25:34 -0400
Message-ID: <20240925113641.1297102-113-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Denis Pauk <pauk.denis@gmail.com>

[ Upstream commit 1f432e4cf1dd3ecfec5ed80051b4611632a0fd51 ]

Boards G15CF has got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

Add the board to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Attila <attila@fulop.one>
Message-ID: <20240812152652.1303-1-pauk.denis@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 9aa4dcf4a6f33..096f1daa8f2bc 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1269,6 +1269,7 @@ static const char * const asus_msi_boards[] = {
 	"EX-B760M-V5 D4",
 	"EX-H510M-V3",
 	"EX-H610M-V3 D4",
+	"G15CF",
 	"PRIME A620M-A",
 	"PRIME B560-PLUS",
 	"PRIME B560-PLUS AC-HES",
-- 
2.43.0


