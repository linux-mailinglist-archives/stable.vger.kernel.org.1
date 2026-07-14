Return-Path: <stable+bounces-274159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id glybH+7WVWqnuAAAu9opvQ
	(envelope-from <stable+bounces-274159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:27:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF2751786
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:27:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cMKictyh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274159-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274159-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0463C3029785
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E12D7386;
	Tue, 14 Jul 2026 06:27:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BB275B1A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010476; cv=none; b=tWk0MQjONMcvTbp2buxeKr1xTmpLIhfqprGCBEcwpPiaQTHrGtt6b6HoB/Cws1503kqSNgRbGkh9+WCtjhAS0lXAdLg6uktL5Csj5JTyaRBSy63TL/ZBVF/VyJIm3gHOOO788gXqIPPVGL48+TPy24TjZMwFXwfJKWZGj479vIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010476; c=relaxed/simple;
	bh=pJG5VHUMIbJYe94r2iWRstBlolLK9xvWO+NtoSrqI1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nePYTmE2z1seH8BKpoMT2PhEyOkqbKeiWHyQo/9NonedeHljZ7NenTN0FSdKmQvociqcAzYYplqAN8tDhqo7/4G4HWScSjGAX8Xoi04s5qmtQ3ae5WfHn/o5IszAhgvxy32e5I1nsX5+Vor2x4eqm7M1v9dwZf/DtK+6tOZCIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMKictyh; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad8076b01so46015605ad.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784010474; x=1784615274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OT3QgGn/8h7LxaasZ82I0pD7QJ8te5z8lFRU4KJ98IA=;
        b=cMKictyhaSS2nZr2O6dK+2ePshIezOFXxj8ZUyYzCyzfdoPmT4wRQ8idstQUlaaxAV
         QBt2eecU+jqYOLQgLYmUDlRPwvVi520Hs6y+8Ts2Hhy9WnCOuMxMZG8Ha594aA7vpGxT
         +9TO+OQ/YJNM83avoVfSkB0zaHmOslPA42IKwg0IGjSsT5dQaF//ukYZRViB+dkb0ziV
         M2vobNanAr8k0f4iLiKruSpiKNzo0rx/lLTary2xdqXTNdbh+NdSHXpu9vqKrbjxQ1pO
         1Oy/qHNajSE/3D9pR1Q5iRxEuaxpzbE1xO1c/rmO25rwi+eQYStiuoFHvlsUef20HiXK
         Assw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010474; x=1784615274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OT3QgGn/8h7LxaasZ82I0pD7QJ8te5z8lFRU4KJ98IA=;
        b=PYpMxLM2nxm+ogN5hdKs+P6SE0O6IbtiM/aTmD+1l/n/GpDf2nXorPYiLcXPwx1yqz
         TTF+vbLzpOAyKeXotKgyLDTqjDO2hTFS9uTVnazwhK0Bg4KpGTJDBpx0ETLG6Fumz8gE
         NLgegzp2xKhhX5xq5ry/uPbzAJCTIhmEFI4ar5IvCzZq1YqXnc+FUOtpskXnJEpC67SQ
         HAZVlTedgbalOClMYdEtZkU0gb7hC3bczxay74yhvd/ZVe5GIMYqiILTSlXLEb7NcOKr
         kVJrh73Iwfyzngnnvq4howED86l+/d6yzmT8AlbbOX4rFWyeDQgG9LQdfxRLYeRwLFl9
         yQTg==
X-Forwarded-Encrypted: i=1; AHgh+RrmJ82xeOS9CQUfc6XUpMMXcDgPEK9OplYR7/Da5dgAEZypyACNn5JJcrexwLQ+NanDNLhErk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQPbYMK7Y0LB3yavWwOAV44nBTqTl6smuwJ91jxoEOsaOA107
	UYr470sm1fWagfqSQof+ClWT2AQ+O859wO1eigBDeIj7m/f8vTmb+J3h
X-Gm-Gg: AfdE7cnxiv10kp77Q7EhQEFkNd9Ah/EAiVZkW+J+wgw4Lh4YtAXjR1hn18V75WCc5ek
	bthcNvekFL4biMfFIrFmHJzuSiZFq/dRWn4deh6R1FbuxFxLbgszmZuh8m7A4Bqx5/T9t97wS9p
	RRYs3e8jt61VzqfcNTU/cdzX9XbCETQhaJAt//DAMcnbse5h3a3JhvrRA1+bN5gcyUsg4RumPDT
	UXdHkxUkrNSBs8UeFt9NeTL/nv1m8iSKxPjodsXZmnnSdD71vCWHrLIslMG+gtv62gp+JeeOXj0
	zTtuKJiCW1xcfnHmyoQQUP86kicNNUTrvIhEgezz8SwPIN+DQuAqHvK2n80GrmivQvtYrrFEi/m
	sfnyufPYi0qrn4Ioc3wr7vb3T3SQbt4MlEjxCe7Qk9PHst0OVJu/HvRvMA1CNf031NHk9xOx4Ph
	lGwLCfmWX+CviRYflOtO8w4UWXKshZkbAbHzupeyto8X2eHjuU41U=
X-Received: by 2002:a17:903:3583:b0:2ce:b096:e50b with SMTP id d9443c01a7336-2cee9bb19c3mr21600385ad.47.1784010474102;
        Mon, 13 Jul 2026 23:27:54 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfb7aesm110798435ad.29.2026.07.13.23.27.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 23:27:53 -0700 (PDT)
From: "=?UTF-8?q?=E9=93=AD=E5=AE=A3?=" <omeux327@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E9=93=AD=E5=AE=A3?= <yangmingxuan.ymx@antgroup.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: security@kernel.org,
	HanQuan <eilaimemedsnaimel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
Date: Tue, 14 Jul 2026 14:27:40 +0800
Message-ID: <20260714062740.79126-1-yangmingxuan.ymx@antgroup.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274159-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:security@kernel.org,m:eilaimemedsnaimel@gmail.com,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[omeux327@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omeux327@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECEF2751786

From: HanQuan <eilaimemedsnaimel@gmail.com>

inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 bytes,
the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the netlink
INET_DIAG_LOCALS attribute and then only zeroes the bytes from offset 28 to
sizeof(sockaddr_storage).  The same pattern is used by
inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.

The IPv4 address-filling helpers sctp_v4_from_addr_param() and
sctp_v4_from_skb() only initialize the sockaddr_in portion (16 bytes) of the
union sctp_addr; the trailing 12 bytes (offset 16..27, the sockaddr_in6-only
region) are left uninitialized.  Those bytes are propagated verbatim through
sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=28 bytes) and then
copied straight to userspace by the diag fill functions, leaking 12 bytes of
kernel stack residue per local/peer address to any process that can issue a
SOCK_DIAG_BY_FAMILY dump for IPPROTO_SCTP.

Fix it by computing the actually-initialized length of the address from its
sa_family (struct sockaddr_in for AF_INET, the whole union otherwise) and
copying only that many bytes into an already-zeroed sockaddr_storage slot, so
the uninitialized tail is never read and never reaches userspace.

Fixes: 8f840e47f190cbe61a96945c13e9551048d42cef ("sctp: add the sctp_diag.c file")
Cc: stable@vger.kernel.org
Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
---
 net/sctp/diag.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index c2a0de2adf6f..ec12f3f03318 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -68,6 +68,7 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 					 struct list_head *address_list)
 {
 	struct sctp_sockaddr_entry *laddr;
+	size_t addr_len;
 	int addrlen = sizeof(struct sockaddr_storage);
 	int addrcnt = 0;
 	struct nlattr *attr;
@@ -85,8 +86,11 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list) {
-		memcpy(info, &laddr->a, sizeof(laddr->a));
-		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
+		addr_len = laddr->a.sa.sa_family == AF_INET ?
+			   sizeof(struct sockaddr_in) : sizeof(laddr->a);
+		memset(info, 0, addrlen);
+		memcpy(info, &laddr->a, addr_len);
+
 		info += addrlen;
 
 		if (!--addrcnt)
@@ -114,9 +118,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	list_for_each_entry(from, &asoc->peer.transport_addr_list,
 			    transports) {
-		memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
-		memset(info + sizeof(from->ipaddr), 0,
-		       addrlen - sizeof(from->ipaddr));
+		size_t addr_len = from->ipaddr.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(from->ipaddr);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &from->ipaddr, addr_len);
 		info += addrlen;
 	}
 
-- 
2.43.0


