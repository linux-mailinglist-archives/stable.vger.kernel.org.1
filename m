Return-Path: <stable+bounces-79937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8BC98DAFB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058B4B26D0D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC11D0F44;
	Wed,  2 Oct 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4eYo9FG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEE1D0DCE;
	Wed,  2 Oct 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878905; cv=none; b=bntvslwShml1WZAeyKSYfacRumEodlotccJuFWC6c/kksZYrQv8P6ygb0qqq+XCYBy+kxFaY7yvGD8+tCZkh7fLjfpUsVL9qisHpl8zmW1fRt3QYxMRWzS1QQiDGhscMKJS1NSte/PwpwDCZzE2HvWGaRvKMSu92C9tQGRj4HLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878905; c=relaxed/simple;
	bh=G0F95l096NRMl3+a4pzopekYTRDgMrT0TgZzR0LbXsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEYpbSLJI1KxcLCzusZx73H6s3MS68BmWqMklzkp4CDeXZDHO3SogEREvu7XVQZZqjugZQaRJF4x6xqHqjQbzLvlTKKN6/V/qhcH9h9QQ75PNeuDGHmbk1s1yOObId5JUgac0pN7pQetyyZonZ+R1xosNH88MJLo1Ywx12ED7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4eYo9FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C9AC4CEC5;
	Wed,  2 Oct 2024 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878905;
	bh=G0F95l096NRMl3+a4pzopekYTRDgMrT0TgZzR0LbXsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4eYo9FGglRhWz8V49PKexP5jUz0i+WZiTe8/IV4urBC3A3q2wOQ4VJvtej2AaK78
	 PzlmQQ+F3BaQS1AMo8HzxygRu35T9Sek+DEg52yU8YFC9UyEwJxXFIfsz26TcgyMLE
	 qQCdYRBgw/gJ9fV65aGeKIn5XPb57/OBbrDcHa+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Chen <me@linux.beauty>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.10 541/634] ACPI: resource: Do IRQ override on MECHREV GM7XG0M
Date: Wed,  2 Oct 2024 15:00:41 +0200
Message-ID: <20241002125832.463790283@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Chen <me@linux.beauty>

commit b53f09ecd602d7b8b7da83b0890cbac500b6a9b9 upstream.

Listed device need the override for the keyboard to work.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Li Chen <me@linux.beauty>
Link: https://patch.msgid.link/87y15e6n35.wl-me@linux.beauty
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -555,6 +555,12 @@ static const struct dmi_system_id irq1_l
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
 	{
+		/* MECHREV Jiaolong17KS Series GM7XG0M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
+		},
+	},
+	{
 		/* XMG APEX 17 (M23) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxBGxx"),



