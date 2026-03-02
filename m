Return-Path: <stable+bounces-222603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M0mCbyZpWnxEgYAu9opvQ
	(envelope-from <stable+bounces-222603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F41DA645
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA5353054206
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E43FB044;
	Mon,  2 Mar 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewY/0WdU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED73F23D9;
	Mon,  2 Mar 2026 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460001; cv=none; b=hsWKX9Lcz7emwtgk6ujWsgGYCBAkRo1p1utE0WUIBq9R5aaZZYKc2+5ns/5NXVA1drvnSgftuhlDbstFE0d0xDqmAV9EhH+wU3l1lLQR5ZWPQgi0av+GMFrlt5fImwsNgYC/EnijxDInc9qdfXv1M7y3Pq0iytsTnYjBP+8isk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460001; c=relaxed/simple;
	bh=Jop44HVklrI7DjKMtDwksgo6hcl1CuU5HgBN5PPGDbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7rjZrCoBPkOdABYVxvKqBXDEk8QO8h/nPfY6mI8vXKVnqf+BMXwYnWYSQXmE44Tq7vzxhgft2FKFuEj78sOoOP+7TdBl0SPDlubkdCdfEuBzqmSOHeOed3c0S56NfcgVIz+tbVdh8WxkB4OH2SZiZJA3WiygnQvle58MXnzaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewY/0WdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61056C19423;
	Mon,  2 Mar 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460001;
	bh=Jop44HVklrI7DjKMtDwksgo6hcl1CuU5HgBN5PPGDbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewY/0WdUhmYKV6RE6wL0enGCZRQWFGEDNDL25j2I8YARqc6DZHEi8V1JAH5yxblzs
	 fEdbi4hFkKDlLlSGXYWS5RCrsYUQLxL+WRb1XcrEivL9ak5GgOiD4RT0VPeEC+jDET
	 xzZvXsMc0Tw66AqiyjGeCFT10lv6EWHyrx8+O5LmIN2S0AZRUGciBLuki6nZc9QLP3
	 DzbXfbKPGh20yIZs+P/npRJH8Ha6HB7dgdyeUcGvs/uAShjPxMUFYcPeG9R9R7hIwB
	 NmGWX7pnqx6JllR8n+Xp5GBdHiyIs7bxCgevV75F65840G+et8m9E9svCWialAtzTD
	 lln566Exkobhw==
Date: Mon, 2 Mar 2026 09:00:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Navaneeth K <knavaneeth786@gmail.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.19 374/844] most: core: fix resource leak in
 most_register_interface error paths
Message-ID: <aaWX4I0rOM3BX3Ei@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-375-sashal@kernel.org>
 <229d3499-6600-4245-9ee3-219266f83cd6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <229d3499-6600-4245-9ee3-219266f83cd6@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222603-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linaro.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE8F41DA645
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:08:20AM +0100, Jiri Slaby wrote:
>On 28. 02. 26, 18:24, Sasha Levin wrote:
>>From: Navaneeth K <knavaneeth786@gmail.com>
>>
>>[ Upstream commit 1f4c9d8a1021281750c6cda126d6f8a40cc24e71 ]
>
>This one is fixed by:
>2c198c272f9c most: core: fix leak on early registration failure

Queued up, thanks!

-- 
Thanks,
Sasha

