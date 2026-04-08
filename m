Return-Path: <stable+bounces-234999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHTvOJep1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-234999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:16:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C32D3C2AB9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE00306A935
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C08337B81;
	Wed,  8 Apr 2026 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DfVykaxK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EB34AB06;
	Wed,  8 Apr 2026 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674309; cv=none; b=uXyss0iEmhzHpG+clcEK+0GG+0sfFsieWZjJz1si8IUnTsfdVIUR1kEglqiMrizPZfFOUgiyetWaBaZgelfA+ogG/BwuyjMR9OU3WAh0QZ5/KVbvxVraNL96Ys/SZByPFEq+ELcFE4WBdOt/DL2pdRgOYAi2NTmYb+Z5euzwG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674309; c=relaxed/simple;
	bh=fu5jvsuRHwVxaU7c5Chzn3MSdwOJIPfw19jN+fcD5+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLHRkdwbcRKfWg5hPj3eeVgc3YsDqJJB93zt98uOqGqocl/rL7uBN/AGIQw6UXdE0S2rtt95QU9RzhbcypI7Mola9q3LjCNer8phbJU5SbPDsUEyf4XfKsVixEkp3+4XJ8Vk+ynS3d48xmM0Kmn0oUBiRwhXxlUa3OuvzTDHxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DfVykaxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4AC19421;
	Wed,  8 Apr 2026 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674309;
	bh=fu5jvsuRHwVxaU7c5Chzn3MSdwOJIPfw19jN+fcD5+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfVykaxKTInGl3bYngIJVdxq6LXdGNQoT8pWzlvpmzgj2gtynAaSX1oqhbomJVGr1
	 twZ9Map0ZxnC1wxRjvxzDGPqVADbXOO+xzBC7W1m7gEMw6DBMB4hD6SLjKlnP+ZO1P
	 1sZgWYgAlHTZYzlxys8TC4sqqYAMVO+lIFVW1Huw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yochai Eisenrich <echelonh@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 048/311] net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
Date: Wed,  8 Apr 2026 20:00:48 +0200
Message-ID: <20260408175941.209419020@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234999-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C32D3C2AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yochai Eisenrich <echelonh@gmail.com>

[ Upstream commit ae05340ccaa9d347fe85415609e075545bec589f ]

When processing Router Advertisements with user options the kernel
builds an RTM_NEWNDUSEROPT netlink message. The nduseroptmsg struct
has three padding fields that are never zeroed and can leak kernel data

The fix is simple, just zeroes the padding fields.

Fixes: 31910575a9de ("[IPv6]: Export userland ND options through netlink (RDNSS support)")
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260324224925.2437775-1-echelonh@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ndisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af97..186e60c792145 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1209,6 +1209,9 @@ static void ndisc_ra_useropt(struct sk_buff *ra, struct nd_opt_hdr *opt)
 	ndmsg->nduseropt_icmp_type = icmp6h->icmp6_type;
 	ndmsg->nduseropt_icmp_code = icmp6h->icmp6_code;
 	ndmsg->nduseropt_opts_len = opt->nd_opt_len << 3;
+	ndmsg->nduseropt_pad1 = 0;
+	ndmsg->nduseropt_pad2 = 0;
+	ndmsg->nduseropt_pad3 = 0;
 
 	memcpy(ndmsg + 1, opt, opt->nd_opt_len << 3);
 
-- 
2.53.0




