Return-Path: <stable+bounces-211072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE+dNWozcWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:13:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A625CEB1
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E228A4EDEA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63F3B8D46;
	Wed, 21 Jan 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RAC+3RIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7D330678;
	Wed, 21 Jan 2026 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020346; cv=none; b=T5/5Lv2Gylv5yVgcNpmzkdDGcwKt/dbAtWER+aAVHVUX6+8xWwHMaQbRw0Azp3f2tyDS78QPixMSS2HEYGBCvlvzFAw2Xc4ZIAMb8xejM7SKzI34GgRC67DEVPhRYH7VJVj90da7ncCqvGUpHrwGNbYy9nBzFB96LgXesMbC7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020346; c=relaxed/simple;
	bh=Hgn6n1O3ODqG75AOJEOv/t51o8bQWTy9g+mGTy+u2s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfznrUHzc2BJ/94L3uxhDTmL5fhAid4Uoxsfxj8U738797+9sVEsD/Q8ohLZqDDQCRfB280WrqvqDpb8lB1kaoGeqkWGGQ12BC9kyRH/2myfnfB0sINpoCXv5KR7Z3boaxLL9sBd4tEJ99RDl/3MfLWdqhTUZQGR0ZxHDYjuv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RAC+3RIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD41C4CEF1;
	Wed, 21 Jan 2026 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020345;
	bh=Hgn6n1O3ODqG75AOJEOv/t51o8bQWTy9g+mGTy+u2s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAC+3RIpPd5eBiHuXE39SEAeo1YOqcMw4L9nSNCM8v/dToi5x/DAAojDijDh+/oyL
	 U/H1jroJ2stFRVN7XqvnWqRwwWfp9c2DVZWjDKgXI96Ma0mfwVUiu3K8yLcWYP5tBB
	 mxoftqa9r9bYg5DsF3NFMu0cwDenfaGKtGW8CD94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Erkun <yangerkun@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.18 129/198] ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref
Date: Wed, 21 Jan 2026 19:15:57 +0100
Message-ID: <20260121181423.191272375@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211072-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,huawei.com:email,iloc.bh:url]
X-Rspamd-Queue-Id: 26A625CEB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Erkun <yangerkun@huawei.com>

commit d250bdf531d9cd4096fedbb9f172bb2ca660c868 upstream.

The error branch for ext4_xattr_inode_update_ref forget to release the
refcount for iloc.bh. Find this when review code.

Fixes: 57295e835408 ("ext4: guard against EA inode refcount underflow in xattr update")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20251213055706.3417529-1-yangerkun@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1037,6 +1037,7 @@ static int ext4_xattr_inode_update_ref(h
 		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
 			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",
 			ea_inode->i_ino, ref_count, ref_change);
+		brelse(iloc.bh);
 		ret = -EFSCORRUPTED;
 		goto out;
 	}



