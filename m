Return-Path: <stable+bounces-178107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B037B47D47
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B4B3BED40
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131A2836A0;
	Sun,  7 Sep 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HiatUZtH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A01CDFAC;
	Sun,  7 Sep 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275786; cv=none; b=ldA28o8MkgvsYWEy0nJgv3QwOicrqsWb4nDvjt3JctvTNKPfGvjk1j8f5lHx3qVrqCy8kYgC5v4rOBGVVC29esqKTjP5RBL+z8q3iFEERoGjuBAsqq6UTYu07qZlsjdQocDTynf2iOPjKxN7/zcZEWHN3fZj4G2sixNKhrruTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275786; c=relaxed/simple;
	bh=4POVdGVR9JXrenJ15HWnb6ts8oy018o/4EEDPBtS0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK7QlYuUeVgbKGoXzJUXuC3PmUf8CbmxSioUWfGDqvXlYliXJXXs4zvu/r+47FJFU3HTuDWQwumf72V2B6Yop2HLnJGCDo9MLSOtWERbxV613EkKuIoBIFNrX/7bis+k6nRKa4JlG9M413fRuxxWvRfi6c6J5JnhcCpS6GaXLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HiatUZtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DBDC4CEF0;
	Sun,  7 Sep 2025 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275786;
	bh=4POVdGVR9JXrenJ15HWnb6ts8oy018o/4EEDPBtS0R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiatUZtHfJTPNW/va3t6VFOHEneJRvli8V2fBmWmfXOAMPOEeZQ7m68wdyeh0Uzc6
	 HpIzD6/RhqD+lrVlsz4Mct5XkYWKdeaV3zrMXo8thrzLAMCfLDy4yc7xc8fhLAL8Ie
	 OL3uV7OyOyBoxxD16zTcaR+AllVRCDqmL42Cf//k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 03/45] netfilter: conntrack: helper: Replace -EEXIST by -EBUSY
Date: Sun,  7 Sep 2025 21:57:49 +0200
Message-ID: <20250907195601.058935618@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
References: <20250907195600.953058118@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 54416fd76770bd04fc3c501810e8d673550bab26 ]

The helper registration return value is passed-through by module_init
callbacks which modprobe confuses with the harmless -EEXIST returned
when trying to load an already loaded module.

Make sure modprobe fails so users notice their helper has not been
registered and won't work.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 32cc91f5ba99f..89174c91053ed 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -417,7 +417,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 			    (cur->tuple.src.l3num == NFPROTO_UNSPEC ||
 			     cur->tuple.src.l3num == me->tuple.src.l3num) &&
 			    cur->tuple.dst.protonum == me->tuple.dst.protonum) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
@@ -428,7 +428,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 		hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
 			if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple,
 						     &mask)) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
-- 
2.50.1




