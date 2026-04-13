Return-Path: <stable+bounces-237385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAWUIkok3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE443F107D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF39E301E578
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0733161BF;
	Mon, 13 Apr 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGiaHxEd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F7327C1D;
	Mon, 13 Apr 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099319; cv=none; b=DCD4nSlDanwTZcwvp/NK6/DV0nLXKtB6bozpmY5bqgFdpxraldEdJH79YjppYdQU0F8zXprJ8H4hW1tn0xO7YOwsONRiULJfpgkdQMg08O5EkM/boeU4oZ1yuw7GN+TnBe6D75Dm0tLXmCF0UsMvLNSlUKGW/qttGA8pN71FZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099319; c=relaxed/simple;
	bh=EIpapzGe7G3BaZxIYLLGCCpnHItrlhadzNsEWASwLHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kcq5V+NLaI/ou3+4O4EysxVHrBB23ZzgXKg79DjVh2b3G4CtJc9ipzfmWEBDce4hMy/QOb9Eak6WPFYoTLJWnKwW4mlsyiBw4w9WrzzFW813Khc0G7vUVMo1K/lZg/YZSvNDh1JBS9k1Q9mhNdqMv+z/m3E7xHyZjTOyv2h+dBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGiaHxEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890B1C2BCB8;
	Mon, 13 Apr 2026 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099318;
	bh=EIpapzGe7G3BaZxIYLLGCCpnHItrlhadzNsEWASwLHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGiaHxEd3EWOR21sHzKnmRuATTsJGdELHgepSFRUTpn629J5W5DvqBlf3lB9flaXJ
	 k3axrQcRLEAGoGfXMzvUEMnFcPsAyJ/5T4ZQ5S8S9u+EGlKzeo+p35iMwH9dyiNMS/
	 Qs38v2cPmp1/Va6J05Gq3UbqliOlyCEP0lN/nyDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.10 295/491] s390/barrier: Make array_index_mask_nospec() __always_inline
Date: Mon, 13 Apr 2026 17:59:00 +0200
Message-ID: <20260413155830.088738391@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237385-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CE443F107D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit c5c0a268b38adffbb2e70e6957017537ff54c157 upstream.

Mark array_index_mask_nospec() as __always_inline to guarantee the
mitigation is emitted inline regardless of compiler inlining decisions.

Fixes: e2dd833389cc ("s390: add optimized array_index_mask_nospec")
Cc: stable@kernel.org
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/barrier.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -56,8 +56,8 @@ do {									\
  * @size: number of elements in array
  */
 #define array_index_mask_nospec array_index_mask_nospec
-static inline unsigned long array_index_mask_nospec(unsigned long index,
-						    unsigned long size)
+static __always_inline unsigned long array_index_mask_nospec(unsigned long index,
+							     unsigned long size)
 {
 	unsigned long mask;
 



