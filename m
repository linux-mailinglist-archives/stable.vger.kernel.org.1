Return-Path: <stable+bounces-203545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4868CE6B50
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866F63008199
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB730B539;
	Mon, 29 Dec 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XtXb0G9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C1275AE4
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011728; cv=none; b=tAOApJum0satSMDLes1J47AbXQ2dnaseu1hgGzWw8mrikV39Ivn7fGcqP6E3l3Tb5tCaVatSHJT/2lXYBhoi1TTWwowVlAvTEqasZoru21pnNVrFZsMLkbP8Yx0rxpXdKOi3A8Ookpg0nH9w9aBNI4WnJ2EYUKWfzj2GmF7YTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011728; c=relaxed/simple;
	bh=7syWpHHTlMwmmdf4MlT8ui90+R2MSYLTXW79xUoJ7JI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eU/pv2xqJv3TgM/1y2iS/Yfon9nhLJuzLV5AHigK3F+9nccTkvxkZEx/Rmu1QsQQe9Z8yXK7CLQtZAYSeRyTF+JACGQS9cndF2RR5tEhpAgkhFJxHK7ZxOP/PptQ3bG5p4xIlrVgi7YA96lB4/api/sCxd0MNtP8/g0/ux1ff0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XtXb0G9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2A6C4CEF7;
	Mon, 29 Dec 2025 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767011727;
	bh=7syWpHHTlMwmmdf4MlT8ui90+R2MSYLTXW79xUoJ7JI=;
	h=Subject:To:Cc:From:Date:From;
	b=XtXb0G9HszUQeIdZVkMyhhD1+KC60XlfJSvLNSypqQvHJOYN4nBcxD5BY/YWKAG7C
	 GqB6UKUhjWFAgjIz3ExAaU3chrEgYdoRNLzjc/sG0+LuoT6MJNGEUIVt4ZxSf5FcmH
	 8A6zVUDdEOUF+7zuR0XtLRkCQhWe3MhiEmb2mgHc=
Subject: FAILED: patch "[PATCH] mptcp: pm: ignore unknown endpoint flags" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 13:35:22 +0100
Message-ID: <2025122922-cedar-reapply-f9d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0ace3297a7301911e52d8195cb1006414897c859
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122922-cedar-reapply-f9d1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ace3297a7301911e52d8195cb1006414897c859 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 5 Dec 2025 19:55:14 +0100
Subject: [PATCH] mptcp: pm: ignore unknown endpoint flags

Before this patch, the kernel was saving any flags set by the userspace,
even unknown ones. This doesn't cause critical issues because the kernel
is only looking at specific ones. But on the other hand, endpoints dumps
could tell the userspace some recent flags seem to be supported on older
kernel versions.

Instead, ignore all unknown flags when parsing them. By doing that, the
userspace can continue to set unsupported flags, but it has a way to
verify what is supported by the kernel.

Note that it sounds better to continue accepting unsupported flags not
to change the behaviour, but also that eases things on the userspace
side by adding "optional" endpoint types only supported by newer kernel
versions without having to deal with the different kernel versions.

A note for the backports: there will be conflicts in mptcp.h on older
versions not having the mentioned flags, the new line should still be
added last, and the '5' needs to be adapted to have the same value as
the last entry.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-1-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 04eea6d1d0a9..72a5d030154e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -40,6 +40,7 @@
 #define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
 #define MPTCP_PM_ADDR_FLAG_LAMINAR		_BITUL(5)
+#define MPTCP_PM_ADDR_FLAGS_MASK		GENMASK(5, 0)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d5b383870f79..7aa42de9c47b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -119,7 +119,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	}
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));


