Return-Path: <stable+bounces-236379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLpzA60Y3Wn3ZwkAu9opvQ
	(envelope-from <stable+bounces-236379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF53EECFA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA4D30C86C0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FF283FEF;
	Mon, 13 Apr 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jh6Spzxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB32765FF;
	Mon, 13 Apr 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096754; cv=none; b=EB4b15Am0d9aQDDZThWBuIeTK7Djbu8abmy59F0uBMoSoEFC69grKzzJmD+zBeDvNE0JZsul4NCqLjRYEITSnNdCGYxAtK6dGsrOpFKvFefoYQ+u8Ius71ARclkoM4u9fhA/EUfZVLRgLHCRT0jJvjpXlfjBG6lFaJz41iwaoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096754; c=relaxed/simple;
	bh=FCS3r5MiBOQ5NQOYtULG18z4vH+Nhnl4uEIof6zt9Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r83rMiSv7l3ofyakZiVoSpfLEZlVNnDmGl/WLQ+RqL+aMvCo2RE85RH/F/yct3GpoTfZWZ77bMWF5noV1xlWe3jt/xjSb9M5iWcx7yrxH5KkMb2XlAORj/BffmVgD63OXm12t5WJATmvWOemfrVG3gxSLl13cuw4ULLMGcmZAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jh6Spzxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D64C2BCAF;
	Mon, 13 Apr 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096753;
	bh=FCS3r5MiBOQ5NQOYtULG18z4vH+Nhnl4uEIof6zt9Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jh6SpzxbsEuFPnRTf4RiUj3/D2d8TKRDC6txtGaEi+uYGWS0bhw+cotGzdq+sciJv
	 PCAbbyVzh9v0Ta+mb2SJflUyzaMlrt6CB7Db3ZwfONXIFJEDtZ9oLmZBcXJUc7gBWQ
	 HLdKLjF0bozT6ZSpnlefRhp2V4YsV1SWjLGVv5jk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 17/70] btrfs: remove unused flag EXTENT_BUFFER_READAHEAD
Date: Mon, 13 Apr 2026 18:00:12 +0200
Message-ID: <20260413155728.830660975@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236379-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 86AF53EECFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vacek <neelx@suse.com>

[ Upstream commit 350362e95fbbe86008c240093697756d52049686 ]

This flag is no longer being used.  It was added by commit ab0fff03055d
("btrfs: add READAHEAD extent buffer flag") and used in commits:

79fb65a1f6d9 ("Btrfs: don't call readahead hook until we have read the entire eb")
78e62c02abb9 ("btrfs: Remove extent_io_ops::readpage_io_failed_hook")
371cdc0700c7 ("btrfs: introduce subpage metadata validation check")

Finally all the code using it was removed by commit f26c92386028 ("btrfs: remove
reada infrastructure").

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 316fb1b3169e ("btrfs: fix incorrect return value after changing leaf in lookup_extent_data_ref()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f21fd8b50abc8..4126fe7f3f10e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -39,8 +39,6 @@ enum {
 	EXTENT_BUFFER_UPTODATE,
 	EXTENT_BUFFER_DIRTY,
 	EXTENT_BUFFER_CORRUPT,
-	/* this got triggered by readahead */
-	EXTENT_BUFFER_READAHEAD,
 	EXTENT_BUFFER_TREE_REF,
 	EXTENT_BUFFER_STALE,
 	EXTENT_BUFFER_WRITEBACK,
-- 
2.53.0




