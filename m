Return-Path: <stable+bounces-37699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A589C60A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1431C23996
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CB80604;
	Mon,  8 Apr 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QgU2dWR3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99680045;
	Mon,  8 Apr 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585002; cv=none; b=FlBgZzfLT5O49WT/am+fQ112Mp8FYuotH3G+SB5XvWgmekCkwGT4cHwZwBDSvqxs6gR7E+vBvkjvorWLcKl5JWGETODXI+2mflyZapb+DJiBL3Jwv5yt3ALBr+WQPItn81JCpWeoxnOkgnyrw2Y59StpdNEluVB6lRX981l6Gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585002; c=relaxed/simple;
	bh=Youz7XcCmZoP2GCRjumSyhA1GiHfWM7HxlsmCrAuC48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxVuUa5ZRnbC3/zKbt+IXQv8KRI56O43oL9+jsLOzT+l7oMMRhMEvUijwCNbEC0g+zfTxAkE5VT02NAFJTfhsFeEdTBIU75ZC9ZK+67LrtZvpQhO2dhLO3lgeeLLRGKqwyqjVmG8fGKfQBn12uBnWDJSD31aJofX1VPExJoRWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QgU2dWR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF441C433A6;
	Mon,  8 Apr 2024 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712585002;
	bh=Youz7XcCmZoP2GCRjumSyhA1GiHfWM7HxlsmCrAuC48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgU2dWR3jasQ59hjmSefQEjZUJvvQr+4G5dD2hSjfqKTWcNEP03NJPk9Dd1/u0s/c
	 AAJNoNlxwKlPiT3KVB+ztZRjZqeDRdvEAiTnXAF91ROy1nWeFIFKIvCPYhb6RBcohI
	 QwIesm7/ENHyreoGG5Vc1LTuChLgx0A1npQyiJW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 630/690] io_uring: ensure 0 is returned on file registration success
Date: Mon,  8 Apr 2024 14:58:16 +0200
Message-ID: <20240408125422.483370130@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

A previous backport mistakenly removed code that cleared 'ret' to zero,
as the SCM logging was performed. Fix up the return value so we don't
return an errant error on fixed file registration.

Fixes: d909d381c315 ("io_uring: drop any code related to SCM_RIGHTS")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -8422,7 +8422,7 @@ static int io_sqe_files_register(struct
 	}
 
 	io_rsrc_node_switch(ctx, NULL);
-	return ret;
+	return 0;
 out_fput:
 	for (i = 0; i < ctx->nr_user_files; i++) {
 		file = io_file_from_index(ctx, i);



