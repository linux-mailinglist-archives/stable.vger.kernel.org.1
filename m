Return-Path: <stable+bounces-79938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF09A98DAFD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68141B20B20
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3D1D0F48;
	Wed,  2 Oct 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krJKfUjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E501D0F43;
	Wed,  2 Oct 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878908; cv=none; b=d4pCuoii823P020w3cfeIjOQAu3yCwRJrabU9f1N9XS/7Q5jVrZdMnKACUVXgcdp/pZs0W0aG8624ihcuJDRT0LalnBFAacDVNNvBIW6cxix/KabGV/s0JYjrO9dLJ6+Mf8SVYxjAPgc2XERjsUk4/OVnAooZgfcQTWNFepTusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878908; c=relaxed/simple;
	bh=7ybcVWlgJsfJrADgHWb0zDS2EWaoXJPB8g8p50rnYkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWpL2MMOxMeVAOhuK7sJoC6cd2mRzMf7WlimkibOq5fbcm0Z9uen2HIO3jbe6tnzpQh5LRqeewOntlzm5nQxm1YG58KqcGVmnIfoyK7Zt9VoWkcOTvXzSNBkP5nkEqPnLqgQoNHA0DMNrOSxUZVcrhZg5q99efVNH4i+q+4YfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krJKfUjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FB4C4CEC5;
	Wed,  2 Oct 2024 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878908;
	bh=7ybcVWlgJsfJrADgHWb0zDS2EWaoXJPB8g8p50rnYkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krJKfUjFntCmZUeeDiG75MreaDBxH5ytRoYQub+EpqTEVul3l1XQI0sF+vOOVDYSO
	 aL/7rAct+NIaUBfnRajoK/72u4trky8q48pUlvVdNFy1CB+y62K5qUTJ8MyhBasSa9
	 jAPicseUuZ5JkG53jCJJ5zRrtikR6fkwS5y6DaRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.10 542/634] ACPI: resource: Add another DMI match for the TongFang GMxXGxx
Date: Wed,  2 Oct 2024 15:00:42 +0200
Message-ID: <20241002125832.505093238@linuxfoundation.org>
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

From: Werner Sembach <wse@tuxedocomputers.com>

commit a98cfe6ff15b62f94a44d565607a16771c847bc6 upstream.

Internal documentation suggest that the TUXEDO Polaris 15 Gen5 AMD might
have GMxXGxX as the board name instead of GMxXGxx.

Adding both to be on the safe side.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240910094008.1601230-1-wse@tuxedocomputers.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -579,6 +579,12 @@ static const struct dmi_system_id irq1_e
 		},
 	},
 	{
+		/* TongFang GMxXGxX/TUXEDO Polaris 15 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxX"),
+		},
+	},
+	{
 		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),



