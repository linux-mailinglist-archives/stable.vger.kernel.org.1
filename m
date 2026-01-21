Return-Path: <stable+bounces-211172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCcPJOc5cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:41:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24F5D73C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74CF07ECEB6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76E3002B9;
	Wed, 21 Jan 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="K6Vc4K72"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F113559F8
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025554; cv=none; b=inXVYHq+ZXCLxuMf6vYkS+D0G5plEqUI+RssAC2ys2Z3WZTDqHs0QCdG/wGTTke2xu1SR+HZuSJHJnroS2VV6XrLdHzPskrFkbqOpnI+8TOgomBlef9LFyvSTkVJsSqGg3tYF/OOumcRpbzZkFW7fBzTPM7kMOd/L7tfMbbniBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025554; c=relaxed/simple;
	bh=iAinQJn5QYQ3kvgqKm4iTv2GpvuABTLS4Cuy/M96RMM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=HDJkhbqNgZP9yGc7rx9poy0CvNG4vnGD1Vt0tOYSwu5osOW+nH/RgHnDcIxrHnqHClUSEFfeIJbpb+cgdDN3CRORvfuM94Ibsznp0Y6GbHysFMvD0vcj1RXKg4VVc7rV4YqFYchMVSCe4iJstdVPiFAMxZU8MlrVunnDiKG3BaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=K6Vc4K72; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b6b0500e06so318029eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769025551; x=1769630351; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GARQQsAnTLylvU5q1KvHxmmX6+D/SIUBChYjeDOQP8=;
        b=K6Vc4K72SFKmAEOmspVrSL+g2xDSRTizkqCWYqGf5UFlt0xkNd/x36p57Bfjqkurl/
         dYxNo0Kn4m5dXNa+iMTXC5O2GjiWE67cCfZalVuq8wonfpvTlknKNb4qlHtK9oXi3fXL
         bR3EtPzRbEiKErrLt8WZCbrNIpEjNYPhl9eK6zaJHr2ddvqT5B60xUAw/UuzvQ0vFX0v
         Q0mwh/2KJZl0XF5m/oDMxw/pC8GmAiVptpQwX+rXFEp7Nfb/rlkBJPS2s+qqE6QfeEG9
         hNnZK53c0nqlndwY8RrHJU4c67aIbA0/5I6IdgmUlv8Qn5B5/smxb+hjz8ORFhVslSHV
         Zvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025551; x=1769630351;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GARQQsAnTLylvU5q1KvHxmmX6+D/SIUBChYjeDOQP8=;
        b=Ba86URFgySSEZmnL75ZdxSW2CDVHwojvVJ36aeh19bJd1QGqoobzN3BvCj6MV+ckms
         tj+Bp1EsYLY0MBx8pOgbdjXLMGub10uVLfvvQ4wipDcM+0iUC+11x/7/6yiwDhAPOdSI
         9EUjURK6ylJk38g9Ck8KKz8gpLUJ01MuRC1m631c4WcnXOeO6kA+K7KphoIG4ZcLiRH/
         VqoZoPCczoZJdBQlF43Fb3zuRkCpOTtbj/HoUemAZmhRwjU1YQDOeJpDDAbwt+CFa/BN
         qTcyCxp9ywcpQ1TEOWONlyPMAYRLO4Ia+NFGwrqzj1DjhUEdgItXm6mkJ/PcPqP9ESQz
         4KWg==
X-Forwarded-Encrypted: i=1; AJvYcCWYMQDMJqgQ2UJxPYMgSCGVTo6ZgVAl8/a/dVOAPtR23cDfVloDZpudnhV91lvwWw8BnoDaWGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvlqsmrKUYdfi8jP36WuhyH65MjPHrc/29t1vSCzRjBa32H1no
	3myhDH/b+4DxDW1goxaS/6CMM//8PgI4MjGo7w52KhORJv3EG9xnWcIFo7BHtzioojE=
X-Gm-Gg: AZuq6aIne90grnCY7TKjqRdD11FqPpsgEyPExuIKl7viHg7vWwuMOYtnZVXcciApnzO
	GGgpz6S/ObuSH4esQ1/h6uLOTABTdOF6pBpBkGq3QhTyGXiA0e4wV0D3KCMtPCc6NpX6Ej+HlPD
	rWpdD5v3D+ABYKGyA6vRCF/aUDFgO01JICxj8MfaJCRiBaWLA4G6Ax1A5boxmSyxYbmdDyQ8mjw
	cu56qe6uTD+IGT6t/iDHejjkt+/tUaG7Fv0ABpsSCptxpbKRJ8kPhrL+NuGmfT1zCPFlmdopACF
	zA/9rozLXzErQUE81cLTbBmsp9fJT2H4dnndvMg32TDBVn8vD3Zq9LZEbakbOhkmJAwfAfwmwuU
	K/1IPhW0boLyE/9nu4FyZT5ALz5Oqpvtp2GjLa9v9CeM4K1wW07GE9o9qUgQHbgWjBvGw49djU1
	4vJm1/
X-Received: by 2002:a05:693c:60d2:b0:2b6:ffcc:65b8 with SMTP id 5a478bee46e88-2b6ffcc6e0fmr3190672eec.3.1769025550919;
        Wed, 21 Jan 2026 11:59:10 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b71ccf2c95sm2313676eec.35.2026.01.21.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:59:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29_unused_?=
 =?utf-8?q?variable_=E2=80=98atslave=E2=80=99_=5B-Wunused-variable=5D_in_dri?=
 =?utf-8?q?vers/dma/at=5Fhd=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 19:59:09 -0000
Message-ID: <176902554918.564.13470632052259281449@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-arm-697117dbb2a19cc73abf1e48/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211172-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:email,lists.linux.dev:replyto,kernelci-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3B24F5D73C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 unused variable ‘atslave’ [-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:f881c63f6dfec0f96d93d51269c3a33c1d8721bf
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d16e94d964e9243489e3ac17cfd7f6a1714b3540


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1323:34: warning: unused variable ‘atslave’ [-Wunused-variable]
 1323 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c: In function ‘atc_free_chan_resources’:
drivers/dma/at_hdmac.c:1583:9: error: ‘atslave’ undeclared (first use in this function)
 1583 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1583:9: note: each undeclared identifier is reported only once for each function it appears in
  CC      drivers/soc/amlogic/meson-gx-socinfo.o
  AR      drivers/dma/ti/built-in.a

=====================================================


# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v5_defconfig-697126edb2a19cc73abf671a/.config
- dashboard: https://d.kernelci.org/build/maestro:697126edb2a19cc73abf671a

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-697117dbb2a19cc73abf1e48/.config
- dashboard: https://d.kernelci.org/build/maestro:697117dbb2a19cc73abf1e48


#kernelci issue maestro:f881c63f6dfec0f96d93d51269c3a33c1d8721bf

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

