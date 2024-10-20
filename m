Return-Path: <stable+bounces-86943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE09A52AB
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 07:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C4B1C214ED
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 05:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B39BE5E;
	Sun, 20 Oct 2024 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="Bygoib5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BEDD26D;
	Sun, 20 Oct 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402449; cv=none; b=frek3q7hqB6vZGLDB5MrfYV/eNRCtyZPlsFh7zep+70Mw3cMa3Qb33cD/ztBs+rgk6GV5q2pv5x9OGKQUBPVEKmbbaoVHdAnO0b91bw6xsWctEXOj/+Z+OiIMXIk39ixhjeaYnIumO7yHm6U3zVIGsIxfwt2H/mIjUb42S5zzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402449; c=relaxed/simple;
	bh=67WXJCg9R4GR0zcOVJJJjWaadN4fzsti+3L9kPB6TJw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Dge7gNM+VoMg+GjF54Giu0Yobbq1/rl5V/Rs1dvGGwea7hdpfAGKrPMrsjxWzzM3lTTzM7c0SLjf361YzCVY1NIb3BjoxPVQ+s/AHQiYuf/LNxpCug6cc5GXg8A02f0+tNNsMMBPSU54HP3vKv3ClgyolLAvOb4iI+Hn9qv45Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=Bygoib5S; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 49K5M31L014914
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 20 Oct 2024 07:22:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1729401726; bh=be54kpTFzAbFpBrYrKaH6Cm7QGzCJ1NxCsxHd8m+gA4=;
	h=Date:From:To:Cc:Subject;
	b=Bygoib5SC89kuxgPSwvG2bk96Mr5xRz8gKSiP0k/p98vfsvX+M+LaZ1jfiuAvHiNQ
	 077FhBbnH24NLQfyJgfZSHIrP41f5AyByE4A2gD1lthVjFFGqYSSdnJXxWWs0PxmB5
	 ekKBkBpDyfVtMICa3AokODQB7YctxbB4dQN8n/Rg=
Message-ID: <8eb81c74-4311-4d87-9c13-be6a99c94e2f@ans.pl>
Date: Sat, 19 Oct 2024 22:22:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: 6.6.57-stable regression: "netfilter: xtables: avoid NFPROTO_UNSPEC
 where needed" broke NFLOG on IPv6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

After upgrading to 6.6.57 I noticed that my IPv6 firewall config failed to load.

Quick investigation flagged NFLOG to be the issue:

# ip6tables -I INPUT -j NFLOG
Warning: Extension NFLOG revision 0 not supported, missing kernel module?
ip6tables: No chain/target/match by that name.

The regression is caused by the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.6.y&id=997f67d813ce0cf5eb3cdb8f124da68141e91b6c

More precisely, the bug is in the change below:

+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name       = "NFLOG",
+		.revision   = 0,
+		.family     = NFPROTO_IPV4,
+		.checkentry = nflog_tg_check,
+		.destroy    = nflog_tg_destroy,
+		.target     = nflog_tg,
+		.targetsize = sizeof(struct xt_nflog_info),
+		.me         = THIS_MODULE,
+	},
+#endif

Replacing NFPROTO_IPV4 with NFPROTO_IPV6 fixed the issue.

Looking at the commit, it seems that at least one more target (MARK) may be also impacted:

+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name           = "MARK",
+		.revision       = 2,
+		.family         = NFPROTO_IPV4,
+		.target         = mark_tg,
+		.targetsize     = sizeof(struct xt_mark_tginfo2),
+		.me             = THIS_MODULE,
+	},
+#endif

The same errors seem to be present in the main tree:
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0bfcb7b71e735560077a42847f69597ec7dcc326

I also suspect other -stable trees may be impacted by the same issue.

Best regards,
 Krzysztof Olędzki

