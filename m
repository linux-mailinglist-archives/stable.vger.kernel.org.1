Return-Path: <stable+bounces-255986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGgRL0CoGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C6C5F94B3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747543144C4D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9E25F7B9;
	Thu, 28 May 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3/27LZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D7330D35;
	Thu, 28 May 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000433; cv=none; b=PwBK+oPu+kC+Sy6TGDI5fLdde9FDZPfykycoWwpMoBXJ5P3l/3uIMSSFwnO/x9ypKKcv2FXgkJ8vjEAribAfefZRv9mxa0dAkXZUcaHwh5IJxpp8v9SfaVRvs/xYwSLoUkAWtADaQrqtKzjA9QDooftJQ+iXZR25DJVi4YFwdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000433; c=relaxed/simple;
	bh=FlLGHm7fDJ7vJodmLvo4aQe6sMl0yG1Y0zj3D9YLWAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfCMoX38aPzd+fksH8VC5/0SHhNQB74NudSPYe064qOgWklABj0eFZfEsdZWHofnSN7Q4gFpuHoqQIp9sG/uHMbUlTCwoMlIktXCxBfFo+IAJuH3BnJNLa0WjRGqrKdMWRJ7djGLkxPZ6dGCe8KLqogSSnZTVxxEQtxmrzMy0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3/27LZ9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED311F000E9;
	Thu, 28 May 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000432;
	bh=qwTK5T+urildgEwb5k3lj6JnrOpAYLfnYk1MO+6K+28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3/27LZ9g86m52xW7XcotsoYx1vzVcUwvStcCVJZpfmA53o1SF7ABZIVWPpd5DpAx
	 sCe0BSD4iMQUms11arOU5aKVTSlFK8brpNUSgqd6uWeunyP+1YzXplmYXlMgPtd/s3
	 R2UMKYsceCn5FF27TOWgBT7HZGZYeVAm5cEfhcEE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rajat Jain <rajatja@google.com>,
	stable <stable@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.12 042/272] sysfs: dont remove existing directory on update failure
Date: Thu, 28 May 2026 21:46:56 +0200
Message-ID: <20260528194630.558451164@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255986-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 73C6C5F94B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 237557b8a81ab948e8332f7c0058e758f081c0a3 upstream.

When sysfs_update_group() is called for a named group and create_files()
fails (e.g. -ENOMEM), internal_create_group() calls kernfs_remove(kn) on
the group directory.  In the update path, kn was obtained via
kernfs_find_and_get() and refers to a directory that already existed
before this call.  Removing it silently destroys a sysfs group that the
caller did not create.

Only remove the directory if we created it ourselves.  On update failure
the directory remains as it is left empty by remove_files() inside
create_files(), but can be repopulated by a retry.

Cc: Rajat Jain <rajatja@google.com>
Fixes: c855cf2759d2 ("sysfs: Fix internal_create_group() for named group updates")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patch.msgid.link/2026052003-uniquely-hastily-c093@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/sysfs/group.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -179,7 +179,7 @@ static int internal_create_group(struct
 	kernfs_get(kn);
 	error = create_files(kn, kobj, uid, gid, grp, update);
 	if (error) {
-		if (grp->name)
+		if (grp->name && !update)
 			kernfs_remove(kn);
 	}
 	kernfs_put(kn);



