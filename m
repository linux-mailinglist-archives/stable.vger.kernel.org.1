Return-Path: <stable+bounces-214979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF9EJuzuiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F921104A1
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BD5A3006174
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA737AA91;
	Mon,  9 Feb 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1BWt+m8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED535CB6B;
	Mon,  9 Feb 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647273; cv=none; b=Y99xTAh20jLXi6MdDGVusD5DP6uddLeWRJLO98GPJU5UzkT7P2UU+WfUZLCUMTTn5t9kuhazl/6tWwDDwYh36BbQjRNZaZYOfT7NRvhxiJXS47kxnm8JEbSWFBnZcmLPB46tUH//uYFSyOkm08Z75oU02x3rmMe/tCgotdHGp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647273; c=relaxed/simple;
	bh=PVAj38ZhDD7DrIrbwB1cBQkSwfvr09Li0DfWKi/9Mdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfpoIRcfL68mfldDGEl19CHKIFhrP9aOldILdi/yFoAUcERFoAf0fnXfpRehxD2l298LR0XDheMW/XdlNIy8SmblwrBcj1l1uk2+BiNiNgjNep/Fd2cwQId6uf9P1TZ9XGHoFnDS89Fviy2OTy/oH8zdN69vaOH0UHZTU8qbjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1BWt+m8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18230C116C6;
	Mon,  9 Feb 2026 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647273;
	bh=PVAj38ZhDD7DrIrbwB1cBQkSwfvr09Li0DfWKi/9Mdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1BWt+m8zj7nVvy5aJnq7k5y0sqweKCld5kG+SZt8FfzhO4Fgazs062KmGCmW9APlv
	 HSt4o4mJuUP8CQlVikIFg4WLz5jKzbkF8Jv4HB+iqzfCrRkyZxKYpwJd3YgZEqWSNC
	 1pt5CppT4P83aLgpM+24zajxNKKptwHB6dzWcABA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Daniel Vogelbacher <daniel@chaospixel.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.18 017/175] ceph: fix oops due to invalid pointer for kfree() in parse_longname()
Date: Mon,  9 Feb 2026 15:21:30 +0100
Message-ID: <20260209142321.096064117@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214979-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,chaospixel.com,ibm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,gmx.de:email,chaospixel.com:email]
X-Rspamd-Queue-Id: 31F921104A1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vogelbacher <daniel@chaospixel.com>

commit bc8dedae022ce3058659c3addef3ec4b41d15e00 upstream.

This fixes a kernel oops when reading ceph snapshot directories (.snap),
for example by simply running `ls /mnt/my_ceph/.snap`.

The variable str is guarded by __free(kfree), but advanced by one for
skipping the initial '_' in snapshot names. Thus, kfree() is called
with an invalid pointer.  This patch removes the need for advancing the
pointer so kfree() is called with correct memory pointer.

Steps to reproduce:

1. Create snapshots on a cephfs volume (I've 63 snaps in my testcase)

2. Add cephfs mount to fstab
$ echo "samba-fileserver@.files=/volumes/datapool/stuff/3461082b-ecc9-4e82-8549-3fd2590d3fb6      /mnt/test/stuff   ceph     acl,noatime,_netdev    0       0" >> /etc/fstab

3. Reboot the system
$ systemctl reboot

4. Check if it's really mounted
$ mount | grep stuff

5. List snapshots (expected 63 snapshots on my system)
$ ls /mnt/test/stuff/.snap

Now ls hangs forever and the kernel log shows the oops.

Cc: stable@vger.kernel.org
Fixes: 101841c38346 ("[ceph] parse_longname(): strrchr() expects NUL-terminated string")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220807
Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Daniel Vogelbacher <daniel@chaospixel.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/crypto.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -219,12 +219,13 @@ static struct inode *parse_longname(cons
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
 	char *name_end, *inode_number;
 	int ret = -EIO;
-	/* NUL-terminate */
-	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
+	/* Snapshot name must start with an underscore */
+	if (*name_len <= 0 || name[0] != '_')
+		return ERR_PTR(-EIO);
+	/* Skip initial '_' and NUL-terminate */
+	char *str __free(kfree) = kmemdup_nul(name + 1, *name_len - 1, GFP_KERNEL);
 	if (!str)
 		return ERR_PTR(-ENOMEM);
-	/* Skip initial '_' */
-	str++;
 	name_end = strrchr(str, '_');
 	if (!name_end) {
 		doutc(cl, "failed to parse long snapshot name: %s\n", str);



