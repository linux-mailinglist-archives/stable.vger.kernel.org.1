Return-Path: <stable+bounces-101822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C29EEECE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57F516EEEF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD24F218;
	Thu, 12 Dec 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B1f1hVa3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AA2135B0;
	Thu, 12 Dec 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018922; cv=none; b=iyVtlbVEQYeFAOyU1NB5PJmYrSZlm6cev0bsVQa1tQXukcyPNhoAJdSw30hxZlA/Pc2hmpAiK6mOyOo0VpB/7gLMpSMwwyj+SQ5ADw1/yrWlBpWpFCGAWoHeXoeuzv4J+UAEj6kojVAAWAx1uK+6zAFcsvWDNNYJaJb+8LKV6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018922; c=relaxed/simple;
	bh=dlgXd1bnROXlN26soaTspZafyIlesl44EcV5VR7pbaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARk5onLZZE682HpsD90QjF0/7ot7RsCy85x+QOFXgZj9vNafByjgTDpmXsaVOk+0BFc5F3KbW22oTEU3WHX5R3bU8DIRIN3k5IVK8U6yBSEaeUHwIhzmjrE9Xa95rwAKziq8yCyHaP7jk22ajffBzmibiMwqyUJllGRf8SgUrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B1f1hVa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD1DC4CECE;
	Thu, 12 Dec 2024 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018922;
	bh=dlgXd1bnROXlN26soaTspZafyIlesl44EcV5VR7pbaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1f1hVa3RLJMogEi3fKut6XwZIFbBU+WQeTWUC0Wq4sQpO2w5nhCh6rzm7k1/Fjp2
	 QN6wAJ5XzVwj32jEgvpXKqil54Z4LKB4F3uS9YkMjOmTmbrE33GRi9AlE4wxX87Dl/
	 C/jHpy2qP417XorjUJ78NAzOKTaamV3gzSTk5IO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/772] thermal: core: Initialize thermal zones before registering them
Date: Thu, 12 Dec 2024 15:50:16 +0100
Message-ID: <20241212144352.865155338@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 662f920f7e390db5d1a6792a2b0ffa59b6c962fc ]

Since user space can start interacting with a new thermal zone as soon
as device_register() called by thermal_zone_device_register_with_trips()
returns, it is better to initialize the thermal zone before calling
device_register() on it.

Fixes: d0df264fbd3c ("thermal/core: Remove pointless thermal_zone_device_reset() function")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3336146.44csPzL39Z@rjwysocki.net
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ebb36b2c72d5d..ba6f44f8b2623 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1271,6 +1271,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		thermal_zone_destroy_device_groups(tz);
 		goto remove_id;
 	}
+	thermal_zone_device_init(tz);
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
@@ -1313,7 +1314,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
-	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-- 
2.43.0




