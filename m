Return-Path: <stable+bounces-253412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJjWHS1RDmpq9wUAu9opvQ
	(envelope-from <stable+bounces-253412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:26:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C235459D483
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCC7F3009F2C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F53242D67;
	Thu, 21 May 2026 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaXr6pn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E21E5B88;
	Thu, 21 May 2026 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323173; cv=none; b=Q/IhjVx31HNsNO+yaxicJ563eFQwqeDBAxn9/5df0jQHSjaRpWmjOHJI3QxTP269zSZyUZ2Tc2D2zyHcxA9cYiFzvl4B3j9wxgrbbmpQ6R7xPZrmG5mtNR+FXyEw/WpTt9TeatG9XHhaTZkWE3cfzkLKmNmAiUljTksJ3yvG/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323173; c=relaxed/simple;
	bh=JIBKqwX7IL5FbIet9rqh0HFHn29IohMbMw8Hf1pqEDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRnIMP3svBIDOOaltXLheF/SaRGyGLBgdnHCfpBwB4HLWZpT5VAI1kvFsyIBvMcn0Kl5ZstiTukcJ19CdBTH+i9w1NTZx6irAiin0f4p2Z+7GJamnz6Khr8Oo0nDDhbp62yA6vOvM62WJz/JwzFnTJ6UXxXG9bbmSHt8dc9uoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaXr6pn8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6521F000E9;
	Thu, 21 May 2026 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779323170;
	bh=JIBKqwX7IL5FbIet9rqh0HFHn29IohMbMw8Hf1pqEDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jaXr6pn84reZS5ubOWIWXvNn6VNd9TUmh+BEnhumXaVzgHJn9Ntapuy5vCmPoU2iH
	 +Op3GtFPndMWuXJrjiRUlcHvkjxYmiY05UrVkqvS9uVvTU6K/JTbp3RQuNP8N8ahA5
	 GP2KTJjtIHt9oIRmQHSQnAMtvLYpEWAzGVBFPAShE2ok+ODxgtEpnrqLaCpG3k8EIM
	 28GbPLn6BzQz1N19+w97ytdemYp3fxo2Fli6Kmkw8LKX2DqInCd9BtFT3xmdckKvO2
	 SJYwMmCcomEumo1bYiX2ipseLXPmwi+xNHqM2PTV19nXFshBVaHQpRld4E5qEbtBCh
	 mzMjKeVz4/UVQ==
Date: Wed, 20 May 2026 17:26:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets
 over MTUsig
Message-ID: <20260520172609.3034337f@kernel.org>
In-Reply-To: <20260521001327.3729880-1-michael.bommarito@gmail.com>
References: <20260521001327.3729880-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253412-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C235459D483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 20:13:27 -0400 Michael Bommarito wrote:
> From: Michael Bommarito <michael.bommarito@gmail.com>

Please (tell your bot to) use the get_maintainer script.

