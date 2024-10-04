Return-Path: <stable+bounces-80916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A61990CB3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82961F23A41
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC71FCC78;
	Fri,  4 Oct 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvgd3MiU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9E1FCC6F;
	Fri,  4 Oct 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066238; cv=none; b=Ma3IlgrUxN2EwA4N9qELaoo8w+MG1lk+cqR0pugJ/XqVb4jhvRKMADPqqwIezKIG/aCRBQgdfevwftwvKgrSS1d8Ez91mvl90SDhZ3l/saF0LKCRBf+EqpPD5obwZh/7JP1I0naJ0FhtRyvG/hLRF4E+mLphelQN63U1XwhCoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066238; c=relaxed/simple;
	bh=Bk9YsL6iFGKSTVRwhI/gd8IweX/aAxs7s3R0/EDDezg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3vBmqleUqxUvm2pIQHgHDox1aAOQssNG4qwB2CCsCmMpvh3tgpdhKWZY/5fAG7v6+H3GVUnn1N7lUEQXhZcfFeWzvQmCUVijSKETLpb3VwpAjwNxNwHniQHKr7ueYgdAC8nAq8zZhwXg215r9gS8VM7wvPvhugl2SHUp0h7WuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvgd3MiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450ADC4CEC6;
	Fri,  4 Oct 2024 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066237;
	bh=Bk9YsL6iFGKSTVRwhI/gd8IweX/aAxs7s3R0/EDDezg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvgd3MiUmLnPPtTVZ/uuHAPUj+UnI7q+UUzAEKkz3Qt3FY5+EWXx8byUccQF4VMf+
	 MfB5zJFCvgDU7++nLVNDpqsGoKOIPEYJvsB7qoBeXKt/MfQlPmHN3p9bwLZfj+N7wy
	 WnfkN/ZXyRYEFF+H+G7SJqPQoQi5rsCAzOXOy7leRSG6XT9rLUP24h5BtkwiYI3FHj
	 aMyxvTyi7++T76Af3UxGET0KLf+Mcx0vbVpylOoGVsuFlLleMta1OI2ouZnRsVAx1S
	 aW9KuS+dKbnUhkuSriAJmBmecE9e/k7Rd4fMifN6ZSvP/iXLtiwsjFoA/OdwEHppSS
	 P8oT7dmSCcomQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 60/70] driver core: bus: Fix double free in driver API bus_register()
Date: Fri,  4 Oct 2024 14:20:58 -0400
Message-ID: <20241004182200.3670903-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


