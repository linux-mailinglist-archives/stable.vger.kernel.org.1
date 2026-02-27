Return-Path: <stable+bounces-219986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGzmCRrGoWkVwQQAu9opvQ
	(envelope-from <stable+bounces-219986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:28:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F761BACAB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC53530752E0
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35C42EECB;
	Fri, 27 Feb 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=p2p.industries header.i=@p2p.industries header.b="Xagl5VsF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AA43E4AE
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209679; cv=none; b=ovP74Ru4yLXb4TTNaQkBwNw/QRxEFRTjooSDpyott20tNSEo/lKcJqZ9ON0i7yZAvZyzw2vRwOPStrNvrRjVH04cBkfez+9WzKQ06Pibzpf4MslbZ0mAPPMY1jT+HMIVby328CUaT8tj7q9/DAdkf2HFp6PFDxP+Y4Gn2mA/Le4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209679; c=relaxed/simple;
	bh=tkupGVLWosd9h5O9WTeJtLj7xFFWbEgR/Q3ECU1nYnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbyncWiSED8R870gogqf6j8BcNYHqjaBQqEm4BMBoQiGj9dHVUDmv6RkcnSaZS2eHpTDXAfOgyPvKFjJtMal6xipKOerxHb3zAsAKD50NVaOuG/NNYdG/9sfPhIOqzx05XpNyLsc5b+0Tmr/cFT2ieW9pcOct4dKNcHNd/DP2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=p2p.industries; spf=pass smtp.mailfrom=p2p.industries; dkim=pass (2048-bit key) header.d=p2p.industries header.i=@p2p.industries header.b=Xagl5VsF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=p2p.industries
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=p2p.industries
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483a233819aso22505205e9.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p2p.industries; s=google; t=1772209675; x=1772814475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLOUNewpxFrSWUmNtLjrQOnmr3Uj3bvJ8Kyt6EDWtos=;
        b=Xagl5VsFQxbItkRnLRmXofUJp6a15z4/GMeQRcc5K2aSD7ZuvtoblLpbEE98e4OV3D
         YbPqf7gdGuo0N2uOcTtq/1zKcxumxG8w7BkctwTcDgGDgmYvaGtu1noNipPWVEAjfojt
         rORacTAWI3DrF7sGQ/zoAUmIj4WFl4re+6YTi7XXoCNqY9T2mCtD2y2zcASiJEkPRCuq
         hz4ZDJcAtOe5zU4Fs3VXb9HXcK3gYx49//8KhjkGeXNE6m5Cg92dYxYadPsjgpcR0iyS
         OqvA8KJxYMBZ1xl/39uAlABE1nXyIC5IIfKALtN2NJjMts3Pyu0Op2taMY+7SZPzhbzT
         v5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772209675; x=1772814475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLOUNewpxFrSWUmNtLjrQOnmr3Uj3bvJ8Kyt6EDWtos=;
        b=eqNDFo1WM1yRmtMWfOvTaLFk7mAGPnEMT55GDzK2waqYdeUyLPzK2UkbgaIUMMvywD
         pZQ5TZ7mQ936rgrQYGcu9tJVFIslpUozGTWLu8cZCZSslCQIMYk1PGqlzIyCYno/zeLL
         3d/Wz5Znq9KOWYOAHi042LQ+k3vfHsvyBDWlPVO1C+mfRcferUhV/m3KD53+fAFJsWom
         G/1qpmDDmdnpW7NjwxuhOajetw9GMYnxvgsuw9tJF+qnNOcQ0PVxazC0TTk85dkM0NxW
         F0NuaVETZdSZiWzuaHmc80XM1hLWjhKuQaPGf8dkhmlhKPWWLXoh1cWmb+qCjicgDFJc
         LgPw==
X-Forwarded-Encrypted: i=1; AJvYcCU6nH0569Gk9ck8lePNi8UYQgmUE+4kQllusyNdD2YYkxNi9oEfkTM/G590CW4swu5ZY/9Yr8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6LUu1C8wU+n/1P/XsYt8PiLpJi6AGLY6BvRNfbmWyJ0MYenu
	eNXUbbqEXt1jJLLSXrQhF+o1tGE0o1GGM1f36A0hjfKIL5y0TP1yCXdleH7UcJF2tzY=
X-Gm-Gg: ATEYQzysIkybo40/Jd2BG3sCT4ZANSUwKMpFtNLzwLhfBo+xPKZVafAKdV1sKI7olQf
	SH9VW2EK4wKTUrgWI9oZ4G9Q+fcYDSuRYRioviGs45mOmjutEMJ2Lu656cjs+RiO2MEWTo5OlcQ
	VtCSi2AvAn51RgBPu4t2IJ+rPDRlu21p7O0r4DWHHKp8k2c9tksqB7aIVRSib+yfZ7kt3QC1kyb
	2s24KqAakipP91+oW2pHlKmttjTyHWHHbRAm66z7H+IyzJ9ey2MIoP4WLKVIiaZDTZcLY/NiwWI
	lNyhMmkIIs7eemnTP2qeb3ElV7++GJvwfUy4OkPJ7BHtkWxmGrIAhafUxR/O/Qmj5CaIeIvyGrg
	swMyiqdZVvSgmyTq/0uL/smQ08QUCNOysy7+jlAhv5wetj8auY0lRl2DsIq2Ci5z82Latj5TwaT
	hyXukFygxxb4yw+Q==
X-Received: by 2002:a05:600c:350d:b0:483:a8e9:201b with SMTP id 5b1f17b1804b1-483c9b81265mr61099385e9.0.1772209674956;
        Fri, 27 Feb 2026 08:27:54 -0800 (PST)
Received: from nixos ([2a02:168:646f:0:b9df:9962:a75a:7bad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcd0b14sm62116515e9.27.2026.02.27.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:27:54 -0800 (PST)
From: Hannes Furmans <hannes@p2p.industries>
X-Google-Original-From: Hannes Furmans <hannes@stillwind.ai>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Metzmacher <metze@samba.org>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hannes Furmans <hannes@stillwind.ai>
Subject: [PATCH v2] io_uring/net: don't check MSG_CTRUNC for IORING_OP_RECV
Date: Fri, 27 Feb 2026 17:27:30 +0100
Message-ID: <20260227162730.79355-1-hannes@stillwind.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226220310.758404-1-hannes@stillwind.ai>
References: <20260226220310.758404-1-hannes@stillwind.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[p2p.industries,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[p2p.industries:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219986-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[p2p.industries:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@p2p.industries,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[p2p.industries:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stillwind.ai:mid,stillwind.ai:email]
X-Rspamd-Queue-Id: 67F761BACAB
X-Rspamd-Action: no action

IORING_OP_RECV sets up the msghdr with msg_control=NULL and
msg_controllen=0, as it has no cmsg support. Any socket layer that
calls put_cmsg() will find no buffer space and set MSG_CTRUNC in
msg_flags. This is expected — the caller didn't ask for control data.

However, io_recv checks:

    if ((flags & MSG_WAITALL) && (msg_flags & (MSG_TRUNC | MSG_CTRUNC)))
        req_set_fail(req);

This sets REQ_F_FAIL on a fully successful recv (ret >= min_ret) when
MSG_CTRUNC is set, which causes io_disarm_next() to cancel all linked
operations with -ECANCELED. The recv CQE shows the full requested byte
count, yet linked operations are cancelled.

This is triggered by kTLS, which calls put_cmsg(SOL_TLS,
TLS_GET_RECORD_TYPE) for every record in tls_record_content_type()
(tls_sw.c), but it affects any protocol that delivers cmsg data on
the kernel side.

The MSG_CTRUNC check was introduced by commit 0031275d119e ("io_uring:
call req_set_fail_links() on short send[msg]()/recv[msg]() with
MSG_WAITALL") whose commit message states "For IORING_OP_RECVMSG we
also check for the MSG_TRUNC and MSG_CTRUNC flags", but the code
applied the check to IORING_OP_RECV as well. MSG_CTRUNC is meaningful
for IORING_OP_RECVMSG where the user provides a cmsg buffer —
truncation there means lost metadata. It is meaningless for
IORING_OP_RECV which never provides a cmsg buffer.

Remove MSG_CTRUNC from the io_recv check. The io_recvmsg check is
left unchanged as MSG_CTRUNC is meaningful there.

Fixes: 0031275d119e ("io_uring: call req_set_fail_links() on short send[msg]()/recv[msg]() with MSG_WAITALL")
Cc: stable@vger.kernel.org
Signed-off-by: Hannes Furmans <hannes@stillwind.ai>
---
v2: v1 incorrectly guarded req_set_fail() for all done_io > 0 cases.
    Stefan Metzmacher correctly pointed out that short MSG_WAITALL
    reads should still sever the link chain.

    Root-caused via ftrace + msg_flags inspection on a real kTLS
    connection (TLS 1.3, AES-128-GCM, S3 download):

    ftrace shows io_uring_fail_link firing immediately after
    io_uring_complete with result=67108864 (full 64MB), from io-wq:

      iou-wrk-52242 io_uring_complete: req ..., result 67108864
      iou-wrk-52242 io_uring_fail_link: opcode RECV, link ...

    A debug recvmsg on the same kTLS socket shows:

      recvmsg: ret=67108864 msg_flags=0x88 (MSG_EOR | MSG_CTRUNC)

    MSG_CTRUNC is always set because kTLS calls put_cmsg() but
    IORING_OP_RECV provides no cmsg buffer.

 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 8576c6cb2236..8baaf74e8f8d 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1221,7 +1221,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
 		req_set_fail(req);
-	} else if ((flags & MSG_WAITALL) && (kmsg->msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))) {
+	} else if ((flags & MSG_WAITALL) && (kmsg->msg.msg_flags & MSG_TRUNC)) {
 out_free:
 		req_set_fail(req);
 	}
-- 
2.53.0


