Return-Path: <stable+bounces-240780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E3nD1Fz62kLNAAAu9opvQ
	(envelope-from <stable+bounces-240780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA0D45F70B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 410B8307EB6A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25803563D4;
	Fri, 24 Apr 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0E9pzdLz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCA179A3;
	Fri, 24 Apr 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037821; cv=none; b=Lr+aH6EqubiGxKxorxRouEWtEr1UadQ4c4XfHW9Adk3zdzcFS+OCKV3+999nhcYV07sU2uY/+rgo2R+on5kriLrzPpzXJY6XAj26qCmg/f6TayYVs+gOsLoW0uw5hfTXkkIUqtczYyV0Vq8drFwgFw25VOGCebTrKkGn0CQOFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037821; c=relaxed/simple;
	bh=doFXX2/+tQilqCjFywAt+h8ImgYC1ZNwNzR0nD9gtqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baPmhfLxp+gb0O0frCpYoENVF9JmfsG4hngi0SO5IslsPIwpwK1+BmeV12TFL/Ba/+hIxvlddhIkcfm1H8T1Q7auWHYGCxBdrwjvyVEVcOIbjkQLS/6gj2YydIDnhNrES6i9/T3tRFxuved/URSzkY99PUeh1un8Sk/VI7Q22d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0E9pzdLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE85C19425;
	Fri, 24 Apr 2026 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037821;
	bh=doFXX2/+tQilqCjFywAt+h8ImgYC1ZNwNzR0nD9gtqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0E9pzdLzQauc7dS+b7AxG0mbS6prauXUuc+MOYYpQU6LssaA6XwT7LDBBySSjl8mj
	 XjjYjxTExTjgGnxgTL0X6DfPfJra1/x4jOSeTyIeCACh1WeNocE924butVSGZMF7ZQ
	 uaW+mL6uGyFHvql2Ru26IO4xDXO/xZ8wdjK3limk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	stable <stable@kernel.org>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 081/166] smb: client: fix off-by-8 bounds check in check_wsl_eas()
Date: Fri, 24 Apr 2026 15:29:55 +0200
Message-ID: <20260424132549.801210395@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7AA0D45F70B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240780-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microsoft.com,talpey.com,vger.kernel.org,lists.samba.org,kernel.org,manguebit.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talpey.com:email,manguebit.org:email,samba.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 3d8b9d06bd3ac4c6846f5498800b0f5f8062e53b upstream.

The bounds check uses (u8 *)ea + nlen + 1 + vlen as the end of the EA
name and value, but ea_data sits at offset sizeof(struct
smb2_file_full_ea_info) = 8 from ea, not at offset 0.  The strncmp()
later reads ea->ea_data[0..nlen-1] and the value bytes follow at
ea_data[nlen+1..nlen+vlen], so the actual end is ea->ea_data + nlen + 1
+ vlen.  Isn't pointer math fun?

The earlier check (u8 *)ea > end - sizeof(*ea) only guarantees the
8-byte header is in bounds, but since the last EA is placed within 8
bytes of the end of the response, the name and value bytes are read past
the end of iov.

Fix this mess all up by using ea->ea_data as the base for the bounds
check.

An "untrusted" server can use this to leak up to 8 bytes of kernel heap
into the EA name comparison and influence which WSL xattr the data is
interpreted as.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -125,7 +125,7 @@ static int check_wsl_eas(struct kvec *rs
 		nlen = ea->ea_name_length;
 		vlen = le16_to_cpu(ea->ea_value_length);
 		if (nlen != SMB2_WSL_XATTR_NAME_LEN ||
-		    (u8 *)ea + nlen + 1 + vlen > end)
+		    (u8 *)ea->ea_data + nlen + 1 + vlen > end)
 			return -EINVAL;
 
 		switch (vlen) {



