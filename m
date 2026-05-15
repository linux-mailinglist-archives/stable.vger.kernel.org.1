Return-Path: <stable+bounces-248224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM8nLiNLB2q5wwIAu9opvQ
	(envelope-from <stable+bounces-248224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7675537F5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24FA030F08D1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DE4D2EF2;
	Fri, 15 May 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IAOvgCF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220E4CA264;
	Fri, 15 May 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861187; cv=none; b=YlfNtR7ApMiNI62x+MleO3ReFVlk1nB6SNiiei2wx+9iso8MNFJD+P/pP0WDlNgb4Okcg295Kv/ugLCqzkOMR3lP6FtqexuhpSZ3P3gJzQcaVJXQlORVOvishYxGifWpmNzms3Fzz545W48SA2V8flhh4Oz5ZGVXH/cA+wSXvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861187; c=relaxed/simple;
	bh=UxZGlOyrMSqfDhxNjWMZZrtApBfuvHXBtnXQ8d4T9Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNohgjXOKtb5B3poM9Z/cM4mfCmJSv9UlR+IdoUhTLyOB/Sc5q2JCBEp8UvPH4GdxKsEfCLU9HKNrm2dpHJsbOnXLGG40bEMa+J+vbtubhdUpVA7sF5DLL+40Cr/Q04qWfNcy5sRtEsKuAhtvci/fk6XY6HyC9dC4GgAgGU4M2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IAOvgCF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68768C2BCB0;
	Fri, 15 May 2026 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861187;
	bh=UxZGlOyrMSqfDhxNjWMZZrtApBfuvHXBtnXQ8d4T9Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAOvgCF8d1ImoVqVUP0aM/S4u02bfQyWQrbVggTlRYdG8jQDS6rwhbwBa6MfP9Dyx
	 NxUWFB0c8/oGOCLDUSI5WeEezxX5MnoxO8o5UApYQERRFFHrEBr6XxGHY+xnzoF1Kx
	 +V5WALPineZsOS5iStHfhDh71Xwc2VQRkkUiZR5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bharath SM <bharathsm@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 231/474] cifs: abort open_cached_dir if we dont request leases
Date: Fri, 15 May 2026 17:45:40 +0200
Message-ID: <20260515154720.003483225@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6D7675537F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248224-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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



