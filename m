Return-Path: <stable+bounces-211267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ/xHLhzcmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:00:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6E6CD26
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F633310CDAE
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B34378D9F;
	Thu, 22 Jan 2026 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="KA/yPfd9"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B038A704;
	Thu, 22 Jan 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102252; cv=none; b=bkfBaqCnZrDXM7lmYmlQA1aGwVwRct2uk/Y5fmiqXlqPC2JWH9SCHZJ0xqWl8TFKyzH6tJpjsay1Gn5wOiWFGKRcHE42u+iqWo+6M942DugOJ54bEsY3ZFs+vSx+mJwp9xg+1666bHSy5IqQ49jXKJ5oFPfh4XKo+BUWp8eNQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102252; c=relaxed/simple;
	bh=wHrHAh9qAYZKlLsJaVkNP46Ozl070JWNB04EUoTPRhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbA+jk6IsjRIarpC9QAmLBpZkgVYEm24RWerunhZB8ijUdAktxJya8Xky9F3j2v1DW3275YfrHzInjM0koXFr/X4w1zd1ux2J/xtsJwfEol3pnWJVqZSL/8Z/HVrZozN0WEgD3RkR81LU7wU9jQVZX/7dcGAsgIWfWR7Ybb5/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=KA/yPfd9; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=v4W3CyHbe9Vycjmp+cFUJEqqnnmW3pjhgP12dine9WY=; b=KA/yPfd90+J9ckBkW9un96sSqh
	X2DSUQ474p6vBoGa5Ec96SEtBzUZ+vs+5r53LDbaO2Dq2LtnJqQJXVTqBvSvRqPMVnysjhEYm4OdJ
	Yf54y1MefYgCFf4v58kHWAeap5mE9jRMrczbBM6ZtaksDizjjI+Nb8HxKrOzfPKLuJceI80iVHk9o
	6X6mgz1vQGCVWrFf+5tK6rtpxll5y6Ar0+BxAYnJcnliPML1kUwuT+jmbCGSkzd+rrNNs+6WlE0EV
	uL8hIHpssvtkEpIl88WOBNPNmCoe5UFgIn3Z90BV0n2C0BRrtAL+qfjywS0tk5lX/XJ+nmlGIbrC6
	8PMAZVTD2W1n7zdxg5WEsLOwzuKZP7ZDxZF0/SRLGd1yI7R7iruhqeovmR1gMayD/JGidTI36ML/W
	55/wR6HtCDRR//2qNuf8GfI/Tu4TxVrHvLQPvkeLQECTkiiimNirEENH94mCtKAk0e01A2CADmEm2
	YVbvQFXBbsQDUgeB08SHijLN;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1viyJ2-00000001pkE-2cAb;
	Thu, 22 Jan 2026 17:17:16 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 01/20] smb: smbdirect: introduce smbdirect_socket.recv_io.credits.available
Date: Thu, 22 Jan 2026 18:16:41 +0100
Message-ID: <3f2675c368391b2cb0de67670e24031b3bcf2714.1769101771.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769101771.git.metze@samba.org>
References: <cover.1769101771.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-211267-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.928];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,talpey.com:email,samba.org:email,samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: 4EB6E6CD26
X-Rspamd-Action: add header
X-Spam: Yes

The logic off managing recv credits by counting posted recv_io and
granted credits is racy.

That's because the peer might already consumed a credit,
but between receiving the incoming recv at the hardware
and processing the completion in the 'recv_done' functions
we likely have a window where we grant credits, which
don't really exist.

So we better have a decicated counter for the
available credits, which will be incremented
when we posted new recv buffers and drained when
we grant the credits to the peer.

Fixes: 5fb9b459b368 ("smb: client: count the number of posted recv_io messages in order to calculated credits")
Fixes: 89b021a72663 ("smb: server: manage recv credits by counting posted recv_io and granted credits")
Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/common/smbdirect/smbdirect_socket.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/common/smbdirect/smbdirect_socket.h b/fs/smb/common/smbdirect/smbdirect_socket.h
index ee4c2726771a..403a8b2cd30e 100644
--- a/fs/smb/common/smbdirect/smbdirect_socket.h
+++ b/fs/smb/common/smbdirect/smbdirect_socket.h
@@ -239,6 +239,7 @@ struct smbdirect_socket {
 		 */
 		struct {
 			u16 target;
+			atomic_t available;
 			atomic_t count;
 		} credits;
 
@@ -387,6 +388,7 @@ static __always_inline void smbdirect_socket_init(struct smbdirect_socket *sc)
 	INIT_WORK(&sc->recv_io.posted.refill_work, __smbdirect_socket_disabled_work);
 	disable_work_sync(&sc->recv_io.posted.refill_work);
 
+	atomic_set(&sc->recv_io.credits.available, 0);
 	atomic_set(&sc->recv_io.credits.count, 0);
 
 	INIT_LIST_HEAD(&sc->recv_io.reassembly.list);
-- 
2.43.0


