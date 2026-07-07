Return-Path: <stable+bounces-272516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O8CsGuJ4TWoN0wEAu9opvQ
	(envelope-from <stable+bounces-272516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 00:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA971FFE4
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 00:08:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=breiti.cc header.s=google header.b=SvsVYU3f;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272516-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272516-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50B94301D4E5
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5A3B9D81;
	Tue,  7 Jul 2026 22:08:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFD3B71B8
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:08:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462110; cv=none; b=VXCeCp3dKyIf4IfBIKbQs1Vi0arMgNRfwe7jFgfiOVo6mrgJpHJ+V5cUKgEUKQ4zx+1S3kKyUVgZxR/bnHycLJP0VVlT87Q/jQ7pO6+vE3Z1JaLoFZ7PsX8zPCBsGfiHmMqk70FwHzfC0iLFf/R/OBA7n8qbRy5FbwmMFXisD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462110; c=relaxed/simple;
	bh=D+X3YsGJQPAG+YArlXUucHzgWYaeRVUvFG6vKuZQdTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWcqLcefymBOeT4AUsUlj1RT/0iPWBGgjpYzCD4BgcWcTokR7B12zlH1CIGKHrwAjvSgtWns77gVj/id5LjBRCOtSi5w4+SOQcS8ff4RG2ZkyjV1godvC30jdRVJPZpGIXsKlsH8FiGvkjJJHC3plAlGKeDit1uPEYhWs3CGhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=SvsVYU3f; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45fd464d51fso18097f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783462107; x=1784066907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0Y00LTtFUh7icGquSYtKTdqm4NPmTd3M/HSxiWVIL0=;
        b=SvsVYU3fKlvDhkft/5a8whv5ilLDfuzwhgf/QTGRmmGHrpG0R3qEJmVlR2shOZHPKZ
         i2+aVFS6V90BxPRilUbYDqA+YtCN+bXb2zqbAUwAsg1PmJZL3ANyNAD2DQ/r57mGqMT6
         e9TL3plnMAAUM3MdS/74HcWYdhQbX0fN/Ecug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462107; x=1784066907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z0Y00LTtFUh7icGquSYtKTdqm4NPmTd3M/HSxiWVIL0=;
        b=h/5Q1WZ1ypvXR72hiW7fKyMNRJqdiswBzAqsuFTxghVjLjsHrz1/JRqbYKPO+BhHpN
         QGQ8XW/Gn+OFS075SdFy0OajXRjl9KS6aaaPx5yRnKimTrXQzcBV4MwdFABfQuhNUkl3
         cuekJeDUSFSWCIiFIbXAsk7qyZW3PQXTYFtgUemlhtqFu8imsBpClRb4x1LBWHseM+cl
         jqjNjT9clNgOg9yLTmMZhDkIcAArh3sIS3xqCxAdFLI1lOQ23bvdxAZXabMko9aFAH8a
         5lJc9M20a0+9gZbDUVL9fwf3T2y4NEkHOFGUiVsIdh8xWjBMQP2rdQGIPH5VL2Zp6+y9
         gpMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqi74HnOyChoZRzRvI59z3haoyaHRemT4o5h4lOHzOTgOnr5nIjrsSvkhzkszY8aHeBJKhde78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlisZu/iBWNiyZYeL/BzC/twRJCJBtpB6lyJ1mAd8fpw51988b
	fdHmnTKi5u7JIAn+vgYXZ66LAKZ5Mm6b6TGpHMoplhLjGgFlpV5gl15d4e6mCuEwycyzWUVBaQ8
	ViRXesiO5
X-Gm-Gg: AfdE7cleIMdY9LkbmTNqPN7WtDMNeIUl4w485Qc9cwV2eIHbM3VVYv/xezMCPJ3lSR+
	0DRkZtiDBVMFT7S7ZumtWlbplmp+vVZ1v4SW9mMrSV1SStPCGHCc0k6mPwpdKzWMJhgDAhUpA7M
	0AT03CvxQ+O5h35QO7siLedSmWa6MJmDBn1y3/bfq2t1wVLaPHw1dfxOBULJJvb2U21S2KOZGfr
	64SOcu15qKiONAu7YKEyAVJMt6cuUj+YHWYBvOmmwhWYVZxSUy9YPgt0tZW2Ulw8TvoyEk42Lz3
	8e2wbz7SIjvLrN4CS62EpNa8zwyAVJrKuEhlh0SeNgBxdEhLchjpFhDyzguiqDV0sQ1K6PwUgLO
	EZFmFIJJU1EqVOZUipWbSalXK/S6cLWxI2scgtxxJGkIRpc8PpkW8OAZsdQsKYAp7jlYKrvTsTN
	k3+s6fUPnX2KWTWXbGWmVNwiOiaDdOeF7T+Nmu72neVD3ASoDrtA==
X-Received: by 2002:a05:6000:1081:b0:466:6ed8:1e1b with SMTP id ffacd0b85a97d-47de665b919mr6903538f8f.21.1783462106858;
        Tue, 07 Jul 2026 15:08:26 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm38025856f8f.9.2026.07.07.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:08:26 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	bre@breiti.cc,
	bre@keba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	yong.liang.choong@linux.intel.com
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on unchanged mode
Date: Wed,  8 Jul 2026 00:08:14 +0200
Message-ID: <20260707220814.109028-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <abd431d1-2819-4dc9-97f5-8e2b2ceb2658@lunn.ch>
References: <abd431d1-2819-4dc9-97f5-8e2b2ceb2658@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[breiti.cc:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[breiti.cc:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:bre@breiti.cc,m:bre@keba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:yong.liang.choong@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bre@breiti.cc,stable@vger.kernel.org];
	DMARC_NA(0.00)[breiti.cc];
	TAGGED_FROM(0.00)[bounces-272516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bre@breiti.cc,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,breiti.cc:from_mime,breiti.cc:dkim,breiti.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1CA971FFE4

Hi Andrew,

Thanks for looking at this, and you're right - the runtime case is the
more dangerous one. If a genuine interface change (SGMII <-> 2500BASE-X)
happened at runtime while the disk was live, reprogramming the shared
ModPHY LCPLL would disturb the SATA PHY under an active filesystem, and
a failed boot would be preferable to that.

Two points of clarification:

- A plain switch change does not reprogram the ModPHY on my fixed-PHY
  setup. mac_finish() only runs a real reconfiguration when the
  MAC-side interface mode changes (e.g. a multi-rate SFP moving between
  SGMII and 2500BASE-X). On a fixed copper PHY the interface mode does
  not change, so changing the link partner / switch does not trigger
  the reconfiguration.

- The runtime reconfiguration path is not introduced by this patch. It
  came in with the Fixes: commit a42f6b3f1cc1 ("net: stmmac: configure
  SerDes according to the interface mode"), which added
  intel_mac_finish()/intel_set_reg_access() and the PMC LCPLL
  reprogramming. v2 will only read the current SerDes rate back from
  SERDES_GCR0 and skip the reconfiguration when it already matches the
  selected interface. At boot that suppresses the redundant reprogram
  that breaks SATA; for a real rate change, v2 leaves the
  reconfiguration unchanged from mainline.

So for the runtime case you are worried about - a real ModPHY rate
change while SATA is live - this patch does not make things safer or
more dangerous; it only removes the spurious boot-time reprogramming.
The broader question of protecting a live SATA disk against a real
runtime ModPHY change is pre-existing, and I don't have a board that
combines a multi-rate SFP with SATA on the same ModPHY, so I can't
exercise or safely test a guard for that topology.

Given that, I'd like to keep this patch scoped to the boot regression
and leave the pre-existing shared-ModPHY-with-live-SATA question to the
maintainers, who have the hardware knowledge to decide whether a
stronger guard is warranted.

Thanks,
Markus

