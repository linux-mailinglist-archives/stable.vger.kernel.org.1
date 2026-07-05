Return-Path: <stable+bounces-271996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SEEaO3zLSWrE7AAAu9opvQ
	(envelope-from <stable+bounces-271996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 05:11:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D9708D5E
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 05:11:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HK+0vI+t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271996-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271996-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC9530107ED
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FD239E6C;
	Sun,  5 Jul 2026 03:11:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5042C9D
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221114; cv=none; b=ZA5oaKNUwdoKcyfoCyTyZudjd3bUL9oykNm3uOA+vqUvIEW+KkDC6ur9npDj6kZtdOLGhMM0IN0MB6p1wwCzMdzPhuAksZ7KVF8+FRq64wLILDIj/rYqPskWSz203AUTxVsFCC/bLp8WlDRcja3l7PMQwgfm4Wjsx6ZA/Xxq8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221114; c=relaxed/simple;
	bh=YwVUFeaWUWt2D03m+00XeK12Zvp8lLOrn1yQ+qi8Sts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyOo4RxwxIjug4rcOCpaczggG9eZ+op3Eq+uov1nmb4Pby4K5ZTRSDmlfbbBUrV/aEcuPMm0VDmqaX0DmKnXlxNwiK4TPjSIQWMzTr5zzKssU4t5Qf4RxnfpYU/kJCc+keit1FL6JMTGKuwZVwoQHpZkzmnqaY2sPgS8vApjoLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK+0vI+t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9931F000E9;
	Sun,  5 Jul 2026 03:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221113;
	bh=Ot/6N1IQgTICjy/rpnTyxdZqmRKfEncbl3pmN/BM34M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HK+0vI+t4N/gUvUS1jxS86la3iMZ9ftpThZWZQumHMtQkOwsu0QSC75/DZzAE4zT5
	 P7Xn8v8LUrW1khmCmlgR5F8Iu4Xt1umQjZa+H8L+nZn1iZQi+yPEI3JO0xaVdqG/ki
	 FAOyrLeBfnGzCQfH4hlGe02Mh2pc1a4vmQ/edHhUv6m5dVi5gHyHHFBnpgi8Lm//IV
	 +R8hbSIhctaRaE82pTqSlfYivR0CiL80/WEcEhSym2NbCdor3HqV8DUJTbq07lJgLn
	 V/qKnBkaKWTc7OyfUXZSizy3CH9KyOcieRNSxppXDX5ugISPxn1LSM8ywwF+8YBWGJ
	 QEiy8vv+MFTGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
Date: Sat,  4 Jul 2026 23:11:46 -0400
Message-ID: <20260705031150.1600970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070242-poker-barricade-3a69@gregkh>
References: <2026070242-poker-barricade-3a69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271996-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:snitzer@kernel.org,m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:anna.schumaker@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C6D9708D5E

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit a61466315d7afca032342183a57e62d5e3a3157c ]

In later a commit LOCALIO must call both nfsd_file_get and
nfsd_file_put to manage extra nfsd_file references.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: 2c6bb3c40bc2 ("NFSv4/flexfiles: reject zero filehandle version count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/localio.c          | 2 ++
 include/linux/nfslocalio.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index ce6d408598c788..f9a91cd3b5ec74 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -29,6 +29,8 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
+	.nfsd_file_get = nfsd_file_get,
+	.nfsd_file_put = nfsd_file_put,
 	.nfsd_file_file = nfsd_file_file,
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index e1b8018ba6399a..7b2a86213d9e9f 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -56,6 +56,8 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
+	struct nfsd_file *(*nfsd_file_get)(struct nfsd_file *);
+	void (*nfsd_file_put)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-- 
2.53.0


