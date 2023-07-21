Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359FA75D186
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGUSty (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGUStx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34730CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D87619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0157DC433C7;
        Fri, 21 Jul 2023 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965391;
        bh=dE/YRUR/M90BfMeVJ6/rHgGLSZA89KLMIfVg5T+jt+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXwfKVjjYgANOyi2SrIuq0L00YSuxlmkS/BXju/anyEaE2S0saIvURlDj1WZDSlZE
         6Wmobx14orFDTv3AAG3z/7VUKfsE7rnnuXekKCf0v98q0YfElY6oFW2cWZ9kSHBQ/N
         MufhH8BpgcyjRZSef8ZhpptZ0gWtg5Kgiq2qjXEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 268/292] smb: client: Fix -Wstringop-overflow issues
Date:   Fri, 21 Jul 2023 18:06:17 +0200
Message-ID: <20230721160540.444353902@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit f1f047bd7ce0d73788e04ac02268060a565f7ecb upstream.

pSMB->hdr.Protocol is an array of size 4 bytes, hence when the compiler
analyzes this line of code

	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;

it legitimately complains about the fact that offset points outside the
bounds of the array. Notice that the compiler gives priority to the object
as an array, rather than merely the address of one more byte in a structure
to wich offset should be added (which seems to be the actual intention of
the original implementation).

Fix this by explicitly instructing the compiler to treat the code as a
sequence of bytes in struct smb_com_transaction2_spi_req, and not as an
array accessed through pointer notation.

Notice that ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) points to
the same address as ((char *) &pSMB->hdr.Protocol), therefore this results
in no differences in binary output.

Fixes the following -Wstringop-overflow warnings when built s390
architecture with defconfig (GCC 13):
  CC [M]  fs/smb/client/cifssmb.o
In function 'cifs_init_ace',
    inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
    inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
 2987 |         cifs_ace->cifs_e_perm = local_ace->e_perm;
      |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
In file included from fs/smb/client/cifssmb.c:27:
fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
fs/smb/client/cifspdu.h:384:14: note: at offset [7, 11] into destination object 'Protocol' of size 4
  384 |         __u8 Protocol[4];
      |              ^~~~~~~~
In function 'cifs_init_ace',
    inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
    inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
fs/smb/client/cifssmb.c:2988:30: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
 2988 |         cifs_ace->cifs_e_tag =  local_ace->e_tag;
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
fs/smb/client/cifspdu.h:384:14: note: at offset [6, 10] into destination object 'Protocol' of size 4
  384 |         __u8 Protocol[4];
      |              ^~~~~~~~

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/310
Fixes: dc1af4c4b472 ("cifs: implement set acl method")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 19f7385abeec..9dee267f1893 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3184,7 +3184,7 @@ setAclRetry:
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
 				InformationLevel) - 4;
 	offset = param_offset + params;
-	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;
+	parm_data = ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 
 	/* convert to on the wire format for POSIX ACL */
-- 
2.41.0



