Return-Path: <stable+bounces-269853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FnfBCssfQ2pwRQoAu9opvQ
	(envelope-from <stable+bounces-269853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 03:45:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68EC6DFA25
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 03:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JqtuBAKF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269853-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269853-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090DB302C6EE
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40F14B950;
	Tue, 30 Jun 2026 01:45:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EC25332E;
	Tue, 30 Jun 2026 01:45:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783942; cv=none; b=c13isEgbu7NDYh2qDz83v86m5IDQOoxepJvw2EW4ftAHOudzGvo8o6C6TyolvezkdIrWAP52h1QMEqncW0Ph8DVA3RUKqKlXtSYWOTeM958Ty044mHkM1tnxfQx4q1b/VbyeRwbAtrpNlRhNYi2pw4gRE6R4OMIemPtE36SVLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783942; c=relaxed/simple;
	bh=D94q21odBhNf5SmUDYFZ7h+7mfurDN0SNw/pbDxsQNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGIgnMla0jcRUhKX51TOW2bWSFyngUHSfbAerBsW3Zk2LcdElYJ5ZVIWTZPtUtiit7XoL0zbV31zorVJs135hMPXBPLQI5ImktSuuemYd3uhq6QGK56AAi3OUvhnLbdjUhyejAu2tW9cSDZWonlm+1iytc49RG632wrLpLGpj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqtuBAKF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D021F000E9;
	Tue, 30 Jun 2026 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782783940;
	bh=kgpqgyIQx2BD+vAJtEmQ4KIj0mfEfZD8qoHQYPrvpj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JqtuBAKF4iG5BAwrNz+A6oRJJzs7RMs+uY/Pn/Ibmo0J5xgyV3eQxUyZehcb9x2Wc
	 Wh4Kyjyg91w6iDLAxtoZaF24Oob8Qgi1aaNsOHzo/E8vLHW2FoAy19DhfRGwETX5t/
	 anzl+PxjmuRoUoaVRNm2ujbmkIPhQc+1+MFORvVEjh4QflJWAETBVlQ4lmntovIAST
	 9OQjTSQXeralF4LuFUXItVuPHVuiIuLnGnItS14E4KBeC5kuovyE2NcbCk6jBqpctK
	 zDs/ikqHzo0y0ZQMjykAn2Yagm9jFHwq3CKF3XhLJx0w6bJhi7izCuFwZhfwnexZ2n
	 L62KmsLijcg2Q==
Date: Mon, 29 Jun 2026 18:45:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jbrandeb@kernel.org, richardcochran@gmail.com, amakarov@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
Subject: Re: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure
Message-ID: <20260629184538.353a477d@kernel.org>
In-Reply-To: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
References: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269853-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jbrandeb@kernel.org,m:richardcochran@gmail.com,m:amakarov@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org,seu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E68EC6DFA25

On Sat, 27 Jun 2026 14:03:50 +0800 Dawei Feng wrote:
> Subject: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure

patches does not apply, please rebase and repost.
-- 
pw-bot: cr

