Return-Path: <stable+bounces-269824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IDIFGKPTQmoHDwoAu9opvQ
	(envelope-from <stable+bounces-269824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:20:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F26DE98F
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:20:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=f9D6ryyv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269824-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269824-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965783040206
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63739023A;
	Mon, 29 Jun 2026 20:19:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4F38BF69
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 20:19:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764380; cv=none; b=QJvmlemT7INNjARsKNkvZLX8u63ZiKlWaArE2+ls5GF4lQsqPKJgQy2YWLY67YTPl/UTxhLbGOlA16w+iAO8hvivRKYT2VHuzWvEMJziz6Zn4QK/KgkuScUQrSzCIXeYdygF60YSejLop074v6h+Abyp5uM//wFQzjyDE4NOVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764380; c=relaxed/simple;
	bh=99WKfdqZoi1+9ylSQNVVCW06vQ25p+lbTWGbcCvQBW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=luXldDEqC/QV8jPZDpA8Z6k7+iE/71DpZ82XVRdQDuIu0YbfmUCJVdFU5cya+xfehfDcHVKxHL75ZvG7vMeeDmhD1tqbQxe5DsugDNxVNWk+CaArZRSgCAsnwXwLdnIY5HoZnMhtjzKtRih7OlnO8tFqWBqD9Nk3Q8JFFU8rsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f9D6ryyv; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8478a25f268so825782b3a.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782764375; x=1783369175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiWkzSXLrg0x2FGE/eIO2X7UZ5sYnOvtaeA8i0STfAs=;
        b=f9D6ryyvdXnvVuX+Wyr7ate0AiJRDrButbjp3k/IOAzXYyYWeLBQINdGwlz1lecJyI
         itthAY/k2FRsbMvI2s2RZWbuS2lyUvjNVUYkX5YuEOE8c8szFtNBZY1fZAiYGYTGa1Jf
         Jm18HqW498HAwjiTYvvo4erYbCwoM2gNcFCszWZs2gg1Trxr4yj1rxVMIk3jHLhKv54c
         8tK0FN6R2blnc0c7fQdhknXE41zSA6wwTyMLI4bdE4tSdc67Bum9/ousg/cR4scLBlCL
         1ZMyVrlAAYcB92j5ftjxVuFDSHq6KdFv/LIGwdu8tkpDmxquVEmz10o8/uw0j8iT1J2S
         Y5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764375; x=1783369175;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiWkzSXLrg0x2FGE/eIO2X7UZ5sYnOvtaeA8i0STfAs=;
        b=ruGkCiMsF+3U35+kyiXyu1whzlH2oNOZWoWWBViP+QpA79MNz+FkX3iDOECjXvjHWP
         Wmz/zc8NPjN5fQ4dWpzKwFRPrPiOMHmcW8xP2gWkNL3Z5Sa5Gk/GbZOyNzZ3paG6BJZZ
         Oxis4FWc+H0dlImTmgh+b/Olq01NLi8qiB6Gmr1aFsTQfHoqrUd0hSAlweYwkqfySR5X
         D1NAlGbXhFKX+REMq9a0I/56HfGbPqHSl28Ei0W5zYunSJfFkx7m/O9DlLunagR1VU3C
         0yHIRiRF+wBjv6VdGSLLBX6DaPjpCb93cKdOuec8YEv24Nm/EVbcnTYHPXd44OKEUFub
         X7bA==
X-Forwarded-Encrypted: i=1; AHgh+RopZX3yl3XoO7h9EqkmDsLxcnvDiuJXc09WF1urPlkLWj6Co8cfNboCuZVlHTpKL8RMTTU09vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMqsfGJ8f9NUhUB330G71DnPAj9Q7JzdHFuVvMShTirpviKzh
	xACgGnv9HevV4Y32+bcVitaiTL13U5wOw1o5CLR0YJrPi1BY4sK4QL9eChxsFdLc1D4=
X-Gm-Gg: AfdE7cleDnzN6l+X95too0AG0/iDMzXWrK/AsZzGYmmkO+lM95aYbAM7zJC35EJ1W+1
	UOLzaGtpOsYP15th1XPpETz361Hq58gqFYh2ZgwuROZp39A8lUhwfRU9fYXiAXhv7e0zDPDNHGv
	id1NUIe3vYmqzK2bktinhc4pds5e5nnAy5KzoC0F9rHBtEnb0hfcI4vMEyztoGGir2quxx2Xe38
	566wfheAwOeKDZ9ctIIgyMr93ElMQVaA9cIXXqZNMgR+3nKkqEIM7nr+k9sO8fQEHWGdODFw+77
	+mb6O0ZPGXosFIARn3hFRS4UnNcNzcz3/+LBU9Gayp9wFfAR+cHm7qUHXp+9/9XGXHuxuLcv+ZE
	Y51X8KbdVjPbfgsKWPBFSTaZe1yJWraVlAUV4BOincoKJxSWrIVuhGdunlNv71qMDuFIZkLYNwe
	FHGl48mT4kmQ==
X-Received: by 2002:a05:6a00:1814:b0:847:98cc:a347 with SMTP id d2e1a72fcca58-8479f2ce28bmr712007b3a.61.1782764375358;
        Mon, 29 Jun 2026 13:19:35 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-847a0007464sm316121b3a.23.2026.06.29.13.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:19:34 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: paul@pwsan.com, aaro.koskinen@iki.fi, andreas@kemnade.info, 
 rogerq@kernel.org, tony@atomide.com, linux@armlinux.org.uk, 
 Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260623072534.1997680-1-haoxiang_li2024@163.com>
References: <20260623072534.1997680-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix a reference leak bug in
 omap_hwmod_fix_mpu_rt_idx()
Message-Id: <178276437440.1055800.18333324347324908320.b4-ty@b4>
Date: Mon, 29 Jun 2026 13:19:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:paul@pwsan.com,m:aaro.koskinen@iki.fi,m:andreas@kemnade.info,m:rogerq@kernel.org,m:tony@atomide.com,m:linux@armlinux.org.uk,m:haoxiang_li2024@163.com,m:linux-omap@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[pwsan.com,iki.fi,kemnade.info,kernel.org,atomide.com,armlinux.org.uk,163.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[khilman@baylibre.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269824-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE0F26DE98F


On Tue, 23 Jun 2026 15:25:34 +0800, Haoxiang Li wrote:
> omap_hwmod_fix_mpu_rt_idx() gets the first child node with
> of_get_next_child(), which returns a node with its reference count
> incremented. The function uses the child node to translate the MPU
> runtime register resource, but never drops the reference afterwards.
> 
> Add the missing of_node_put() after of_address_to_resource().
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: Fix a reference leak bug in omap_hwmod_fix_mpu_rt_idx()
      (no commit info)

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>


