Return-Path: <stable+bounces-259227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAS6HToyG2qkAAkAu9opvQ
	(envelope-from <stable+bounces-259227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098F612C22
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B85B300D60E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7C2233952;
	Sat, 30 May 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uObI1jUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9F137750;
	Sat, 30 May 2026 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167035; cv=none; b=PPhSftLVVaJHLQOyL4IjAMVNSJzbGy5OMY8ueokDwnpmNQdA7ixS03bOVgn9YHSDgTdWQfsjsQFdm8QXJxt7Xa18o7z8UBHiKoMwkeCfBtsbPIqKwnijgb5Uy0/UtffH/7EThRznZeQDl890xKHyEtxi3NkmzuyDlMca4+kRr3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167035; c=relaxed/simple;
	bh=t6MtQl5MGlS2zbZYo+qM1XFIRQC3y4+0Kn1onRv6Rw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bG8bivYj0TZjJCJKk08hDbzsi3HHvlBBCxWtqEBSpJIb2nRFyGR/XfMDU0gxy9KAhJNf6hQCWyKvmG50qcFbBzQS/nCfrxaYlPFrzTm7moyf6ZqoJ3B5HSYvMiTKk+3Y/sFBGwEcui7VoZKuVkgswzpNzWDh0lBsysjA7CzRkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uObI1jUd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF51D1F00893;
	Sat, 30 May 2026 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167034;
	bh=9HiK0aRlCeALyeRKFy0fygZDId6vhsvY94UJ/d3/RR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uObI1jUdGkbowrAzdA5CgkFAqdduT7CkWgpU+FO0UPmhVwKBqzjGoSgJBE1MccwRM
	 hxp834woDkw1x9Yr1TG5IOYZY/o+i3zVKq58yJemBUhy+HCWknqF9oo5QZ0lR4ZlG6
	 gQp30I0ZQlpwPKW5B+iDX7hQ2p96wofPHdBSUH3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Xiasong <lixiasong1@huawei.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.10 505/589] netfilter: nft_ct: fix missing expect put in obj eval
Date: Sat, 30 May 2026 18:06:26 +0200
Message-ID: <20260530160237.877303557@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259227-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1098F612C22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Xiasong <lixiasong1@huawei.com>

commit 19f94b6fee75b3ef7fbc06f3745b9a771a8a19a4 upstream.

nft_ct_expect_obj_eval() allocates an expectation and may call
nf_ct_expect_related(), but never drops its local reference.

Add nf_ct_expect_put(exp) before return to balance allocation.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_ct.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1296,6 +1296,8 @@ static void nft_ct_expect_obj_eval(struc
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;
+
+	nf_ct_expect_put(exp);
 }
 
 static const struct nla_policy nft_ct_expect_policy[NFTA_CT_EXPECT_MAX + 1] = {



