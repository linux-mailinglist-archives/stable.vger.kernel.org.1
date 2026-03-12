Return-Path: <stable+bounces-225042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFiwKkogs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:21:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE3278D82
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9DE331632DD
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167E312815;
	Thu, 12 Mar 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQXVrLQb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA12BEFFD;
	Thu, 12 Mar 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346725; cv=none; b=W9NB8M9US1WOjTNkXoSdv442rLEyVejgzR79H2dh642ZdI+3tjF53jR/d51KUHWDEZmDINP7if04TsufsdGSfnAcl8o43E59NYk7fqMSfFCGq7UWqCfXvc1mmqz7LsnfRyhPM7zP/o7H9tERbwmzzkHSR3qwr0Tea+5aWtIK4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346725; c=relaxed/simple;
	bh=lZRQJ0ebc5YPWldPMP88CvoqPrMXAajegdkrEuSOX+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKUBYrIJnZ1AwDflAjKUF6iJ5pE8DgP1XFe82I7Hq/sIoelDvCfMxlbRUa4oJG22yYbDDASBCCIykhrj+qs2yL6q94KfMfNV3VyJBua8UzZ9WJh/IEN+KXAp28eRUR1FIIkGYRJegGVK8DWGYQOUX6fiPzGNVpSztPUQ7c3sJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQXVrLQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2597C4CEF7;
	Thu, 12 Mar 2026 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346724;
	bh=lZRQJ0ebc5YPWldPMP88CvoqPrMXAajegdkrEuSOX+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQXVrLQb5kbm68WiDhL+DOcPJdE5xyavkL7LPva6WPDSjZF8WNrX0V9+UYmZmCJ88
	 LS14YPWLWU3DWoifECU92+KKgkUid62bB5BraOzDorzydesq4DYNH2xag0n+ipE3rd
	 9t/77bET/7mukWgX4KFWJ/UAhQ7ddZbopUsfqtss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 108/265] btrfs: define the AUTO_KFREE/AUTO_KVFREE helper macros
Date: Thu, 12 Mar 2026 21:08:15 +0100
Message-ID: <20260312201022.137761356@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225042-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 2EEE3278D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Sabaté Solà <mssola@mssola.com>

[ Upstream commit d00cbce0a7d5de5fc31bf60abd59b44d36806b6e ]

These are two simple macros which ensure that a pointer is initialized
to NULL and with the proper cleanup attribute for it.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 52ee9965d09b ("btrfs: zoned: fixup last alloc pointer after extent removal for RAID0/10")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/misc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 0d599fd847c9b..1212674d7a1b4 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -10,6 +10,13 @@
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
+/*
+ * Convenience macros to define a pointer with the __free(kfree) and
+ * __free(kvfree) cleanup attributes and initialized to NULL.
+ */
+#define AUTO_KFREE(name)       *name __free(kfree) = NULL
+#define AUTO_KVFREE(name)      *name __free(kvfree) = NULL
+
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
  */
-- 
2.51.0




