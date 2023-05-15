Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3C703812
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbjEOR1H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbjEOR0t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0A812EA8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E284D62C39
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6336C433D2;
        Mon, 15 May 2023 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171535;
        bh=VrWsb2kRQw+fErr23gXJEMqklrdRjVJeQWSzcPK/e6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CO4H7uix/liiI93D5GEPTd9K5xbF+oV5Rtq2/4ebwKfNacXQG1ZkcoNFOOYTjEjw8
         Tyov/dDjYnXHHm7MDfxNPCirZtpFSDpOX4ckCVEbZzZ8J4Fh1480AMAa5PyV21e8m9
         Z841QRNH5BIHFzNgzrEa7Jf+H5ts4UGVHjWrJi88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.2 233/242] ext4: bail out of ext4_xattr_ibody_get() fails for any reason
Date:   Mon, 15 May 2023 18:29:19 +0200
Message-Id: <20230515161728.901721297@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 2a534e1d0d1591e951f9ece2fb460b2ff92edabd upstream.

In ext4_update_inline_data(), if ext4_xattr_ibody_get() fails for any
reason, it's best if we just fail as opposed to stumbling on,
especially if the failure is EFSCORRUPTED.

Cc: stable@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -360,7 +360,7 @@ static int ext4_update_inline_data(handl
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");


