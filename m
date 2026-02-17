Return-Path: <stable+bounces-216774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP71KMxClGkgBwIAu9opvQ
	(envelope-from <stable+bounces-216774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:28:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709914ADA9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87A65300C0CA
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902A320A23;
	Tue, 17 Feb 2026 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgFEcrIK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DC320CCF
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324105; cv=none; b=hsKgy1a3p61ijSv2zuQHki8+/NNbKwrIBajcIN1Twr7q6HcM0nVF4cItu6zEYF7xc7fZcP1FBL4OCbAKzhudfuIvxe8u0zZm3O6L5G1cNquoNtZsitRHfZh8Jh0ufKNuszbAy409U23Uxhz6U2gtYsvjHqp/KTaTvZBiPlOieTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324105; c=relaxed/simple;
	bh=Wi+6FL2HC8in9JB/8tyHaqg2qNDpCsf/gocDozzWypE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t5mjCPWvNUrNmbu61zc2xabm88IhfZfi+6dF9CTk2fiwb5ciBlAFbOF8Lu64Ib6lsmebjslVGyMxGo+xx84t/E+voF2Ddvbc+7r5sF19OFtlTm1casg8CjcR5PGYoDjlf/BrVrucQNnock9IfjtWjlPlkcXt+W9JMVqPyzud3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgFEcrIK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so35053115e9.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 02:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771324103; x=1771928903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi+6FL2HC8in9JB/8tyHaqg2qNDpCsf/gocDozzWypE=;
        b=FgFEcrIKVMxPDDwqKM6iojWZeDocgvGNWFeR+vvi5M9Fs6UZhP0vsK1dRORZve0ANy
         WqQ0GYx7aYKz0Cz6fw7T90vks0YA2POu6TyzPp/kU9KCfrsrqMH+dyEedeVvOZwWqbNf
         5b8aomv7mYH69N627LvcLb5GFrVCF8X/uvywumg/wU7jtWkm9/qnBxSZW5tFDA9BFgC3
         TSjNsSgjOf/BA4BbVjEngCiib2UKgrWjBA2xYBreXXRdJqlJiHdQpgcXduGaAK1xkNcz
         BkVv+nzKGJ1PnkkSyVqen0rxqaVgCSfRclyOzCZYFhqmtq+KRrHI54Y1rsHER2M+6/wS
         tAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324103; x=1771928903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi+6FL2HC8in9JB/8tyHaqg2qNDpCsf/gocDozzWypE=;
        b=eL5XQcQQSPLj8sfzN74ejU/rDKff6Lk0GI9hUg2KhM7qo2WKb0crlLX0v2P6W6/5F0
         /VlzLvzCu9Y52cbRUAoMii56LdeOFH6P6k0D1YE1MQg5qEKPR8liOHnt3dcdhZmfoPwn
         0LxXH2WUhqHRzjPtbHXSgMcQWYk0UBj3+Elhdr7EKyshTbOw6pPK08VHu1fMXgDRpQr5
         eB9UoM8IhcmMnncJurlFLe0hde6UqI3O+fRwxSb9w3zJQuZTgJ5TvliBkffSe/6CPBYI
         tDHbQHiG+5N/3yJefhJMlkI/+lugdDDICrLlHUeVDF6GJvviAqHNliu5t+AhYFJSI7Z/
         KZKQ==
X-Gm-Message-State: AOJu0Yzj07SeRpPd+eB50g8KYv0ithFBX0NxLzWGCOxaIkqyFiCwdGJg
	BkqkGRIBWgsRxnZDqTmhSi8xNy/7EE/0NRL7AhU12f0FS8LhSDFUuGuR
X-Gm-Gg: AZuq6aJH/MSG7eHlt7V7K7Se/3M07ktat2edy/wZbehEp+nq2m/JkxuINh8O+eqOjpH
	VC9zAEpcV/CTLhz58WimrVqUigLotWz+4UxhQDrVq/LzRvSRZlYqdxVYcPMLTEsB3Atrcu9SYtI
	n7bhHhdnEZfvaqqG9cZjH92KjjpQRYjJL3cXG4RHq+ce40nhBFvM1Xju/bykDqaAzYg9DHBqq4K
	wAQjeJt5/Hn8RlnhXUe115JFkOcpeaBq1/+AziSHV6KV0VY+l5HFNuGFGSrKz0T8+qycfNDGQzi
	Q5zaYbs22I4K1m/qhV868yEaBySuGcRl48DRk7f+cg3fIKdFPpwCMIlnbPl07g/GjgYRGblkLxF
	5DWEI76xdKjjiinJVUhYN0ueny96SHDqqvOmjyMlfJK3K5wGlXZLVqU5TniawSFd6Kh6EFz3ZRH
	des4m4WRbYJsRYclsOFI89eRBP8hvQ0s5JoCfVKTb8BAp81S+MWSX4zaW7
X-Received: by 2002:a05:600c:6808:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48373a3e755mr228402645e9.18.1771324102413;
        Tue, 17 Feb 2026 02:28:22 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm904469255e9.11.2026.02.17.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:28:21 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 05E4CBE2DE0; Tue, 17 Feb 2026 11:28:21 +0100 (CET)
Date: Tue, 17 Feb 2026 11:28:20 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please apply commit 9990ddf47d41 ("net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons") down to 6.1.y at least
Message-ID: <177132401902.2893171.1371685164011289024@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216774-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4709914ADA9
X-Rspamd-Action: no action

Hi stable maintainers,

9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare() return drop
reasons") was alrady backported as well to 6.12.71 to address a
regression when backporting 81c734dae203 ("ip6_tunnel: use
skb_vlan_inet_prepare() in __ip6_tnl_rcv()") (this one was backported
without the prequisite commit to 6.12.67, 6.6.122, 6.1.162, 5.15.199
and 5.10.249).

Can you pick please as well 9990ddf47d41 for the other stable series
as needed? I can only give a confirmation that it works as exepcted
for the 6.1.y series as per https://bugs.debian.org/1127823#36 .

Regards,
Salvatore

