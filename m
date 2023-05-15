Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4B703371
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbjEOQhE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbjEOQhB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8D126
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3126282A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539D8C433EF;
        Mon, 15 May 2023 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168618;
        bh=iYL8y8yM2SdFXKcvjmQWXL8dd02w2G3EHkn9kaMUThE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jE+9uU0V49GmzMzjSDU8EQZX19rM5dmVryX2qFFZrWZCPTDqoL3OmYmAqboi5Ec8I
         64KcOd0rYgtDHWIGWQwZIxS7RjdQBDMXANegdUh9zeMsDHluSD1i+98vJda7KYcKF7
         jT1ryhHi1Jhuxdtzm3goaQgmNKdLhrpIJw6P/L8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 108/116] ext4: bail out of ext4_xattr_ibody_get() fails for any reason
Date:   Mon, 15 May 2023 18:26:45 +0200
Message-Id: <20230515161701.833034890@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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
@@ -364,7 +364,7 @@ static int ext4_update_inline_data(handl
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");


