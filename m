Return-Path: <stable+bounces-255192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMuhHxyeGGpblggAu9opvQ
	(envelope-from <stable+bounces-255192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275675F781D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 821B83016CD7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7933CE8A;
	Thu, 28 May 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lxDtYfVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265B3290B0;
	Thu, 28 May 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998220; cv=none; b=IGn4hxbaFKc0FusE2Zdv9an5klAWmUyuzkJhvcG8BaVAb/gBAtTaWgIHoDbMc4Mv61N/9m8TjsKlRdFopOpM+UdAhoyjyVo68duKBOG82wsKHLd2wHLwYLDnMvAceQ5kM0Vv2B9smAVvFkmaFumXj9uGoLQ87GJi9fepO3+zY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998220; c=relaxed/simple;
	bh=cF8XsTBXVSl+oN3ZKEx3br7Yavd+swp3rIH/eLrdLKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK5nYXfVO3XqE/Rz/RAngU9zA6tIU+iMS654XxEkGm43ByejkXCF2lUf2RYv0McvvdhG1y0WIfWJVOPPH6iA2V49d4d082s0MXPRdfc1Lz/koj5ew9lO001kAG1CK9/QYoRwFwv3Zl5zSe1NVpj/qofo7q38gZ2vdsER+2P5fKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lxDtYfVw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF89C1F000E9;
	Thu, 28 May 2026 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998219;
	bh=74OyxaZQq+3/9lhCPlBsUjzz0zqsEzCth5fqmChX3gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxDtYfVwJQnqpUbdqcaFN9NMSdhxFfrxBRh9kwLawLTg7PYUahwSkEjVov0h2flcy
	 3y80OQ/IKr0BUPWJbUY/aZ80hPs/v48TMkSaqXtZoVnUJC+qi0RZSmeAAMCYCzj2I1
	 re0JilhEHI1bt05mnAdU40OAeY4DcPsyYjMUKwxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 7.0 096/461] cifs: Fix busy dentry used after unmounting
Date: Thu, 28 May 2026 21:43:45 +0200
Message-ID: <20260528194649.724093823@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255192-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 275675F781D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit c68337442f03953237a94577beb468ab2662a851 upstream.

Since commit 340cea84f691c ("cifs: open files should not hold ref on
superblock"), cifs file only holds the dentry ref_cnt, the cifs file
close work(cfile->deferred) could be executed after unmounting, which
will trigger a warning in generic_shutdown_super:
 BUG: Dentry 00000000a14a6845{i=c,n=file}  still in use (1) [unmount of
 cifs cifs]

The detailed processs is:
   process A           process B           kworker
 fd = open(PATH)
  vfs_open
   file->__f_path = *path // dentry->d_lockref.count = 1
   cifs_open
    cifs_new_fileinfo
     cfile->dentry = dget(dentry) // dentry->d_lockref.count = 2
 close(fd)
  __fput
  cifs_close
   queue_delayed_work(deferredclose_wq, cfile->deferred)
  dput(dentry) // dentry->d_lockref.count = 1
			                 smb2_deferred_work_close
					  _cifsFileInfo_put
					   list_del(&cifs_file->flist)
                    umount
		     cleanup_mnt
		      deactivate_super
		       cifs_kill_sb
		        cifs_close_all_deferred_files_sb
			 cifs_close_all_deferred_files
			  // cannot find cfile, skip _cifsFileInfo_put
			kill_anon_super
			 generic_shutdown_super
			  shrink_dcache_for_umount
			   umount_check
			    WARN ! // dentry->d_lockref.count = 1
					   cifsFileInfo_put_final
					    dput(cifs_file->dentry)
		                            // dentry->d_lockref.count = 0

Fix it by flushing 'deferredclose_wq' before calling kill_anon_super.

Fetch a reproducer in https://bugzilla.kernel.org/show_bug.cgi?id=221548.

Fixes: 340cea84f691c ("cifs: open files should not hold ref on superblock")
Cc: stable@vger.kernel.org
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsfs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -340,6 +340,8 @@ static void cifs_kill_sb(struct super_bl
 
 		/* Wait for all pending oplock breaks to complete */
 		flush_workqueue(cifsoplockd_wq);
+		/* Wait for all opened files to release */
+		flush_workqueue(deferredclose_wq);
 
 		/* finally release root dentry */
 		dput(cifs_sb->root);



