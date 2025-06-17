Return-Path: <stable+bounces-154569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8EADDC29
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB77AD523
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5125487E;
	Tue, 17 Jun 2025 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj5Yopsz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526F2571DD
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188090; cv=none; b=h1me8U8EG+czTJ7R+sQp1LNoEn2gMaaHVx1ujqKO36zThJMQajLX3AKeTNgE1YaXDSejzbWtrnmegFf3CicjzW0ljf7ReWO8YV4WYIooWYLvwEhoFKve9ujXzXM6X4SJxTsxc4I4BFHIySrs6QAxFH0vnQpGyYvWLf7VG52zG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188090; c=relaxed/simple;
	bh=OaZBS/9tk5XN1LcJfFla9cInKYs6BRojb9KDuxgpcm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qp6usawcXR7w1tx/DJMYlRsBU+BTkXTKuLwjJMZk1MwnhiIfsuZKkeoPcFDJ+Eph7hqH5eDT7O8DYJpVIUsrsROohXjao4zQOrDn7RMITIXpEO7FuHoEy4SryDJWygkhKKYQG2gonA+/eN4SMLsiLNUUZR37CTAkJ3OLleGNcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj5Yopsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30F9C4CEE3;
	Tue, 17 Jun 2025 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750188090;
	bh=OaZBS/9tk5XN1LcJfFla9cInKYs6BRojb9KDuxgpcm8=;
	h=From:Date:Subject:To:Cc:From;
	b=Cj5YopszKcgOHKO+Y245q5NnPp7alONk9bOq1YqITr9yL8p6Xw58SXNBCRzVUgkQc
	 5+A0MVhoYIJHb8syFAxFSdrXlZjjTEIF39YNUHFKXl1S2GTCe3IS7uKoUkXxRBjmWB
	 0myYJU0OCyijb/xWS3j96QXd0pXNyaxwlMxGNf0h+/1Y+CX1l3ZIA3OcoYr/pufSsS
	 SEhXpHgh/e6QQNB3YsLoObj30EjPMUNlWZU91vispd8TpfbOPea8YHB7s/EDsBgAwl
	 jp+4tNK4mxdVMzI74LgVBbLmGRSW1PK2XcQWu7iawe57wOJIBrlJELQ7VQVaXxqnns
	 i7G36fq0i3CRQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 17 Jun 2025 15:21:13 -0400
Subject: [PATCH v2] sunrpc: handle SVC_GARBAGE during svc auth processing
 as auth error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-rpc-6-16-v2-1-9447e6bf8124@kernel.org>
X-B4-Tracking: v=1; b=H4sIACjAUWgC/23MQQrCMBCF4auUWTuSiTWxrryHdBHTsQ1KWiYSl
 JK7G7t2+T8e3wqJJXCCc7OCcA4pzLGG3jXgJxdHxjDUBq30URmyKItHg2TQe+v0gTvfGYJ6X4T
 v4b1R1772FNJrls8mZ/qtf5BMSKio5fZ2GhyxvTxYIj/3s4zQl1K+TTelEqEAAAA=
X-Change-ID: 20250617-rpc-6-16-cc7a23e9c961
To: Chuck Lever <chuck.lever@oracle.com>
Cc: tianshuo han <hantianshuo233@gmail.com>, 
 Linus Torvalds <torvalds@linuxfoundation.org>, security@kernel.org, 
 yuxuanzhe@outlook.com, Jiri Slaby <jirislaby@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OaZBS/9tk5XN1LcJfFla9cInKYs6BRojb9KDuxgpcm8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUcAzqZm9rqnopvh7g9gYV69M2rY3GAZZKu4BV
 TQeK4QzxyWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFHAMwAKCRAADmhBGVaC
 FUUOD/0R0enZUIhfao2wealwRYs0I3nx5pbQ3GQY8gRpsS6vhUqsUQVrbNmprAs8Pa/vcdXtlFk
 vl4wlqvyerZEJBd5UWTg8nJZ7OgbKf3MYorh5FPaXtbZjVfnx+JRw/+g4DzhEum9d0lS3tN+pJM
 ozkEXYcfb+czTvsx7YOvbIcA6NtHauXajzt9H5LoQKHT91b72viTTjYqkVSRLjrYHDoZiKXCB8a
 81MHvBkgzH8s2R02eXBib2Puy3xcpVgFXEixpdceDzixqPa7Wv/OCsAuLt+QgqzXdJ9v3EE00d6
 lUQdKBh4Q3acJN1X7hpmigjV/dg5+tyKqI4/IG9iMo89zA/DDvOUL2oSVF879b1sUQeRFNq+LN5
 /NimIzvreKpJEfoltXfjGmuLyJq2RqscotBoPEHlLawhpFz12Da/QCcaewA6ekFl6CPTehHT6Gp
 umIOePZx55/H0iLZs/s818U8FDWXvqD5a3L7RyepDFXoXnc0855u1lnRdsxe9kMfe9ZpASOTqrH
 IloiW6Ci+WKn31+B6Bp5kIvuMIzSibQdi7/JKTRedLmRReQ4WsLaGFB4iDOUjpyI6z9mhP7gHav
 QCd67eky9SPmCsNVezVD6wjJL/yFNnj7Er+wp1hpV9ceSb4+dG2qbnVgYLbrQcGRlzW0Gxi1lCv
 WPbJ0bhcdWEhmFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

tianshuo han reported a remotely-triggerable crash if the client sends a
kernel RPC server a specially crafted packet. If decoding the RPC reply
fails in such a way that SVC_GARBAGE is returned without setting the
rq_accept_statp pointer, then that pointer can be dereferenced and a
value stored there.

If it's the first time the thread has processed an RPC, then that
pointer will be set to NULL and the kernel will crash. In other cases,
it could create a memory scribble.

The server sunrpc code treats a SVC_GARBAGE return from svc_authenticate
or pg_authenticate as if it should send a GARBAGE_ARGS reply. RFC 5531
says that if authentication fails that the RPC should be rejected
instead with a status of AUTH_ERR.

Handle a SVC_GARBAGE return as an AUTH_ERROR, with a reason of
AUTH_BADCRED instead of returning GARBAGE_ARGS in that case. This
sidesteps the whole problem of touching the rpc_accept_statp pointer in
this situation and avoids the crash.

Cc: stable@vger.kernel.org # v6.9+
Fixes: 29cd2927fb91 ("SUNRPC: Fix encoding of accepted but unsuccessful RPC replies")
Reported-by: tianshuo han <hantianshuo233@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This should be more correct. Unfortunately, I don't know of any
testcases for low-level RPC error handling. That seems like something
that would be nice to do with pynfs or similar though.
---
Changes in v2:
- Fix endianness of rq_accept_statp assignment
- Better describe the way the crash happens and how this fixes it
- point Fixes: tag at correct patch
- add Cc: stable tag
---
 net/sunrpc/svc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 939b6239df8ab6229ce34836d77d3a6b983fbbb7..99050ab1435148ac5d52b697ab1a771b9e948143 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1375,7 +1375,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	case SVC_OK:
 		break;
 	case SVC_GARBAGE:
-		goto err_garbage_args;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		goto err_bad_auth;
 	case SVC_SYSERR:
 		goto err_system_err;
 	case SVC_DENIED:
@@ -1516,14 +1517,6 @@ svc_process_common(struct svc_rqst *rqstp)
 	*rqstp->rq_accept_statp = rpc_proc_unavail;
 	goto sendit;
 
-err_garbage_args:
-	svc_printk(rqstp, "failed to decode RPC header\n");
-
-	if (serv->sv_stats)
-		serv->sv_stats->rpcbadfmt++;
-	*rqstp->rq_accept_statp = rpc_garbage_args;
-	goto sendit;
-
 err_system_err:
 	if (serv->sv_stats)
 		serv->sv_stats->rpcbadfmt++;

---
base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
change-id: 20250617-rpc-6-16-cc7a23e9c961

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


