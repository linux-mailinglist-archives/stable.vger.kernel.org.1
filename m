Return-Path: <stable+bounces-229376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eES7D89fwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F692F6CD3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C087C30157DC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453D3BE625;
	Mon, 23 Mar 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L03J47p8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459233B8933;
	Mon, 23 Mar 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278921; cv=none; b=U42f8XjZV55ub/z8Nta3rPtC+LM17iRfsQIZ0Fnlz7M9dvaCwcMB/4kPb4S4Y3Fto52m0T4tCiSThCFBBTuVVx/nqaHzBYa4LItS/LcTQY0sPYoohPvExATS2PPyRSXWzWCeFUf1U+JaN0wKpV3L84PRal1qjQB7SzoD798NnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278921; c=relaxed/simple;
	bh=IcVKYIqk83fGYz7Tfeg41olf8Obf1xkORYMadpAMdno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CacEwBAk4I0NIRkf9qfmAENcGzAju/A2u9hbk7iEsMYUeVqKX7IYYtcpn/g3/yYXa3Hxw/iFWPKl/0KHVzBtlp/mA2bfloXaaptDLePb+VAVC57vCQjycCGtiJCTQLiZf3HXlTb48J6kEn86gFm+HECSVpNE/CcwhY3lSNHtOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L03J47p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FBFC2BCB1;
	Mon, 23 Mar 2026 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278920;
	bh=IcVKYIqk83fGYz7Tfeg41olf8Obf1xkORYMadpAMdno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L03J47p8PfKfpEO6Qzs9UJWkSv5g1KjcflsvY+hKkJ9wTPSmjQZ//1CA6x6545Xpl
	 jxUd86X7U3OJbhmZ+2uc34UF6Sh0RZiqKuYZtUAgFIaXbpVi1WLvI07mUxE0vAKQTp
	 e+N6kXP29eGgMqr1O1D8RD6lC/fOYcDCmXNLrz4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chen Yu <xnguchen@sina.cn>
Subject: [PATCH 6.6 419/567] iomap: allocate s_dio_done_wq for async reads as well
Date: Mon, 23 Mar 2026 14:45:39 +0100
Message-ID: <20260323134544.255084351@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,lst.de,redhat.com,kernel.org,sina.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229376-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,a2b9a4ed0d61b1efb3f5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 31F692F6CD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 7fd8720dff2d9c70cf5a1a13b7513af01952ec02 upstream.

Since commit 222f2c7c6d14 ("iomap: always run error completions in user
context"), read error completions are deferred to s_dio_done_wq.  This
means the workqueue also needs to be allocated for async reads.

Fixes: 222f2c7c6d14 ("iomap: always run error completions in user context")
Reported-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20251124140013.902853-1-hch@lst.de
Tested-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Chen Yu <xnguchen@sina.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/iomap/direct-io.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -659,12 +659,12 @@ __iomap_dio_rw(struct kiocb *iocb, struc
 			}
 			goto out_free_dio;
 		}
+	}
 
-		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
-			ret = sb_init_dio_done_wq(inode->i_sb);
-			if (ret < 0)
-				goto out_free_dio;
-		}
+	if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
+		ret = sb_init_dio_done_wq(inode->i_sb);
+		if (ret < 0)
+			goto out_free_dio;
 	}
 
 	inode_dio_begin(inode);



