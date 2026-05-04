Return-Path: <stable+bounces-243852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG9XG+S3+Gn1zAIAu9opvQ
	(envelope-from <stable+bounces-243852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:14:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A14C0884
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7BB303CF9F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9073DF011;
	Mon,  4 May 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUuRjf0K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23733D8114
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907463; cv=none; b=fiJ0OzWuqukXQuFcGYZ76eExogJTFRlP2lNm1sTr9rqxohnS8wBcCMx8XCPJrarRJE6FhdLXm+mhNj9cEthEOip/osSnNwUeNP/PR2Tx0HNFOeIr0+uMOgFPuJZrN2Zvh0sPh26Lkk7glDHUPAmdT+fkLajOkHeru09AJMkMd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907463; c=relaxed/simple;
	bh=epyxwrL8HrbxoCP7PkosxUpgcxoLg7mTf7gK+mD/Juw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ImNrk4iKzYyy29iKr4ipDi+n3OTub9TiqmSlF4H6uVhHMsXr7XzPQI1PJ9c6RQyosSLOXqBLTjeoYxUIbFMGPEyrINYLrFnvZLNbDJ9zduqD6YfnxARbMNBhbmK8mxwaWbc8r3TeVaxZsbvJrOJv2nXOezPf25BkxK360IRkRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUuRjf0K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891ad5c074so222335e9.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777907460; x=1778512260; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8WdMGm0rrN8quly4F4KIR+pnvKVzpSZ4Q6VY0RQAP8=;
        b=sUuRjf0KbxyJMoH2OM2N9Q4R/QlouG6oE7rFuiylsWpYGaN4B/yNMUhXxDJ892tGZj
         LlebA4LPDobWTzyWlsRs9hmRTe3QMEWoIpXnq+uPohJxO+VP6/2lF8KwUuco6Cf+yjzT
         Zrpb/K923gsaeWOPhVbuQi1cFwrF9/8KRr9GxG5dKBWok+ND3gHiH5a+m3fjvIfBnmCi
         VI0iM8spmvZH9QJN13+z04WD22tQfgHRgR42HnJY3NWT/+454VmCuxP8a37N8OoYNlm5
         P9pHGYL0fmCh2pimvVv3yoUAok4RHVY3ywVcjqgke+NGhFukmmok0dXdqL8ghmHmpxyM
         U7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907460; x=1778512260;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8WdMGm0rrN8quly4F4KIR+pnvKVzpSZ4Q6VY0RQAP8=;
        b=aBIENh1wjS3sUMeuQO6C/JrQ2nZ3ic0rUQPx55B/oyyPPLiMg8ROxAY+tv/pmahIQA
         zWhnCn/muK3bZC9LOjT58XQbWYZNpbJB1M8f0dWeSEBYvSaiOZQy7atw3D8iJ9N8eeGt
         71UQwCp5fb3nal/rhDWu/rcMkLyZcFH7i/SliNj/0oYLhgTWY1xgW3b8iiYCPO/NOzCe
         9k8o5DdOdxzuUeUM7BQoPR/sx7w/h5rmUJxOzHGgf8FTdCMOCd8N3n4h2w2azSbxA7ZH
         mkiO5TvBaPqeF8xxn9Bd6U1GwwY/d36t8kl4Cg3ESiWvViAVdpBVE+dRBmjrsC0ywx3G
         JC5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/5216J77h/JPCacQ2KF9XsLp95QvGOOzGutN5u9t2H6DkUxuK6aQIntwU2FBBr0rAJy7F6tQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSFMMAp0o78hj/lFsUfJolfNY1O7yWAslM3wqRWSSHosSaugr
	dQmVUey4TzzgcstLzKLxhDx6EXYQoOVob3pW6OH7zr2FbKVp2X4Crc+gHYj4aYdNIWJwHLXSnuv
	Ko0yN2zy/
X-Gm-Gg: AeBDieumATYBI4OBOMNc9+3VReM5vQCCWUC8oeEvexTGMi0pVsyGt2WSjNzu7vnY/Jl
	O8Ud4DMfHbX/r+KjygVmdoSlRk16Lumofhl5I9ZGQj0D8UM9kxeTD+5o+LfuipgNvUWS1Rd4Q8r
	xoSCOq9XzXCYrUTEPgsh8rMvxpw3LforjBnkOBo4XqrKIyW3yb4BViMp7rQ7D61/aascZTQMycp
	UoCRmS/gnXgvtcaNFMJRfdjSCdpJGO4wh19SOHBt4fUHw6qJ961Pjvbr7eX7wVnPZrTU+mKnIju
	m+QJeNCrvR4AjrOkFY1n/dvFnSc6BVf32dEroeONLQCIMRkdP3Mw75GuL/FpKf8c7ksNnfZqR/7
	jyWw5hQYodvwtP6d57AXT3uTdV987z89oGI+q8NfqmDq0pUhBne0ukOboPBAthgRotxQiUi9ZIw
	tXH4gYKsYS49BmvOsYPaqJbS12xrAWzIZXg2d8dPVGDhS9+5wyRWc3XBh7lIpmj27AKVTb8/k0/
	Apf5es9toQ=
X-Received: by 2002:a05:600c:6c01:b0:48a:6321:87f7 with SMTP id 5b1f17b1804b1-48a9852d32amr2442135e9.8.1777907459745;
        Mon, 04 May 2026 08:10:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ee16:7cbd:ae26:6ec9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee8751sm140677795e9.9.2026.05.04.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:10:59 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 04 May 2026 17:10:51 +0200
Subject: [PATCH] Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
X-B4-Tracking: v=1; b=H4sIAPq2+GkC/x2MQQqAIBAAvxJ7bkHLgvpKdDBdcyEy1CKI/p50n
 IGZBxJFpgRj9UCkixOHvYCsKzBe7ysh28LQiKYXnVC4bCflELJHbQwdGU/t0PGN1rVDaxarpVR
 Q8iNS0f96mt/3A1I0V0xqAAAA
X-Change-ID: 20260504-bluetooth-accept-uaf-fix-df393cbda114
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777907454; l=2723;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=epyxwrL8HrbxoCP7PkosxUpgcxoLg7mTf7gK+mD/Juw=;
 b=QoIgBmQLNzGorMBeLgzY082aDS4VEiDU46sH6OYp3kRwhxKnglkde1HyRIGwFeBEpXI50XpAF
 ueO6oxPOUaSCINSshOm9Vq2+5uvIxVsKaQXkEMkLeGnovKOkGIyW8Js
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: C79A14C0884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243852-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use lock_sock() to guard against bt_accept_poll() racing with concurrent
close(accept()), which can lead to UAF:

task 1           task 2
======           ======
                 __x64_sys_poll
                   __se_sys_poll
                     __do_sys_poll
                       do_sys_poll
                         do_poll
                           do_pollfd
                             vfs_poll
                               sock_poll
                                 bt_sock_poll
                                   bt_accept_poll
                                     [read ->accept_q next pointer]
__x64_sys_accept
  __se_sys_accept
    __do_sys_accept
      __sys_accept4
        __sys_accept4_file
          do_accept
            l2cap_sock_accept
              bt_accept_dequeue
                bt_accept_unlink
                  [removes new socket from ->accept_q]
__x64_sys_close
  __se_sys_close
    __do_sys_close
      fput_close_sync
        __fput
          sock_close
            __sock_release
              l2cap_sock_release
                l2cap_sock_kill
                  sock_put
                    sk_free
                      __sk_free
                        sk_destruct
                          __sk_destruct
                            [frees new socket]
                                     [UAF read of ->sk_state]

This UAF only leads to incorrect reads, it does not corrupt memory; it is a
fairly tight race window; I believe every race attempt requires an
incoming bluetooth connection; and the leaked data is limited.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 net/bluetooth/af_bluetooth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 33d053d63407..d24897167838 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -521,13 +521,17 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	struct bt_sock *s, *n;
 	struct sock *sk;
 
+	lock_sock(parent);
 	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
 		if (sk->sk_state == BT_CONNECTED ||
 		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
-		     sk->sk_state == BT_CONNECT2))
+		     sk->sk_state == BT_CONNECT2)) {
+			release_sock(parent);
 			return EPOLLIN | EPOLLRDNORM;
+		}
 	}
+	release_sock(parent);
 
 	return 0;
 }

---
base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
change-id: 20260504-bluetooth-accept-uaf-fix-df393cbda114

--  
Jann Horn <jannh@google.com>


