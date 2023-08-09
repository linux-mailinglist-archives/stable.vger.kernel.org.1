Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255577599F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjHILCJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjHILCI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786321724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EBBB61FA9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D3CC433C9;
        Wed,  9 Aug 2023 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578927;
        bh=+PNxod4OvDHmAkHY8n88tQJmYujZXunDAdYKP+UXrXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5nWEb+9otlyVlb87wNmhKzt0Uz4p6+BCer8BcZHTd4WT4/6EhwikbOfOU7ttbq3P
         idYd4Obtg8hQMQWVO2GmFShYe5r8lGUJlPHgYx5tJhsg5T3Naec7Wew7oJQ8iIll2K
         ugYYZNouZKfY6l4LTg6XySTSv1BaH+8WkOK8Nnac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Subject: [PATCH 4.14 005/204] drm/edid: Fix uninitialized variable in drm_cvt_modes()
Date:   Wed,  9 Aug 2023 12:39:03 +0200
Message-ID: <20230809103642.739475096@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

commit 991fcb77f490390bcad89fa67d95763c58cdc04c upstream.

Noticed this when trying to compile with -Wall on a kernel fork. We
potentially don't set width here, which causes the compiler to complain
about width potentially being uninitialized in drm_cvt_modes(). So, let's
fix that.

Changes since v1:
* Don't emit an error as this code isn't reachable, just mark it as such
Changes since v2:
* Remove now unused variable

Fixes: 3f649ab728cd ("treewide: Remove uninitialized_var() usage")
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ilia Mirkin <imirkin@alum.mit.edu>
Link: https://patchwork.freedesktop.org/patch/msgid/20201105235703.1328115-1-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_edid.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2691,6 +2691,8 @@ static int drm_cvt_modes(struct drm_conn
 		case 0x0c:
 			width = height * 15 / 9;
 			break;
+		default:
+			unreachable();
 		}
 
 		for (j = 1; j < 5; j++) {


