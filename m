Return-Path: <stable+bounces-222472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLH+C9llpGlcfgUAu9opvQ
	(envelope-from <stable+bounces-222472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 17:14:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 641141D08D4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 17:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C2E3005D27
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7D30F7F3;
	Sun,  1 Mar 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="gKKsS6Nx"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEE1E1DF0;
	Sun,  1 Mar 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381652; cv=none; b=gY8ujLyKfu5YmWdou9lwLCrjtV1zcepPFQaizARYkm+ucL3J+Bx86XKf8PR2FoC4s+tauxhqO2Tv6DbfLwnKpKN9nMTynyu3DeRrkOcNh2r+CcZbChLwI7XkYGgsJnp8DrO0jtIn2qL14GQbSyeDnjp0vJQ2wkac8OT93OTZGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381652; c=relaxed/simple;
	bh=ywb14zP4hY5kGEa6vgvzGC50Elu8HIVGlLBTbLTT7W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxwuqN+NoiR0Iu3sHRMeyEjaDc/ZL+xP+nPaR/61t3dDc2OQKPkofpDDNkrGuSxcd2EbnnvHqlQpXpjoT/t5eLWmNvvMFHiWcbDjd4E6ISW3vZ3oi8HSfsz2agPgCaAj+qMsay0ZYvUUoyJ2V9Qh5RaDJUwdHCEwU31M8n8gl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=gKKsS6Nx; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=ywb14zP4hY5kGEa6vgvzGC50Elu8HIVGlLBTbLTT7W0=; b=gKKsS6NxdTG++QVLjMlGYb3EoE
	n9hMbe75uzA2VXkY6vLDoQtwVGpuYhlDsfUMKuDT7Hg5PHu39Bp45CwBZv2MNKqZC/GCBl3BD+Z4s
	DWOVsOpxtZD1WTHKj1cala0dFHTjTMebKLY1jUu1t+57bVAtN/Ua0hny2swyX2gHqTFHGVHHlM7e/
	jAcjW1qRMXxkRTs7y7iqZS0DzxXXghzyPL+e7qjwtBUUwegNqfCDr096zeC1SA+wTm8UV4b4vLkBR
	Og31K5+9IWJFWEcjdS49kMgmILaigR78U/OzC2aP03yOMyLiYbhg+csh3yzMDp8YEnB9HZpTdotQo
	suZZF4AaYbbbqi1PfxoYTov2L0IIo0th0WEArfSPgnlLUwq4ZhtzQ733otiIEv/rcBUNalzhYmD2C
	qrzfDcM+nsBHo5m+J3NsrKKPHj3/oBY/jlk7TkOioJxZ/p425+cg8ozCFqwHQ74MAQpVBn5b1TCbY
	i72NZDxKYfT4uV1CTmNBjOIq;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vwjQf-00000009OHb-36Qe;
	Sun, 01 Mar 2026 16:14:01 +0000
Message-ID: <4a0ba7d9-97f5-42fb-bdb9-9f985da18a2a@samba.org>
Date: Sun, 1 Mar 2026 17:14:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "smb: client: let smbd_post_send_negotiate_req()
 use smbd_post_send()" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
 Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 Steve French <stfrench@microsoft.com>
References: <20260301020428.1732937-1-sashal@kernel.org>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260301020428.1732937-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222472-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:mid,samba.org:dkim]
X-Rspamd-Queue-Id: 641141D08D4
X-Rspamd-Action: no action

Hi Sacha,

> The patch below does not apply to the 5.10-stable tree.
...
> Cc: <stable@vger.kernel.org> # 6.18.x

I'm wondering why this was even tried at all,
as it was marked down to 6.18 only...

Or is that tag not what I think it is for?

Thanks!
metze


