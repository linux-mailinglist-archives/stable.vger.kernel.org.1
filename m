Return-Path: <stable+bounces-80977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B841990D72
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1292C1F2572F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014CF20B782;
	Fri,  4 Oct 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKP6hxxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34463DAC03;
	Fri,  4 Oct 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066397; cv=none; b=bJaEO+ew2P4AjTD+uqNvHqUckaBLVgS/6ziLeErer++opCFIDggGA01EWYTHOUOvZwdKoiP8OAphPP6QzQVeWs3Lb1wTc+JuVSID/yfHUMyVMH5+PQudBRrMm1pwBnf5PvOifCSZPMcSzsf858cvbAOyttn7ib4FX0KFRnFfJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066397; c=relaxed/simple;
	bh=5HW4vdAKGVjujW7sXlF0WZ5+/v2AdJbGn4VIMafCk4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG2gD1ejqEIkIqF+Ld6gi8PpOD8Wjve3BBG/qoKIIqwGsCx7T1UcCfgAEZ5J41MjZq5vshgqa4LVsE1V1rXPPLsPB56bScUwlK7TRc3lbTsmzplYqirt/RbAakz4t/+1DxAqnpUX/LZvO4G4q3A6BjtV4H3unoPKRMMbBSJZBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKP6hxxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6DBC4CECC;
	Fri,  4 Oct 2024 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066397;
	bh=5HW4vdAKGVjujW7sXlF0WZ5+/v2AdJbGn4VIMafCk4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKP6hxxziWuqnsAjMz0LJXy4XXz+IPfBgSF97mwr14m1Zz36o2NA90/pW6dl2NNCT
	 V2V/SAMPTzmzfQo0UacCSfIa94lr6+3QihnxUIQGpFzsWyaLcsLdtugTBY83L8NUsC
	 n7c6pAklH3OfCEbsc7vkGhLE5Nco0Qf2LNfNgHwV9I/J5VV+uK+Dr1vzpd/05szIdC
	 jEtC9YioGiXnrhYOsMj2o6ggbNpdAMig+/Nb+4yH7Q5Cb0omTTytOHyAvysjp3AREn
	 e+YTSANNQRmmoleGhwoUpx2fsjzq40zIr2LbQjSWIzKQc2X3waZiPwBwtb+cmfQiQ0
	 GTmBAhaHY0jyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 51/58] driver core: bus: Fix double free in driver API bus_register()
Date: Fri,  4 Oct 2024 14:24:24 -0400
Message-ID: <20241004182503.3672477-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index d7c4330786cae..e7761e0ef5a55 100644
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


