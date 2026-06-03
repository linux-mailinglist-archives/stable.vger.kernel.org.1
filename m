Return-Path: <stable+bounces-260193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id et/NKtGSIGr35AAAu9opvQ
	(envelope-from <stable+bounces-260193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 22:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A33563B343
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 22:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260193-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260193-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=collabora.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F89E3025FA7
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05DA400DF0;
	Wed,  3 Jun 2026 20:47:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB33D16EB;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=a/rlqr4G2D6tf3C5BfgHXwKN4CLNNz8PynWEQaKioQS8odnXUSuYOuukcxLCbQPV5wyYzrM9Zl+F2+jjC9f/Otl4sJBemx/Gc+bWnl01d2SAuT5O+2yHpzdjVjLYjDjnGZqPMxTDjzdyxgmtO1qZVQcGAJCO92uvDLI7HYEbbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=chZby+AxiDQtNZwdRA6tTlO83+D1yOnB3uueyicfC+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ay46UmnZY/q3oskFPgdmSG8HpaaAG0DWrXiiDjvTfW65+rfXCTsa5Ef0Dze50TGrplHZEciUMe+YISO+dTiIopmWnYyguYkN7ESGnyCQY7Pv71GwK/UVxrRHg332Z/z3pWr1BUn4bIj5296IlFZMx0j8WkZ4f9/A8huTnQi4Xrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9E81F0089A;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D116B18261A; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260407073025.271865-1-vulab@iscas.ac.cn>
References: <20260407073025.271865-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] power: reset: linkstation-poweroff: fix use-after-free
 in the linkstation_poweroff_init()
Message-Id: <178051961984.2666348.12784021615069579744.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260193-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sre@kernel.org,m:vulab@iscas.ac.cn,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:mid,collabora.com:from_mime,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A33563B343


On Tue, 07 Apr 2026 07:30:25 +0000, Wentao Liang wrote:
> Move of_node_put(dn) after the of_match_node() call, which still needs
> the node pointer. The node reference is correctly released after use.
> 
> 

Applied, thanks!

[1/1] power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()
      commit: 8eec545cde69e46e9a1d2b7d915ce4f5df85b3bd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


