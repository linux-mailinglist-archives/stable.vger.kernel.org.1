Return-Path: <stable+bounces-226852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EEEF5ePuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:29:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061282AFB16
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2049C30489D4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804C331A64;
	Tue, 17 Mar 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQvXocKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAF15E5BB;
	Tue, 17 Mar 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768477; cv=none; b=RYq1lzW04MpGC4hJfGEu3Rygp4RaUr2CsY0tDbj/eNQBu2DxKyZtzWajWj6deGaUSyQvkhvxDkdguz3AMGMt01MDnGIBuBre9ITqCnbQgEt4CLT0cQS5+222FABuoAAawiN4SVz+EQPQrEtE/bvwwPkHck6pdIFvfeSjwA9UCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768477; c=relaxed/simple;
	bh=q201tWn09Xb++Yf+i0GtOSw6E69Qad9yxJz+XQF16F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOuFUtElYTNAd+2XnvGsedCPwZM79fe4M04MYiOgiBNnS3/KKARQn0lshjgGkXZOSSFyyjHwxg4CCovi9Lss4GIKs9pP8ghvNK9e/63IfTamaM5zwLlBnMVfKlZwcTw9PcKxRGs2B0R7RYfJ2m7cf9F6igOc+/OBeD4D2t04UuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQvXocKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2735C4CEF7;
	Tue, 17 Mar 2026 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768477;
	bh=q201tWn09Xb++Yf+i0GtOSw6E69Qad9yxJz+XQF16F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zQvXocKCVOOB/FPF9e+ftd97fhTjy7QPuTuGs7PMla1axxfpVH2kWQCIbYWsuWkXK
	 0i0HCI8ls/nYn+xY4ScOtQKiIbhRgBBkGeUYIyPD/Ss2ebSfROQRgMraRhoFu580EA
	 ZsphtU8fM0WB2t/Um2MuWbYC/+FWJxQZr4U/qoPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 285/333] smb: client: fix in-place encryption corruption in SMB2_write()
Date: Tue, 17 Mar 2026 17:35:14 +0100
Message-ID: <20260317163009.959172181@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226852-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,manguebit.org:email,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 061282AFB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharath SM <bharathsm@microsoft.com>

commit d78840a6a38d312dc1a51a65317bb67e46f0b929 upstream.

SMB2_write() places write payload in iov[1..n] as part of rq_iov.
smb3_init_transform_rq() pointer-shares rq_iov, so crypt_message()
encrypts iov[1] in-place, replacing the original plaintext with
ciphertext. On a replayable error, the retry sends the same iov[1]
which now contains ciphertext instead of the original data,
resulting in corruption.

The corruption is most likely to be observed when connections are
unstable, as reconnects trigger write retries that re-send the
already-encrypted data.

This affects SFU mknod, MF symlinks, etc. On kernels before
6.10 (prior to the netfs conversion), sync writes also used
this path and were similarly affected. The async write path
wasn't unaffected as it uses rq_iter which gets deep-copied.

Fix by moving the write payload into rq_iter via iov_iter_kvec(),
so smb3_init_transform_rq() deep-copies it before encryption.

Cc: stable@vger.kernel.org #6.3+
Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>
Acked-by: Shyam Prasad N <sprasad@microsoft.com>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2pdu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5172,7 +5172,10 @@ replay_again:
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
 	rqst.rq_iov = iov;
-	rqst.rq_nvec = n_vec + 1;
+	/* iov[0] is the SMB header; move payload to rq_iter for encryption safety */
+	rqst.rq_nvec = 1;
+	iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
+		      io_parms->length);
 
 	if (retries)
 		smb2_set_replay(server, &rqst);



