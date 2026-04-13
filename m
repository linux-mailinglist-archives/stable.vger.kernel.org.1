Return-Path: <stable+bounces-237576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMdJO+kl3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:20:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2A33F1354
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDB9D310C259
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68EC335072;
	Mon, 13 Apr 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y64C7Ers"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DD3016EE;
	Mon, 13 Apr 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099811; cv=none; b=UzVoezYWjxyT0cpgKGKUUqGjtn7aKsQsZva/Rk274VLNlPcyhHQh5zk1Z81w6VELJa5Y3xd0P804K2pguiZ5qFtPtre/LWgvLpd7yFAgbCZR/10/ZdzW1ktep2HsHuQzWhl85WEq9CsllqtzokLmfdeBKe+YnWKZi1+Wv0Po0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099811; c=relaxed/simple;
	bh=TuLnoJRk9khNWy0MQi0/zB/tfK9CjaPVafKzRODo+Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDMbWWhkA35V+1444elVBOaZ8r2qLQvLDnHXuCvdspWkFI15Jz4PLirqpA4HSfQfZWlntBzMO443ke2AGbAIg27P+pSsEmGe3Yh4MJ6Zni8L6NwMbLzNGSOHTJZ0e1TC/tTwa9ppeNRp16Pay03MC0i1oTsdZoyLVJJVp3HE9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y64C7Ers; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D98C2BCAF;
	Mon, 13 Apr 2026 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099811;
	bh=TuLnoJRk9khNWy0MQi0/zB/tfK9CjaPVafKzRODo+Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y64C7ErsoRBqT30WfpViFWnsHQHX6AfBSIncSI5GgwvG52Grh/VlhWfZXPTkxgm50
	 JPoeHQwbOwfoEWmfXUTmFeNKNTrTB4UfTVoTkvAT5hPX/WQzV+DqZezc9j9ZS8UWkH
	 8lTxN0XlNPnjFXmcB/9vguYhWxWSw9MagMcVewmI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com,
	xingwei lee <xrivendell7@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 456/491] netlink: add nla be16/32 types to minlen array
Date: Mon, 13 Apr 2026 18:01:41 +0200
Message-ID: <20260413155836.107008522@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237576-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,strlen.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,3f497b07aa3baf2fb4d0];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: EF2A33F1354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 9a0d18853c280f6a0ee99f91619f2442a17a323a upstream.

BUG: KMSAN: uninit-value in nla_validate_range_unsigned lib/nlattr.c:222 [inline]
BUG: KMSAN: uninit-value in nla_validate_int_range lib/nlattr.c:336 [inline]
BUG: KMSAN: uninit-value in validate_nla lib/nlattr.c:575 [inline]
BUG: KMSAN: uninit-value in __nla_validate_parse+0x2e20/0x45c0 lib/nlattr.c:631
 nla_validate_range_unsigned lib/nlattr.c:222 [inline]
 nla_validate_int_range lib/nlattr.c:336 [inline]
 validate_nla lib/nlattr.c:575 [inline]
...

The message in question matches this policy:

 [NFTA_TARGET_REV]       = NLA_POLICY_MAX(NLA_BE32, 255),

but because NLA_BE32 size in minlen array is 0, the validation
code will read past the malformed (too small) attribute.

Note: Other attributes, e.g. BITFIELD32, SINT, UINT.. are also missing:
those likely should be added too.

Reported-by: syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/all/CABOYnLzFYHSnvTyS6zGa-udNX55+izqkOt2sB9WDqUcEGW6n8w@mail.gmail.com/raw
Fixes: ecaf75ffd5f5 ("netlink: introduce bigendian integer types")
Signed-off-by: Florian Westphal <fw@strlen.de>
Link: https://lore.kernel.org/r/20240221172740.5092-1-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/nlattr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -30,6 +30,8 @@ static const u8 nla_attr_len[NLA_TYPE_MA
 	[NLA_S16]	= sizeof(s16),
 	[NLA_S32]	= sizeof(s32),
 	[NLA_S64]	= sizeof(s64),
+	[NLA_BE16]	= sizeof(__be16),
+	[NLA_BE32]	= sizeof(__be32),
 };
 
 static const u8 nla_attr_minlen[NLA_TYPE_MAX+1] = {
@@ -43,6 +45,8 @@ static const u8 nla_attr_minlen[NLA_TYPE
 	[NLA_S16]	= sizeof(s16),
 	[NLA_S32]	= sizeof(s32),
 	[NLA_S64]	= sizeof(s64),
+	[NLA_BE16]	= sizeof(__be16),
+	[NLA_BE32]	= sizeof(__be32),
 };
 
 /*



