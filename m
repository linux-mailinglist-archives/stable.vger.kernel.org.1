Return-Path: <stable+bounces-274302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o2y3HE5LVmry2wAAu9opvQ
	(envelope-from <stable+bounces-274302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:44:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000375601A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:44:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CIH5EDZR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274302-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274302-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E155730430EC
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BE481FB1;
	Tue, 14 Jul 2026 14:42:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604D481647
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040144; cv=none; b=HEo179fuUvu3ouBNwLIq4eICR/lVBv4sQI4L4kld7g/qtRhZMVQJSld2jxqTxhBK0DNYK8l9GOjySwffEeHFnGyahR/p1J5ciTcqRD6Vo8wNEnNNk5yFpEIJC/6TSjKlUgtBlMroxt0NvXO21BF0UDj8qDDFyXfzqAYE5KxUMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040144; c=relaxed/simple;
	bh=1Eg0Pb12lyB7IZSHTtHRoBt8Iv/f3lDNLg/OZu7xfi8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dfs9Oe0la5oEx6+Wcm+eKPNHI6Z0tOqDUlgiKgzWzBstBtledqRQjhYE/IswbBVD36Ke+oKShM02A62tNHFN5rg3EtY8Y5KzYqQMMvGcDN17VijHy7NnoeprmbKLn7GSUSLHJvphaBYxptN/9OUkXiyC0BDvqcZXjGOliU0GqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIH5EDZR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06111F00A3D;
	Tue, 14 Jul 2026 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040128;
	bh=svqe6bWe7ho3FfkyVxO66ti0QpHyqbg1LPY8WePKL7U=;
	h=Subject:To:Cc:From:Date;
	b=CIH5EDZRH0gi3ezwb5Yg+EzAFBsH/Cfa4zN9OO72WaBYfyIH/xBq4QuJo+iVNeYHt
	 Qu7bAvrMccBmkyPHeu3WniQEC92tQfqjR5D9uPmKFb9v5E/vzWpBt6l2RxgycJpAUY
	 yfpqyjNB+aK8JB5fMfz3mildw75GTLSDbOfIeu8g=
Subject: FAILED: patch "[PATCH] smb: client: mask server-provided mode to 07777 in" failed to apply to 5.10-stable tree
To: nmanthey@amazon.de,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:41:54 +0200
Message-ID: <2026071454-prowler-bucktooth-a71f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274302-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nmanthey@amazon.de,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,amazon.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0000375601A


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e3d9c7160d483fc8f9e225aafad8ecbbc43f3151
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071454-prowler-bucktooth-a71f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3d9c7160d483fc8f9e225aafad8ecbbc43f3151 Mon Sep 17 00:00:00 2001
From: Norbert Manthey <nmanthey@amazon.de>
Date: Thu, 9 Jul 2026 15:54:39 +0000
Subject: [PATCH] smb: client: mask server-provided mode to 07777 in
 modefromsid

When modefromsid is active, parse_dacl() applies the server-provided
sub_auth[2] value from the NFS mode SID to cf_mode without masking to
07777. Apply the correct masking, same as in the read path.

Fixes: e2f8fbfb8d09c ("cifs: get mode bits from special sid on stat")
Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Assisted-by: Kiro:claude-opus-4.6
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 07cf0e578233..9424281a7674 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -962,7 +962,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 				 */
 				fattr->cf_mode &= ~07777;
 				fattr->cf_mode |=
-					le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+					le32_to_cpu(ppace[i]->sid.sub_auth[2]) & 07777;
 				break;
 			} else {
 				if (compare_sids(&(ppace[i]->sid), pownersid) == 0) {


