Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4C726EAF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjFGUwC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjFGUvx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7169611D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC586472E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D625C433D2;
        Wed,  7 Jun 2023 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171110;
        bh=yVZUa91cC4AjJsDmOCeAkbo4Wi1nABQ4RHqQaHMya8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyhKWKsHHo4Kc3u658INM465owmg/b53iUlZp5/eZu08VLSuOy/Bxhf47Wx2vX55z
         XasU5pYMOTVynuB+kg81beYxLuKXgKCtdtViZUM2afxKNQ00ZjbVCZjxUSgTOlnl+Z
         2dqWqYRr/gdUGISmfFAMEFAXlB+VAH1iC/Yk8qVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.10 114/120] crypto: ccp: Reject SEV commands with mismatching command buffer
Date:   Wed,  7 Jun 2023 22:17:10 +0200
Message-ID: <20230607200904.520857466@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
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

From: Sean Christopherson <seanjc@google.com>

commit d5760dee127bf6f390b05e747369d7c37ae1a7b8 upstream.

WARN on and reject SEV commands that provide a valid data pointer, but do
not have a known, non-zero length.  And conversely, reject commands that
take a command buffer but none is provided (data is null).

Aside from sanity checking input, disallowing a non-null pointer without
a non-zero size will allow a future patch to cleanly handle vmalloc'd
data by copying the data to an internal __pa() friendly buffer.

Note, this also effectively prevents callers from using commands that
have a non-zero length and are not known to the kernel.  This is not an
explicit goal, but arguably the side effect is a good thing from the
kernel's perspective.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210406224952.4177376-4-seanjc@google.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/sev-dev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -156,6 +156,7 @@ static int __sev_do_cmd_locked(int cmd,
 	struct sev_device *sev;
 	unsigned int phys_lsb, phys_msb;
 	unsigned int reg, ret = 0;
+	int buf_len;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -165,6 +166,10 @@ static int __sev_do_cmd_locked(int cmd,
 
 	sev = psp->sev_data;
 
+	buf_len = sev_cmd_buffer_len(cmd);
+	if (WARN_ON_ONCE(!data != !buf_len))
+		return -EINVAL;
+
 	if (data && WARN_ON_ONCE(!virt_addr_valid(data)))
 		return -EINVAL;
 
@@ -176,7 +181,7 @@ static int __sev_do_cmd_locked(int cmd,
 		cmd, phys_msb, phys_lsb, psp_timeout);
 
 	print_hex_dump_debug("(in):  ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     sev_cmd_buffer_len(cmd), false);
+			     buf_len, false);
 
 	iowrite32(phys_lsb, sev->io_regs + sev->vdata->cmdbuff_addr_lo_reg);
 	iowrite32(phys_msb, sev->io_regs + sev->vdata->cmdbuff_addr_hi_reg);
@@ -212,7 +217,7 @@ static int __sev_do_cmd_locked(int cmd,
 	}
 
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     sev_cmd_buffer_len(cmd), false);
+			     buf_len, false);
 
 	return ret;
 }


