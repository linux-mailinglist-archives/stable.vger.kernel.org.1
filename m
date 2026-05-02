Return-Path: <stable+bounces-242588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MYKCHfC9WmVOgIAu9opvQ
	(envelope-from <stable+bounces-242588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:23:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD94B1820
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97EC2300C91F
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182761B3925;
	Sat,  2 May 2026 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWPJwSaE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF7156F45
	for <stable@vger.kernel.org>; Sat,  2 May 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777713773; cv=none; b=DqJpRuKbVYcDszE3Sr1HQDNFkJlL73wnUeVp6eFkC0xc8a/HOC9yfm3K9NGgk9YXUaIdfXRm/gxeVj1X6i7d69Isaaen4n0H89PPqj9LrekA07RL7wFLjFIRZVy7OM6hZqFvWhuG+niYMVxdDduBtAfGgFcdsKEigAieN0TyNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777713773; c=relaxed/simple;
	bh=5D3TxgIyE00DYrWiTKhypjt+XeZdEVjGxqgjrwqORLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j7cSM0VJ6xehRgePGA3I5Cq3LkAr5kXRKVT9x64Ika4FEguJJ585EQRoLKM6RpmgpR42tbX+2/rpAS/qI0cuTciQ8znyIdwzk9CeNMTRGsMxPq3Na8C+uIlrt7A+7RTGBm4TF+J9T7ce1XohjlNfzb911EYJkWSEUS3/i55FYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWPJwSaE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so20396975e9.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777713771; x=1778318571; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5D3TxgIyE00DYrWiTKhypjt+XeZdEVjGxqgjrwqORLI=;
        b=lWPJwSaEf6l3p2JcYfgl1mXS4GawdUZOqbnMX+TCc/q0dq7bMEz93e9S6P/X+hksEO
         +nnD+XKzUx0DjUV5dK3HmLIHHCyBAZmm/eCbC+tUUjPfPX/LH6zOhaxEQgm9YIqFFwfr
         xsZtHkbfP2ZUQeCFKuUnyKQ4rVbnLBgDCf7VA8mBe8cXfliiqx2ZSC93a4dtyZkZUaOB
         wtMr6xIw57qeTBs9NmpbRujaps4Jq3hUb5sMUb1EvFTwVtHI99sJHT+Eg7zAhLOnw3o9
         222lDP/SmuSDKnXYmcVWzA7roqOs/VCBEgOXbhP9ZG9HuMmEmOFzRp+7hRp2SFYs09MH
         UpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777713771; x=1778318571;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5D3TxgIyE00DYrWiTKhypjt+XeZdEVjGxqgjrwqORLI=;
        b=AZsTJHXAW1fjViVjreCRcpBcJ4oC91ouBInNj75DEGTQgCPfdaj0JcZ8O7+6nGPSd5
         5xHl2/iZDUQMdL2zF4/5Obu97PwsteHCcgR5I/h3LsRtZ4BmZ7/djdS08h0GBssjBJo/
         yLXC/pWMNRKO0Rel9JLRuZYBg5DstvM0vl7rhEhQJXcbak2J4Cd5I/1trTA/8E4cC7+p
         Ba84MtNQUTrl72jw0khe1zuc8+B0RlahxRIPJ4hz+fWOU9A7faHfIHEyCY3Ed5cUgNeJ
         1FqtHshOoAck50hM2iTap3I/Hv6dUHx5aNhGH89hgNqFAGBWNJ5/kRwGjUJlA8PvWAwS
         3QzA==
X-Forwarded-Encrypted: i=1; AFNElJ+k/XUZwEKALKMmbZUiLEy3flBTNhJCEwW7xwXJb0ZAz2ThJOYFBQbay5eo8qRmS6OdnFcZjfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtafCdnpoYPiIj3z9ytQDg+xYdKYWHB5AYG/Bx4PyZWLYT/zH
	WCke2QhhtQdvNVHQJIAbKVrBbBaZwBzfSTKI+s45Z2N28hK/gd0+gBy+
X-Gm-Gg: AeBDieurBpFLfCZOjJiMeH2NO413Mw5bHOKDSAT76EjJUtgfklgRNi2HI6Zd6JlOO21
	p4UxluJuAY85ndhRDA0K0sRY3NaMToYuwVma5KPjahhZFevbzfRyy2m+XMZR6m5/b3MsbrZv3el
	Oq1oK5Qxh/RAdQ1h4SHbsBCNC/S2kI8TLks2RbWPgzjS/yUzg23Z/d8epTmBo+AFTy/udCuDKut
	bUXOtKKWhx0JOPOsmNXpahwRQBjFe9vt7YwOh7ExiFHIKEmuk8nwYLfH0UOelQgKT/GM4DnBOzU
	J7npiyn0+jYOVWludrGLBVHxzP7AAiVYFxyeODcKw//fgGTWrRHQ9utW1LC+lM/ChskEnQp6DYn
	9JKDIjenOm0Iz1vKWxRtaM/9CG1qCejg2XODp3Zh6oMBacYnWEtg9JsLGBKpvtQurHLTRwbCsyA
	t5sdy7OtbxoTLsx309V0E0AoIswpmTLr4j+ZAoeGGNeoRp/9i4HflVABr4HFFww/dFL9/psA==
X-Received: by 2002:a05:600c:3f06:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48a9852cc0bmr36278225e9.4.1777713770454;
        Sat, 02 May 2026 02:22:50 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aa70dsm11010046f8f.25.2026.05.02.02.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 02:22:49 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C3801BE2EE7; Sat, 02 May 2026 11:22:48 +0200 (CEST)
Date: Sat, 2 May 2026 11:22:48 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jiayuan Chen <jiayuan.chen@shopee.com>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	1135514@bugs.debian.org, podorski <podorski@gmail.com>,
	Brad Barnett <debian-bugs5@l8r.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [6.1.y regresssion] 9a95ec9144ee ("xfrm: fix ip_rt_bug race in
 icmp_route_lookup reverse path") causes log spam on ping to unreachable host
Message-ID: <177771348699.1898023.16904466444228860838@eldamar.lan>
Mail-Followup-To: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	1135514@bugs.debian.org, podorski <podorski@gmail.com>,
	Brad Barnett <debian-bugs5@l8r.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: BEDD94B1820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242588-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,bugs.debian.org,gmail.com,l8r.net,davemloft.net,kernel.org,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RBL_VIRUSFREE_UNKNOWN_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eldamar.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Control: forwarded -1 https://lore.kernel.org/regressions/177771348699.1898023.16904466444228860838@eldamar.lan

Hi

[sending correctly including the needed mailinglists]

This is a 6.1.y specific regression, so I'm not CC'ing netdev, but
maintainers, hope this is fine. After a backport of 81b84de32bb2
("xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path") was
applied in the 6.1.y stable series as
9a95ec9144eeff1fc6fbcc21b677e322c6f1430b, user are reporting that on
pings to unreachable host the log is spammed with the "detected local
route for %pI4 during ICMP sending, src %pI4\n" messages.

One report is at: https://bugs.debian.org/1135514

This does not happens with other stable series versions (6.12.y
tested explicitly, 6.6.y I have not avaiable to test).

Is there a missing requisite in 6.1.y?

#regzbot introduced: 9a95ec9144eeff1fc6fbcc21b677e322c6f1430b
#regzbot link: https://bugs.debian.org/1135514

Regards,
Salvatore

