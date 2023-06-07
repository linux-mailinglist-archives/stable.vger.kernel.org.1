Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12218726F32
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjFGU4R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjFGU4O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68FFC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672546482F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78647C433EF;
        Wed,  7 Jun 2023 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171371;
        bh=XoNTfPVcj/zDFprYglcjvKbAP5hhuU89V9zc+Z8J8pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InRup/h89d5v71lQq46928QFujmGxuLnZGLxUUllvs+KV3e9SexwIQ3hTYmHmtBxc
         JKa6JaoPBMOnENil2ENVTuQNCZg/dMuYMKEssKpxiooPGN/2SyC/EmFb3WMzX/O1mT
         U9/le3Z6YyYfcpFnkGVFUXRr4EyudARQ45qnvez0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Borowski <kilobyte@angband.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 75/99] ACPI: thermal: drop an always true check
Date:   Wed,  7 Jun 2023 22:17:07 +0200
Message-ID: <20230607200902.577884111@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Adam Borowski <kilobyte@angband.pl>

commit e5b5d25444e9ee3ae439720e62769517d331fa39 upstream.

Address of a field inside a struct can't possibly be null; gcc-12 warns
about this.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/thermal.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1153,8 +1153,6 @@ static int acpi_thermal_resume(struct de
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!(&tz->trips.active[i]))
-			break;
 		if (!tz->trips.active[i].flags.valid)
 			break;
 		tz->trips.active[i].flags.enabled = 1;


