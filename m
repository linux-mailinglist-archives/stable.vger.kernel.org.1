Return-Path: <stable+bounces-96150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F119E0B2A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1410A161435
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9561DDC26;
	Mon,  2 Dec 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GRFvEwKo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED61DACA1
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164640; cv=none; b=MhBmmzGrtKkvmJ42gg2JhCeYZA0TyYu7dVhmMB6Kn2JMwk169LRB86Y1XPy/FECsxTOwLJmcRZUEVPY34rnN5YLAd4xdcm5h73EeMh7psy1FUGCjypQbLW/6+lWkjZV3ic4yw/nrqiEUw7CmFY3QY4dSB+AInYsayw6Ty8zqpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164640; c=relaxed/simple;
	bh=GySl7FH6k87Q3/FtrzBlUZC5QkSjJLlXFooz+T2dIAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4Gtu4+Br/1vRCUZCi3TfHAq8GF+uZvBQRMjxXg9S8JZo5Z1XbPEN5MLH/wZF1LUl0efWQ9hYmFrPIB9/opz7sgAaYn6bRPIBZuFiFA/jvegWdcjwvvK5stoDjvyRZ2STkU41q0YtGsQnHHvwfOROozed0MauiOE4+1E+mxgjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GRFvEwKo; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-21271dc4084so35648995ad.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733164637; x=1733769437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gamT5R0QZH8leUSxmRBzCBBfWx5ZsvLWbSvscKjg3BQ=;
        b=GRFvEwKo8P+z3RIniZZGU8ZS5QhAlh47NQF1niYUPq5a0K8TZhdGqrgyDiHUFMKhSV
         NlKyBdkhATL7+Ov1TTYLblyS8tGnxx9L06Zk2Llod7pZHC+9YMn7lX8oDx2+V73/QfFG
         qEN83AUjYEUBeg4Fjq6L3/KztU+WaKYHUj29Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164637; x=1733769437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gamT5R0QZH8leUSxmRBzCBBfWx5ZsvLWbSvscKjg3BQ=;
        b=ID6U2TC0q3T5moJn4N6z6e5qwd/YiObXNUWDph0m7Mt6dN1/mp0exLxkQgDEx4Wf71
         AjikhpDJx1tM45uKz5DR3+eOfYxyxt0o7l+BnzbWvbsYz9pifgEJ9xZc1PVug3dRaCV8
         Z+Zs1uGbjMLdKmEpk0St8FAuAHWHkX+C0iodRuhgf86poA3X75cnCo/BxNiVlg5XFQMz
         PFFzPCFxm9yFGUJcPhikvRDVoQ845WbzMUBvVhhCW8CHAcMeUTZzCI5MoR7fGV0uOM/o
         IjFFWpHUqxDYjyzVQfoX5vItAlYUj5xLl/lAd+ipLkKdICEILiNQguW0DsWAurwtHdIl
         AL7w==
X-Gm-Message-State: AOJu0Yx8HNDnBydyGR6nVCXYgt94DMfKnIpSXlMcAmX2LnTHu2dvmUh8
	lWun89WLqeEl5ah3fzJ8MEz777gpq9wBu9sR/I1SPAk76DoXahVedp4hg4O/MkVObmIDw5P3sX5
	7mA0yMqPy6+diL6PJSMKcQHADoz7sOgHOPjeNU4vwmu+Nt/J8AnL9oFk/Mug4hCVL7GbKeFyHGR
	kZAgyAgB7f5nALdAm4c1a9PieQw6gYXi+b3XDNrwnS3FZ/nynfMNVkHfw=
X-Gm-Gg: ASbGncuNx1YjpGyuMCFgKJwCzZRnmeEtaMvMMjWHurzBmlHpPfyflwRxJX8Uk1i/h2b
	tD0+CJgBJm/wgykyH+55B3KrR55NWSp3xwKoexB60iZ1ShqPlSPouOPQ6NkWFU1v4dgBc/KdpVJ
	aSeMwoaZCa151U31s55N3ANjtVXEucRXv5DA1uEvFYgfkSQLsNGtu++PZNG2dKI+0KJI8JicdSv
	cXHW1NJMO3GIik7Y8YHUeZPyxxC0Och4f/1ZB1E9u9HXEHyKpb8CWcNbLTzTL9lIIBFPd5OoCRi
	nWbf4TunWlrWuz1ftCDFyo7c
X-Google-Smtp-Source: AGHT+IGLkT6ebiwedqvqD1f42rQOK97GOKfKbbqS3UgkMvqu804h8LS9uj6tSTOvjSkk69IcJWBMig==
X-Received: by 2002:a17:902:ec8a:b0:215:a05d:fb05 with SMTP id d9443c01a7336-215a05dff24mr58869175ad.32.1733164636589;
        Mon, 02 Dec 2024 10:37:16 -0800 (PST)
Received: from photon-bc6f59b69a50.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154c2e1f62sm56463395ad.101.2024.12.02.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:37:16 -0800 (PST)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: quic_zijuhu@quicinc.com,
	rafael@kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Subject: [PATCH v5.10-v6.1] driver core: bus: Fix double free in driver API bus_register()
Date: Mon,  2 Dec 2024 18:33:30 +0000
Message-Id: <20241202183330.3741233-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit bfa54a793ba77ef696755b66f3ac4ed00c7d1248 ]

For bus_register(), any error which happens after kset_register() will
cause that @priv are freed twice, fixed by setting @priv with NULL after
the first free.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240727-bus_register_fix-v1-1-fed8dd0dba7a@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Brennan : Backport requires bus->p = NULL instead of priv = NULL ]
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
---
 drivers/base/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 339a9edcde5f..941532ddfdc6 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -853,6 +853,8 @@ int bus_register(struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&bus->p->subsys);
+	/* Above kset_unregister() will kfree @bus->p */
+	bus->p = NULL;
 out:
 	kfree(bus->p);
 	bus->p = NULL;
--
2.39.4


