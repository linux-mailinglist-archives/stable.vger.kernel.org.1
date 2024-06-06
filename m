Return-Path: <stable+bounces-48446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2B08FE90B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB21C24DEB
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54D1991BB;
	Thu,  6 Jun 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzDoBTfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5131991BE;
	Thu,  6 Jun 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682972; cv=none; b=BQY2eX10NrWcKLa1w4uc4vAV+PUeZ0eZOQkfC1Po6eNgw8MBOB5CffwR4fhPcysdAUETAg/sRhS+NtNTn8zadAUcupGKl89SFtb9bLbYswTCQwQdL/y04kBQXSSRi7Wuqo9UTe1HnwBWwMkidP25/4sH+rWWM0gCdmkI1RaKz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682972; c=relaxed/simple;
	bh=RYfZVtvOyQ9obyXNaLbAlX0sSVg/zdgo+kElGdorJHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYkN41ii6hOpx+2NpEGm2owSM0OEuWmfZJ9sY8lj39gsKMLEKMW6oBi3wua4Cx5eP5kHn4+pKwBAGiN8ow6c4C1hPIEs7ry4daonP5zFTB0psw2eL5gKKoyvREpExTgfk/aJjzmRjklAUqqzCdig7tsWWQCdTUvhEi+oILm/KvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzDoBTfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B483C2BD10;
	Thu,  6 Jun 2024 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682972;
	bh=RYfZVtvOyQ9obyXNaLbAlX0sSVg/zdgo+kElGdorJHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzDoBTfms3gySoIvdVb56BflhnT4PRD6xN0LjE4YtL2CQOmDpnUbypQfffPWPHsaL
	 Si6rwAhsCJn0R0QaftiGOzziPPGCB+sFzooRoR20HBTMbitoW1CNE/TNTvOCReZt+v
	 n4CCorrDXCJcRMs7zQyk3Fr3Ru6qnhOQAC3MiULs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 147/374] Input: ioc3kbd - add device table
Date: Thu,  6 Jun 2024 16:02:06 +0200
Message-ID: <20240606131656.845362119@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karel Balej <balejk@matfyz.cz>

[ Upstream commit d40e9edcf3eb925c259df9f9dd7319a4fcbc675b ]

Without the device table the driver will not auto-load when compiled as
a module.

Fixes: 273db8f03509 ("Input: add IOC3 serio driver")
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240313115832.8052-1-balejk@matfyz.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/ioc3kbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
index 50552dc7b4f5e..676b0bda3d720 100644
--- a/drivers/input/serio/ioc3kbd.c
+++ b/drivers/input/serio/ioc3kbd.c
@@ -200,9 +200,16 @@ static void ioc3kbd_remove(struct platform_device *pdev)
 	serio_unregister_port(d->aux);
 }
 
+static const struct platform_device_id ioc3kbd_id_table[] = {
+	{ "ioc3-kbd", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ioc3kbd_id_table);
+
 static struct platform_driver ioc3kbd_driver = {
 	.probe          = ioc3kbd_probe,
 	.remove_new     = ioc3kbd_remove,
+	.id_table	= ioc3kbd_id_table,
 	.driver = {
 		.name = "ioc3-kbd",
 	},
-- 
2.43.0




