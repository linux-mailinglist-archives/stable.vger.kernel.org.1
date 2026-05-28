Return-Path: <stable+bounces-256236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDb5NoytGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:03:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBD5FA25F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 327B2313502D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECD317142;
	Thu, 28 May 2026 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xXxTwt/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFA2F1FEF;
	Thu, 28 May 2026 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001138; cv=none; b=fHgJ2Tq//N9DKWsfrsfncCDcuGjzXelWwsgxCyRxZKojxCqxkkYLnzrDXjRUNJe/rWlaMQZSMbNwYHJupTP9fEOzqL3HHjOLskf/zoWVjdao63f07cRcsRT2kkMBFfDzV34luJ7ym6s2DmEcoUqDW9qaWCV8rroH6vrFMyJQiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001138; c=relaxed/simple;
	bh=tC2QxwobzP8Gu0hEaWa8Lqc5y9y7Qgdm4o4iFdbRK0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfXEPHPh9WVdsEoEoe1eVtNW0nDx+8xHMrOoLgzhnVIN3eD6rTg/5AeGQbdFNPhi+ZI8a30p69UuAkUhjQEB/nEQH17w6igDEpHbnS0s1kJBCsEzVzO7fwHNsprniyRN8Y6JFp4OtrNZb9yW9dv8R4I9ksZy5vWx3qQb5LzLhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xXxTwt/x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE01F000E9;
	Thu, 28 May 2026 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001136;
	bh=pNad2m4uOY5wJ40FuF0wGdae5NYAOpBN95V+RPe7tdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xXxTwt/x2oAvKSKZHKwfqGpdfy4fbWyI1CbeHzy9ZCRsgVdOsAFCMEaib30tUtHUA
	 NflHWk8nSKGBC2pDF3jEkOWecsyevNb5AryIExdMW8bat20sRElTpLAKRSkJn/vWNR
	 Scm+EtC180fFXYCIou1ZJu1uUd1A2b7HYKV1xHlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 020/186] Revert "af_unix: Reject SIOCATMARK on non-stream sockets"
Date: Thu, 28 May 2026 21:48:20 +0200
Message-ID: <20260528194929.503185964@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256236-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EFBD5FA25F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 0d7e7235bc543c6ed7b873e3015db814d8e8c414.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c621f00902752..8f785b2600ae4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2809,9 +2809,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				goto out;
 			}
 
-			if (sk->sk_type != SOCK_STREAM)
-				return -EOPNOTSUPP;
-
 			mutex_lock(&u->iolock);
 			goto redo;
 unlock:
-- 
2.53.0




