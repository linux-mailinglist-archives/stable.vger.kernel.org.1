Return-Path: <stable+bounces-194784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96983C5CC1F
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CFA3BCB1D
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE23311952;
	Fri, 14 Nov 2025 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh59nf0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB58309EE1;
	Fri, 14 Nov 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118356; cv=none; b=MLCBdJK/qxi7Nw8/uLVOdklzX19Cnr6BeE4phhDXnEqzYf2plmW9+H6szW+QfBq2Kusr01UQ12tVR5Pq2QpyIwBzdj9e1/oAGognj6QIZtVyKKVRhQxmCPuXC9P/CSr37ewwBJmai9tZh1Rt+2nMMf+B9f/ZmpodcAwoa7xUTZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118356; c=relaxed/simple;
	bh=AWvh0tAT5JIUf4qQUQXLy3CA15RMTyWdzC1GrwGYlCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcRvfXnoINb6QrwdxzCJkvFntjQV9PWECrir3mAYQyylDeDiaIbteOXjcbALrgBUP3Yfh9Me7WwW+Q6BgZDOYwgwWUGMlMshjx5cmuRiPnVtOPYoIJJqV0QJ1MHhQp18bEvAFsOUlZGwLuF6ZD6NIYGlqB22/3eHIimcEE2JgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh59nf0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272DEC4CEF5;
	Fri, 14 Nov 2025 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763118355;
	bh=AWvh0tAT5JIUf4qQUQXLy3CA15RMTyWdzC1GrwGYlCE=;
	h=From:To:Cc:Subject:Date:From;
	b=Rh59nf0H1f/8YhD8RFwgvsgVXzXoc3ReS506BNhYjhilze02VfmPPv1D+M4IXY9Tp
	 9ZFTkD+KUY0OVj4TO83G+klIWFUE6eV/AhyHUpfNpWG7y3aoevShSGr+YGoOFCjpxl
	 MloTZsV8HllFblWO1Ibos8ljTqWrxfyUgE8Yf2h6dPP4KCuTFPfG5Zsx794hmJ299j
	 R+ViLgDzWoCGpg3wJT3L2+CcEyWe7cJFqfuMkh+HdyP718GJSaS8peea5QmBZYkjyu
	 dgHF/5mD4ENO/2ygtbLQCnlDiQfhNr8noGHIbkePp8jjJq1P8JGnyEwQCD+pL07Adz
	 ezQHHQ0m7X9qw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org,
	WangYuli <wangyl5933@chinaunicom.cn>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH] nvmem: layouts: fix nvmem_layout_bus_uevent
Date: Fri, 14 Nov 2025 11:05:39 +0000
Message-ID: <20251114110539.143154-1-srini@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

correctly check the ENODEV return value.

Fixes: 810b790033cc ("nvmem: layouts: fix automatic module loading")
CC: stable@vger.kernel.org
Co-developed-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
Hi Greg,
 
There is only one nvmem fix in this cycle,  
Can you pl pick this fix for 6.18 release.

thanks,
--srini

 drivers/nvmem/layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index f381ce1e84bd..7ebe53249035 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -51,7 +51,7 @@ static int nvmem_layout_bus_uevent(const struct device *dev,
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
-	if (ret != ENODEV)
+	if (ret != -ENODEV)
 		return ret;
 
 	return 0;
-- 
2.51.0


