Return-Path: <stable+bounces-239499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDOGOIle5mm3vQEAu9opvQ
	(envelope-from <stable+bounces-239499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:12:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76424430BEC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A973635B9C5F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019833B970;
	Mon, 20 Apr 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ignCnCTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48E2D77E5;
	Mon, 20 Apr 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700410; cv=none; b=E27bf36ctcbh2pNoEJf/lkyf6kwFOAC55RKzZ2W1hAlKWF/UsfNXAv7x5ZaoMW3ISC4bicL4Wn0RoERn5Z+qNmplZ6hkzdzXXInxsX43ISxR+ngV2L/qeqE3rsVNgZzTKzIGk24KSIeItdvRnCR9zFXJJbKMZ/gvsENXoc+LwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700410; c=relaxed/simple;
	bh=Gn8NTj/J3fDGMQJQV5ZoG8/iNG+ZsOmWCsBHO3Yk75I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNRqf6nXPs2zSJGphNV1uK3O4m9kjehfuwCCYqPplw6kj6KRS2jobuMghTDRmseDMDbz1vBilYP4mTUvviEG5+GCtITzqLxP6g/Fh7v0B8fUdegzQXqCOUwYL43dB9Wryu45KFcPo/KPiAwxZG/lzMIBYfS+ToWGaVXZiRS73m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ignCnCTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F56AC19425;
	Mon, 20 Apr 2026 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700410;
	bh=Gn8NTj/J3fDGMQJQV5ZoG8/iNG+ZsOmWCsBHO3Yk75I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ignCnCTsldfJCUibYi/sm4EvfwdNlC0jubluxw3xv9CgSO9ejdMjsLvs8Nrj4zxgT
	 Bq6PUx01eTUokavo3sPNsuvQyt1n6vrsgDXAoFsS+LD4hWDaf435SY9bXWbmrKnq7Y
	 EalDDpiofbk64W29fBI7xXiMTDRkPbLMLSdPw590=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruikai Peng <ruikai@pwno.io>,
	stable@kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	security@kernel.org,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 161/220] smb: client: avoid double-free in smbd_free_send_io() after smbd_send_batch_flush()
Date: Mon, 20 Apr 2026 17:41:42 +0200
Message-ID: <20260420153939.825233523@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239499-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,pwno.io,kernel.org,gmail.com,talpey.com,microsoft.com,chromium.org,vger.kernel.org,lists.samba.org,manguebit.org,samba.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,manguebit.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,talpey.com:email]
X-Rspamd-Queue-Id: 76424430BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

commit 27b7c3e916218b5eb2ee350211140e961bfc49be upstream.

smbd_send_batch_flush() already calls smbd_free_send_io(),
so we should not call it again after smbd_post_send()
moved it to the batch list.

Reported-by: Ruikai Peng <ruikai@pwno.io>
Closes: https://lore.kernel.org/linux-cifs/CAFD3drNOSJ05y3A+jNXSDxW-2w09KHQ0DivhxQ_pcc7immVVOQ@mail.gmail.com/
Fixes: 21538121efe6 ("smb: client: make use of smbdirect_socket.send_io.bcredits")
Cc: stable@kernel.org
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Ruikai Peng <ruikai@pwno.io>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: security@kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Tested-by: Ruikai Peng <ruikai@pwno.io>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smbdirect.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1525,17 +1525,25 @@ static int smbd_post_send_iter(struct sm
 
 	rc = smbd_post_send(sc, batch, request);
 	if (!rc) {
+		/*
+		 * From here request is moved to batch
+		 * and we should not free it explicitly.
+		 */
+
 		if (batch != &_batch)
 			return 0;
 
 		rc = smbd_send_batch_flush(sc, batch, true);
 		if (!rc)
 			return 0;
+
+		goto err_flush;
 	}
 
 err_dma:
 	smbd_free_send_io(request);
 
+err_flush:
 err_alloc:
 	atomic_inc(&sc->send_io.credits.count);
 	wake_up(&sc->send_io.credits.wait_queue);



