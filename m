Return-Path: <stable+bounces-220799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDfYAP9Xo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:02:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2C11C8B91
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC67032B1EDD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525240E94B;
	Sat, 28 Feb 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXG2digM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACE40E946;
	Sat, 28 Feb 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300684; cv=none; b=IhYkjcbylD5L9uZRCDB0gj1Jl57FE4byspENAtr/ZTuraqeZZzw82dKaJwtT+TUlhNcCOsvCwR91YM2ermj3IADsR2NZYZaze91cxa5gaXchBNRHFpm5yDvHEk4O3EbiHWWLrJPqygTFfY1Pwtu25QdBkc2rT00Q9ILg2tfSGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300684; c=relaxed/simple;
	bh=829/Owi9SM/5ByjQlN4zVXMTkXwocNKaHkz6VOhfvpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH8ynnL7HtHb/3ynH0jk8dFuIqpQBCuKG9P59fSwS2sTAJLp1HZU04iYET9jKL8xstF2C8BRwLH0J09Rfd3ad7wKYnbxuXwM0XhKQjgX10WgvIe4qrtpYj1u+cygihqJgAShghNRLWE8TIRoC8mj7+VK+xvCmqVdFdfTrMCIsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXG2digM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5ADC19423;
	Sat, 28 Feb 2026 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300683;
	bh=829/Owi9SM/5ByjQlN4zVXMTkXwocNKaHkz6VOhfvpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXG2digM8/+R178tdEn9L8/cxk932JfsZ92Du83znOahYHBrr3bhSksOHmtf1cl7X
	 UhabIOlvyAYNsEVjIVH2xITlhKOTVyUfXlLuckvrEZIQLduBXg6tfy9xxIRo3A+pJr
	 YblctWQPb0Kgsa4kn5pjz0yR/dqNzmO0Vl/c3dD2noAGYx6snFdx6s7Umtwz5mFM4h
	 /i6Qu2v1O0siETOUwkD5QKM7yBK2WiELv3F1zg5YtEWNM9VKEj+hTXfdqw+HYLf3QU
	 U1ygOO+03Z16/TQ7OWMR/VzJxARhVfyrkQSNPv/2IZXmK1OGx9vk2vMKcc9pxftRne
	 2tvq8Qpqzfp2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 720/844] ocfs2: fix reflink preserve cleanup issue
Date: Sat, 28 Feb 2026 12:30:33 -0500
Message-ID: <20260228173244.1509663-721-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,oracle.com,gmail.com,live.cn,huawei.com,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220799-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,fasheh.com:email,suse.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 4D2C11C8B91
X-Rspamd-Action: no action

From: Heming Zhao <heming.zhao@suse.com>

[ Upstream commit 5138c936c2c82c9be8883921854bc6f7e1177d8c ]

commit c06c303832ec ("ocfs2: fix xattr array entry __counted_by error")
doesn't handle all cases and the cleanup job for preserved xattr entries
still has bug:
- the 'last' pointer should be shifted by one unit after cleanup
  an array entry.
- current code logic doesn't cleanup the first entry when xh_count is 1.

Note, commit c06c303832ec is also a bug fix for 0fe9b66c65f3.

Link: https://lkml.kernel.org/r/20251210015725.8409-2-heming.zhao@suse.com
Fixes: 0fe9b66c65f3 ("ocfs2: Add preserve to reflink.")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 1b21fbc16d73a..1bff4f2d1345e 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -6394,6 +6394,10 @@ static int ocfs2_reflink_xattr_header(handle_t *handle,
 					(void *)last - (void *)xe);
 				memset(last, 0,
 				       sizeof(struct ocfs2_xattr_entry));
+				last = &new_xh->xh_entries[le16_to_cpu(new_xh->xh_count)] - 1;
+			} else {
+				memset(xe, 0, sizeof(struct ocfs2_xattr_entry));
+				last = NULL;
 			}
 
 			/*
-- 
2.51.0


