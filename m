Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224777BDE46
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376732AbjJINRu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376997AbjJINRu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:17:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE555B4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:17:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353F9C433C7;
        Mon,  9 Oct 2023 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857468;
        bh=BYbLfJfa9JcPgIWdUiuNEPGv5l6J7omBo8RetnhpkxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGZMiHxJNRmjELdDj1Vjl/woeo/HjNtVnf6CELxiiGKoKpu1BeZDV/vg5EfX6t3cT
         bbRQRyys5Z6YQkYLCoYwK8nzFtap15KNR5ai9D1nDAdICJ6Xj0So8eq71W74yAcm7Z
         X9zGWSGWOBnJGjJTf71Gaw0nnVB8tnNtDGvOn9v4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 056/162] vringh: dont use vringh_kiov_advance() in vringh_iov_xfer()
Date:   Mon,  9 Oct 2023 15:00:37 +0200
Message-ID: <20231009130124.480686451@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Garzarella <sgarzare@redhat.com>

commit 7aed44babc7f97e82b38e9a68515e699692cc100 upstream.

In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
the `iov` has 0 lenght.
In this case, we should skip the iov and go to the next one.
But calling vringh_kiov_advance() with 0 lenght does not cause the
advancement, since it returns immediately if asked to advance by 0 bytes.

Let's restore the code that was there before commit b8c06ad4d67d
("vringh: implement vringh_kiov_advance()"), avoiding using
vringh_kiov_advance().

Fixes: b8c06ad4d67d ("vringh: implement vringh_kiov_advance()")
Cc: stable@vger.kernel.org
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vringh.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -123,8 +123,18 @@ static inline ssize_t vringh_iov_xfer(st
 		done += partlen;
 		len -= partlen;
 		ptr += partlen;
+		iov->consumed += partlen;
+		iov->iov[iov->i].iov_len -= partlen;
+		iov->iov[iov->i].iov_base += partlen;
 
-		vringh_kiov_advance(iov, partlen);
+		if (!iov->iov[iov->i].iov_len) {
+			/* Fix up old iov element then increment. */
+			iov->iov[iov->i].iov_len = iov->consumed;
+			iov->iov[iov->i].iov_base -= iov->consumed;
+
+			iov->consumed = 0;
+			iov->i++;
+		}
 	}
 	return done;
 }


