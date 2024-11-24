Return-Path: <stable+bounces-94765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2809D6EEB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C3B224B5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91518FDAB;
	Sun, 24 Nov 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW1KzNsp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67D18DF6E;
	Sun, 24 Nov 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452321; cv=none; b=gTi96m4MGBXoNiJrOfC1fTxDgM5xxl5kE48P+YOc9+xW+GmeU/fj5UGAEDackLqIjSFCFRIiBXhTKfY7mGvTi4KjcaDLU7h33Nm0XkRY+EqEgNbqbkLMQ42egk/rIeQU5d5Z2wDMsbY++9pDYetphzXMp9YICTEByiiyea/1IbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452321; c=relaxed/simple;
	bh=U0/U2tEFLD6b79I/LulY4tgji590SiyhcKVcreMzKE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMkJNvnxb99Kqp1hOxE9BWac6bWEC96jWdfSOiRpw8GAAsnPHVUy1kA4uoKLQ+H9F+HNn2S17R8K676S4UsEqLqu3hk4Vz4LK6tQCeaatbo5E8zXMJfR8Piu2kdTytiVE6iMDKFTbkdOekMJ7uK+dVkwTI4CahC+CEGsvlUr2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW1KzNsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75983C4CED7;
	Sun, 24 Nov 2024 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452321;
	bh=U0/U2tEFLD6b79I/LulY4tgji590SiyhcKVcreMzKE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW1KzNspDMUVbykMitTpAoHIZy8ANl8wVRN+l85F1w9NEeQXbQXOKEK85bO5Ai+sx
	 FUe25J01ZiSsV1vmmHbdoODNdIhop1D7p6gpvtVAPEEFOcOzWi9xYieuuym+5kbCxr
	 fc++72N7HGXA+MEVFksDKibNSfQtbGi23due8/CnPpP63KWEfUAszFN5jsgAfMRywR
	 jylrTIMr/WvYIXdXmXH+V5t/m+0CwJwkt7Jpsm0f18yffESXHr4wFmjbE0xJeMJll3
	 QG75Z4qV25t9DJSG3+6CzIOD0zHbrH1Kt1WRQnLJCRW4cfyA9v85/qzGV/0hwRhvTQ
	 15Y0OJDeUZntg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sarah Maedel <sarah.maedel@hetzner-cloud.de>,
	Tommy Giesler <tommy.giesler@hetzner.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 3/6] hwmon: (nct6775) Add 665-ACE/600M-CL to ASUS WMI monitoring list
Date: Sun, 24 Nov 2024 07:45:08 -0500
Message-ID: <20241124124516.3337485-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124516.3337485-1-sashal@kernel.org>
References: <20241124124516.3337485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Sarah Maedel <sarah.maedel@hetzner-cloud.de>

[ Upstream commit ccae49e5cf6ebda1a7fa5d2ca99500987c7420c4 ]

Boards such as
* Pro WS 665-ACE
* Pro WS 600M-CL
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

Add affected boards to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Co-developed-by: Tommy Giesler <tommy.giesler@hetzner.com>
Signed-off-by: Tommy Giesler <tommy.giesler@hetzner.com>
Signed-off-by: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
Message-ID: <20241018074611.358619-1-sarah.maedel@hetzner-cloud.de>
[groeck: Change commit message to imperative mood]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 096f1daa8f2bc..1218a3b449a80 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1350,6 +1350,8 @@ static const char * const asus_msi_boards[] = {
 	"Pro H610M-CT D4",
 	"Pro H610T D4",
 	"Pro Q670M-C",
+	"Pro WS 600M-CL",
+	"Pro WS 665-ACE",
 	"Pro WS W680-ACE",
 	"Pro WS W680-ACE IPMI",
 	"Pro WS W790-ACE",
-- 
2.43.0


