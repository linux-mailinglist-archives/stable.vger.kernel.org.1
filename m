Return-Path: <stable+bounces-210585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JqQCpXab2n8RwAAu9opvQ
	(envelope-from <stable+bounces-210585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:42:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BFF4AA4D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5D3B50E1E9
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A228D43634B;
	Tue, 20 Jan 2026 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b="TOEr5Fsa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F2362147
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932337; cv=none; b=P5qEvEUNW9gvuatvG/NkxnBU37ILG5T4C9gR0VtZc8nxmBAoo1TBaoae73r9fnKxoAYVy4F8CXQmEHJ5wXCZRW5YH7PSbbKUv33WrC5351E55F3xUJz6XOhoDDDJzF7jdYKYBu3zxL5DuA1BACgLa0J6jV1OxIhm69Yh7uIdS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932337; c=relaxed/simple;
	bh=PLPBMJ+Xul+GCVmsfjqrQBSjs4dMWtSa1Yyl4ZdhPyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HV9NzCQy/ArasQzz1sX/cvyRQr5X/FgqHEnJQDMm5G9wMqL36fxN48y10pg/N9cJqU+gbuvhA809OZtdxGwNsTGervUG1mjH0h/csu3X7DtZLDW345RP0tDhXDnmHtPndOdqS1hClih2/JCGFAkRVjVqUQeBcNw6Q77nwm5KiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt; spf=pass smtp.mailfrom=jakstys.lt; dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b=TOEr5Fsa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakstys.lt
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b86f69bbe60so889178066b.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jakstys.lt; s=google; t=1768932332; x=1769537132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCVqhiNdGxyvTknOJgRK/gQVdV9IWty332W75iVfXug=;
        b=TOEr5FsasC0qBqi2cwml4hr4XRysGftOZSPVJTFdhU9KstaiF0CRanBOMYdozr6pOi
         xUN8Y3oY4X4dqOJ08Ho+qAUWwQN3rrOQnRkozCf6o4emQDxW1MxgKA6nm02H2iNuDnu1
         pqGkU5F6IyPx1D7C+ZxukPo+TD5f2kKQ2V9um9Ej8ijolEuM3KPLjYR3A6RjLJSsk4rA
         hkATtOv9o/e3kBBBvHVeYgIdl4byeqzyfY6kyMY7v9I+fqEmjH4F3LfFmel5AKmiPl4v
         eZ9QjDmFnlHl+OJZ6XzscNNZKJoUFh+AeM6woyyccLQDbepSPryGccw1sNw65ggsS6gn
         ECIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932332; x=1769537132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCVqhiNdGxyvTknOJgRK/gQVdV9IWty332W75iVfXug=;
        b=J9gRpKlGDQW/WsPEp9pp0R/5z1E+J+/KWvPIbsgdG5GZAZaqymu27vUHK4CIDoq65q
         H0KFpP0lr6o/dbhmiaPwQUM++Rpx5aIDu1kD2jqadjTfaRCcuh+7v6JPlSFR0rqaxojw
         pu5RBRfzLX3Pu0qeZKv3V3Cc2CvDE19HZWPokezOsmiSM/lSQma6TtS+AS7R0g43kOXf
         C27qHD1oWw0kcsGP6EOo7BPQAul2LJwLGRp77632XJBEyxV23qbeDiDFCLjL8Jczaoau
         +YqYL3Z6YBKVOicjIjGzUOzXd/KxqzCIPJCkbjB4RYq0CClcRTEq8wvOt+aAs9wYbZY9
         csLA==
X-Gm-Message-State: AOJu0YxNMoS3lAQEM6+Wv7FXsmb34syhjUv2HjUKsyM/eHEReYBN9N6W
	StwQjXAzBZlasxk7eTQqfLon51mIE9r92fh5NxL9oi1blltCW1SZroJ/D6yRB3bCGs0BG3P2RzF
	5ADq2dA==
X-Gm-Gg: AZuq6aKvDHQbsUiSa6Q3b+OEfnEeqH/6Ovk0uBqoqr1Kf55kY6JomOfyYb2b+rYjsRW
	wKbvYHsL5jbpSWjnBS75vmudl2pbc0xSp0Ep0dOB2CxNi5LohiNTEsID9mOIpZXN0wHPEOOGPGb
	8ANXlHBt/c3ApCaWQhTlMKnm8h4YHA1Z3g/tzpvv93xWT2+AbVXLx3F5BQFX/DOO9eaOfjo9+Fb
	3Y9E5GFpDu71LB1axQXB3dK5+QWlWEW8IWh4c1SsAQa1W42jdzvIO7RGSRmVG+/3n2OMWgXyzNe
	467EUxT72f8y8ub4goOPnNLnTpEHvOpHQLswS5ClOdILxQPsXMuEZu4JEsYnbY1dgwo8MvGoxCE
	8In9zdbXaU2dIHyfaDYtrCTa1ExizvgRhKs2MDfc3kH7M5UPl01k3pSFzzVDr3rJXb9zGrtxw5J
	syPm78GM0oATtQWIKVGIjJLjApsr/VksR2lcffR8iZFiCMO+rfm2QVhGRFOhDd4UPuswHH0bFy+
	nGWbP2TVFTqFEXnRTM2XVgoRTZmq6Q=
X-Received: by 2002:a17:907:9443:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b87968b6ac7mr1274696166b.8.1768932331790;
        Tue, 20 Jan 2026 10:05:31 -0800 (PST)
Received: from localhost ([185.104.176.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513ea20sm1495498766b.12.2026.01.20.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:05:30 -0800 (PST)
Date: Tue, 20 Jan 2026 20:05:28 +0200
From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <motiejus@jakstys.lt>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, clm@fb.com, dsterba@suse.com, fdmanana@suse.com, 
	linux-btrfs@vger.kernel.org, robbieko@synology.com
Subject: btrfs: fix deadlock in wait_current_trans() due to ignored
 transaction type
Message-ID: <kytenpx2jfpyit2rxt2v7owrcxd6qy7amlrxkizdgcmuvhkqjg@tqzxg44mrsey>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jakstys.lt:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[jakstys.lt:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[jakstys.lt,none];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210585-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[motiejus@jakstys.lt,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,jakstys.lt:dkim]
X-Rspamd-Queue-Id: C4BFF4AA4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear stable maintainers,

Please apply 5037b342825df7094a4906d1e2a9674baab50cb2:

    btrfs: fix deadlock in wait_current_trans() due to ignored transaction type

To stable kernels v5.10 - v6.18.

This patch fixes a btrfs lock-up, which we have observed a couple of
times over the last few months.

Motiejus

