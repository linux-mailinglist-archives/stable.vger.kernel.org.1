Return-Path: <stable+bounces-229320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ6GCL1vwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:52:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0B2F8F28
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D3D320F42C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256B2280338;
	Mon, 23 Mar 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pH2FFaG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81A242D70;
	Mon, 23 Mar 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278746; cv=none; b=ISBdcZQJ9YT0A1+hcEVkHCfsx+eKjUwve3HCfVXIjC0yNzgMO+b3npZMkHPvIWK/VWKLK0a9Ve/P1Kur1PmOOaW1+N7dJ2g3aXtOhRpabUekS6KoA6MhVVGmbdgHVDFXfrvllj5t5GJVMMEw6U78Di+8PqyJGTCZr01h3xHmL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278746; c=relaxed/simple;
	bh=lz+IhvxSRairiKgW5rYs1e7SfPxEcWpekR5S90ynUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXX0SyX2CmNpoPTS02gqgX1FBQmd+ZCy8DjrvsCURhLIqRghP6irny5VCQjTmLQTploELIaS7GVM5SuH37WA6uZ2NOStFXNUtVPeb3KyH2Qpj1OEKcczDKjAsFpoOwI8p/uf8jDN5YjsPh0n3stB1FGADkxnfBe1bS8/31h59EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pH2FFaG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484DBC4CEF7;
	Mon, 23 Mar 2026 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278746;
	bh=lz+IhvxSRairiKgW5rYs1e7SfPxEcWpekR5S90ynUkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pH2FFaG/S5rj6GnzzYJ8rww5JdMrn0tIsyccyRBJgQ9OTJLU/wZREEBHy6dBjdjXy
	 VCulVbgABDxwFgrGxTnnjU0C0Q9FPobDhZ6ovZDHxHaXXXw38dL4feWTrj6vvoMicY
	 HI1EyHdoD+OM/FLUPceQxpEsAHKkek4e1tqWeSjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	David Sterba <dsterba@suse.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.6 405/567] btrfs: fix NULL dereference on root when tracing inode eviction
Date: Mon, 23 Mar 2026 14:45:25 +0100
Message-ID: <20260323134543.895486237@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,mssola.com,suse.com,139.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-229320-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,d991fea1b4b23b1f6bf8];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 62F0B2F8F28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Sabaté Solà <mssola@mssola.com>

[ Upstream commit f157dd661339fc6f5f2b574fe2429c43bd309534 ]

When evicting an inode the first thing we do is to setup tracing for it,
which implies fetching the root's id. But in btrfs_evict_inode() the
root might be NULL, as implied in the next check that we do in
btrfs_evict_inode().

Hence, we either should set the ->root_objectid to 0 in case the root is
NULL, or we move tracing setup after checking that the root is not
NULL. Setting the rootid to 0 at least gives us the possibility to trace
this call even in the case when the root is NULL, so that's the solution
taken here.

Fixes: 1abe9b8a138c ("Btrfs: add initial tracepoint support for btrfs")
Reported-by: syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d991fea1b4b23b1f6bf8
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/btrfs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -225,8 +225,8 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 		__entry->generation = BTRFS_I(inode)->generation;
 		__entry->last_trans = BTRFS_I(inode)->last_trans;
 		__entry->logged_trans = BTRFS_I(inode)->logged_trans;
-		__entry->root_objectid =
-				BTRFS_I(inode)->root->root_key.objectid;
+		__entry->root_objectid = BTRFS_I(inode)->root ?
+					 btrfs_root_id(BTRFS_I(inode)->root) : 0;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) gen=%llu ino=%llu blocks=%llu "



