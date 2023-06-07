Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41507264FC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbjFGPqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjFGPqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 11:46:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818510D7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 08:46:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so5465132f8f.2
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686152806; x=1688744806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxS/9Ys9u2Pgq+4/hvPW/gZlE+C5ORTJ3U6KczNWt38=;
        b=VoXXsLltEs2tVYbDy5e/S61nPVXkUeWvrZInsCMiSvmTHwd31wjIH9pXsXhhXXCT7Q
         1c8Tssv0BOcCIw89OCIVmaml0ybygmE3g2C80kgmXntyEKfl+f61zrS+3Ut+/iODUXC9
         7prM1GwZKc7LIE/PRKzKJi0IsHZQdfPh8NPpS9GBR208iJrPL899OoN9QVQqvyTlOtBv
         7630VmYOAct3E76ORMlaf0v7j7ye9gDd0L4kt7L2wNepLkP/wpAvs4mZeWif/AgGTKOU
         ahxcerq/r+00xd6+NX4Vp6KhGi7j3M1KR17T2EOi6jGm3VOI1gi67aumCepP+dezo1xR
         v9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152806; x=1688744806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxS/9Ys9u2Pgq+4/hvPW/gZlE+C5ORTJ3U6KczNWt38=;
        b=ctdXByXTTi4q7kixID+RwyzbbJ8+Ub1vGfZRXyWrFetySQVqxI1bU3skNJGgVpQ8ng
         LSJb7YT4e6cyut3upPHgE+znts92z39rOWjmxlIbZ8hOs9sn2udPwxp+OUSAqkQYk4BC
         IQ5wp3OOMqkY0Psh91Lh8z45SLsS+mk7i5B3/RFuUYzXhyM1pPbTtMOQAbep4tDFGiIf
         xhDZO4ekWLmzKQTog2cpQ+z30/ALLYQrmQM9uiXL7M4TrV23LxZXDklL9XXgKOcEX9b3
         liPgHuxC4ywemLcEot2EP5D5y7PCkuZeXcJtY1PN1nhTX8Ky+aiqiawKIm9KIaG7RHJu
         1HBw==
X-Gm-Message-State: AC+VfDzBS9u6v+RjTIwncSxoIHhrI7lMWwgQLq/MX72qh8g9NWNEsI2/
        0HxorgoAxyvb8RxYox0ZTwWby/CLF2XgAPqOm8SZwA==
X-Google-Smtp-Source: ACHHUZ5Clvy4pLkoYMYfK+7KjBNoOd6vUgaNuRb5eZx7x9hhKQmyHH77Cca8IlqAyulU4XSDPcBNtg==
X-Received: by 2002:a5d:5506:0:b0:309:5122:10a3 with SMTP id b6-20020a5d5506000000b00309512210a3mr4347151wrv.48.1686152806519;
        Wed, 07 Jun 2023 08:46:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b003078681a1e8sm16095854wrb.54.2023.06.07.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:46:46 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] selftests: mptcp: diag: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 17:46:31 +0200
Message-Id: <20230607154631.2694278-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060716-speckled-duchess-40d9@gregkh>
References: <2023060716-speckled-duchess-40d9@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=G4Ht7P0rd4viicEOXfkc1mPB5WEkYPk5vLErySnS2QU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKZXg2txQpFw8EKZf3UAuXZ1ISGVd7nqus7sR
 t/VnVBiRFSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICmVwAKCRD2t4JPQmmg
 c+FjEACxFh6hF3SbjmihpzobbEid94TA76U1tjaaD4yJqRlK7809VQxGgp94hbtzXLZ/tfbhG6J
 jiM93TyyL/VNJaNHxub0BJZ7rEkL5ownCivw4IHlBcE7HfIBjB/JHC9WPrPUKwCwboSGe4M0f36
 88DJQ1GkjtubUhr0vi8IDJNFPYbSb90eykeBOm8S2WdfiY+fWlTH7ONx1/NIOXkw+JbNFIg+liF
 jLXm2eHFlVuQNbrKTX0qxiCQyX9hIXxI4CpIxYJw5sRH/RmUFixGBQguAGx7CmtOab6VdUUux6g
 aYqoxfxj9aWYFpYkRC9lG5rD3B340GspshCX+O5cTwgVlcvptMAoKeNhvkBOFuH6rXAr0cUBW/x
 jxEH+4VZwNrQ1yUUJSvDvHK9bo+6yjQ6TYu6eu0W1uhI0VPsNQSof1s+lxJt93Gd8TGrnkw83jG
 LZngSPOf5Il9zhArMAFECmrYVrMqGpCLJv1So8cJe/xfEgJUEO6rHp89NJtXeFBbC3+Ud/JAUPx
 GgzGSAAvSrTpNdXc1nadqR78SmMBaRf9p+JX5z2LkgALAURfznOaFjcLhzWd2nPFkb1aiJrJoZM
 A38LXITJ10rYQtHv4q+tLmEWjAB/dMeoakVAsY1DVjdU6dwlUQXzXXj0cdrt+ewrZjyHLdkMzp6 jZQPyeuttnaHETQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 46565acdd29facbf418a11e4a3791b3c8967308d upstream.

  Backport note: a simple conflict with 787eb1e4df93 ("selftests: mptcp:
  uniform 'rndh' variable") where a new line was added for something
  else in the same context.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 39edce4f541c..34577d469f58 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
@@ -28,6 +30,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

