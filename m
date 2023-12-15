Return-Path: <stable+bounces-6839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEAD814DB5
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FEC1F21B64
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04813DBB9;
	Fri, 15 Dec 2023 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hjUuVjzS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BC3FB0A
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702659451; x=1734195451;
  h=from:to:subject:date:message-id:mime-version;
  bh=+O2Xk0eT+CS92YVsZLQ1XCgYu9yuT75TmtqbaC6HdJw=;
  b=hjUuVjzS8p1mS2VQ2/SJ0OY1j3/Wrn69EVQGEx1iQHyiHYfY8MzmjI+A
   /s5tcYdCzGNbrblWiQP+8FzvsYMPEJiFzm33RlAhOipFMsw5GK4TIMf4V
   lbslAJvJv7K+0MQZo2ft3fGZJsJmREvRc49Nhk6vsm4mLW+52at8Ob0/t
   c=;
X-IronPort-AV: E=Sophos;i="6.04,279,1695686400"; 
   d="scan'208";a="260088155"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 16:57:27 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id 7C43E49A55
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 16:57:26 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:64187]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id 4cdd51ad-527f-4e9c-b2e6-470d0cb69896; Fri, 15 Dec 2023 16:57:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4cdd51ad-527f-4e9c-b2e6-470d0cb69896
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 16:57:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.174) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Dec 2023 16:57:25 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 15 Dec 2023 16:57:24 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 56BF423F2; Fri, 15 Dec 2023 17:57:24 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <stable@vger.kernel.org>
Subject: backport: perf/x86/uncore: Don't WARN_ON_ONCE() for a broken
 discovery table
Date: Fri, 15 Dec 2023 17:57:24 +0100
Message-ID: <lrkyqil4zh097.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Please backport following commit to 6.1 and 5.15.

Commit 5d515ee40cb57ea5331998f27df7946a69f14dc3 upstream

On SPR MCC the discovery table of UPI is broken, there is a patchset [1]
to mitigate this which landed around v6.3, this can't be backported to
stable releases since it is based on SPR related patches which will be
needed in case of mitigation backport, but already WARN_ON_ONCE in this
case is not needed here since this is hardware problem that linux can do
nothing about it, this patch replace WARN_ON_ONCE with pr_info, and
specify what uncore unit is dropped and the reason

[1] https://lore.kernel.org/all/20230112200105.733466-1-kan.liang@linux.intel.com/

thanks,
MNAdam

