Return-Path: <stable+bounces-8797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831578204EB
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400CA282114
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03179E0;
	Sat, 30 Dec 2023 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmil2nYA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB788489;
	Sat, 30 Dec 2023 12:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B2C433C8;
	Sat, 30 Dec 2023 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937787;
	bh=UIfzTt4MHUGLq7PCIeCXpuy+d2zUI9fOnuFxct/dH8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmil2nYAFECykGFDj/InICl11kKViuebksBgZ9vh9/l0/vL9Ipz+fjJnE5qxmv+f6
	 YFREAyR9kKzH5nFVDFQ923stjIElqJhMQRAT0k+pv9lLgu9LuhzQ1EO7+/9tG0Xu3P
	 LWeCgLTd4QVzgbHgIhESyqp5H0A7fG28du/ij4cA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Suvanto <markus.suvanto@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/156] afs: Fix dynamic root lookup DNS check
Date: Sat, 30 Dec 2023 11:58:37 +0000
Message-ID: <20231230115814.405414596@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 74cef6872ceaefb5b6c5c60641371ea28702d358 ]

In the afs dynamic root directory, the ->lookup() function does a DNS check
on the cell being asked for and if the DNS upcall reports an error it will
report an error back to userspace (typically ENOENT).

However, if a failed DNS upcall returns a new-style result, it will return
a valid result, with the status field set appropriately to indicate the
type of failure - and in that case, dns_query() doesn't return an error and
we let stat() complete with no error - which can cause confusion in
userspace as subsequent calls that trigger d_automount then fail with
ENOENT.

Fix this by checking the status result from a valid dns_query() and
returning an error if it indicates a failure.

Fixes: bbb4c4323a4d ("dns: Allow the dns resolver to retrieve a server set")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Markus Suvanto <markus.suvanto@gmail.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dynroot.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index cec7d8e5ad0c9..10905a53d5b27 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -114,6 +114,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	struct afs_net *net = afs_d2net(dentry);
 	const char *name = dentry->d_name.name;
 	size_t len = dentry->d_name.len;
+	char *result = NULL;
 	int ret;
 
 	/* Names prefixed with a dot are R/W mounts. */
@@ -131,9 +132,22 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	}
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
-			NULL, NULL, false);
-	if (ret == -ENODATA || ret == -ENOKEY)
+			&result, NULL, false);
+	if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
 		ret = -ENOENT;
+	if (ret > 0 && ret >= sizeof(struct dns_server_list_v1_header)) {
+		struct dns_server_list_v1_header *v1 = (void *)result;
+
+		if (v1->hdr.zero == 0 &&
+		    v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
+		    v1->hdr.version == 1 &&
+		    (v1->status != DNS_LOOKUP_GOOD &&
+		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
+			return -ENOENT;
+
+	}
+
+	kfree(result);
 	return ret;
 }
 
-- 
2.43.0




