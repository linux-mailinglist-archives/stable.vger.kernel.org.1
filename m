Return-Path: <stable+bounces-236178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM6zKw8U3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:04:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDC3EE493
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50507302D0A5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9026982C;
	Mon, 13 Apr 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cda9TNgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810B24E4AF;
	Mon, 13 Apr 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096244; cv=none; b=jKrsjkUB4H6Vf5W9rkJiP7hcUdworsW3pkp9aw/NwXJnthu25j21xjQX9e+NKxmWlfw3flC97I2QKcp6qExVvN57VMz7DmTQJBEn/MUoqZNQtecWda7fsa00fwyCoyuVSyxDuUbdOsoCf6a98DxSpw2pKff4mBMbrwHYzVXRkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096244; c=relaxed/simple;
	bh=u3t8ySsbIJ9VKPPe97ZZAq4yh4kU3aUn8pz/JvxvvAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSWuT3n5q2ozNknpy8WUd1twLQsdL7ZzRAmlWG5YRgSpQ0R8rcymLXQSbx2kk79jtyAMIblclArL1A6ACVLPLsknNYQ2z1lS8Ynbp/JXeyTa5+5YLDjdWw2BUkD1CZPKdyRULOLGjDzintEfRfLRyEObXG4wzeMJfTPwTRbw7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cda9TNgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC2AC2BCB4;
	Mon, 13 Apr 2026 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096243;
	bh=u3t8ySsbIJ9VKPPe97ZZAq4yh4kU3aUn8pz/JvxvvAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cda9TNgDZCHBPG2E8Q77rOsDnEXL8JDzqDXmKH2wy4GYzmkgaAzPmDZbZdZAdPC96
	 SExwQRIWV+UcMvAzd0vviIFHfpYIAbSILzOi2VwtXDGxynkrw2dLX8Sg9k3hEK0QEV
	 1nJMHO1nsHBJ4Pt66+zSsxJCH/Ai+5VXFVOZC4j4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6.19 22/86] xfrm: clear trailing padding in build_polexpire()
Date: Mon, 13 Apr 2026 17:59:29 +0200
Message-ID: <20260413155732.406752080@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,debian.org,secunet.com];
	TAGGED_FROM(0.00)[bounces-236178-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2ACDC3EE493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

commit 71a98248c63c535eaa4d4c22f099b68d902006d0 upstream.

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3951,6 +3951,8 @@ static int build_polexpire(struct sk_buf
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;



