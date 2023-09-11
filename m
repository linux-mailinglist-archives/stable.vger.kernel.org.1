Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B179B9B6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjIKVt2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbjIKO0X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE4F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E8EC433C8;
        Mon, 11 Sep 2023 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442379;
        bh=Mqd2Ec+DWA03tfKDxz7/EQRyfZYH7mzq62cH313DWyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fgnd8l/oT0gSU9klClR4fGSvWYZNx0KsqHLz9OUArr0aA7QLXRV8GD3/54DTvTAu7
         jYjk5EQ75jAylpyqutdbu8jmU6Boc9McJ2s0zDr0klAj8EPtk1xy3IMJymEO7KQQZK
         P5Uz6SnvhA09fFY1KAU2UmPOBFDLgyNvLec7R9mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 734/739] selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Mon, 11 Sep 2023 15:48:53 +0200
Message-ID: <20230911134711.561101713@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Xu <jeffxu@google.com>

[ Upstream commit badbbcd76545c58eff64bb1548f7f834a30dc52a ]

Add selftest for sysctl vm.memfd_noexec is 2
(MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED)

memfd_create(.., MFD_EXEC) should fail in this case.

Link: https://lkml.kernel.org/r/20230705063315.3680666-3-jeffxu@google.com
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Closes: https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Signed-off-by: Jeff Xu <jeffxu@google.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 202e14222fad ("memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 7fc5d7c3bd65b..8eb49204f9eac 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1147,6 +1147,11 @@ static void test_sysctl_child(void)
 	sysctl_assert_write("2");
 	mfd_fail_new("kern_memfd_sysctl_2",
 		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
+		MFD_CLOEXEC | MFD_EXEC);
+	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	close(fd);
+
 	sysctl_fail_write("0");
 	sysctl_fail_write("1");
 }
-- 
2.40.1



