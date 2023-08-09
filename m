Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC0775D7D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHILiI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjHILiH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A62173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288B663591
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5CC433C7;
        Wed,  9 Aug 2023 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581086;
        bh=JvnTWk9xrQWaRqJBpAOwLeRFiG3PYr8DHyPS8Ozyhmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUtRIRwWGcFyJEBjaFaDrWbOow+NfVJtBjW4d5rOEA208wLj44DujZ+bgPzvI3dUK
         UVo/ECNGEXXhIpopXjOuDChdM9Jq0XbasL2/PsR98g3OGGG0IDavf/nxQuW+Q7iCin
         Lot8lMhMB12NgLDxAO9chjcv/N1n4hXl+tRY8CgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 5.10 083/201] Documentation: security-bugs.rst: clarify CVE handling
Date:   Wed,  9 Aug 2023 12:41:25 +0200
Message-ID: <20230809103646.588639981@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 3c1897ae4b6bc7cc586eda2feaa2cd68325ec29c upstream.

The kernel security team does NOT assign CVEs, so document that properly
and provide the "if you want one, ask MITRE for it" response that we
give on a weekly basis in the document, so we don't have to constantly
say it to everyone who asks.

Link: https://lore.kernel.org/r/2023063022-retouch-kerosene-7e4a@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/security-bugs.rst |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -79,13 +79,12 @@ not contribute to actually fixing any po
 CVE assignment
 --------------
 
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+The security team does not assign CVEs, nor do we require them for
+reports or fixes, as this can needlessly complicate the process and may
+delay the bug handling.  If a reporter wishes to have a CVE identifier
+assigned, they should find one by themselves, for example by contacting
+MITRE directly.  However under no circumstances will a patch inclusion
+be delayed to wait for a CVE identifier to arrive.
 
 Non-disclosure agreements
 -------------------------


