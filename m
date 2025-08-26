Return-Path: <stable+bounces-174731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB56B364A7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264A856224D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12205321457;
	Tue, 26 Aug 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ORip5vfG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51022B2DA;
	Tue, 26 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215167; cv=none; b=VTjPTIc9PljVj0XtYM//5imwMm8+Y7pAtCw9tFZqPWGkXBh9bWYDmy+tdLsSOgzhvhqRTy5HEWlz/BXHMlgXFZv9rlUHaBgANXtkbletR1AcRyOXhTFWVsrG3tH2DDTRvgSbdIxMwx3RF4//f3bF351rqpwX+/8QCyWXE3dLfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215167; c=relaxed/simple;
	bh=gnI+JicFiN8PDcxLumzGH0N6zsLJFjfwNjS/ywaMFfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHgC5sJSsN8b28xIJaxVwoCiaNaOuIU40Z0Nrm8kuKZywjtONFP8pObocRVD7zN8mKcLx8kq6q35zodHYkOtj1VtYwgpOTYR5X0aOwuXLmUOvV5eRGuF12s1NOQSar+hVWfDl2jBxYbUBqvjyBFwi68ZLyPhinfNGgDLDhnjw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ORip5vfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55985C113CF;
	Tue, 26 Aug 2025 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215167;
	bh=gnI+JicFiN8PDcxLumzGH0N6zsLJFjfwNjS/ywaMFfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORip5vfGNq69aifOIAJOL0tysNQ3zFJoqto8eI9jV5JGCnqVv3D58loxpTLaDqpmW
	 2UrXS7wCoDQiqCJeX2TKsIZS76VToEHGrgfwak7EroTMChwttRCxpNHIGjkzaoJ+Fs
	 qA/8gqKNrAYuF8LNtvLUZxa4g7/g891v6hPD+LHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 6.1 412/482] most: core: Drop device reference after usage in get_channel()
Date: Tue, 26 Aug 2025 13:11:05 +0200
Message-ID: <20250826110941.005953127@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

commit b47b493d6387ae437098112936f32be27f73516c upstream.

In get_channel(), the reference obtained by bus_find_device_by_name()
was dropped via put_device() before accessing the device's driver data
Move put_device() after usage to avoid potential issues.

Fixes: 2485055394be ("staging: most: core: drop device reference")
Cc: stable <stable@kernel.org>
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20250804082955.3621026-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/most/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -538,8 +538,8 @@ static struct most_channel *get_channel(
 	dev = bus_find_device_by_name(&mostbus, NULL, mdev);
 	if (!dev)
 		return NULL;
-	put_device(dev);
 	iface = dev_get_drvdata(dev);
+	put_device(dev);
 	list_for_each_entry_safe(c, tmp, &iface->p->channel_list, list) {
 		if (!strcmp(dev_name(&c->dev), mdev_ch))
 			return c;



