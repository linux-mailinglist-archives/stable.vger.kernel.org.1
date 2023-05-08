Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF06FA4C0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjEHKDC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjEHKDB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8473120BC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1C8622E6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D96DC433D2;
        Mon,  8 May 2023 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540165;
        bh=JJXEF3sE+EiIAkPBgV37jmCIvWUqRe9SCSfkapufKvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUt0uKGU3sAiGSNpWpPZgG0bbOqo5KNf1Va8xTV9d8d0eJLsJsWYheR56DEWGlObH
         HoE6n+GeyCMzBGcPRZhIL+IIQXYFwHu1MsfdvtYedL8ujeoibxxYgAmeEJ8ZPlHcw7
         yZug01LhOlAxvuLl/yS5OKvOEjtRClFBQN84UmP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 261/611] ACPI: bus: Ensure that notify handlers are not running after removal
Date:   Mon,  8 May 2023 11:41:43 +0200
Message-Id: <20230508094430.893910085@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit faae443738c6f0dac9b0d3d11d108f6911a989a9 ]

Currently, acpi_device_remove_notify_handler() may return while the
notify handler being removed is still running which may allow the
module holding that handler to be torn down prematurely.

Address this issue by making acpi_device_remove_notify_handler() wait
for the handling of all the ACPI events in progress to complete before
returning.

Fixes: 5894b0c46e49 ("ACPI / scan: Move bus operations and notification routines to bus.c")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3b6146b1e25cc..a16b7de73d164 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -586,6 +586,7 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 		acpi_remove_notify_handler(device->handle, type,
 					   acpi_notify_device);
 	}
+	acpi_os_wait_events_complete();
 }
 
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
-- 
2.39.2



