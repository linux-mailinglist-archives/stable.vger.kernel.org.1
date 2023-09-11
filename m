Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273979BA65
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjIKUzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbjIKNwj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:52:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798DCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:52:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356B1C433C7;
        Mon, 11 Sep 2023 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440354;
        bh=nHk+EUNQOFA2VsrbK0Y86veDQ6rhCio99WOjcLhtcOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ZjOIjnBclEiO5x1zBXXs3K8T9b51yonfB6zmNWEbGFUZqMEPSKLzHDEE1qyBdqxX
         nrEj6kgT8uGK+FUsWIcXXoeLHILbnB3ZI+bsGdrZ/CTTAQ1jQWdT5PZRXI55wSJlU9
         sebDTCUUvLSe2kARscFf4EP+WOZUtkuxIw211XfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 032/739] selftests/resctrl: Dont leak buffer in fill_cache()
Date:   Mon, 11 Sep 2023 15:37:11 +0200
Message-ID: <20230911134651.983780164@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 2d320b1029ee7329ee0638181be967789775b962 ]

The error path in fill_cache() does return before the allocated buffer
is freed leaking the buffer.

The leak was introduced when fill_cache_read() started to return errors
in commit c7b607fa9325 ("selftests/resctrl: Fix null pointer
dereference on open failed"), before that both fill functions always
returned 0.

Move free() earlier to prevent the mem leak.

Fixes: c7b607fa9325 ("selftests/resctrl: Fix null pointer dereference on open failed")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/fill_buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 341cc93ca84c4..3b328c8448964 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -177,12 +177,13 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	else
 		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
 
+	free(startptr);
+
 	if (ret) {
 		printf("\n Error in fill cache read/write...\n");
 		return -1;
 	}
 
-	free(startptr);
 
 	return 0;
 }
-- 
2.40.1



