Return-Path: <stable+bounces-223121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOa0HmJxqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:52:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B6020579C
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A303021732
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8C35DA75;
	Wed,  4 Mar 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jj5yJcfG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E53382E7
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646659; cv=none; b=ETrI57R7b+7S/fdPJQD+av5MRS0AXxXrPfxHleh23RqEIPpEscId99OJ9yfcx3/7ydOeJig8IHaUog3sMk2QKWTHWLC8NDnRXqnfEsAs4MpWmd+pOYDR5lSwnJTR1laEUeoIlwfaew08w4iKRSJj/I7cnqHFLpOxCCuuvpMCOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646659; c=relaxed/simple;
	bh=2Mvgz7k4MBiBihmZ6pwsyf3yLPFdtGpxts4opu+Urhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qu9cNpfXyHZeQALUdd2+6ijOoiffkthW+zqZaPCROOgpiVinC996x+hQoPo98pMISrbSUYDjM5Ld9yXGXu4yB+iBQkc9eesup2MKUM9fhukFGMC/jmAoib9UxfpYvJsFCDjz9l4e3JmAWfclm3jShtddGrA9ohfFfHb2QA0Okfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jj5yJcfG; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d19bfe1190so6443717a34.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772646657; x=1773251457; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNMYYOJfjMKLq9zkyVGgSwjqMf4o4L892jbKOFVkLGk=;
        b=Jj5yJcfGd6YfE8j9dPMK0uQP/S4LJKknSdI+oP/6HEDa0drHxa17k+pc3fQ3lIFTLn
         2cJ4ph7OCRpTFrsu/QOvizcz64eqXkE05nUFv4ySFEtRAzyswxAm/HOXeWj8phapvH3k
         kjrp/gTgS/NoeHauR0D5QFcCuI7Qsv3zgUqIjsri6la4yMehPa31+TeHC6vV/OTXCird
         /V5hDW2Ee5KK4QEFm5hhNz3fOuWXwyigMd3RfmB2HrZn3vMrGPLvJWLg2UukZup4YMal
         6zqMtvews5Vz+R6WSZLTSIWk3Oi8Q/xHww/Dr4jULQtfmoDJnxvcSxdtqFzlnuzcVoI1
         srBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646657; x=1773251457;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNMYYOJfjMKLq9zkyVGgSwjqMf4o4L892jbKOFVkLGk=;
        b=RNeu/QFiGDSDYNJBNADKHGP9t1IwNgkUv/nsSlFtE03MLRsv0d9Z/C8ShTB/efGlwZ
         LwvsjlSPKsBg+mSeBVdrNfqk3vJq0SpfQPaGPkHU/aDg154bn/84VqAFTOHHtrTSSzdp
         zQPCvRa6FxmCLEOOfQavrn+ThLqN8rlRisFyPJ0UqEVgpupL2ZP1HuROoCaqq30aFRg1
         m80cynIFRUN7RpTd6UeUJYHM4QvRUdpyLkmwTfleh0rHkCzojA71BnieHIrH0eHu4LJe
         xowHjtwIox4D4EU4bfnanFM3RiunK/HLlo+T1W5v8YCTy/U8/Sh0b2Bn3xMIsy93K86/
         Lg0g==
X-Forwarded-Encrypted: i=1; AJvYcCUxXq+PeQT2YYZ8KPSUespXkj33IfKvJ1UnbiJYIK1j+VXlyBvWCaMF17QzTOqstsX0rdK3P2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjiJ9g7VcYv8/9gf6c+eF8CZGRyzNK09uKhTsn/0fmXxRS1V2
	vfE85GU8jydoRRXWU5bQmtuuo34uVnBVqkE33EsRvECCT0sV2+lsUMsp1XUyIuJ6/Qw=
X-Gm-Gg: ATEYQzxehvrCeDzQrAJtybb+nMWpxNxrxPbtn8cp9+oGApAypn9hr7kqJ+g0ykITo8e
	QzUSabRYBrle/+D2IPQBXnG+I9mKS+aZtQFbmpOS1U1WrdhO66zS0kYosOEEMddoOxZTiU/CaOv
	N1gI404wok2pF7x75mgbCRmt3Ensruv+q7htjAlCdJn44PIykQipFoN0QOo+mdoS7fQSyk64WON
	TtC5OrhCN18e8d4DkoAL2GGZ/X8SMMsGb33KYj6VkpVpInM83wRkqpi0N1r0U5KZ0w9/XltfE2g
	dzqQa/3Ivc0cEtGhWyrRX3oSnhpiBRQZVT9DIlQ5qiRlOAWadtpDjTMdOAbW66XqT6B5/WYgBge
	QAIcKD4/5rV6wVELDtebxx2NsLGXo/7MmvgEeK54jankSKIoDfHGMwA2rEZmg8d7/UnxT205aL2
	vSHXOmZA==
X-Received: by 2002:a05:6830:3901:b0:7cf:d1ed:f9ff with SMTP id 46e09a7af769-7d6d38f9810mr1782147a34.34.1772646657516;
        Wed, 04 Mar 2026 09:50:57 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::281:54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626abfsm15735411a34.14.2026.03.04.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:50:56 -0800 (PST)
Date: Wed, 4 Mar 2026 11:50:54 -0600
From: Chris Arges <carges@cloudflare.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lwn@lwn.net, jslaby@suse.cz, kernel-team@cloudflare.com,
	netfilter-devel@vger.kernel.org
Subject: [REGRESSION] 6.18.14 netfilter/nftables consumes way more memory
Message-ID: <aahw_h5DdmYZeeqw@20HS2G4>
Reply-To: 2026022652-lyricist-washtub-eeb4@gregkh.smtp.subspace.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: D6B6020579C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[cloudflare.com : SPF not aligned (relaxed),reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cloudflare.com:s=google09082023];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:-];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223121-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[2026022652-lyricist-washtub-eeb4@gregkh.smtp.subspace.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.152];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

We've noticed significant slab unreclaimable memory increase after upgrading
from 6.18.12 to 6.18.15. Other memory values look fairly close, but in my
testing slab unreclaimable goes from 1.7 GB to 4.9 GB on machines.

Our use case is having nft rules like below, but adding them to 1000s of
network namespaces. This is essentially running `nft -f` for all these
namespaces every minute.

```
table inet service_1234567 {
}
delete table inet service_1234567
table inet service_1234567 {
	chain input {
		type filter hook prerouting priority filter; policy accept;
		ip saddr @account.ip_list drop
	}
	set account.ip_list {
		type ipv4_addr
		flags interval
		auto-merge
	}
}
add element inet service_1234567 account.ip_list { /* add 1000s of CIDRs here */ }
```

I suspect this is related to:
- 36ed9b6e3961 (upstream 7e43e0a1141deec651a60109dab3690854107298)
- netfilter: nft_set_rbtree: translate rbtree to array for binary search

I'm still digging into this, and plan on reverting commits and seeing if memory
usage goes back to nominal in production. I don't have a trivial
reproducer unfortunately.

Happy to run some additional tests, and I can easily apply patches on top of
linux-6.18.y to run in a test environment.

We are using userspace nftables 1.1.3, but had to apply the patch mentioned
in this thread: https://lore.kernel.org/all/e6b43861cda6953cc7f8c259e663b890e53d7785.camel@sapience.com/
In order to solve the other regression we encountered.

Thanks,
--chris

