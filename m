Return-Path: <stable+bounces-273929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jd73FT0nVWpZkgAAu9opvQ
	(envelope-from <stable+bounces-273929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:58:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B374E399
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S7hsQcEp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273929-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273929-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8455E30CCF6A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF434A796;
	Mon, 13 Jul 2026 17:54:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838F34C981
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:54:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965256; cv=none; b=IA3kZzkifhm6DTrGWyzxF7MKg2bqp61+49i6t3IymJd3smtyn/UWXACB6G7taq6ichyMSZ1ENL6g2NM+Xfe8NdsYG1VUFqd+Ol7ILHuubkWem4OJtclSaYytZ6ikdYnc2P8O5r+IePDTAt5GEoIoefNOKken6rua8fNplaKOKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965256; c=relaxed/simple;
	bh=fwwlYXwipnRJM74azo+rjLcKco1it7zPCL0/YQ8eHvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGVI5pkXDLQlPPx1rC3d++8tHdhl05PIL4wi6lH0m1Z0w5FSimZhR1awL5Hm1Vzx1UgE0L9sE6R1vV33SrNWyEIKaDRC2kZuaC35xH0+Oej1+L4VGoBdBlpGu71/n5pDDtkxbnL3pJKozDhvc3Rmf0DV361HQpWtWOdkN3Pe9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7hsQcEp; arc=none smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a168dc590cso2411162eaf.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965254; x=1784570054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oi7RBUONXGXfnURZsInlGh33PNi9ChYYlmF2YyoKqk=;
        b=S7hsQcEpNtyUh/EAj+9DO7grKtEOyeWQtbWp2Yb0cg5SQlNWWrxHPsuQdX8usCpQgB
         OLogv1fXbN4zpis7nAqZazMOY5SvEVbgyp9/pkyt3WKqL+8/7mbW8XcpR3E4gPxccw3z
         lOhqpnaxhUMCGyem01H8E7YtJVTD731yaT7hqm9kjvfKlsNp1adghZjhXz4OFqAgncoh
         6bfNY99uQKl45nGXiNUBZzGoG1Bb1WpljSSUlGpiFtg5OuDc7Cu0tcie9fXmLEybOpDJ
         pFT4Yl+ZnxF7FnJa3TXqcjDgzR8iGluluTNTptPZrXrIJatuuSm6M8/SCBc+WezrT3me
         Du1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965254; x=1784570054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oi7RBUONXGXfnURZsInlGh33PNi9ChYYlmF2YyoKqk=;
        b=LHry4mft/ERMXKO97neLmRz2SvsByCa5YNw0w1stqyOM3eMHfPxPbeiKm+8vFcJlfv
         6YKQGOW498xNvfQbWYmtuLsIU1lgTs2xZG7IYV2tzSZ831VfyxSNTxueVaTllzOEOBdy
         l4Wv4QJpDiampGCXKL5kc6/RO/tpv/ZbmcjT+OuT5SobkA6cRyBn8cKFprPxDLZ00VmP
         7xZcDLO47+RODocrC9N5KI2pcytDMLMj5DvZNTkqIvMl5WMsVBwkBr8CeNsgnKbmTTAT
         8J7Z566b9GiFbJmO9LrmYNjq+lx7q4LlMG3SGC5kLk4bLCtn6d7A0eF0ipLF7gTPplrF
         VQ4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/f6ru1pDQVDxYuP9IzsnbQkZ68hyLkhdrJIzqbo0680otIM+4Lul1G+lTuiPPIMlrSgiEefZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPUshDkrMGhhN5JXohl/biRZ5umIQXSyfBhDQKGvgRvpe5JC6
	ePpCFecyw04dbmqmw+AkZCWy4jBnoDqOsa46rhl6OiybxzhAYamqwKmS
X-Gm-Gg: AfdE7clujbmQKzVeJbEgliQyMc+/LMw4DXLMuvW0ophQpNHOU7HEs0mRscfdcXD1Clm
	kL2KO+0FxQO6Xbe3Eaib3SccyrGNu5AcjcWM1M4bJk8RR9VVAesh0wgNSRzVF444t+qf/FRktwV
	mtflwOS0EpEEXv7QGtl5zIbUhKgYYDoSy+KG+/Lhr+hDGoOfpfiBYqVN4aUCaj0OUoA21SuORub
	/DruEuvCgpWrlm1UkRKLmbeboprikGVHKfyHS7E3TSggXfIPTwOia5/ZwmzJr6h0rN305ohIyFA
	BN4TIQSFCnHUjl4dbFmEnY1ZaxWtEdbTluc7fQ2AcqJ9JO5gYVC922Kw4nXaYaEhLonvXDrefX4
	fSonJogmBAUIhutHbH1Ugvmg4BEjZMHHAodpoL8jEy1OaKgNA4elGlFQiKrfWMLm7ct9R/xxnoZ
	KcPNlapRNDkgHEjcn/eenrHwN1ZvSCq/xKcZTaAs5bXJMsgojuPLcF54Xs694v/zQIa8PO2rMWl
	J4=
X-Received: by 2002:a4a:e910:0:b0:6a3:7701:660c with SMTP id 006d021491bc7-6a3c607cbb7mr303794eaf.20.1783965253754;
        Mon, 13 Jul 2026 10:54:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec2229b4bdsm4169384a34.1.2026.07.13.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:54:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v1 0/2] fuse: fix missing barriers in io-uring init
Date: Mon, 13 Jul 2026 10:53:43 -0700
Message-ID: <20260713175345.2542331-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273929-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:bernd@bsbernd.com,m:fuse-devel@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A83B374E399

These are two pre-existing issues Sashiko reported [1] on the fuse zerocopy
series.

[1] https://sashiko.dev/#/patchset/20260630211436.2062816-1-joannelkoong%40gmail.com

Joanne Koong (2):
  fuse: fix missing barrier when checking io-uring readiness
  fuse: publish io-uring queues with release semantics

 fs/fuse/dev.c       |  8 +++++++-
 fs/fuse/dev_uring.c | 10 +++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.52.0


