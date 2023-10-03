Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D257B643C
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjJCIcz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJCIcz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 04:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07FAB
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696321922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oM/kNXmOf7pF5c5aEMrfjCntn3rClcCDEzkX2duHLEA=;
        b=KE/06FCA/q+RpB1+kHwCcog/Hbw6Btc7xpWD0YJNj3wYs4gmNR/1Q1iyTuvw+fjwj0Jc3F
        7o07CWLVMKOaV6YTlG911EifWsHHkvfPNosSlO6Shh00RpI49MLdhf0eSHZPCAwLDE//oX
        DGZGN3VRajEB7yGmRNcutB/108HManU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-BfZFTetXOteg2vcm-T5Egg-1; Tue, 03 Oct 2023 04:30:47 -0400
X-MC-Unique: BfZFTetXOteg2vcm-T5Egg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5360b1af14fso760509a12.0
        for <stable@vger.kernel.org>; Tue, 03 Oct 2023 01:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696321846; x=1696926646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM/kNXmOf7pF5c5aEMrfjCntn3rClcCDEzkX2duHLEA=;
        b=VGmCUM3VxUASkksxTekuQ8V/21rCT5nTT0jclVlO8XNTPdXfud7ye/GxifXKqVvE/W
         lzIQDjlHjhFbLedQrOlUfPiY0unumwyDrJIj7k8U3LhRdnabse58cRIN0AfKcjXRQZ+L
         LEk3ZsfwEWGVLfie1uJ8wqDkGxl7V+kEaBbDP7lYnIVaENJFrF+hhaagoNQcWhkM99/t
         2E6qhSAYXXR2+vBmCe2ShjDjaJEk+3CztD9lPVTSpdG8D36bt/eD/5UFp+4e5tnsM4qg
         8DbwEMBsxBEds6F9OWRxMJd4GtSfsHVlpaAZyJj9HuX8bhMIW6uJJuy1+r//cI9MkrYG
         ko0w==
X-Gm-Message-State: AOJu0YyarIACAq5QiR2UbrI0Ef5jfqnEVy6ZyowIPC/Iep+ofIQfvW/B
        bm/+pX7mbrGeXWgdxiGg5UiGI9dVgcQFmNpS1O+tAkMrUfPLJYLqb38Rr/6DTFu+VAuJxShROMn
        dVlEzPtuV9Hbb5oxA
X-Received: by 2002:a05:6402:51d2:b0:533:5d3d:7efe with SMTP id r18-20020a05640251d200b005335d3d7efemr1813905edd.6.1696321846441;
        Tue, 03 Oct 2023 01:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3HBkf/spAPCWg2buADvp8XJgSosJn5mNjPkpxijnTnpr+wawUqquGx+CMLe/IM6grUfrflw==
X-Received: by 2002:a05:6402:51d2:b0:533:5d3d:7efe with SMTP id r18-20020a05640251d200b005335d3d7efemr1813891edd.6.1696321846102;
        Tue, 03 Oct 2023 01:30:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7dbd2000000b00535204ffdb4sm486394edt.72.2023.10.03.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:30:45 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     qemu-devel@nongnu.org
Cc:     Fabiano Rosas <farosas@suse.de>,
        Vasiliy Ulyanov <vulyanov@suse.de>,
        Thomas Huth <thuth@redhat.com>, stable@vger.kernel.org
Subject: [PULL 01/24] optionrom: Remove build-id section
Date:   Tue,  3 Oct 2023 10:30:18 +0200
Message-ID: <20231003083042.110065-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fabiano Rosas <farosas@suse.de>

Our linker script for optionroms specifies only the placement of the
.text section, leaving the linker free to place the remaining sections
at arbitrary places in the file.

Since at least binutils 2.39, the .note.gnu.build-id section is now
being placed at the start of the file, which causes label addresses to
be shifted. For linuxboot_dma.bin that means that the PnP header
(among others) will not be found when determining the type of ROM at
optionrom_setup():

(0x1c is the label _pnph, where the magic "PnP" is)

$ xxd /usr/share/qemu/linuxboot_dma.bin | grep "PnP"
00000010: 0000 0000 0000 0000 0000 1c00 2450 6e50  ............$PnP

$ xxd pc-bios/optionrom/linuxboot_dma.bin | grep "PnP"
00000010: 0000 0000 0000 0000 0000 4c00 2450 6e50  ............$PnP
                                   ^bad

Using a freshly built linuxboot_dma.bin ROM results in a broken boot:

  SeaBIOS (version rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org)
  Booting from Hard Disk...
  Boot failed: could not read the boot disk

  Booting from Floppy...
  Boot failed: could not read the boot disk

  No bootable device.

We're not using the build-id section, so pass the --build-id=none
option to the linker to remove it entirely.

Note: In theory, this same issue could happen with any other
section. The ideal solution would be to have all unused sections
discarded in the linker script. However that would be a larger change,
specially for the pvh rom which uses the .bss and COMMON sections so
I'm addressing only the immediate issue here.

Reported-by: Vasiliy Ulyanov <vulyanov@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230926192502.15986-1-farosas@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/optionrom/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index b1fff0ba6c8..30d07026c79 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -36,7 +36,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
 
 pvh.img: pvh.o pvh_main.o
 
-- 
2.41.0

