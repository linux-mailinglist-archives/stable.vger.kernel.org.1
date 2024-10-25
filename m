Return-Path: <stable+bounces-88156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD09B046A
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CC128407D
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798D1E52D;
	Fri, 25 Oct 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm5zNzoO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76C2F3B
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863968; cv=none; b=f6R3R8JCM/1gi/uODCqaqR81z7OaFTFcS8679SsamHioewiJXBEFcdYGXV2FcjESEDNDcdAUhY3emVFGFVEolud0G8i8lWUw7j7CDZpaqN2bTP3xm9GWSkrgD4T8U0GvqFLSJDnDV4Powu8sqhqVIqCTZtVi/Ztx/mCPOQN3wsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863968; c=relaxed/simple;
	bh=/5F1S1qZ2Lb/CpHWfdbbPEt0hCpGHjdkqz6yfOhd5OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8vpORSUd4XBVM8SSAcb2/CTXrvjp33Bu6p/pxef27lpjzgADugdzzxu2VOsjN2NQ33wDfwiW+450DQkT7Hx26dpXTyDZ8Ut0cYqcrRF7jHNElJGjcrmozIKiEGwTLkRT1hql/W9ClGIt4jaZCdZV3AttdLhOuRZ+4DaRsGofcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm5zNzoO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so20012365e9.3
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729863964; x=1730468764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JILYNotk0SoSZC9ibNIc280JVlCgGuDr0hgCGJ8jNg4=;
        b=Gm5zNzoOUIZwpWdm0nDwpo0a0ki/KEC4HGKrSbhCK5XKn2p3c0i+ZxvBdRh/78uMum
         f5VmTyw5TOlMg6qaiHv/RGHlmPQzEUYAwZWRwqyhilx8Vk0CToVX3iDT38w5mv7kLkmG
         d9qYPBuIxHr5f8h843CNZDVo8lsdAwp4FKomx/sBtsQOMx8ujXPy06slpLxth3XrNPe2
         m80F66ul/B7qlj/A7wx3Nc03pBTGxfirZBa/18VUQ5fPaeTpuzpy7HPQ+Rxgcg216F2q
         YlnPJojqA9mycM3Rnt8YZ3WPTmTPd+8616WvmZsX+EWK1C94XZv7CD+Qta+TIkShxM65
         GPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729863964; x=1730468764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JILYNotk0SoSZC9ibNIc280JVlCgGuDr0hgCGJ8jNg4=;
        b=fby5c6cVET64CVbgaOBsRgIYLQA698zglwCXkEO/HKLzRFnZ3HGLFXSkIfb0VxA4Op
         K0XVHsY8mIXWHAxitOeBRuX6FKd9WniOvmkEQf6j9gdtDaLs4I0M6uJ5tK/NmiMHvej5
         43bndeet5SCnxPckPHZVtFUwZewWedXOHRNgt/LYa8FPkogasHCjOj8WCIgAIUh8JSUA
         6jmrXRAsCsgrEKaV5OZYD1oC9BnatP9WNBhYEEulZtzD/S75kyWvMBEdvfDqhzFv1Cgz
         AMjFB+GK9eC6pjplwjdULxKWAkwlnd+tafMbS5H8ICYVIIQs4XSD4YoYREm7XHVhkkva
         JKdQ==
X-Gm-Message-State: AOJu0YxWpVs09bpWdqriK8MlYxHGShEYMyubZaIV3UeeYUFJvS4hjO21
	yUv2CXini3cQiQ9KXNjw25LT62kgRruwufnrWWjsRVxTgJxPdLzgZHe5Hk7OM2PaMw==
X-Google-Smtp-Source: AGHT+IGJSsAIZEnnaMb0SjpsZ2Zm8hgxCzg8PnHjK+P9qzvcs2WEFyOElexdDabcXL3WGWPQ7WIc9w==
X-Received: by 2002:a05:6000:2:b0:378:89be:1825 with SMTP id ffacd0b85a97d-37efcf9297cmr5888469f8f.49.1729863963601;
        Fri, 25 Oct 2024 06:46:03 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm1543499f8f.94.2024.10.25.06.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:46:03 -0700 (PDT)
From: Tomas Krcka <tomas.krcka@gmail.com>
X-Google-Original-From: Tomas Krcka <krckatom@amazon.de>
To: stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tomas Krcka <krckatom@amazon.de>
Subject: [PATCH 6.1.y 5.15.y 5.10.y] driver core: bus: Fix double free in driver API bus_register()
Date: Fri, 25 Oct 2024 13:45:55 +0000
Message-Id: <20241025134555.10272-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
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
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 drivers/base/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 339a9edcde5f..8fae7c700cc9 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -853,6 +853,8 @@ int bus_register(struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&bus->p->subsys);
+	/* Above kset_unregister() will kfree @priv */
+	priv = NULL;
 out:
 	kfree(bus->p);
 	bus->p = NULL;
-- 
2.40.1


