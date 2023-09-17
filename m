Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD88E7A3791
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbjIQTWK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbjIQTVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:21:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F92CDB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:21:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34994C433CA;
        Sun, 17 Sep 2023 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978500;
        bh=RKNB913EeKKdX1GUYYjiWzUwXEMPPZSMXgTmfdhCZcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUTjAvjp3MWlgW7fIq5xgPnAO+oQfl0CLSrXxgpozEiafIgwv5UP7mkdtpUCj2jfK
         Isd3mEUqRaAHeYKo8ZJAnB5v3atnfpPOTNp/Y7gsrlVUdEm3PIUZ3pPUyOKp6DtF/l
         qeGGqL9QYclmMRAxVgJdfh8jp6mhJxJbbF9Y1sZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ani Sinha <anisinha@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/406] vmbus_testing: fix wrong python syntax for integer value comparison
Date:   Sun, 17 Sep 2023 21:08:24 +0200
Message-ID: <20230917191102.464221750@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ani Sinha <anisinha@redhat.com>

[ Upstream commit ed0cf84e9cc42e6310961c87709621f1825c2bb8 ]

It is incorrect in python to compare integer values using the "is" keyword.
The "is" keyword in python is used to compare references to two objects,
not their values. Newer version of python3 (version 3.8) throws a warning
when such incorrect comparison is made. For value comparison, "==" should
be used.

Fix this in the code and suppress the following warning:

/usr/sbin/vmbus_testing:167: SyntaxWarning: "is" with a literal. Did you mean "=="?

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20230705134408.6302-1-anisinha@redhat.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/vmbus_testing | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
index e7212903dd1d9..4467979d8f699 100755
--- a/tools/hv/vmbus_testing
+++ b/tools/hv/vmbus_testing
@@ -164,7 +164,7 @@ def recursive_file_lookup(path, file_map):
 def get_all_devices_test_status(file_map):
 
         for device in file_map:
-                if (get_test_state(locate_state(device, file_map)) is 1):
+                if (get_test_state(locate_state(device, file_map)) == 1):
                         print("Testing = ON for: {}"
                               .format(device.split("/")[5]))
                 else:
@@ -203,7 +203,7 @@ def write_test_files(path, value):
 def set_test_state(state_path, state_value, quiet):
 
         write_test_files(state_path, state_value)
-        if (get_test_state(state_path) is 1):
+        if (get_test_state(state_path) == 1):
                 if (not quiet):
                         print("Testing = ON for device: {}"
                               .format(state_path.split("/")[5]))
-- 
2.40.1



