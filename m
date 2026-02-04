Return-Path: <stable+bounces-214370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQRHdHRg2nOugMAu9opvQ
	(envelope-from <stable+bounces-214370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 00:10:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1640AED2CB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 00:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1088B3014C34
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E76395D92;
	Wed,  4 Feb 2026 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dc2+0DcA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00D30BF5C
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246605; cv=none; b=ZtTsXwZNcWQcUfX9JK1sjHOpjQLgilEqNpMscdyFz5hAR3zDi0jWXbFxf85jqhhb5Y0hD9LVyQKbwP8tvnBqRaxoHHaRWuyDuFP6XV1VajusM5Fiq4VJvXGj7JdJ1PjolZjhhuZ039093X18s59xgClnYOE/vuKkJsKM5bas/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246605; c=relaxed/simple;
	bh=rImYixcrJnvPaJygPB3tSLn52Cqp/Pv1UYq8g825bEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzKxgdOCJcnQnlMBxO3AlMOEidEMkO03rfWpja6drBF0DWQxfL5ClkvbMa8i3w5DnpnzIGE0XGMTQbvAdAjXNWSOrs07aIB+KWMLJAP9WTcqyqLM/sGaUYJ4FuzpwZUpB46EBGThkFxuZR0uYsUXVenlK5pTc7Qpyrp4lt1dc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dc2+0DcA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so2403565e9.3
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 15:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770246603; x=1770851403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFp8KGfgyMquCSctoZKejUeMlDxZtbunAgT7dT1mhuE=;
        b=dc2+0DcAGmBZSacQOH0OCansGVkSj65K31YU3rdTjoroMkdLkClQ6h0pvoXiTjhEDZ
         QpTQqsyW4jEZcmwCQ8j20vmrp/jJJngCwoUCC/NS3xhxKRxbvjwi8uhNkIZj5p3RFDlY
         eM22sqnUprgg1/aukr+XYmqe6ai2/grDzmXhMSMqPNxXog5Ro9pQPXK/lNjS5uOm4R+D
         mA7HkN6CQaCb41UVrRRhNAuArpfqGy8Ao+vUdfkHsYxE0OTKJTXl521bG9wT/V4kzhtT
         s61BRgA/TBYVHTanypBrOee6s9/KoJ0aAAqF0OFmMfxn/USrZ/kjdtw1TsMlFeZ2gxSF
         p9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770246603; x=1770851403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFp8KGfgyMquCSctoZKejUeMlDxZtbunAgT7dT1mhuE=;
        b=YmFrASu9VcNHI7HwNjdzxrWomSa/6IGbBVZ5Si0Tk5p0ie97dX+vk0KEO5c91asAEe
         VjAeHaACtb0yGc+M4aAXV6Yi6dgwcSJlEqO3D+gKIOqCNGp6BuwfoUy8vv5JWV4d/FDz
         6OKj/zQ/Y5ccw2AKeIWMEAzgguX2p8q3JZ6exrjilLxT6ofdusAekO7IJ85demXvI0p+
         BV0zVL7VyTYlBAsBY97F2uK4N5FWRKolUR7q2s9sqg0oEceudS7PtS2ja7A7boN4GCjQ
         PDm6RXN2CjlWculFEoyeos/csXTlXWAFi3yQmU7vEAtwR88M4+Ndo2goBTpSHp04W/a4
         9ShA==
X-Forwarded-Encrypted: i=1; AJvYcCWFzpYgf5b317qYQX6JmOwsN0m0KjCoqG3bW4qAwzN9PX4Y1fQIUS01L4PKGl9vkHkHyf9KmFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5bDr4X+2cqAMuMdIkNGu3+MSZmnfPPi3UxeTEHKHPn45v6eb
	Uf53eZNMl2SLw4QaNoDBbVUr9B1GoNuvGKiVjduekZ+qyXm3ecIb5tqVMFaHXdGc14s=
X-Gm-Gg: AZuq6aJgDBI2xDxA+b1LPvSkE0MNcdRcvRaDal8kJa9ChvHvb8Z4C0L2FMVx1GPwDZN
	jo0Mh0KbsWgqcZKkupIMbnY44vnytHgJ7X3qGEL5HiPpyW31O+bGfb2b0MR/RSd9FdyRPV2XsKe
	GAeb6VFzbdmhE6eQNkSSZMZzTZ77ybnNtU8wwG4vOJ2FAR9X2IOxqAbuq4onvKNnAiVmuuAdJsC
	FpPx1Y5rD1oqd69Eww5/6NPAUPGztxiciycpQuyBzVS9ORnY0HD6NM+HMkEwRFuZBD2IWrCJgK6
	px3et8/L2CuRVOtf0IQo2mxfcNMtqDoEQ7x8MDyZoGx+0DVIrqgJIJpmixw/IwwxazOB/IcId9Y
	vXVywjAjpPnHrOyW3UOVVJvH/9J3KKMg++FODo8luWhnDo1qzGigRV8sKVv39gHH5dXmqWZsQlr
	aJnKON0+NUBGkJ8O4Pq5LHf3ys+uWT8g==
X-Received: by 2002:a05:600c:8b8a:b0:47d:6140:3284 with SMTP id 5b1f17b1804b1-4830e99572dmr57949495e9.37.1770246602933;
        Wed, 04 Feb 2026 15:10:02 -0800 (PST)
Received: from precision ([2804:7f0:6401:4338:fe12:6a4e:72af:4ca4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa9f5c6sm285008685a.23.2026.02.04.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 15:10:01 -0800 (PST)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: linkinjeon@kernel.org,
	smfrench@gmail.com
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()
Date: Wed,  4 Feb 2026 20:06:43 -0300
Message-ID: <20260204230643.387345-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214370-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1640AED2CB
X-Rspamd-Action: no action

On kthread_run() failure in ksmbd_tcp_new_connection(), the transport is
freed via free_transport(), which does not decrement active_num_conn,
leaking this counter.

Replace free_transport() with ksmbd_tcp_disconnect().

Fixes: 0d0d4680db22e ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/server/transport_tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 4bb07937d7efe..2436dabada957 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -40,6 +40,7 @@ static const struct ksmbd_transport_ops ksmbd_tcp_transport_ops;
 
 static void tcp_stop_kthread(struct task_struct *kthread);
 static struct interface *alloc_iface(char *ifname);
+static void ksmbd_tcp_disconnect(struct ksmbd_transport *t);
 
 #define KSMBD_TRANS(t)	(&(t)->transport)
 #define TCP_TRANS(t)	((struct tcp_transport *)container_of(t, \
@@ -202,7 +203,7 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
 		rc = PTR_ERR(handler);
-		free_transport(t);
+		ksmbd_tcp_disconnect(KSMBD_TRANS(t));
 	}
 	return rc;
 }
-- 
2.52.0


