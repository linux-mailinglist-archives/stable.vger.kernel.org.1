Return-Path: <stable+bounces-257205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B/aF38YG2r2/AgAu9opvQ
	(envelope-from <stable+bounces-257205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74160ED47
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E29E30E63AF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD1366567;
	Sat, 30 May 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cC5vP7ft"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9534F48F;
	Sat, 30 May 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160177; cv=none; b=eyBJgJ02P3EYS61eQ2s9tXbnmI20bN6w0gRbQja64EuQX3NgLsuJmuohVMJRlAdI/XgsIzvR5SPEmxw6O9By6tFdrYyfcAq71VMbtTA2Qj64LPAs16M2JBRu7z3st7vl9kJP0R0r92yoWuVmiaNDNj3/mjxCJMY/xRO/E/jNBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160177; c=relaxed/simple;
	bh=UOKchgcunj0riXlVQf6gbmzahOvWi/QZ4QT7/wT2iIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oyt5BvVMZ3+sIdCJKRHh3VsjHc0sodDe1Rs4daZvwTcx45zyu+4Ga6pzzdqkwKtjnb+YM4Ws+YUe+kCmdnpZaRi4V6YBCjIzl49jUJ6BirbcjoPFoiICfY2uGgftHuJi6OuW6ATkbnpH7h6kQ+qONPHIKyN/ONxtGFSZluttccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cC5vP7ft; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599221F00893;
	Sat, 30 May 2026 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160176;
	bh=fjGxTGFnwQNqQaqS23MS/s1Bdz4L3t3fAZ7R1dYGBIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cC5vP7ftLuzsBPbT7pK0MUQdsutorGChY7VT1g0aDBQjICCTGJ7isqfCwS3n9Aqg3
	 RSuptz1EcFgvku/XjqwZ3XeZN1V4kEkm8xUrxnNw/BF5jjnzUbqrk2IJLyaAM7CwQZ
	 L+USgz44OKpzvyO0Gvq+rZlXU/O0cis2lf4KOZUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tobias Gaertner <tob.gaertner@me.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.1 265/969] ntfs3: add buffer boundary checks to run_unpack()
Date: Sat, 30 May 2026 17:56:29 +0200
Message-ID: <20260530160307.792796223@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257205-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,me.com,paragon-software.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AA74160ED47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Gaertner <tob.gaertner@me.com>

commit b62567bca47408e6739dee75f02a2113548af875 upstream.

run_unpack() checks `run_buf < run_last` at the top of the while loop
but then reads size_size and offset_size bytes via run_unpack_s64()
without verifying they fit within the remaining buffer.  A crafted NTFS
image with truncated run data in an MFT attribute triggers an OOB heap
read of up to 15 bytes when the filesystem is mounted.

Add boundary checks before each run_unpack_s64() call to ensure the
declared field size does not exceed the remaining buffer.

Found by fuzzing with a source-patched harness (LibAFL + QEMU).

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Gaertner <tob.gaertner@me.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/run.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -963,6 +963,9 @@ int run_unpack(struct runs_tree *run, st
 		if (size_size > 8)
 			return -EINVAL;
 
+		if (run_buf + size_size > run_last)
+			return -EINVAL;
+
 		len = run_unpack_s64(run_buf, size_size, 0);
 		/* Skip size_size. */
 		run_buf += size_size;
@@ -975,6 +978,9 @@ int run_unpack(struct runs_tree *run, st
 		else if (offset_size <= 8) {
 			s64 dlcn;
 
+			if (run_buf + offset_size > run_last)
+				return -EINVAL;
+
 			/* Initial value of dlcn is -1 or 0. */
 			dlcn = (run_buf[offset_size - 1] & 0x80) ? (s64)-1 : 0;
 			dlcn = run_unpack_s64(run_buf, offset_size, dlcn);



