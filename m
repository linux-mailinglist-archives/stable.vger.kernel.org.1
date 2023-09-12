Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D579BE63
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378911AbjIKWh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242385AbjIKP3h (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:29:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87244FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:29:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A95C433C7;
        Mon, 11 Sep 2023 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446173;
        bh=kN0ilVn/WfDYWcQIObvS7ZR6aACEk5c9TCgyL83El5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPp4XYB2VkIOBgcJGzhYmRf3ICegp/n+pXYVe8SJFpPoDh/mlzF8EJ/40fcY0D0uj
         t9lNY/tTYtgekzlvJbEa12UmnNsGwBwCG+a7cy+00wn967nqnivSeRpFwmOx19hMAS
         rVUK06D/X6sMldhW3NL8NZJZX53eDJoExloobuD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 6.1 571/600] platform/chrome: chromeos_acpi: print hex string for ACPI_TYPE_BUFFER
Date:   Mon, 11 Sep 2023 15:50:04 +0200
Message-ID: <20230911134650.467322535@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit 0820debb7d489e9eb1f68b7bb69e6ae210699b3f upstream.

`element->buffer.pointer` should be binary blob.  `%s` doesn't work
perfect for them.

Print hex string for ACPI_TYPE_BUFFER.  Also update the documentation
to reflect this.

Fixes: 0a4cad9c11ad ("platform/chrome: Add ChromeOS ACPI device driver")
Cc: stable@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230803011245.3773756-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-chromeos-acpi |    2 -
 drivers/platform/chrome/chromeos_acpi.c              |   31 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

--- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
+++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
@@ -134,4 +134,4 @@ KernelVersion:	5.19
 Description:
 		Returns the verified boot data block shared between the
 		firmware verification step and the kernel verification step
-		(binary).
+		(hex dump).
--- a/drivers/platform/chrome/chromeos_acpi.c
+++ b/drivers/platform/chrome/chromeos_acpi.c
@@ -90,7 +90,36 @@ static int chromeos_acpi_handle_package(
 	case ACPI_TYPE_STRING:
 		return sysfs_emit(buf, "%s\n", element->string.pointer);
 	case ACPI_TYPE_BUFFER:
-		return sysfs_emit(buf, "%s\n", element->buffer.pointer);
+		{
+			int i, r, at, room_left;
+			const int byte_per_line = 16;
+
+			at = 0;
+			room_left = PAGE_SIZE - 1;
+			for (i = 0; i < element->buffer.length && room_left; i += byte_per_line) {
+				r = hex_dump_to_buffer(element->buffer.pointer + i,
+						       element->buffer.length - i,
+						       byte_per_line, 1, buf + at, room_left,
+						       false);
+				if (r > room_left)
+					goto truncating;
+				at += r;
+				room_left -= r;
+
+				r = sysfs_emit_at(buf, at, "\n");
+				if (!r)
+					goto truncating;
+				at += r;
+				room_left -= r;
+			}
+
+			buf[at] = 0;
+			return at;
+truncating:
+			dev_info_once(dev, "truncating sysfs content for %s\n", name);
+			sysfs_emit_at(buf, PAGE_SIZE - 4, "..\n");
+			return PAGE_SIZE - 1;
+		}
 	default:
 		dev_err(dev, "element type %d not supported\n", element->type);
 		return -EINVAL;


