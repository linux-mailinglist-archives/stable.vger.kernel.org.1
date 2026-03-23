Return-Path: <stable+bounces-228907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kApHD4FYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 961242F5FB1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBCA33235F9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E253B19B3;
	Mon, 23 Mar 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0w1T9FC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB983AC0EB;
	Mon, 23 Mar 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277455; cv=none; b=tC9uXzIYcnIfDrNSOQlIjJPXMdNrT7cZrA/Ik2Ve2g+DreJqLlxMbgsWLrFUeXFKk+sHgrd/BViL9cIJe2y/jRitBUxzqgy8QV1VUU67gu5nedxM1wnC90MWmL4z55Gs8sZwDBMnO8Kj7G2SSnbSxdFwdw3HIxhc8Gpbi0lXxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277455; c=relaxed/simple;
	bh=V+JNWGNPwL2CETUlI41xQqxjExtGPAFCidUVBfJI0yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0aEKahj63y9PrrbLQowIsVp7/5uc23MnLpWdnV1fiBNVG5kM2S1ZdlEzrF5swSjBmxZZtatkQArtzAjsLLSWTOGm0eJmbVp6N+tEQ0Gc5k0lH/IzWlaN/cwi5umIz7/mJ9LdquZ/xpqEOwYDTIeAh9aUrl8J1QOJBEgH401oYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S0w1T9FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28025C4CEF7;
	Mon, 23 Mar 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277455;
	bh=V+JNWGNPwL2CETUlI41xQqxjExtGPAFCidUVBfJI0yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0w1T9FCzKnAmf0KqOaP0tgbf91S5EMDWuq4Xy6XKgBCkQpFo5zhGmtlrLvHo7qwJ
	 zQBBUH2Tf3/rSjewx+cG8CLa/bV881LvLGatCnAi4DeLMrPKIMfkcfsMO859gvs+sJ
	 9isbs6CQwePqjTediloBqcPcqWRZ58vQRXBV4g3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Hugh Dickins <hughd@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 446/460] mm: shmem: avoid unpaired folio_unlock() in shmem_swapin_folio()
Date: Mon, 23 Mar 2026 14:47:22 +0100
Message-ID: <20260323134537.542976066@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228907-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 961242F5FB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit e08d5f515613a9860bfee7312461a19f422adb5e upstream.

If we get a folio from swap_cache_get_folio() successfully but encounter a
failure before the folio is locked, we will unlock the folio which was not
previously locked.

Put the folio and set it to NULL when a failure occurs before the folio is
locked to fix the issue.

Link: https://lkml.kernel.org/r/20250516170939.965736-1-shikemeng@huaweicloud.com
Link: https://lkml.kernel.org/r/20250516170939.965736-2-shikemeng@huaweicloud.com
Fixes: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ hughd: removed series cover letter comments ]
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/shmem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2198,6 +2198,8 @@ static int shmem_swapin_folio(struct ino
 		 */
 		split_order = shmem_split_large_entry(inode, index, swap, gfp);
 		if (split_order < 0) {
+			folio_put(folio);
+			folio = NULL;
 			error = split_order;
 			goto failed;
 		}



