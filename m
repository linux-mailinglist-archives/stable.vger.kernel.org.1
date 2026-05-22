Return-Path: <stable+bounces-253715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK7HA3YYEGoITgYAu9opvQ
	(envelope-from <stable+bounces-253715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A38635B0B78
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E35AD300B462
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7B3A9611;
	Fri, 22 May 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="U0p8F1o9"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9A3A901C
	for <stable@vger.kernel.org>; Fri, 22 May 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439730; cv=none; b=F+fZtRX1zH69kY54pAMheV/zMzpiNBGBeOZPViaSMNZpHr3sxCj6AhYREfNyVgL5Rk3OW+ElJ7ZWgJJT1k9n46KAlw1aafZu2iQXkwY6opwi3ULK0aeswBfsBm3RejPsXvDKjXp1/B2X4KQ++VgkFvebCSKT99jQatrlmGYXnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439730; c=relaxed/simple;
	bh=JfyZk9na0+HNyT9Sk7ISiG769utjIj/bHEiQdUvlVHs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O1Du4273L0RJLOKN9SFt9s+8S0s1ZTAebP/g3Icu+XnY79j+mD+DpJfHAAVfMP7ORAK9wINaImDujy0Sy2jQjhMQgoGVz/BRaAPyH66C00CiGx5SPf8JwqNOamjXWkIkTrEuNOgvGhebtDKdAupdGQme+IEjqU95Bd9zCvZD/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=U0p8F1o9; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779439728; x=1810975728;
  h=from:to:subject:date:message-id:mime-version;
  bh=KqxTp45t+dKpX9SK5yEjA9iqlPvxJq0qvZKAduuL/ks=;
  b=U0p8F1o939uRi7I3PWeXE7Nybqpj0St6t5vFofjDuDmccMwQjb464yvt
   7egLoP6kLHrXb+44m6VBxU4mzDlFKBGTGUxawMuFx5oEwEWdiZInq344z
   jglSxrV0zIkRtrRPtWptMwNubHdLJoNM1vazNNi8S79S+eQSKZtenhN7d
   gCk0RZv+udlnQ98FqekfLzSQg2vhipwbjAzhVnTtLqQLmE0Nv6FmdumfD
   ALUrvU1OB7JVsyG4qPwVEzskWDL4w7eZ1Ix0lpftMeFeiMZPwdTJbHR76
   lsAwv1pKHdn8X8gSZcX1lF4K2lp2Sm2PjZPVk+VjXh1cqR2eTfVsAn4dl
   Q==;
X-CSE-ConnectionGUID: EKPzl7s3ToicvO4+XrF2Lw==
X-CSE-MsgGUID: Yiw599v0SQuv0Cb+i2jIrA==
X-IronPort-AV: E=Sophos;i="6.24,162,1774310400"; 
   d="scan'208";a="20144772"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:48:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:8535]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.254:2525] with esmtp (Farcaster)
 id fe1ab78a-ccfd-48ec-9f1c-f70799f50fa2; Fri, 22 May 2026 08:48:44 +0000 (UTC)
X-Farcaster-Flow-ID: fe1ab78a-ccfd-48ec-9f1c-f70799f50fa2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 22 May 2026 08:48:44 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 22 May 2026
 08:48:43 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <stable@vger.kernel.org>
Subject: Please backport 64fac9903768 ("selftests/mqueue: Fix incorrectly
 named file")
Date: Fri, 22 May 2026 08:48:41 +0000
Message-ID: <h6dsxo6i7suc6.fsf@dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253715-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[amazon.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amazon.de:dkim];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A38635B0B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi,

could you please queue the following commit for backport:

    - 64fac9903768 ("selftests/mqueue: Fix incorrectly named file")

to these stable trees:

    - linux-6.1.y
    - linux-5.15.y
    - linux-5.10.y

This commit is already present in all LTS branches down to linux-6.6.y.

For the linux-5.10.y tree, there is an additional dependency required:

    - de53fa9baa70 ("selftests: lib.mk: Also install "config" and "settings"")

Tested on AWS EC2 m5a.4xlarge.

Thanks,
Simon



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


