Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00494775C38
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjHILZG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjHILZF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1492ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888A263258
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979F6C433C8;
        Wed,  9 Aug 2023 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580304;
        bh=6n2+D8+2/s9dkbRo5CzbvCt3cjwJEKgjpBh1FHZhBYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1JKBRoZXh6vX+lDziz7zs0c6o/YKzp/uzyhcc3wBKMtHkJbv3/duBX0F8XFdpSD7
         rZkeYaeAzcs2H4SvQ9LJ25IHivOdBsbWRs32EZc2HUYLTkgT50GJ/wdypvtQILsBYT
         mCVwxBB+bxymEoeFulVWElmhbZUc0YMEGGBurm90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 4.19 270/323] Documentation: security-bugs.rst: clarify CVE handling
Date:   Wed,  9 Aug 2023 12:41:48 +0200
Message-ID: <20230809103710.417541025@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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
@@ -72,13 +72,12 @@ not contribute to actually fixing any po
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


