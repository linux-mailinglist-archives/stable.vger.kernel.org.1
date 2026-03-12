Return-Path: <stable+bounces-225123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI36N/Ags2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD37278F7C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAACC302CB00
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816C372EF6;
	Thu, 12 Mar 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egRjd/NM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC632D0606;
	Thu, 12 Mar 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347054; cv=none; b=XPCCoZE4nQJklTw1GFcdEz1ZqB727TWnkUcPS24294boEVfQa2PJLnaPZGAm7INjAc8mMpR3LFB8M7tKEcRLakXw0fP0F6SzKzyZzLSywtgWFtATAZU7iv6R4hvBckNYvEyCTG1QRojU8fzZKdrvnM0Mtl0Jd/fLHVNqvvqU7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347054; c=relaxed/simple;
	bh=SscjTk3LQxSdnPox1C8Sn3u1Y5wlmvVO6nd6CpoOATk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTfGzZe5/Hz9BgaMv4CAIWMsTDRlcCNxyFuBdC5Ub66hktkl5x8AHPjkvh0rcRt1SP7XjIQzTbhpoElzuX8+N4mQas7KzOnOZog0MKkb30Nds30vCQ+BjGTXwHZoPRDAPkiNUNSOhqowm8j0brqlGkd7FWBmBNdDuYU7UJw2dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egRjd/NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E908AC4CEF7;
	Thu, 12 Mar 2026 20:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347054;
	bh=SscjTk3LQxSdnPox1C8Sn3u1Y5wlmvVO6nd6CpoOATk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egRjd/NM5r0zWdAc4ETzrQOiNPTEEXiJ2MpUBNS+ndZ3hmFWC2PKSecn+Bb7Mwa7s
	 2PwriNslIRYgldIBkgoFBq1Sr+wnJY3eXbV084b3q71mdq9eFEXIiaKiWPqqI0/t0q
	 7teP+olvJlzjhOJoHtXqCB5xdDoSWBU47DaUxjG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaoli Feng <xifeng@redhat.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	linux-cifs@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 158/265] smb: client: fix broken multichannel with krb5+signing
Date: Thu, 12 Mar 2026 21:09:05 +0100
Message-ID: <20260312201023.978879308@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225123-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FD37278F7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.org>

commit d9d1e319b39ea685ede59319002d567c159d23c3 upstream.

When mounting a share with 'multichannel,max_channels=n,sec=krb5i',
the client was duplicating signing key for all secondary channels,
thus making the server fail all commands sent from secondary channels
due to bad signatures.

Every channel has its own signing key, so when establishing a new
channel with krb5 auth, make sure to use the new session key as the
derived key to generate channel's signing key in SMB2_auth_kerberos().

Repro:

$ mount.cifs //srv/share /mnt -o multichannel,max_channels=4,sec=krb5i
$ sleep 5
$ umount /mnt
$ dmesg
  ...
  CIFS: VFS: sign fail cmd 0x5 message id 0x2
  CIFS: VFS: \\srv SMB signature verification returned error = -13
  CIFS: VFS: sign fail cmd 0x5 message id 0x2
  CIFS: VFS: \\srv SMB signature verification returned error = -13
  CIFS: VFS: sign fail cmd 0x4 message id 0x2
  CIFS: VFS: \\srv SMB signature verification returned error = -13

Reported-by: Xiaoli Feng <xifeng@redhat.com>
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2pdu.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1666,19 +1666,17 @@ SMB2_auth_kerberos(struct SMB2_sess_data
 	is_binding = (ses->ses_status == SES_GOOD);
 	spin_unlock(&ses->ses_lock);
 
-	/* keep session key if binding */
-	if (!is_binding) {
-		kfree_sensitive(ses->auth_key.response);
-		ses->auth_key.response = kmemdup(msg->data, msg->sesskey_len,
-						 GFP_KERNEL);
-		if (!ses->auth_key.response) {
-			cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory\n",
-				 msg->sesskey_len);
-			rc = -ENOMEM;
-			goto out_put_spnego_key;
-		}
-		ses->auth_key.len = msg->sesskey_len;
+	kfree_sensitive(ses->auth_key.response);
+	ses->auth_key.response = kmemdup(msg->data,
+					 msg->sesskey_len,
+					 GFP_KERNEL);
+	if (!ses->auth_key.response) {
+		cifs_dbg(VFS, "%s: can't allocate (%u bytes) memory\n",
+			 __func__, msg->sesskey_len);
+		rc = -ENOMEM;
+		goto out_put_spnego_key;
 	}
+	ses->auth_key.len = msg->sesskey_len;
 
 	sess_data->iov[1].iov_base = msg->data + msg->sesskey_len;
 	sess_data->iov[1].iov_len = msg->secblob_len;



