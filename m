Return-Path: <stable+bounces-222537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJB4Ee9BpWkg7AUAu9opvQ
	(envelope-from <stable+bounces-222537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:53:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93721D42DA
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774CE302593C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 07:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599038734A;
	Mon,  2 Mar 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="hnXKXtcZ"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68907212B0A
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437981; cv=none; b=h/onKjZi+Ifst4awykZl7zaygtto5r41vDOFFKsYj/GJutPdrcyFznDwbYi0ah7hwZNgIVC9vZgFSYPQ5ksIkSLaYP1OQs9YcKOJ7gIfyH6SwEeB4hk7rGApxnfIHDUb/sLLnNc2OmuDWb3IKljqB2TdBFOSKgVBE1n9/GUizZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437981; c=relaxed/simple;
	bh=kC3A7HzN+PMcHGoE+LTgMyFQ+mzNGFH602zRP6e7P4A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E4vlwhXdtgiZHyTLG8yQhsL8TJOBgjcJCeT1H8J8kPr/VeRA1bnWX2MLY7GNtizdUE8oDA+IVb0tDzQBeYTE/eLRNM0gUcl9iCqakY/WWozbSwo3nBlqCBFLzEVmsbRDuII+paryrg9001+tZtmQGC6xjVVM+hgoxLu/4bEg6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=hnXKXtcZ; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=hnXKXtcZis0R8gu5nI+7VGjOIt906Ei1Ko1thQLAQhoJKEIUdSSiOy1et3VJMW9r8lbXXiLyMf8Nj
	 O/3P7UN5h2k+dGZFU1yt3Jc9NUiGygWJVqChwKQxamnq7NFOTPS6wYiWLS0RxvVGDqTKvGMqizXVMH
	 YpbO8jnuAjhC9ld4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[106.121.166.171])
	by rmsmtp-lg-appmail-18-12021 (RichMail) with SMTP id 2ef569a541ceac7-8f859;
	Mon, 02 Mar 2026 15:52:49 +0800 (CST)
X-RM-TRANSID:2ef569a541ceac7-8f859
From: Leon Chen <leonchen.oss@139.com>
To: seanheelan@gmail.com,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] ksmbd: Fix dangling pointer in krb_authenticate
Date: Mon,  2 Mar 2026 15:52:47 +0800
Message-Id: <20260302075247.3519-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222537-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,microsoft.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E93721D42DA
X-Rspamd-Action: no action

From: Sean Heelan <seanheelan@gmail.com>

[ Upstream commit 1e440d5b25b7efccb3defe542a73c51005799a5f ]

krb_authenticate frees sess->user and does not set the pointer
to NULL. It calls ksmbd_krb5_authenticate to reinitialise
sess->user but that function may return without doing so. If
that happens then smb2_sess_setup, which calls krb_authenticate,
will be accessing free'd memory when it later uses sess->user.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Heelan <seanheelan@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 fs/ksmbd/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5ff4c855f9c..f40f065c2a4f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1617,8 +1617,10 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	if (prev_sess_id && prev_sess_id != sess->id)
 		destroy_previous_session(conn, sess->user, prev_sess_id);
 
-	if (sess->state == SMB2_SESSION_VALID)
+	if (sess->state == SMB2_SESSION_VALID) {
 		ksmbd_free_user(sess->user);
+		sess->user = NULL;
+	}
 
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
 					 out_blob, &out_len);
-- 
2.35.3



