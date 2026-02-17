Return-Path: <stable+bounces-216886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ96N/CzlGlbGgIAu9opvQ
	(envelope-from <stable+bounces-216886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:31:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2514F293
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5863058579
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95853372B48;
	Tue, 17 Feb 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTTK82Nz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B41C69D
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352962; cv=none; b=OuXpEqtESLX3OKa5VnI0EPEhhEJPd35LX1W9TZf6mGln4AX0b6d7fa7v5ph2kWWyLeqqiDVfyjDyh8mO5DKb7r1EmkXss/upsapPOJ529RLyC/1+c7aq6cQY0nodvJlWcX+4Zmp2wRP3m9n8rrROIF94D1F/C4ecDfyCSu+3qB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352962; c=relaxed/simple;
	bh=ZcHuQ7r21yTDh2VPpv6pPH76RALcIZWJNIKymPfmPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbJULppjfw2FVjKwvP243UnWDrxMmVp+SyMG9bwNibXlRsFwU8KiMpV/pG2ouw1ttAiLY4c4uGbZJQ8LDobgFBIMmMmTzwvikQ2hOqyjk9vfl+mTJbc7n8Bn0vEJITpy3XJr5gppbWGznw/+urTobAnTsmwg4AYvWYGlSE222gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTTK82Nz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so24335915e9.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771352959; x=1771957759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1dTGS0nUrZaB86bFJbEyPn5We33zlH4DX2moTSFdiE=;
        b=BTTK82NzXkSF7dQVXqVj6bNJ7lDcZHp5l3lbn+Hv4gvcH1eLBpJVN6F9tBXJPrmzsa
         Y+9hl3NI1KjFZeav8BHk22uqG13qgujh8Ghlw+TS9/udf+a+nD46m9JaUBwWyQhCEUZw
         3PoqD6wwW8qnsNKXOuvRm6A37xrdqhwdtSuApYzaNAAo0cDh5dvMPbct/usqkqv3/WaJ
         HUZRVEG1RlUGvkf+o5cyh80Tk9kktDWSs5CxaoZt2g8Q/pg1bkHhmh0zQ+vqk2wwz3Rl
         +IShZosVCqmJTq6q/YOioKpn33cKSeWHJWXdm5L0p4vQkv+189l4+S5iy9+iylSchxeT
         vWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771352959; x=1771957759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1dTGS0nUrZaB86bFJbEyPn5We33zlH4DX2moTSFdiE=;
        b=WQEmHf62RT1VRfUuyz9LBo8LRY4q2N/XtM834aGJKK0wXYIjWeRUZT4rq12iUOFzJ6
         9Uib4dT6y8vlKogpwStwj7rMHHT5eXAUBHq9KX+6CRRJoMCylpIvLe6AsQrtstbQPL8+
         nVtMq7q2IP9lIkfdVkgTGNRQDyiePmDzcc51U5MtarkaT/C6rqkTdrK3+RvG4S18nU9L
         taLt7USopZW0i43BgWYzT6r6bwWLZ+PqqsNxDf01Trg1hsY5C+Fk2mTEzi0pkHIydN7z
         GHvqGMVTcRZvP9och5ye9KccrYuZ7UUznlvJWemfv8T0XbJWoiL/Ky9bv2prKrSpYd0X
         gs2Q==
X-Gm-Message-State: AOJu0YzVyK8lyDTFSa28ciGPpHOlXIhy3YjFrQdFdITeeUIQZui2ZQ63
	RKpOSzLKgbe/SJPI/EFTUhodB25OOiFwy/Wd7Zug//zJ8dwOQgtC5Qs6
X-Gm-Gg: AZuq6aJsaOgna9c7XNigCE+tFQeng8JyZ1VN7Xe8yh7ASVt4xV+RQVYiLQVjLIW4fLq
	K+xu70jFXKH8b2VKHzAfTlSg4nA/+j4AwRVr/Wf21IyvjzjtTwWvHkZL+VJe/COfrVgycbbTl0f
	Y6VhiUND8YyfJj7Is6WnJM+8JjH7mLcNzeWmVDqChP+P/fmv2dBLEMhg8YFNhqM4aa4v9CEPz7t
	J0li+02WrpM6dVp8YBnPGMRs5SeqN95yHumtMEwD53Ghxu+N90WkOjbL76qVO+wfykJ6uiXejzy
	1rLHjgn4eyDQyJX1W41/twYAnXcZXJ1kbQyvo+qPWjY9eEM/VoN7OGFn3kkET5MNIXE2Pni5cF+
	D56lu8DxSsf/mAt/ster4epCbQy0H7+LKC+kjFbt/zCVk3QpEmV//LSDXE0njFY4B3VUQpeaOuu
	38xALmiFzxxTuCF8KDCKVg0VxlTUyptLzgcB5mmhB5xe9iECyvsHLLxKug
X-Received: by 2002:a05:600c:3505:b0:483:71f7:2795 with SMTP id 5b1f17b1804b1-48379b990b2mr160828595e9.11.1771352958917;
        Tue, 17 Feb 2026 10:29:18 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839731e101sm1055395e9.6.2026.02.17.10.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:29:17 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 4DBDBBE2DE0; Tue, 17 Feb 2026 19:29:16 +0100 (CET)
Date: Tue, 17 Feb 2026 19:29:16 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hostinger NOC <noc@hostinger.com>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: Please apply commit 9990ddf47d41 ("net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons") down to 6.1.y at least
Message-ID: <aZSzfA3yFQxzj-N4@eldamar.lan>
References: <177132401902.2893171.1371685164011289024@eldamar.lan>
 <2026021740-mom-remix-8103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026021740-mom-remix-8103@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216886-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davemloft.net];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AA2514F293
X-Rspamd-Action: no action

Hi Greg,

I'm sorry having wasted your time, I relayed the testing result, let
me loop in the user which tested the fix:

On Tue, Feb 17, 2026 at 11:57:25AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 17, 2026 at 11:28:20AM +0100, Salvatore Bonaccorso wrote:
> > Hi stable maintainers,
> > 
> > 9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare() return drop
> > reasons") was alrady backported as well to 6.12.71 to address a
> > regression when backporting 81c734dae203 ("ip6_tunnel: use
> > skb_vlan_inet_prepare() in __ip6_tnl_rcv()") (this one was backported
> > without the prequisite commit to 6.12.67, 6.6.122, 6.1.162, 5.15.199
> > and 5.10.249).
> > 
> > Can you pick please as well 9990ddf47d41 for the other stable series
> > as needed? I can only give a confirmation that it works as exepcted
> > for the 6.1.y series as per https://bugs.debian.org/1127823#36 .
> 
> it does not apply to any of those older kernels, which is probably why
> it didn't get added there.  I tried to do the backport myself, but the
> changes to drivers/net/vxlan/vxlan_core.c doesn't make sense to me, so I
> can't do it, sorry.
> 
> Do you have a working backport anywhere?

"Hostinger NOC" team, can you followup to the above? Can you provide a
working backport down to the 6.1.y series to Greg?

Regards,
Salvatore

