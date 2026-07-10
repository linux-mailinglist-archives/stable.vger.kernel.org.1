Return-Path: <stable+bounces-273205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GEh3BXXbUGp+6QIAu9opvQ
	(envelope-from <stable+bounces-273205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:45:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351C73A608
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PWGhC37j;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273205-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273205-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D5B3001483
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C16422552;
	Fri, 10 Jul 2026 11:40:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BF4229A9
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683640; cv=none; b=QdLaQGSekEVadnnCHbZC1vHAV6Q5US/L2Giyl0hmMT7afhgvA1F5PfdSRMYCAHpy71gqzoyCj0wTtgtE65GiycIogSjmdvW27ObP5h9r9eUHbhjZgsqBPPjww7Lc0c322noYka1l2j72WzioyuVh+Qgr9VP+4ketqEfahGQEHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683640; c=relaxed/simple;
	bh=miOil+xxJFCIgjRTftVKJ15xaMaf8REijFU6jkaMko4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kslLzReFWOlsW6DL9tw42+o6zlUhLHG+kLf9HPyMz2bKaJwwQpxHQehFojdZg347cWMHfhMwGdRHwjzsuUQPGmJu/a7yRke4XrLK52sfu9Aw+ipdv/rE3IjC7jbxsgDhioO27SATmzESzDZyxo+MElnfU+N/kIfkm5W02Ry9Mmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWGhC37j; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-476a130c138so1085625f8f.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683620; x=1784288420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miOil+xxJFCIgjRTftVKJ15xaMaf8REijFU6jkaMko4=;
        b=PWGhC37j/qzHq+1aemIJfwG+saY9uS6Gjw0vrBt6tb/LHOUESQQV8/RMD/Puatbr/q
         ZfEl4fzjuI9QXW5ci4MTJnriRTH301rkLkCcnko2wLv7op9EFq/8IDPYlf9U1n5zLK5W
         Gccz7qaYEY2c5VKVnUCju38RsU0g6VnuZT/R4Tm3sgtH4djM4hsMjjN0ZwUCCtfrgHGH
         mZG0HlxZPvb4ewACnVj2B1iEWpFHmQNqBQpX03oZbbGKOzfeENQPfFh4wABWk0TS/Or/
         0zxXdACnB7hDmvGuuXelQJjyMk56NcYpC8ke0joujB2nFa+QWvkEVpHlOezm9aQkGgI6
         ue3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683620; x=1784288420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miOil+xxJFCIgjRTftVKJ15xaMaf8REijFU6jkaMko4=;
        b=io4nOvrTgZV8ONHrg4nLqkuOrtyUaOzyCY6wFNKIGHsoo2L3qNgWVcl2wX07iqbnG0
         stZXb+27VD3f+UuWNYAEBmZTlpvkFF4vw/pGzhm+Jcf50sWxdmi0gr1G5DU/4OUG+nsj
         6rRPshfybdZHC7DTjia0mWyU/VoIlKiEM7vtOy+VUFg3nBRPWIpDG1lhyDYXvRqqniCZ
         VX5lPlOI5lv2Mv9xezX2j6hsnJsWqKFdlGOf+T9pSiyh/F8+8w+PPRCQ8A5C0sy6c7qL
         xavuitkLuoOmcOE0Kc27sJLuOhLL5xfwwXskYBExb1H49UNFQrjOz6QrCDP4pn/vJD8Q
         rgYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgHpW+oGtYBYaK6jbSIQZoGDhvUMd2TBM0Ne8aV1Dne1bIgwB27L+iQ0wVr2JYtjwMu98NK98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZI8v7tQRRGKH38GtJyBpMnYozR4VFPR26qhwgeAO2gU18VdP
	paINoXifkqKYsIDwymEP+6B4eVLMUVpYNQ2eEYhmmtQNEBe4GYiHwxPs
X-Gm-Gg: AfdE7ckz7Dssi/yc+HWNGirCqfwF1WZ73nJ3JZ2bilXUtfGUFxAwcmffgpxUSxfYxJK
	gDN5b6I3wWRLDoxPLhfWTCZRi9sLlixjeTw6Y4WyBBCbe5vGPz3a/OQhcbkkenZHokHTduDqLf/
	qX2mEyNk1dTJEm8VUZMs9abbzMh8dV5JYgbHQavAtDUqvCz2XwiNrQn4o3jerK7hhdLfX9e96cL
	7poRo2p/Nha9iiq7m9VTpXm8PvQPeBmns2aGxLMRd71c/slJ5aWvrLTNPQ+g5gFjgWuI4wk/3GD
	jLYmD8SxZAEAI37snBUnpPYJGQHEJg27MjCGztbDJx8S9P6fzV1rM0BiSyT462DBaPKiRL0avLq
	x8hCu9/5G6/NDmRn1vCj92jJSwevnNMLCglpQZ5l9f1ULzGgut4tnhF/K998XDYAsAZSkZS5imQ
	CiA7DXRFodfmi9iqtzYekEI5fqY9qqeIeM0g==
X-Received: by 2002:a05:6000:2382:b0:473:1706:7efe with SMTP id ffacd0b85a97d-47df073076amr11663574f8f.24.1783683619755;
        Fri, 10 Jul 2026 04:40:19 -0700 (PDT)
Received: from [192.168.15.197] ([84.239.26.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm13988073f8f.16.2026.07.10.04.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:40:18 -0700 (PDT)
Message-ID: <b077f226-8bff-489c-a260-32cbba9ae7c8@gmail.com>
Date: Fri, 10 Jul 2026 14:40:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: reject an oversized resident attribute on the
 inline iomap path
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710023055.3746252-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Mihai Brodschi <m.brodschi@gmail.com>
In-Reply-To: <20260710023055.3746252-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:ntfs3@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mbrodschi@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbrodschi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8351C73A608

Hi Michael,

Agree on the code change.
However, the iomap_inline_data_valid() bug check was removed in 7.2-rc1.
Maybe the comment should be reworded.

Best Regards,
Mihai Brodschi


