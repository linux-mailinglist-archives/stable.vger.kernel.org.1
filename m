Return-Path: <stable+bounces-198250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D88C9F7A0
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3DE5300503D
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585530E836;
	Wed,  3 Dec 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fe8m7Tnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAA30C358;
	Wed,  3 Dec 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775921; cv=none; b=qCX4L4wT9J7oD9Y+C8gZ/cv0tMmmt0bxVSPz1yaVnrzVmDmoHVrYJ4yshvOJVkYo0nkhlrNL2CuDkYo6mJhepEHrTMk+h6FkPIW9rTf0y9giQmi81OoFUnF1RbnW7+hg1Ah9wFv10cow/6XHJJ665jLV6RHdvpiZ5uha45sf/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775921; c=relaxed/simple;
	bh=QsSPnD3dw5KHWzTJZXyoqBTIzxLZNHMjCV1M1vEiXrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKpf5c0Bppp98uXKsJ1HueLPH6QsOYnQVygsL5djUAWPbYU7XoX7AdiVdWzG1hSYSmnOSMY2JcDFKnKTXEcWEvnoEpoxjD3AztVEnTAzuICMCZrWEGQ+EoT3Ff/BeJxjcOxx5FhFi/7ZCox07oVSTndPUfeaPpBMsIi+j+e+VS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fe8m7Tnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBC8C116B1;
	Wed,  3 Dec 2025 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764775921;
	bh=QsSPnD3dw5KHWzTJZXyoqBTIzxLZNHMjCV1M1vEiXrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fe8m7TnfGh9eVtAWIt5kkzzZeEduYzkA8FtHwLe73arhdVP/Mbfh+opy3P0tniD7t
	 TDT30HtnorahIktk3AAHSM6WJNF7Bi6UwU9QexnlVnKPmFHJlqmvjjejGQaUz1MNvR
	 w18Zm9v3BW6/Tx9O/I43C/GGgZs4EWr4V5PCaX40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 005/300] NFSD: Fix crash in nfsd4_read_release()
Date: Wed,  3 Dec 2025 16:23:29 +0100
Message-ID: <20251203152400.658146520@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit abb1f08a2121dd270193746e43b2a9373db9ad84 upstream.

When tracing is enabled, the trace_nfsd_read_done trace point
crashes during the pynfs read.testNoFh test.

Fixes: 15a8b55dbb1b ("nfsd: call op_release, even when op_func returns an error")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -945,10 +945,11 @@ nfsd4_read(struct svc_rqst *rqstp, struc
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
-	if (u->read.rd_nf)
+	if (u->read.rd_nf) {
+		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
+				     u->read.rd_offset, u->read.rd_length);
 		nfsd_file_put(u->read.rd_nf);
-	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
-			     u->read.rd_offset, u->read.rd_length);
+	}
 }
 
 static __be32



