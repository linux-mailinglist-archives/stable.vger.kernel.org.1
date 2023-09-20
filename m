Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9B7A806A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjITMhI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjITMhI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:37:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8119E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:37:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A7C433C7;
        Wed, 20 Sep 2023 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213422;
        bh=PIPzzZvT1S8P/by49wgV1B76lJCgZ8TcQQ4uUIpQNoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xq5gilwl3odDLry+ztPhRPsGmEzoCiDQGr/v96Fwcky5/wjAefxnqhPmoUX28YZ7d
         HdK6vCyUEWozm3plFs1um9jJX02u3+yQrx22PrpZE5d3dQp93c/Z269sTYudZ4m4iD
         P18HwIj2y+2GVg2e4MMPuhp8PzyAkECN8EoipEio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.4 231/367] s390/ipl: add missing secure/has_secure file to ipl type unknown
Date:   Wed, 20 Sep 2023 13:30:08 +0200
Message-ID: <20230920112904.559735861@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

commit ea5717cb13468323a7c3dd394748301802991f39 upstream.

OS installers are relying on /sys/firmware/ipl/has_secure to be
present on machines supporting secure boot. This file is present
for all IPL types, but not the unknown type, which prevents a secure
installation when an LPAR is booted in HMC via FTP(s), because
this is an unknown IPL type in linux. While at it, also add the secure
file.

Fixes: c9896acc7851 ("s390/ipl: Provide has_secure sysfs attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/ipl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -429,6 +429,8 @@ static struct attribute_group ipl_ccw_at
 
 static struct attribute *ipl_unknown_attrs[] = {
 	&sys_ipl_type_attr.attr,
+	&sys_ipl_secure_attr.attr,
+	&sys_ipl_has_secure_attr.attr,
 	NULL,
 };
 


