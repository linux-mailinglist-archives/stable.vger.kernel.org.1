Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA576AF9D
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjHAJtS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjHAJtE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5596211E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A63E614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469C9C433C8;
        Tue,  1 Aug 2023 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883254;
        bh=FfHIKz/WQERcoj73Cjg2kDwe32ot7nbXHVZ5x3B02F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fr26t8UKdKLX94JzM5DE+raV+WX8DiiC0Q9SRMmRSuHqkiQXRV1N5YlaxirkzsJad
         BElkdYsiovA2uW7/4km+GKa0q1I7GRdVyMsuKadzP0b8oWsqlW7MAJBVcb/nZ98+tw
         qTurG8fjhKNB85cuB2gY7NpjGmxcBfMY4nU7nO/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.4 171/239] Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
Date:   Tue,  1 Aug 2023 11:20:35 +0200
Message-ID: <20230801091931.801863853@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 4fee0915e649bd0cea56dece6d96f8f4643df33c upstream.

Because the linux-distros group forces reporters to release information
about reported bugs, and they impose arbitrary deadlines in having those
bugs fixed despite not actually being kernel developers, the kernel
security team recommends not interacting with them at all as this just
causes confusion and the early-release of reported security problems.

Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/2023063020-throat-pantyhose-f110@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/security-bugs.rst |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -63,20 +63,18 @@ information submitted to the security li
 of the report are treated confidentially even after the embargo has been
 lifted, in perpetuity.
 
-Coordination
-------------
+Coordination with other groups
+------------------------------
 
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+The kernel security team strongly recommends that reporters of potential
+security issues NEVER contact the "linux-distros" mailing list until
+AFTER discussing it with the kernel security team.  Do not Cc: both
+lists at once.  You may contact the linux-distros mailing list after a
+fix has been agreed on and you fully understand the requirements that
+doing so will impose on you and the kernel community.
+
+The different lists have different goals and the linux-distros rules do
+not contribute to actually fixing any potential security problems.
 
 CVE assignment
 --------------


