Return-Path: <stable+bounces-136148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EEA991B0
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DF7A7E17
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA0B29AAE0;
	Wed, 23 Apr 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vc+4LtNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1028B50E;
	Wed, 23 Apr 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421783; cv=none; b=GGheeSACMGb5IBWFsh2ctHjiPV0Fx7Y+gGiF2ESOudVy2PM+37lfWb7PS5oCe1zYK2SbbUa9KPLErMozNMRazkjSl+CCd5CkGKwOXvqEPt4L/j1n/HLHuYvYg3abRPXg9pNIr8WaMLhtLApcDnUv/vIZZ2VdRyxOeo3voOowq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421783; c=relaxed/simple;
	bh=nWp9oOKgYfOLWoA+iYlLRzQIrhPplAEkdFNel/RzgFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qplrv7ac6x3rvgM/hcG3Amtt1B6A6BlJfaEI+3klIuQDNxwn17M4o4PoC8Nl3MQvqovtw7qT3x+8bWUbch9k54tMXnktv3lSa6jU8bVjzrY4W4E0x9sncQaIMUtwcu51o2RCnYxinWx+njeGZJXt72rZJZs0xvUC+4Yq8kgJ5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vc+4LtNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E111C4CEE2;
	Wed, 23 Apr 2025 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421781;
	bh=nWp9oOKgYfOLWoA+iYlLRzQIrhPplAEkdFNel/RzgFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vc+4LtNvL8FJRGg9czDVQtFvlTBTH/wD2Hcz96UQ9sA1u0Q2NP+cLTyCvr94GrpO7
	 NF+5Kc88mCxTCMpInyJFTgsMbcR/4IdbVczyCECPR/AF3pdBzzj5dnTdmm2AAZrEoe
	 amhbj7MypLwOjmZ0xiyVTGOYx1s74N10j3SxNVQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.6 223/393] of/irq: Fix device node refcount leakages in of_irq_count()
Date: Wed, 23 Apr 2025 16:41:59 +0200
Message-ID: <20250423142652.598365857@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit bbf71f44aaf241d853759a71de7e7ebcdb89be3d upstream.

of_irq_count() invokes of_irq_parse_one() to count IRQs, and successful
invocation of the later will get device node @irq.np refcount, but the
former does not put the refcount before next iteration invocation, hence
causes device node refcount leakages.

Fix by putting @irq.np refcount before the next iteration invocation.

Fixes: 3da5278727a8 ("of/irq: Rework of_irq_count()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-5-93e3a2659aa7@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/irq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -509,8 +509,10 @@ int of_irq_count(struct device_node *dev
 	struct of_phandle_args irq;
 	int nr = 0;
 
-	while (of_irq_parse_one(dev, nr, &irq) == 0)
+	while (of_irq_parse_one(dev, nr, &irq) == 0) {
+		of_node_put(irq.np);
 		nr++;
+	}
 
 	return nr;
 }



