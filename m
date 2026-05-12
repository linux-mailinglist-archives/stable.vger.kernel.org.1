Return-Path: <stable+bounces-245935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNnaEI9oA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C744D52636B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC5F30F67C5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126B3D5C06;
	Tue, 12 May 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIVdZRJB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CE21FF21;
	Tue, 12 May 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607934; cv=none; b=hkY2bjCpC/NJTEn2UlDxYu70PpbBeVgrZqfLMmYlAGsyo8fAQezcthNoGvkqLssus+YldMSJ3YQkU+9SBILozhcN8Dy56uErtaVtyfiLhzB1fDxfZ7iov4ovvEGH78sV4xbEID1i+9lA4wLeXlFF41071/8gfrxRpSXKSw7tVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607934; c=relaxed/simple;
	bh=BiOSI3Q0Fc4wk3o9MbO+6XyT6Nj7DUPg2wSiGZQlmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpmGxtCUtsyPTRy5LygS98EtK1/4LLsx89DR8gCMgbxMxgo1u0CMjoFyr55cVueiIAaII4JsL+v3BehyER4GwAYOP6L9gUXDCjfnN63rtOLwSvAXrVOE1ajnuluIYgxid/sw70MQZg/D11diDeyyKB6z7X/VIvRWTW2y9G0y+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIVdZRJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BF9C2BCB0;
	Tue, 12 May 2026 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607933;
	bh=BiOSI3Q0Fc4wk3o9MbO+6XyT6Nj7DUPg2wSiGZQlmfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIVdZRJBab3QUHLMx/XRQwjtroDhypHvuAa72qx1PdSlgBFflvXf8no9aHZ+3FYkL
	 /irQFZFDMVjJwi1L4lgvRHkenBv5Ld5fxYaWBz1CVy6qK1QrxSlmoepZwwKLnB+k/N
	 jNOD4zbvBAV3yGBCJYat/q0IZIlQa6imDkqSzpxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bharath SM <bharathsm@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 091/206] cifs: abort open_cached_dir if we dont request leases
Date: Tue, 12 May 2026 19:39:03 +0200
Message-ID: <20260512173934.783583687@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C744D52636B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245935-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit d68ce834f8cf6cb2e77f3331df65166b35466b53 upstream.

It is possible that SMB2_open_init may not set lease context based
on the requested oplock level. This can happen when leases have been
temporarily or permanently disabled. When this happens, we will have
open_cached_dir making an open without lease context and the response
will anyway be rejected by open_cached_dir (thereby forcing a close to
discard this open). That's unnecessary two round-trips to the server.

This change adds a check before making the open request to the server
to make sure that SMB2_open_init did add the expected lease context
to the open in open_cached_dir.

Cc: <stable@vger.kernel.org>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -261,6 +261,14 @@ replay_again:
 			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
+
+	if (oplock != SMB2_OPLOCK_LEVEL_II) {
+		rc = -EINVAL;
+		cifs_dbg(FYI, "%s: Oplock level %d not suitable for cached directory\n",
+			 __func__, oplock);
+		goto oshr_free;
+	}
+
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));



