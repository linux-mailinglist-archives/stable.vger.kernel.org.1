Return-Path: <stable+bounces-228778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFmHO3lVwWlTSQQAu9opvQ
	(envelope-from <stable+bounces-228778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC56F2F59CE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DBC4303F0AB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45683ACA62;
	Mon, 23 Mar 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FvRiQlSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F501459FA;
	Mon, 23 Mar 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277098; cv=none; b=rTn2LRmx8+4C4QPKfEiwgW26WMG0J0/UL00kcS/R0V+isNk6EmjLxmZBmbuYKdxvrMyqOnJoV0fq07W3bCeVHiNDKaWuEwzLxNZb4BIYY9Kj76iCVLlu3PeEyYx3y8nXWL7novPAnJyWpW1HWJEFmJDudqTjntODdboay0zKTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277098; c=relaxed/simple;
	bh=uIxKRiC4dMjSYGXiguiT7HM7dG03RRwG0/Ybuk9+fg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHrgV4eGErOtJvCa4RZjxpVFMW0dpcYqHpesX8C6/UzsCPHB7Vo/Olb2+kKGzUy8F69aw0xjP/NDUOATgmp3WC+qgJ54R5kX4oqTGln8I848GN8aVl5A7eApWfhiMgVFo119//x4jVt3uAMZZqyUx3r3G/M8Kg69XDSRdnJrMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FvRiQlSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB0CC4CEF7;
	Mon, 23 Mar 2026 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277098;
	bh=uIxKRiC4dMjSYGXiguiT7HM7dG03RRwG0/Ybuk9+fg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvRiQlSKx5xEt6Serodhm3crLMe6/lwBh5IB10jU9Mzk3X9IDJ2LydS2hCx67/Yqh
	 WjFn4/sESCPEnYq65J6Z+jo1ir3fQkYIaVZD08HDnfiosfZVKRqEoYEBzn0miJMw3w
	 p647b8M50GqYKSKX/PjWMLu2kyVjiI1X0kkFwsPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oscar Santos <ossantos@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	linux-cifs@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 319/460] smb: client: fix krb5 mount with username option
Date: Mon, 23 Mar 2026 14:45:15 +0100
Message-ID: <20260323134534.341460540@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228778-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CC56F2F59CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.org>

commit 12b4c5d98cd7ca46d5035a57bcd995df614c14e1 upstream.

Customer reported that some of their krb5 mounts were failing against
a single server as the client was trying to mount the shares with
wrong credentials.  It turned out the client was reusing SMB session
from first mount to try mounting the other shares, even though a
different username= option had been specified to the other mounts.

By using username mount option along with sec=krb5 to search for
principals from keytab is supported by cifs.upcall(8) since
cifs-utils-4.8.  So fix this by matching username mount option in
match_session() even with Kerberos.

For example, the second mount below should fail with -ENOKEY as there
is no 'foobar' principal in keytab (/etc/krb5.keytab).  The client
ends up reusing SMB session from first mount to perform the second
one, which is wrong.

```
$ ktutil
ktutil:  add_entry -password -p testuser -k 1 -e aes256-cts
Password for testuser@ZELDA.TEST:
ktutil:  write_kt /etc/krb5.keytab
ktutil:  quit
$ klist -ke
Keytab name: FILE:/etc/krb5.keytab
KVNO Principal
 ---- ----------------------------------------------------------------
   1 testuser@ZELDA.TEST (aes256-cts-hmac-sha1-96)
$ mount.cifs //w22-root2/scratch /mnt/1 -o sec=krb5,username=testuser
$ mount.cifs //w22-root2/scratch /mnt/2 -o sec=krb5,username=foobar
$ mount -t cifs | grep -Po 'username=\K\w+'
testuser
testuser
```

Reported-by: Oscar Santos <ossantos@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1906,6 +1906,10 @@ static int match_session(struct cifs_ses
 	case Kerberos:
 		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
 			return 0;
+		if (strncmp(ses->user_name ?: "",
+			    ctx->username ?: "",
+			    CIFS_MAX_USERNAME_LEN))
+			return 0;
 		break;
 	case NTLMv2:
 	case RawNTLMSSP:



