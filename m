Return-Path: <stable+bounces-229819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP7vMjF1wWl5TQQAu9opvQ
	(envelope-from <stable+bounces-229819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:15:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D54882F9A46
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2EE63131139
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330829ACC5;
	Mon, 23 Mar 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gn5xL2of"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A93AEF5C;
	Mon, 23 Mar 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282950; cv=none; b=W6T0a6kITIDdP6FzibU1/i/oTORQZCVC3b1uATvpbThYKYm6djeeG7PdeKM/y5rgQs8dTmoI67O46n4uU0WklTzA289+j806m8HDDbsekel0KxTasUQRmiKyTP/ayVtfnlXpDpUZ7EB0S9UsiIZjdP+QlJkedQ+CgglZtj+43I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282950; c=relaxed/simple;
	bh=p+1Ft8At5YP8l1pF8JVSFtS32cnqv9sFbkQIUL0RQN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujYbsaujxIbwMwhxGANzQesUhLW8WC9s0ghiPtHsRytVfrZc8jvpxeOK1xWHyYwSqyJW3r0S3GuLikHv9dvd7RuFe1V4eZZ78aaa1YoA2GiOYkJC3VPlcuoxmXd87D2eB7+eaXpOfcG0jiZ+yKYKV1Vc2NBb03yuPkUPzTWxFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gn5xL2of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C6C4CEF7;
	Mon, 23 Mar 2026 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282950;
	bh=p+1Ft8At5YP8l1pF8JVSFtS32cnqv9sFbkQIUL0RQN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gn5xL2ofT7VzyLBAn6ulvYTana9i2G4qM3Kq5DrRKj8svomVS2qVXCdhIJG2400vQ
	 bkUwztTbmT+ZwTXRVdEibSoDETK5a1QOgikAK789fZur26XFYI8TyG/zWcmWp+MYTA
	 NaaiG/I5F3GftVjQNsKZ+ZhW6UV3Z/ZJ53HxgC9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 346/481] xfs: fix integer overflow in bmap intent sort comparator
Date: Mon, 23 Mar 2026 14:45:28 +0100
Message-ID: <20260323134533.533249918@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229819-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D54882F9A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 362c490980867930a098b99f421268fbd7ca05fd ]

xfs_bmap_update_diff_items() sorts bmap intents by inode number using
a subtraction of two xfs_ino_t (uint64_t) values, with the result
truncated to int. This is incorrect when two inode numbers differ by
more than INT_MAX (2^31 - 1), which is entirely possible on large XFS
filesystems.

Fix this by replacing the subtraction with cmp_int().

Cc: <stable@vger.kernel.org> # v4.9
Fixes: 9f3afb57d5f1 ("xfs: implement deferred bmbt map/unmap operations")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ replaced `bi_entry()` macro with `container_of()` and inlined `cmp_int()` as a manual three-way comparison expression ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_bmap_item.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -277,7 +277,8 @@ xfs_bmap_update_diff_items(
 
 	ba = container_of(a, struct xfs_bmap_intent, bi_list);
 	bb = container_of(b, struct xfs_bmap_intent, bi_list);
-	return ba->bi_owner->i_ino - bb->bi_owner->i_ino;
+	return (ba->bi_owner->i_ino > bb->bi_owner->i_ino) -
+		(ba->bi_owner->i_ino < bb->bi_owner->i_ino);
 }
 
 /* Set the map extent flags for this mapping. */



