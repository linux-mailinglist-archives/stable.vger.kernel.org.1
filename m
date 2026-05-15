Return-Path: <stable+bounces-248285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K+6K6FJB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:28:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386E5533B5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B842730AD50B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0F3F58FF;
	Fri, 15 May 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ruaLytPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886E3FD94B;
	Fri, 15 May 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861343; cv=none; b=TxaFNlaHACRidkFZWa8QAObrDFqMiW1K3dlvYcI9U4knghzpNWy6fD3sBl6dLafrktxStI5Jz4yRv5Q0a2It4hNJwGBi2moCv8JC7P4bKI0TsjfQkzZ/6TAQdXJKrut1cjKS0hHmjF0JbYwOd++upCHk8VlOlKwSqix0NLa3HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861343; c=relaxed/simple;
	bh=Fj8vwlcxo5N47lgH+0rzXjzZe4rmCqbpUUlKCYi1n6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmVGWbBURiT0vUEUZE578W7BlK4AfM3AZgOGnK+JfdiC1FCiJLBsTmR6wkPPdMZw/nATBPeidiYAmOS0LbxnGnwBwsxl8zfIwmjsySSejK0pqfzluCQ1/YTv6MGaVQf9PKqH1UlgCs5dE9+AIeflvqjxPpxEOYqLuNDGTm9E/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ruaLytPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3636C2BCB3;
	Fri, 15 May 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861343;
	bh=Fj8vwlcxo5N47lgH+0rzXjzZe4rmCqbpUUlKCYi1n6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruaLytPPV6D9bhRGhWUNVe/KGH6m7tn4TyxhtLi0Zv8KrU3P8HmPmFs3bAk7iSrYa
	 4V/1stD8LzhAGNXPPzJxv6G9EM+tAmYJVbFFtdXQ4WtFe8PzCU7nR+B9L0C7wfDM3Y
	 +30nnwb7/x22G67Gce6zlcEeirboH1T20ZGvFph0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 250/474] btrfs: fix double free in create_space_info() error path
Date: Fri, 15 May 2026 17:45:59 +0200
Message-ID: <20260515154720.407344604@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6386E5533B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248285-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

commit 3f487be81292702a59ea9dbc4088b3360a50e837 upstream.

When kobject_init_and_add() fails, the call chain is:

create_space_info()
-> btrfs_sysfs_add_space_info_type()
-> kobject_init_and_add()
-> failure
-> kobject_put(&space_info->kobj)
-> space_info_release()
-> kfree(space_info)

Then control returns to create_space_info():

btrfs_sysfs_add_space_info_type() returns error
-> goto out_free
-> kfree(space_info)

This causes a double free.

Keep the direct kfree(space_info) for the earlier failure path, but
after btrfs_sysfs_add_space_info_type() has called kobject_put(), let
the kobject release callback handle the cleanup.

Fixes: a11224a016d6d ("btrfs: fix memory leaks in create_space_info() error paths")
CC: stable@vger.kernel.org # 6.19+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/space-info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -293,7 +293,7 @@ static int create_space_info(struct btrf
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)



