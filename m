Return-Path: <stable+bounces-219581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMKJMkPQnmnwXQQAu9opvQ
	(envelope-from <stable+bounces-219581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:34:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C6195D0B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C20DE301DD0D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5896E392801;
	Wed, 25 Feb 2026 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="A2oChaha"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA82E2DFB
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015665; cv=none; b=MfhHuR45R+zkvzaGwDpVaJbto1G7qXccIghAlTYSin6m++Eq5Xci906XW+rwp/Ms0JVuxQ3IGO3fwN62lk6AZSFVaH+PUY7Rlr/klrqzdhyZV5CjXs1SJQx+JhKRF+XajyxWQcruAJOp8D8pcjjN4MTeCWRIHQuLfa42xl50NxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015665; c=relaxed/simple;
	bh=qmeMrTXj4r2vHASQ3+G+btmdSWn7YROfiqQnxojqecg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=H5n3tJAyKRFreEB6VYmoLaz17Cjq10lJ/5owKCPPKsle0AYTrYF36urCOT9ghbU1AKiKKbHfzvgMXghN563fyfF9ReWFYOVTPx3HzUlb60H6CvVw8BCzfC2+LL5rrVouy/1MDDC29+g1KWzv8LsTSjCk84eINXHuUhpJ7hDwybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=A2oChaha; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772015650;
	bh=ASgysYT23uDKKxCRzZ/ZIrq1QopzFWnG/53it85gHmQ=;
	h=From:To:Cc:Subject:Date;
	b=A2oChahaJ7Oj3BgSqIQUvLhHovbtI+C8/UsKw3uv5Uw5OfSyYYZYSir90BstxSMv4
	 +Q8SyyBcHTwehOG857/hNKX8U0YWU0XHLNbM2HU44A9k3XiO3ana2OE7UemZZue5AG
	 Tml8IGni9bFgSbZmZ654acKEGhfzBe5XZu4I+4XU=
Received: from ubuntu24.corp.ad.wrs.com ([120.244.194.215])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 887AA4D6; Wed, 25 Feb 2026 18:34:07 +0800
X-QQ-mid: xmsmtpt1772015647txj9fay6i
Message-ID: <tencent_C3D62F38B3307E0DE0B470350C1FCD926008@qq.com>
X-QQ-XMAILINFO: Nr8YfRCXK4tZOjDEnYkP9qmOwJ4Eq5Fwm4j9cVDllpB5SDmswvwQmd1PF9NINX
	 ANd8nPf5gnXytmGs+U0ui5OGXRZIlMhwhYn93Vz/I/gUxrKkmt+zzGbqtjWGaXlAm9GLTaimZa9h
	 KIHVYybynfjKoyUR5r5ptm2zOK04cpH5AGb2KO4XLQyEXoetWcNJmhEE/WmiSgGWm1G4Hu8gDoa5
	 X9t725fYA8mHtzDd9j8i/usCrngx4iTcWFMGr/yVgaa3iwOTDvRM5e3DIZoHIAZVSxNXIOge12fv
	 ym4JEQZnK5mgGJSyDS2L7Bj0sOfAjDSTRqo2vu7tkNhTOsajkgG7IOHHpNRigP4+cZPebOWNbdHT
	 cqeHwyRfGsC3var61k44HyCBcAtYq9V0wshqKNeVqKFH4YKTDnYRK7qjmQ5E7yzZfUKa636W900Y
	 qP8uKxKVOPgxLJDaKZgxJyL+37chY5LpEPHGnjI/YVlZpTuxRgjolKnr8wZQWP1EZ7+A3kPkPSj+
	 pZfTdXSgg5ihWeIiSbUhAyvQd5DGic4tzSpZcMaAlYY11ZTfVoqvKOjVJkAjruRgN/8LMZFP0iXn
	 l3nKTyn5qqhJCzAF/D4EJZM5ULuHGzCK/CkqT/2Qs/lHhbDBdO/D+QX8l6ggS2tCLYKBsPd1hPbM
	 uPKXzczQx24TdLpFQ1yIxCf/XDhM+XNOEkpN/7+r3eajxR0EvBtATs1xZR1ScU1TZzyvL2WDApA2
	 QES0fIjguV/zUzhKqXzsMcFDsb/h6TQpYDjBniJJLh++VUHwit/jANyurVWkqyWFP3bz9UMjVrsc
	 2zhm06zHyB/Xvcclu5Fyp9kLFmw89aIwBy3PBqibsh5xhExVrdD0+jyMFWuFf8QdiUQ27ViiKnsO
	 ilc1FioTE6WpiTiHC66813Umbzu899OLzWSF1HH6e2+Yfxign7ME1qARNrm8hhJ5pSYryR4DQxl7
	 SL/b9fssRJ4dNDrTzhMMMfRNjx87t+l5OwLyNLVgVIKNEu9jPEzkBVWY70nLeyjLQGSRdG8IzkDV
	 lImD60hvnVAPJ0zFXplwr+3Sc/VmVCRWU7Ah3tPEVumuz7RQh0BO9cvRNmTXB7LFeXMkjNjw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Alva Lan <alvalan9@foxmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] ksmbd: fix null pointer dereference error in generate_encryptionkey
Date: Wed, 25 Feb 2026 18:33:45 +0800
X-OQ-MSGID: <20260225103345.4206-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219581-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,trendmicro.com,microsoft.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,foxmail.com:email,foxmail.com:dkim,trendmicro.com:email,qq.com:mid]
X-Rspamd-Queue-Id: EF9C6195D0B
X-Rspamd-Action: no action

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 9b493ab6f35178afd8d619800df9071992f715de ]

If client send two session setups with krb5 authenticate to ksmbd,
null pointer dereference error in generate_encryptionkey could happen.
sess->Preauth_HashValue is set to NULL if session is valid.
So this patch skip generate encryption key if session is valid.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-27654
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/ksmbd/smb2pdu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5ff4c855f9c..91d1fda30fec 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1628,11 +1628,24 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	}
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
 
-	if ((conn->sign || server_conf.enforced_signing) ||
+	/*
+	 * If session state is SMB2_SESSION_VALID, We can assume
+	 * that it is reauthentication. And the user/password
+	 * has been verified, so return it here.
+	 */
+	if (sess->state == SMB2_SESSION_VALID) {
+		if (conn->binding)
+			goto binding_session;
+		return 0;
+	}
+
+	if ((rsp->SessionFlags != SMB2_SESSION_FLAG_IS_GUEST_LE &&
+	    (conn->sign || server_conf.enforced_signing)) ||
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
 		sess->sign = true;
 
-	if (smb3_encryption_negotiated(conn)) {
+	if (smb3_encryption_negotiated(conn) &&
+	    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
 		retval = conn->ops->generate_encryptionkey(conn, sess);
 		if (retval) {
 			ksmbd_debug(SMB,
@@ -1645,6 +1658,7 @@ static int krb5_authenticate(struct ksmbd_work *work,
 		sess->sign = false;
 	}
 
+binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
 		chann = lookup_chann_list(sess, conn);
 		if (!chann) {
-- 
2.43.0


