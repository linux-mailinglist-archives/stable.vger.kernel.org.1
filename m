Return-Path: <stable+bounces-267500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0+7jF9+wNmqvDQcAu9opvQ
	(envelope-from <stable+bounces-267500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 17:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98D6A91D4
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 17:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=bTU8a32b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267500-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267500-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63707300679C
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37B39732C;
	Sat, 20 Jun 2026 15:25:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D71C84D0
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 15:25:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969116; cv=none; b=SE6AKZNaZH0gVlIN/zbFu0cFTQjswb0CS1ifF6EBwOR1CxkhzaaN7RdxdIDpnXwgfc8VJ/Y41y4omrByBGb11KB7tyydZ6LnTCUWmzeW8oAEqjE9o3Jcw1tbxWxWgckJBo80CQqsTKvnGULHgwgRStHb4T7fKvb9ztpOrrJUS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969116; c=relaxed/simple;
	bh=UpjqJmW84xyAES4CQ03mgWNXY9R2Za2asMrW969qUlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kQCKthQCtnwlZaFlXdRGYUuJ2dPjjvbIFwIG+LZxttVp++eIF1NYytDf6iVeb+LI/6I9E1stMH+su7bABZ1+FzBTIPpmKxAM+ZNwEAqmzje+l5jFWQIxDeUVUi7hm+ewntzLRrfyw/6HnDOlMCflj2o0EdpkXfteJVrf90KuUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=bTU8a32b; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D665911599F;
	Sat, 20 Jun 2026 17:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781969107; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Mw9jcn999gJOxmRDng+/YDzs9QjoxCYwt/PZqRyCCnw=;
	b=bTU8a32bW1v3b/FnE6OjOYt8k8BbsslCxyAg3fjRyf3GWwbjbyuEs0QlsktMiVsCnaU/K9
	soEZCLAWdhOzPtOps0aT6S+Ljki9F6z22h3MOTmRv3zb4PewAn/4u5j6A9WCc2Ehs6sFaq
	vriPh9Q+GlZyNxcIVymjD3RvfgTm+W+HwtLLGEyVFCmdEWplS7OKolotir4CXlMC+O0ACP
	1q2UEHmizECZjWq69/Po9+B786fbBcXIOYdNpAxSeNJqDVP6He2YKPONHl8eEf3rQ8GlBT
	Emk112Ta9ZVsizYkkCyUr4tc1Qkpyp8Y3uhr/YyxKXIHtV5UnCMpRFsoVM3LKA==
Message-ID: <9d7c554b-2851-4321-aa7d-20253608e9bb@nabladev.com>
Date: Sat, 20 Jun 2026 17:25:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others)
 resume regression")
To: Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>
References: <6b4fb2b3-8af4-4963-aef3-ff55797b9954@nabladev.com>
 <20260619.0008.reply@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260619.0008.reply@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-267500-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nabladev.com:dkim,nabladev.com:mid,nabladev.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB98D6A91D4

On 6/20/26 1:54 PM, Sasha Levin wrote:
>> dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume regression")
> 
> Queued for 6.18, thanks.
Thank you.

