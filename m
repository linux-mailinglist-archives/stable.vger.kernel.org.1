Return-Path: <stable+bounces-216721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOxgM1w8k2kg2wEAu9opvQ
	(envelope-from <stable+bounces-216721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:48:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B6145C2F
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6F83016256
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5031AF3B;
	Mon, 16 Feb 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOb5IkJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BA2690EC;
	Mon, 16 Feb 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256920; cv=none; b=UGDLmcAyfa3Iggllvs9HUmJl2XkHoVRSgFU76nfiW3uAJzle7HGevpczHGxIsgyte/vUKVh0xv0sa1T9X9jBKWBO8lSoi8TcsuzHTo4Ftwf/B+3bjdfGU7YtCICqtAKQuBW2OHEwPOsC4bN0mpYjNM3KUc9OIuF9O+GJnG7pGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256920; c=relaxed/simple;
	bh=kvmk9Nk3azwvwuhSY2Z7ciR0/RZ1Vx+Arvb+7UIojmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPe7MMZhtWiJ0MxQkOik9AFIBkWGy04GdpSH185BOmxtXam2u4T7quf61JsijZp/nBZdubAm1L9rBzs13otEP444V+2WuNaa/A86DuiaYaV14EPhxYG0iYR+uNmudlRPIOje81l0SrPprp8u6DjCvLvc0XYZLJE3kd1fjvW1w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOb5IkJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F23C116C6;
	Mon, 16 Feb 2026 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771256920;
	bh=kvmk9Nk3azwvwuhSY2Z7ciR0/RZ1Vx+Arvb+7UIojmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOb5IkJzK82iQS6KiaoOpFZVzWcl+YPajcvGAV0rW9idL5difTNhQK/Kh8RO1Bca3
	 ON6nXSSPWZvBW12HwX0H8BjoAo1WgiU0Sy0LVs59Ej/Bb2rLDS9051M5BS+GRKIv7O
	 XAZCPu4z/pYzggzQsWgzlP4+Bbv+18LCVa3RAwI9lX+MRJMkDBnOuKJKQkXIv97ZvL
	 h7PFVtPf5RPCGlQDxwEd51CJwLL7weFyuvaxAhxwANFGivIJ45Fk+I+uusP1ipBbDt
	 hpJsRy8sP6JYuruMcg0kvReJzeRluESlD6i0wknXXHZyN9j1qDqG8SwVcdRS59yTn7
	 BtLV0ysSX1rlQ==
Date: Mon, 16 Feb 2026 10:48:39 -0500
From: Sasha Levin <sashal@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>, guoren@kernel.org,
	neil.armstrong@linaro.org, brauner@kernel.org,
	yelangyan@huaqin.corp-partner.google.com,
	schuster.simon@siemens-energy.com, linux-csky@vger.kernel.org,
	Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 6.19-5.10] parisc: Prevent interrupts during
 reboot
Message-ID: <aZM8VwMcSOhNHJHc@laps>
References: <20260214005825.3665084-1-sashal@kernel.org>
 <CAMuHMdVeGv=f-Oo1=GQLghn_hwpe2YN5OS79fQsy2uccwyVUZg@mail.gmail.com>
 <aZMXwfvJjG0YkuF5@laps>
 <CAMuHMdX1Mdqp7+Oz9dqe3b2VqMzpp5L7AvBJxRZuUjb0vY6gCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdX1Mdqp7+Oz9dqe3b2VqMzpp5L7AvBJxRZuUjb0vY6gCw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216721-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,kernel.org,linaro.org,huaqin.corp-partner.google.com,siemens-energy.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:email,linaro.org:email,gmx.de:email]
X-Rspamd-Queue-Id: 869B6145C2F
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 02:28:14PM +0100, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Mon, 16 Feb 2026 at 14:12, Sasha Levin <sashal@kernel.org> wrote:
>> On Mon, Feb 16, 2026 at 11:21:25AM +0100, Geert Uytterhoeven wrote:
>> >Cc linux-parisc
>> >
>> >How did you (or the LLM?) came up with that CC list?!?
>>
>> Interesting...
>>
>> $ ~/linux/scripts/get_maintainer.pl --pattern-depth=1 --no-rolestats --nor --nos 0001-parisc-Prevent-interrupts-during-reboot.patch
>> Neil Armstrong <neil.armstrong@linaro.org>
>> "Guo Ren (Alibaba Damo Academy)" <guoren@kernel.org>
>> Christian Brauner <brauner@kernel.org>
>> Geert Uytterhoeven <geert@linux-m68k.org>
>> Andreas Larsson <andreas@gaisler.com>
>> Helge Deller <deller@gmx.de>
>> Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
>> Simon Schuster <schuster.simon@siemens-energy.com>
>
>Still doesn't explain linux-csky?

Oh, that was there because the LLM mentioned csky in it's comparison with other
archs and get_maintainer.pl used keyword matching.

If you grab the actual patch that was sent in the AUTOSEL mail:

$ ~/linux/scripts/get_maintainer.pl --pattern-depth=1 --no-rolestats --nor --nos raw
Guo Ren <guoren@kernel.org>
linux-csky@vger.kernel.org

-- 
Thanks,
Sasha

