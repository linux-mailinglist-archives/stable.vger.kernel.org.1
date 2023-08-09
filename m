Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE097759FA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjHILEQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjHILEP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:04:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6410B1BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026F763142
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10386C433C7;
        Wed,  9 Aug 2023 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579054;
        bh=a4caj6wr3tQ8C3wIQaB71rUB7T6jWBGaH4bJ/Tehhlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikEwUNFDLXv4vQH8NkSHPA8/O1HglS16b5AfN9kOsGGWrayZN/WreQETKvbeinDuF
         GKo0pk0ZPimNjk2MP3eh/+Bml8NSPer9gcRovVQChHz6nvLfsyt7vPJEavDus70dnH
         zDrlpzH4K3n74LiE/y4jt+rVustEH3DrqVFIEFas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 059/204] media: videodev2.h: Fix struct v4l2_input tuner index comment
Date:   Wed,  9 Aug 2023 12:39:57 +0200
Message-ID: <20230809103644.589029149@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 26ae58f65e64fa7ba61d64bae752e59e08380c6a ]

VIDIOC_ENUMINPUT documentation describes the tuner field of
struct v4l2_input as index:

Documentation/userspace-api/media/v4l/vidioc-enuminput.rst
"
* - __u32
  - ``tuner``
  - Capture devices can have zero or more tuners (RF demodulators).
    When the ``type`` is set to ``V4L2_INPUT_TYPE_TUNER`` this is an
    RF connector and this field identifies the tuner. It corresponds
    to struct :c:type:`v4l2_tuner` field ``index``. For
    details on tuners see :ref:`tuner`.
"

Drivers I could find also use the 'tuner' field as an index, e.g.:
drivers/media/pci/bt8xx/bttv-driver.c bttv_enum_input()
drivers/media/usb/go7007/go7007-v4l2.c vidioc_enum_input()

However, the UAPI comment claims this field is 'enum v4l2_tuner_type':
include/uapi/linux/videodev2.h

This field being 'enum v4l2_tuner_type' is unlikely as it seems to be
never used that way in drivers, and documentation confirms it. It seem
this comment got in accidentally in the commit which this patch fixes.
Fix the UAPI comment to stop confusion.

This was pointed out by Dmitry while reviewing VIDIOC_ENUMINPUT
support for strace.

Fixes: 6016af82eafc ("[media] v4l2: use __u32 rather than enums in ioctl() structs")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/videodev2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index b8fd2c303ed04..2ada2122d2743 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1484,7 +1484,7 @@ struct v4l2_input {
 	__u8	     name[32];		/*  Label */
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
-	__u32        tuner;             /*  enum v4l2_tuner_type */
+	__u32        tuner;             /*  Tuner index */
 	v4l2_std_id  std;
 	__u32	     status;
 	__u32	     capabilities;
-- 
2.39.2



