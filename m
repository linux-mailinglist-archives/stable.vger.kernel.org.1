Return-Path: <stable+bounces-254482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJomKlV6FmpMmwcAu9opvQ
	(envelope-from <stable+bounces-254482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:00:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CA5DF46C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195B13033D14
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589930C17B;
	Wed, 27 May 2026 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9B7p3jv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC72139C9
	for <stable@vger.kernel.org>; Wed, 27 May 2026 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857993; cv=none; b=oh+vXVb+DGAhTceR/lZQRg8H4OErsfo8SO8udJcXo++NRlSvdFPS8NjQYDM5/MYos4DnjzfagqRXf5TIYVsxgwpmPsdtaOA7xc8fo2Ewm4PWVFPXxVl9GuwOXkBYJSvYAouuztHCIRSjIPUX9w2OWXITeKnKfcJKZw3XPp0mzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857993; c=relaxed/simple;
	bh=Kju5otEf6nPTWjgWBYRNUKVfEHVQqt8XckJVxXXlHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXk8xAqOSjr3x2OS1kGsiwvxi0DIkGsrU/+rIyG11eQkXmy1D8KvG7mQlCn64LFBOSx5uUj0o5iGitoZL0sXJTSE9ZGGp6HHb41FFhfaFmp1DpC0U6mM4X6i9ccBofOVh48DZAY+w2mVmV919X0kPdEXfkmgWJhEUgwh/flWUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9B7p3jv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83f674f978fso4383720b3a.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857991; x=1780462791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXpYHFY5/4fZ9TlHgcvmSOefEwSix4sKdeWGotgPGHI=;
        b=q9B7p3jvuAaohsNnOtGdh/RFvgENmwxDN2FFGPfTXGteuBFZDs/YhnI3mVWL1DiMcm
         mrX7DK0MUrvqdikOUed444t0QCC6fOdASpDerWwiUA/B0lfB0iZSd2+gSxUGE0jQmRly
         3hVo3Ylwg1AMTMXoGVKChmVIGSMz6dw8HrM6bE4QQ0ZbWgaOnyKVSXSqpCRdgdCXrxC1
         Sbo0k1pPp75+0VpaC1ekxpe2NTk28tGIX/IQo6FQFe00xfmYPVnBBMwktPOw/PCopii2
         VB2FXSPP4EJqoXGzrlUMjyJlUOepPtnhjc0FfroiViCQd/d+BU9hxIirIPpLWXR/NFAl
         rKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857991; x=1780462791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXpYHFY5/4fZ9TlHgcvmSOefEwSix4sKdeWGotgPGHI=;
        b=CbCubiV+pFHNM5nIwPJGUo+J8mMW3XWwCzQyBBcAJOAdZkFgv3VAfr7GxMRw9oIF08
         jNt930k7NM+vQSXHp+VO24luWWEYLp6gdtd4v5kiqZeZluE7hM7nosEiGL2F/ddmlCax
         seu67QD1BGw616NinCinyLdzTq9zBlcALwMjpQmQl/xuUMiMkgaADIQ075uTeCy2bD+q
         5ptJNEQdsnABubnZSQ3kMW8TeR9ziTzCmgSQLAxuYP+hPSmNA+nG45cYkcaprj2kgXTT
         jvcqNu6mD+mAF6oEzQmCE/EqRrCvDFmmvpzSSA0MxUsh2CDvrg2nfBMh2ux2WzIIJLkH
         XuKQ==
X-Gm-Message-State: AOJu0Yx9bYhWAl7G6OTDWRl1Mj4xX2/Nw5Qa6GINuxMn8aTqNoNelY7L
	ulZV93fCck+wLZRkGLLgor/2egURujX0kXgadskyisW/7dPMpCEU+No9
X-Gm-Gg: Acq92OGhqvLVyDPQLLhPjvViyPWfEsSEp5ESN4lEVWIUf80ax3Qjlx7iuFaafqTZOJP
	VkK//hid560WxsUBATaQ2wNeYNnc1oCpt7l+43QBkreeOfqLtfBWntnmLSnimmZERkV2wLuv7gO
	hTYZEduJHZkuBvq15QRsXyhG+bu0YBH/xFDwxQwMNKIxHpzh0rJ98j6rKDwYboqiUfmjtf1Btde
	ns4yA4Ycd6vbCTKA/C6adB1T0Ssnpd23gYm3alu0dIkfvngMneipLuuKinA4tYr+W6VfdoinwlI
	GVBiI85Ax9UXjHrYgNEWwXT9rLc8SA3OLyHaGKsNba5/HHWRe7cC5sjl+WlbebQqG/Lb6Y85iG0
	z9tUQiKSGwDO+agUQ1snrDh/yKzuUxNRql4mXkUfYl/NAjOsaSeLrjromuc3YbGebdibQ1ZfdQs
	I7+Y30oxDYqpcx/pVNmtbmL8Wjdl+q9tA2AXTIAb8w6WW8FaNTBjGm30UySoARR+bBpPstlYCOX
	BT66t4Oe8FqcqoVV7ZNOq8gGvXUvXV8GN/oL027xYxlYIZ0l8yNulUsq+oBRu7VU06DYiZjgkXg
	XuDBbA59hUT2/3g=
X-Received: by 2002:a05:6a00:194f:b0:837:acd7:a78 with SMTP id d2e1a72fcca58-8415f329ac5mr19848617b3a.16.1779857991571;
        Tue, 26 May 2026 21:59:51 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb19asm930900b3a.30.2026.05.26.21.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:59:51 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/2] Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock
Date: Wed, 27 May 2026 04:59:18 +0000
Message-ID: <20260527045919.39077-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527045919.39077-1-meatuni001@gmail.com>
References: <20260527045919.39077-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 075CA5DF46C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iso_sock_close() calls iso_sock_clear_timer() before acquiring
lock_sock(sk).

iso_sock_clear_timer() reads iso_pi(sk)->conn twice without the
socket lock held:

    if (!iso_pi(sk)->conn)
        return;
    cancel_delayed_work(&iso_pi(sk)->conn->timeout_work);

Concurrently, iso_conn_del() executes under lock_sock(sk) and calls
iso_chan_del(), which sets iso_pi(sk)->conn to NULL and may result in
the final reference to the connection being dropped:

    CPU0                         CPU1
    ----                         ----
    iso_sock_clear_timer()
      if (conn != NULL) ...      lock_sock(sk)
                                   iso_chan_del()
                                   iso_pi(sk)->conn = NULL
      cancel_delayed_work(conn)  /* NULL deref or UAF */

iso_pi(sk)->conn is not stable across the unlock window, causing a
NULL pointer dereference or use-after-free.

Serialize iso_sock_clear_timer() with the socket lock by moving it
inside lock_sock()/release_sock(), matching the pattern used in
iso_conn_del() and all other call sites.

Fixes: ccf74f2390d60a2f9a75ef496d2564abb478f46a ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f03b7fa5dccc..876649556d3c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -864,8 +864,8 @@ static void __iso_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void iso_sock_close(struct sock *sk)
 {
-	iso_sock_clear_timer(sk);
 	lock_sock(sk);
+	iso_sock_clear_timer(sk);
 	__iso_sock_close(sk);
 	release_sock(sk);
 	iso_sock_kill(sk);
-- 
2.53.0


