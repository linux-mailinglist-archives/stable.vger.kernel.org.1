Return-Path: <stable+bounces-228006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPi/HHNGwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC82F371C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FE323020A67
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887FE3A6B88;
	Mon, 23 Mar 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SiEeDJsD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC13A961B;
	Mon, 23 Mar 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273840; cv=none; b=S42Yd7bo3vKm78NjyT54wNQvgrMTTrNCamEnr4ravc94OgsX/lKgsFOibqgu6tVqJWLb8b2Mvxl/HuBBOSWgO0QIprYR6dBiM/C1ug8TdHNp8XHuJ1cDvSaW/W2vY5VpXp4kEITbGsZWBw6GVpLdh+8Cn+JsBzvDC5fnTKV8BAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273840; c=relaxed/simple;
	bh=46lBygGMgGqLbhq0M/K0jsMNu6y2g6KmWkcPM3N9fU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Viw/ASRSf3IW+/gR8YhuxGd9YiFURkFPCuC6yIVWA1TFpjU8fBO3dwp9GS6wb1kWUY4GJ4RAunnd00z4bATUiVWGYovd/lRqO93aL1aWdUhgWPtLkPpd+x3neXhQ/f1zv8/1rMHw7vfBmsuwarItptGAq8W498NCLSUdAPkm0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SiEeDJsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F186C2BC9E;
	Mon, 23 Mar 2026 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273840;
	bh=46lBygGMgGqLbhq0M/K0jsMNu6y2g6KmWkcPM3N9fU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiEeDJsDn5v3orNPBgYJoBuEPYPq+XhSGPaswFmXb0n1QW80Dn7zgVy2f+bj+6Fqs
	 /9NcNcyutEOBLgaUe9GxWrPpJ3z8RxpmEMmw+gsagQuIYUFDQmu3rLgq+UfeBK3ZoD
	 2L5jfkvHXVvJJcRdxH3EQ4YjInps0SX+qjb3jFh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 025/220] ksmbd: unset conn->binding on failed binding request
Date: Mon, 23 Mar 2026 14:43:22 +0100
Message-ID: <20260323134505.376368578@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228006-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 12CC82F371C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 282343cf8a4a5a3603b1cb0e17a7083e4a593b03 upstream.

When a multichannel SMB2_SESSION_SETUP request with
SMB2_SESSION_REQ_FLAG_BINDING fails ksmbd sets conn->binding = true
but never clears it on the error path. This leaves the connection in
a binding state where all subsequent ksmbd_session_lookup_all() calls
fall back to the global sessions table. This fix it by clearing
conn->binding = false in the error path.

Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1947,6 +1947,7 @@ out_err:
 			}
 		}
 		smb2_set_err_rsp(work);
+		conn->binding = false;
 	} else {
 		unsigned int iov_len;
 



