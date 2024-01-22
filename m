Return-Path: <stable+bounces-14671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883E838258
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC8EB27522
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194F5787C;
	Tue, 23 Jan 2024 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAXwW5pY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A455787B;
	Tue, 23 Jan 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974055; cv=none; b=QaH4maqBcpTWt/+FNzjkQXJ4ZUHmuMmPaqrV2MEyuU2a6dQwqEPUkqWuJMsYnH1sNzqswQyo+I6knFFWgqYQKKU13IP5RnV5qkr6fv4LwbHsHhFVsrjjzub5aSMAdp+Q6k+M2p+P9UTY5Kr9qMKl9ztpQfr+8ye6hDAzfU93qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974055; c=relaxed/simple;
	bh=IK0yBNsFo1DstpR9ABfzIrBPVR3CWiGyzX8QZXB02VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUxsF+pUkprtGcytUKan/bj3jykpFcQPFVsOcO6SznJjlfSlpdoyk365zQL8dysaYWjdWFrijSCBzINUuOQ3IxkUywZoz1PV2DamH15Ld5jAPuJwjvmgw1ABJrUzSkUP7+B0SJs0I/1RgzjYjs0oQQlnAm8n5HxxbHKgnq6ydo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAXwW5pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D349C43390;
	Tue, 23 Jan 2024 01:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974055;
	bh=IK0yBNsFo1DstpR9ABfzIrBPVR3CWiGyzX8QZXB02VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAXwW5pYm1VIzRESXJIDpXnIyg7iq+gYkLrc8YXUBc/kEm444xLy8/jwejgc7Fl5I
	 /s+t89d0NgbmdqkfJsfLlrkoEpx4o+6jjTd5py6EK1OFnscc5HRszAs1EC/uVlK0M3
	 qV5VLVAtgBCfbO9H+kUUi7ZRUYKNsilsFBRfnjgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/583] powerpc/imc-pmu: Add a null pointer check in update_events_in_group()
Date: Mon, 22 Jan 2024 15:51:10 -0800
Message-ID: <20240122235812.803599252@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index ada817c49b72..56d82f7f9734 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -299,6 +299,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	attr_group->attrs = attrs;
 	do {
 		ev_val_str = kasprintf(GFP_KERNEL, "event=0x%x", pmu->events[i].value);
+		if (!ev_val_str)
+			continue;
 		dev_str = device_str_attr_create(pmu->events[i].name, ev_val_str);
 		if (!dev_str)
 			continue;
@@ -306,6 +308,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 		attrs[j++] = dev_str;
 		if (pmu->events[i].scale) {
 			ev_scale_str = kasprintf(GFP_KERNEL, "%s.scale", pmu->events[i].name);
+			if (!ev_scale_str)
+				continue;
 			dev_str = device_str_attr_create(ev_scale_str, pmu->events[i].scale);
 			if (!dev_str)
 				continue;
@@ -315,6 +319,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 		if (pmu->events[i].unit) {
 			ev_unit_str = kasprintf(GFP_KERNEL, "%s.unit", pmu->events[i].name);
+			if (!ev_unit_str)
+				continue;
 			dev_str = device_str_attr_create(ev_unit_str, pmu->events[i].unit);
 			if (!dev_str)
 				continue;
-- 
2.43.0




