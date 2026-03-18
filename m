Return-Path: <stable+bounces-227088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG3AIa68ummqbQIAu9opvQ
	(envelope-from <stable+bounces-227088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:54:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6FA2BD9B5
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2559D303C631
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584173E0C67;
	Wed, 18 Mar 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rffs6hQE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA763E0C60
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845371; cv=pass; b=lUAHzcCAx8MVqmdWq7ncHmwNPuFrFUnStopXxLIPYys9K7VLGg4QJMeC/Zx0qKamUYPeP7w6YblkYl7vpzbgV49f6K7ouppDBkNiK6hwPJ42O+jU2J1T44JpBXkE0RLebF1h/OoSWMyzS9EvGcHg+BxezFE+fxQL3ClXxhYReBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845371; c=relaxed/simple;
	bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRKHC+illEra9BPx8PdxzxhUU6sVLkk4tuZ9EscZJZmUAGKDqngsKowfrjGZNcQb//XppsmTjlEKEDnrCa41dkfGTd76Xa8vBM43GRK7Ww7yda1juoNt0yox5fadTLulNQY+IAjvBm9OzGJ/efkODTs7L9AVqHxTy90sFp4nRYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rffs6hQE; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35691a231a7so1197a91.3
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845364; cv=none;
        d=google.com; s=arc-20240605;
        b=OcWQu1djdDXYqYP6YS2Ah5buaCjsX8d2dA3U13A74dmGEZU4A++abjREZOn6tWJeUF
         WvPrvs/mlrBWZpmrXY+Skv4AVYS/tL9v3iQrGIGrGOaxdYKrY1r07Wh6G3K6ZYT4x0eS
         0V8wO5+S98rKPpPoz6oUQOknMJ14qGNApk7C8Bpp3zUL3vJK9mAM6wUtP22MhoZyO7cP
         ooUNQukdWF3cOGVZq5dUdSlHhwP5fG8eRzMztuJnJYM52E9uela1GR6gMuEtnO1CKaEJ
         X37FD+bJMLFEMur8+LS0f0PMbDSJqprMWFRNazyTQZ57dVM7J3BiGUbOvXNH6+ZRaWG8
         ce5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
        fh=nwxYG2znC1STJFpiHoe9pmtu7fnE0hwIAozysuVsY4k=;
        b=XBSvH0EXnsAMNVUzeu+G1z+FIFTlcinV46gSfUoCnTH/dnsLszFIpRC25SydeRfnIj
         3d6rmlPewQJFskNS/YT7DOrmMt66ycLJ8bAMYksTbwY4CR6E6z7/+PNxhQO3zUMmDst/
         IefhwH44jx66DamqDP+kyvIXHqIZbe7mLZwQKCHi/KBzBktPhEga8wV9WbLymRfW84zq
         rFiltCLrioi3SJcDioK3kLj0njVAHMl93ebW9BQUbOtb9ZZONP4PUS0j6b3o6qLKuQWK
         BkioN2u+HbEDRyAIJ6Urv24j0Gn4i6tBB9Fh8z1Vmr3O7OHMZNjEOWaSqccIHFLYc3P/
         AYUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845364; x=1774450164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
        b=Rffs6hQEngTZqgC09Vg9OiW6WYP886b8+SUx1JG+wdg7RhOpJFa+97I05/S9e4+7t3
         vn9Q7ShFXgiYwVUsprNbpYv0O8GeHLlRIIVZWqhbEYZzAUZYb2U5qtFMK+WxenCZ+9WW
         iFFGvh3HZSiGfbs2/viywzc3qxkAQPLQmhQ5bHUlHBzrKfAYin9Rjf79LLWzqjbb0gS7
         o/15ZAX28upb6nFJ4ksZnYO1TidZl5SzexLlFIO+7Bs8FSTZPWE0Mn8NfrPbBfUBoGjb
         Zmm52ZcCeO8AZPoD2RlwoKImUbEH8wK39LTAhgqqE2b9FFq+2mneC6jB+x8WmY/+ejLn
         /A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845364; x=1774450164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzt3L8FljthUJAGYI2jmUC2ThE71Y92qdrRQ4fCeeEE=;
        b=SPBGefqVJRYGnlV4Wxf4x1L9RHt2dpN/hGRD9RgB9ipK32F4qq569SlcHcx+x2THCN
         h8Aq196b4wrqnP9fZfGlz031yyPY5Dh86vZkM71pd7skWKu7xEovDasDNkHJLsNw73wK
         xrO3CcawR2QlUxIqSEECr18ltl1QV8T6rYjrdNcifzGiCoMQ9tIV0QAo2LCpxjfxLpbz
         Sj7pSk1QxD1oDNJmOChXYOmejOOwrVl7LutdnZ2ii1JWwrrb5l1CZIjv/5Ffaay2kH2i
         2g2eY2d/GHGHvE8xspHqISAEVbllLR8KxjXLqvpyo2S3XM222Mcdt133QxmPjOWV1ITm
         v3og==
X-Forwarded-Encrypted: i=1; AJvYcCURQ1PJ3PdDNk6wmrLFjyuLQhpJ/Dsz0rY8/eFCmMGuzVpQMC+SZheN5Wnux0FTT/qm1UNF3kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeJ7V4M7LrnNQj33+nfxj/6PV+TTYpImyD4xi4uQJi6IgSPZw
	0GAGU7iSZIDnXNrZfVTMFD+yvubcfrG501cO4iXahmZIg+JMa0uAWOml+D2k4Cjt16NNfbl2ail
	GUIxezN3WcRqBJ+mGbOIeVM4p3j/fw2M=
X-Gm-Gg: ATEYQzydju+hSZABomZwrk51w6tnPp2oGt5WTSZ56ylwZTjG1cznQuYMyhF+qw3Scbd
	QUkSC+grSJHOOAoxXAcuvmdZqFyKNXgcU/Vuu6j+QJNBaJ7qqrnYrc2d4meQp1qcVveh4L4oGK0
	/WBvmhkfuqQPsGtbvztm4b2mqqOKIQf15wrxf+vpfGL82+MadenZJPjz64DCvn7w+U+W7JNWVm1
	udwkxG2PqreMn+aRXOVe+v22WLLZGKZ641p1Tnfh6aHygqzS3qRzW/mCJmgiXMketEJ9w37Mzah
	WQfk2A==
X-Received: by 2002:a17:90b:4a06:b0:35a:1762:92ed with SMTP id
 98e67ed59e1d1-35bb9f5653dmr3408028a91.24.1773845364331; Wed, 18 Mar 2026
 07:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313171659.1225180-1-jhj140711@gmail.com> <abq3yqrsQJGI71jz@pengutronix.de>
In-Reply-To: <abq3yqrsQJGI71jz@pengutronix.de>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Wed, 18 Mar 2026 23:49:12 +0900
X-Gm-Features: AaiRm53b9VgQZBHhKpHk6qxeRQVGZED7vCl-Dy-q0bM0EzZVA_cnAyHZSDfEH2E
Message-ID: <CAP_j_b_QYUJeszN63nkCd1wL0vH3fa8UwCpBxJG4FV9_ARTnHQ@mail.gmail.com>
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org, 
	linux_oss@crudebyte.com, gregkh@linuxfoundation.org, v9fs@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227088-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhj140711@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: 5B6FA2BD9B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
Thank you for the feedback

2026=EB=85=84 3=EC=9B=94 18=EC=9D=BC (=EC=88=98) PM 11:33, Michael Grzeschi=
k <mgr@pengutronix.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> I tested your patch and like the changes, however I have some extra
> patches on top. Would you mind if I take your changes and include my
> suggestions. I would still keep you as author though. These changes would
> then be included in my series I will send today.

That sounds good to me.
Feel free to take my changes and include your suggestions and thanks
for keeping me as the author.

Best regards,
Hyungjung Joo

