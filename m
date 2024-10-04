Return-Path: <stable+bounces-80846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D3990BC6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA621C22225
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD71E971A;
	Fri,  4 Oct 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx8oK3HT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CB1E9713;
	Fri,  4 Oct 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066035; cv=none; b=jUiLpBmYQ5Wl0ORjlXFlZYmyZnEebVuVlMywh6Lf6BjSQsADsMPFjJKcRmlOUjmhH5juDj6jSqFzshyPJbSdgc1hECbF6fo7tCJfTYNilNWe7bTyO11c0SNABg/Ho+vWGMM0VhWcHHE/YmoTQrHje2ULxLOEcvltFj28/XFCZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066035; c=relaxed/simple;
	bh=Bk9YsL6iFGKSTVRwhI/gd8IweX/aAxs7s3R0/EDDezg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPdwbYOM2e6pIq0rjJF28D1GTxfLnrwESmxW8OUbWzqzKleaJGtl+zoGlb/9AFEa6ci/leQT9wtSxPGwLl4by8tFWM2FTym/eUrb20YZwQjpOzomyu5x1v62WX+ueu6bSpViiL3kJhtKR+LHxDx14omrt8NKij7CvXmqVJjJApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx8oK3HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC90CC4CECC;
	Fri,  4 Oct 2024 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066035;
	bh=Bk9YsL6iFGKSTVRwhI/gd8IweX/aAxs7s3R0/EDDezg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wx8oK3HT25v3mv03410+Z1mfr7jaOW6/kUMDZP4calhxfe0Z4x4gWsdflB9Y86eea
	 WSE6zk44vyTJo+hHd71TpOBAJnynM5qiutr0OpfcCafRCrkuPzjjTE0Ey1oChqtBXa
	 XpuzgIL6M8lRaQlm9AxGoMgQRDj8m99dyMo4xRyHdA5dPq8EP2MWKasKUe4M4wjWHE
	 CT73O7Lf5w3agSaoxITp6bYEtH97i9PRJzqqEhwXVxNZYkuMkVZdcXEnCW5/TVGfxO
	 pMIWJVwAhlreOyeK53f5vEgHOprXnQyzEUr6boEnnDD13y+Ys5sIrC9G+K6Z6yQLP5
	 1cPLHFa0Nz1xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 66/76] driver core: bus: Fix double free in driver API bus_register()
Date: Fri,  4 Oct 2024 14:17:23 -0400
Message-ID: <20241004181828.3669209-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
---
 drivers/base/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2f..08362ecec0ecb 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -920,6 +920,8 @@ int bus_register(const struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&priv->subsys);
+	/* Above kset_unregister() will kfree @priv */
+	priv = NULL;
 out:
 	kfree(priv);
 	return retval;
-- 
2.43.0


