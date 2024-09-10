Return-Path: <stable+bounces-74107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAE972705
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D8B1F24B8D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56644142904;
	Tue, 10 Sep 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs19t8ta"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF71DFD1;
	Tue, 10 Sep 2024 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934210; cv=none; b=pGQTi/4v3ZjQTKSTGGS8YQTj2xfaVJ/UYZTUiN69lYETddyQ/7cYsgIu2mEqVQ4kmcQJUnDevGJA4A9CI+WswLw/7tqhxCtHtf+RJa3loLbczDLUFDdgYP2NQOzO9EOVt/NmpqB5Reyh6nKT7f29fMnqiZFsaDTWuAPUyXIMD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934210; c=relaxed/simple;
	bh=2RuHSTo8UTZTwr+IP/0p9+lQ/zEI0R5deN5YL9deaWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsJq9+3llLZr3+xah6OHP3tO2psLUPcTKtkuV7jNP7ld9hE0weSRB1qznxGv6cIUdy8b2E/qTgiabdm+1LuFhXJ2XJWcNSl66On9n9BI7kfbWHT+0bcQcaH0pu3SQ91K28cFq37dB5bCjZFROCkUkCpPDkmEjL7xlvriqanywJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs19t8ta; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45765a0811aso30235861cf.2;
        Mon, 09 Sep 2024 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725934207; x=1726539007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUxVq/uYkeEKFMBzDLEyObgx5MyTJN7izveNlmy8shU=;
        b=hs19t8tatA8RfXiUfFwhACZX4E6lqJYfmvopOCllCRAaxysYKHLF/CTbocDSJZ7XUy
         MDU/e6/M2aSA0FK5W12QS3rHytqLwq2C8yY1fTjae+10oC2kxY5kyncr5ueqmk4BNZJf
         i+ZxpJkOIZ7UdLyZWczF5zBW5euuCDmT6diFMlRHlHYNEyOqgVG44HgqYuuPc5bBERL1
         e2LTw8MqHhJGlCeLhEiAsb2mqKbmd5IAKKR3YC+B+1cnw39uDpQfVFuGgIdUUcWeQ7Gk
         1+MGWlTIi8g/1iQDOeYs9jDMOAHdQsBPzos9wn7DiEjZTPrLYxI0qLbxGpWVPDsxa/Nv
         TT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725934207; x=1726539007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUxVq/uYkeEKFMBzDLEyObgx5MyTJN7izveNlmy8shU=;
        b=nzFQg6StECWFQk8a3846vZLpz7LpYmqT4fc0vgKGyinMBNqEz24eLre/gRPbqK3O5G
         xuYi4pKvGGvBup5OLkVjqlzTJDYGWCApJCSatxnsyldo2wRt95RmDtw+uJX2Hxn+btVB
         7I9EErAZT1/J985PgHZ+vDVCF4lzL7W4iuBd6fQpNDdwdz2c8KeuPiYVT4JX5u7qL4gA
         iKqY6av4g90zMeyoKax+TOc+7T0VYtbm+j/U7+ZJdmt7KEKgtqUa8/IITcqTydG2anC3
         F+z+Ozeg9jiRh7fb/iENIdXPDkieNHnmapAbJ6Xk4A57GeRCOss/OlR3gHuI0Nr+7lDs
         Z1QA==
X-Forwarded-Encrypted: i=1; AJvYcCUVTHiAcMpmM8rG1V/+nqoiVnqZWx7yhdTOIH1rA0l7LDX/Vkkz2wlJsVpLC4I2FnJwf2tZ4K63@vger.kernel.org, AJvYcCV8w0gJDurTU+ML2umBDg/nGQHAQWmVaXIPH889t49nob/d0U3zXfKHMZMbmHvogWByKEXSHlXXOY+9G0B9@vger.kernel.org, AJvYcCWNktQ+phAOFGeIVCl54Y9JV0jEXWjs8/tAzEmUqJcu9+BslKUE0qjX/cYA/QzAfp3kxfsJzROZkd0akQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoemLbOZrnGj5fKPl/VqwUv+paNa5kn1Ep1pniEqQwU1QGYLI+
	zXMg9kv1TXyBhMCCw74VxjCC/JJYtMagiOd9d7KnMieMOeB5a1Mk
X-Google-Smtp-Source: AGHT+IGmeDSS1xPUmyjEW8yUJFMAPO/V2CCsh6Yw95JK0OmbyicAdVkM/O8FfObtrVcamHw/ybV/0Q==
X-Received: by 2002:a05:622a:144c:b0:457:c776:e350 with SMTP id d75a77b69052e-4580c75a11dmr124180981cf.46.1725934207271;
        Mon, 09 Sep 2024 19:10:07 -0700 (PDT)
Received: from shine.lan (216-15-0-36.s8994.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [216.15.0.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f6097fsm25377241cf.63.2024.09.09.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:10:06 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>,
	Arthur Borsboom <arthurborsboom@gmail.com>,
	stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
Date: Mon,  9 Sep 2024 22:09:16 -0400
Message-ID: <20240910020919.5757-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

Probing xen-fbfront faults in video_is_primary_device().  The passed-in
struct device is NULL since xen-fbfront doesn't assign it and the
memory is kzalloc()-ed.  Assign fb_info->device to avoid this.

This was exposed by the conversion of fb_is_primary_device() to
video_is_primary_device() which dropped a NULL check for struct device.

Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
CC: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
The other option would be to re-instate the NULL check in
video_is_primary_device()
---
 drivers/video/fbdev/xen-fbfront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 66d4628a96ae..c90f48ebb15e 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -407,6 +407,7 @@ static int xenfb_probe(struct xenbus_device *dev,
 	/* complete the abuse: */
 	fb_info->pseudo_palette = fb_info->par;
 	fb_info->par = info;
+	fb_info->device = &dev->dev;
 
 	fb_info->screen_buffer = info->fb;
 
-- 
2.43.0


