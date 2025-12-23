Return-Path: <stable+bounces-203269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51759CD8405
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 527983016EFC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B982C11C4;
	Tue, 23 Dec 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="NsQLe06q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FC1A275
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471429; cv=none; b=GXx0oFma5/vkHHhxr9ACKVUUTY1EeyC3t2aKdXy/e3TIwAafcxLQ/q4FSuHhzWHrLyC4fSvfQTnB5+Knt58AY1xbLb3XNUWfk25jaFME3C0lo8RgZ3XktQkj7HdMw3JeZc1IzyKMlHjMmzX/w93qdr1uosopty5lVn9MY+V5i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471429; c=relaxed/simple;
	bh=UOwytaD1y1ivrxR36EtXG7k6vUSMWBbdELoZYS/80io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdHu7qpPQvcOUcp/qrAQW5CL0cfXbCLuJQ77PHdtaUsp3bJUKiHDXhnzoq9duysBtE9U24SfsHLWJ11FLE1yoL7jhNswB4VovmjyM81i2REGtE+cqI/vdzGkdC8E9k/Ltuzmtj58u17OIFDNOUGiQOywWH7eS3i2GeCR3enmctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=NsQLe06q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0c20ee83dso59136175ad.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 22:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1766471426; x=1767076226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txAko9zSpGY/XVp6x32IGp3T6LuAmbYnWNpv6bzw+e0=;
        b=NsQLe06quPlxn1aj3i75rRZHkx2ViwWIeW0sdVpN03nK1qKQz9h89lmExZNqnEae9H
         uGrc30SOhPThzEhMdG6GuOY189xRy+K4Va1K8HRTfe7JXPzGuZxYsx8D6S6ZC9wzEMzK
         oG/HN2iEFjKu+/GmMS0V+e2g+vpzIBoUEz+H0cDzakdh4wWAiEjrrbNNop3DoRbn3qux
         WrBvswHWG+lQVkDZphdqfd3AktBMuwRi3vJdje6Zv9Y+nP8Pt9wdvRjdqYt05m6Y+cHl
         T56Y1QN5KO2ZPkhxQXo+I0/XTSg6cEiZKf7lEfDiMBuOKc1BI4z38qgVvrfOpGTUt8dc
         lBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766471426; x=1767076226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txAko9zSpGY/XVp6x32IGp3T6LuAmbYnWNpv6bzw+e0=;
        b=QPSmk1Hq1TWLFrS7EgaA7u0+CWpnUFYkvTo4dTQ29Ak7Muz4q/QqcdaC8zp6mxzwjN
         7AXiOz23ic5WL3ub4aWw6ZnaZyk/vnbpudxbADVnOkZ0irkUrE5PQFYhU4K21oxSdz1b
         W+gifnXgubnvYMzXHataHtGMFmVLCMfnWhA9/ObB1dayaVl8FeMSdmg+rzGk1LtobE3G
         Spv7BjjMP10NhKMIo7M47WnwXoj17sh+xF+NJP9idcM+Ae3gZyXsiDfeL7Jgh+WD8YJR
         VTka3Is89lVhqyUS+im156pxfwHRVWqeptAvGRmKcDDLdpBv8gwfeUXHIWZVklWkFBfd
         Pw9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2wrHbRw4o6Ox3RIYmhZMAZ8Pvv8AjUOLkaHX6jrx7LjgfjaIbUTYUdUS7bXq3g1t6K9FJcGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7yx+dPw06kIpD5nG/rbt3iIGXV6Nbe9tCT1oE4FUgtm5+hYB
	QP+6GNKcvq0IvugNp/+nhtcbfesYozFdeevO/C/zA6M31JvMxANkBpbdoNxTTk5hDUM=
X-Gm-Gg: AY/fxX5ohjmuVnGkoZ6oK8/CheDLs8sn3SSf6jZzhNO1PmoL68MpAd4wcEDig+Lkp+A
	DNSbPn/zbVap8aDJ+qe7Itr1F+cewQSWCJXXZYntnEuqm27b7sd1l5wih/4h5kUDGU975N2Zg8R
	EKawUxsFJrGLzDcCBMo3mxPVyi61uvHAXaHt7g5cG6GGSXkD1ERhLbplgdeStRn/lV9OP7XTH4I
	BLhOBY3wdWdM5XJHqGWVbtCNn/Cb5w/AQ9ePzg0/OYoP4JPXRdUjbXeSA7mbf0Z8Wp2whEKfKDA
	TOs2Hb9LANJ1SnCDn0bHP4UCVgIL/q/fg47KHgkha0X+3Ptdkm3o9vaWMIfTZhasOPbcqc3EzNB
	W4dud+iVToyW+d0duut5c8ZCsWln71HxYEJc+mBknLZBJhfTWs5dGA1GyxaMBI1oh9B5b88Md/j
	rGQE6HAjuKJDHu9sKj3yMOGRUv
X-Google-Smtp-Source: AGHT+IGgb03I6lSiPUZBtWVnd1QchQMvNYrRHjdG4XZUhFVdzG/yKL5vDYSme6j4qe45ab0hfvjdeQ==
X-Received: by 2002:a17:903:2a8e:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2a2f2426c79mr137786605ad.14.1766471426463;
        Mon, 22 Dec 2025 22:30:26 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a2f3d5d32dsm116266405ad.70.2025.12.22.22.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:30:26 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: jgross@suse.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xen/scsiback: fix potential memory leak in scsiback_remove()
Date: Tue, 23 Dec 2025 12:00:11 +0530
Message-ID: <20251223063012.119035-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocated for struct vscsiblk_info in scsiback_probe() is not
freed in scsiback_remove() leading to potential memory leaks on remove,
as well as in the scsiback_probe() error paths. Fix that by freeing it
in scsiback_remove().

Cc: stable@vger.kernel.org
Fixes: d9d660f6e562 ("xen-scsiback: Add Xen PV SCSI backend driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/xen/xen-scsiback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 0c51edfd13dc..7d5117e5efe0 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1262,6 +1262,7 @@ static void scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
+	kfree(info);
 }
 
 static int scsiback_probe(struct xenbus_device *dev,
-- 
2.43.0


