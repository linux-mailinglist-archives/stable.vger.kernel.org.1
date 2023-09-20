Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7027A7CDD
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjITMFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjITMEn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:04:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E91A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:04:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCBC433C8;
        Wed, 20 Sep 2023 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211477;
        bh=XlR4UHI2YLPkdGoOXpcL2px84L4+PJ5bStd/UayL0j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S68hD56FmwBsR4xIFFl/prOls9YrBppzBzPlHtStMDrquwMoKiEBNrARrSM7g5AC6
         lWBRfpZbDa6I+3Ffc/X7w93i0oNRKkN0QHxIm2IUPbnKIq5SODoFh8AvkRkMfQovL9
         gXPB19RA4mMcy//UdOMScxF6TClUmOuLZGdTRKB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Tom Haynes <loghyr@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 072/186] NFSD: da_addr_body field missing in some GETDEVICEINFO replies
Date:   Wed, 20 Sep 2023 13:29:35 +0200
Message-ID: <20230920112839.470145600@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6372e2ee629894433fe6107d7048536a3280a284 ]

The XDR specification in RFC 8881 looks like this:

struct device_addr4 {
	layouttype4	da_layout_type;
	opaque		da_addr_body<>;
};

struct GETDEVICEINFO4resok {
	device_addr4	gdir_device_addr;
	bitmap4		gdir_notification;
};

union GETDEVICEINFO4res switch (nfsstat4 gdir_status) {
case NFS4_OK:
	GETDEVICEINFO4resok gdir_resok4;
case NFS4ERR_TOOSMALL:
	count4		gdir_mincount;
default:
	void;
};

Looking at nfsd4_encode_getdeviceinfo() ....

When the client provides a zero gd_maxcount, then the Linux NFS
server implementation encodes the da_layout_type field and then
skips the da_addr_body field completely, proceeding directly to
encode gdir_notification field.

There does not appear to be an option in the specification to skip
encoding da_addr_body. Moreover, Section 18.40.3 says:

> If the client wants to just update or turn off notifications, it
> MAY send a GETDEVICEINFO operation with gdia_maxcount set to zero.
> In that event, if the device ID is valid, the reply's da_addr_body
> field of the gdir_device_addr field will be of zero length.

Since the layout drivers are responsible for encoding the
da_addr_body field, put this fix inside the ->encode_getdeviceinfo
methods.

Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Tom Haynes <loghyr@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayoutxdr.c    |  9 +++++++++
 fs/nfsd/flexfilelayoutxdr.c |  9 +++++++++
 fs/nfsd/nfs4xdr.c           | 25 +++++++++++--------------
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 442543304930b..2455dc8be18a8 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -82,6 +82,15 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int len = sizeof(__be32), ret, i;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	p = xdr_reserve_space(xdr, len + sizeof(__be32));
 	if (!p)
 		return nfserr_resource;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index e81d2a5cf381e..bb205328e043d 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -85,6 +85,15 @@ nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int addr_len;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	/* len + padding for two strings */
 	addr_len = 16 + da->netaddr.netid_len + da->netaddr.addr_len;
 	ver_len = 20;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d34ed6575e8fb..997d3134beb32 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4091,20 +4091,17 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	*p++ = cpu_to_be32(gdev->gd_layout_type);
 
-	/* If maxcount is 0 then just update notifications */
-	if (gdev->gd_maxcount != 0) {
-		ops = nfsd4_layout_ops[gdev->gd_layout_type];
-		nfserr = ops->encode_getdeviceinfo(xdr, gdev);
-		if (nfserr) {
-			/*
-			 * We don't bother to burden the layout drivers with
-			 * enforcing gd_maxcount, just tell the client to
-			 * come back with a bigger buffer if it's not enough.
-			 */
-			if (xdr->buf->len + 4 > gdev->gd_maxcount)
-				goto toosmall;
-			return nfserr;
-		}
+	ops = nfsd4_layout_ops[gdev->gd_layout_type];
+	nfserr = ops->encode_getdeviceinfo(xdr, gdev);
+	if (nfserr) {
+		/*
+		 * We don't bother to burden the layout drivers with
+		 * enforcing gd_maxcount, just tell the client to
+		 * come back with a bigger buffer if it's not enough.
+		 */
+		if (xdr->buf->len + 4 > gdev->gd_maxcount)
+			goto toosmall;
+		return nfserr;
 	}
 
 	if (gdev->gd_notify_types) {
-- 
2.40.1



