Return-Path: <stable+bounces-14583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0783817F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D56E1C291C1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386414A4F3;
	Tue, 23 Jan 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+/LVbPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12599A3F;
	Tue, 23 Jan 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972149; cv=none; b=PSCesabd0bQBSjIL0ZOIkp+aEZOtwl9UucuSpgAAPDVzyyyp413XpaboecfgAqacG8qL7+2eaLaU3+o9ZaLNbWj44tZ+tnC4oTrAJw2bZ5YsHS+FAiVSrj7Ge6DC3HcGRplhz0IBYNwKsFoUHt3wzWsyyIcRs2hHugyjWm919pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972149; c=relaxed/simple;
	bh=MJpDHo/zNXmcXYuLpm+hdFj3loJ01T6dLNcEcogBuRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfJkik6OKTTaueXBEjil3V+7Tep+2ibqNNjX2JjTFTpbPZ0VjIIVx6ku+Srq+1Q/Rn3ey3crLEGj1j7lFlgbQyRf512o1aCAgBs8NxfMu2D7Ws4ZkMtvYSeAsOac5KC0s7FXAucL8Qcten642vqakaADwDOQp0bbfVkWhmcsBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+/LVbPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EDDC433B1;
	Tue, 23 Jan 2024 01:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972148;
	bh=MJpDHo/zNXmcXYuLpm+hdFj3loJ01T6dLNcEcogBuRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+/LVbPuC4fSbG5s3fAH3gujxH9/Ft+8h2nV2nMqpgytJ0S9b9TVoxMMiWbFa1uA/
	 YmFjdUnkq3RKBiAAJ91/2OGNrL0ssUC8WOx/NRpDdcjrEbj1rY9RhF27+Fq03Yutb2
	 UroDOgTnBnOXDQm5LI+DkJch9y0kXTkbpMMaRkzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 077/374] powerpc/imc-pmu: Add a null pointer check in update_events_in_group()
Date: Mon, 22 Jan 2024 15:55:33 -0800
Message-ID: <20240122235747.290787396@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 0a233867a39078ebb0f575e2948593bbff5826b3 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231126093719.1440305-1-chentao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/imc-pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 55a853edc3be..e2f6fe259aa6 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -292,6 +292,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	attr_group->attrs = attrs;
 	do {
 		ev_val_str = kasprintf(GFP_KERNEL, "event=0x%x", pmu->events[i].value);
+		if (!ev_val_str)
+			continue;
 		dev_str = device_str_attr_create(pmu->events[i].name, ev_val_str);
 		if (!dev_str)
 			continue;
@@ -299,6 +301,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 		attrs[j++] = dev_str;
 		if (pmu->events[i].scale) {
 			ev_scale_str = kasprintf(GFP_KERNEL, "%s.scale", pmu->events[i].name);
+			if (!ev_scale_str)
+				continue;
 			dev_str = device_str_attr_create(ev_scale_str, pmu->events[i].scale);
 			if (!dev_str)
 				continue;
@@ -308,6 +312,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 		if (pmu->events[i].unit) {
 			ev_unit_str = kasprintf(GFP_KERNEL, "%s.unit", pmu->events[i].name);
+			if (!ev_unit_str)
+				continue;
 			dev_str = device_str_attr_create(ev_unit_str, pmu->events[i].unit);
 			if (!dev_str)
 				continue;
-- 
2.43.0




