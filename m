Return-Path: <stable+bounces-94624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248D9D6145
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185C8B21444
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2C171D2;
	Fri, 22 Nov 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iYrn48c4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB62309BF
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288814; cv=none; b=UuaPoa5C4WDqSX3T+b7/UTldGEHkLiBQc28oh4C4rpeAsx2Cg3mG0J18YmzJfa7vzrvQXgzFlpkCuWgRvFfNhbkoErku+z0tl7TqieHjhidTsBHJ76sQa9wwGZzsvBHjI7q6U2k2avERUOI6ifhkuaFRhgVR7KHnsOAcv5gIL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288814; c=relaxed/simple;
	bh=hkK4S1wTDkim03MNLf0U1fKc8DjPLO0A2wyFdU+pA/o=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWdjwe0UWHIJEaF9Yryq9XFNwZfzrv+l5XWnfRzXhCiTQil6VPrfAp8PWpIiWdnJ9x8WGemGHLR2uBCMDCDthppA12QemF1KAuBXMDlPIydTSWlJXNzj3GXcQAju8fckp75ig06MPZc/C47FHAjwcmnwQuaMJ4I9jlY3yem2J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iYrn48c4; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732288813; x=1763824813;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5eDWqC8BUhYmf+XO67PxFqEI/s9NFauR1AI8q9xOkpc=;
  b=iYrn48c4unNO0yYkFls1Rp2k814f+RSwmPLW6oHV2a1N/n6w2RqEuBpf
   hDlsAh6xuuvVVU5VwN9O4VJcic3GQ+Atnbl0mWZ3Gz9o9tjvtW4YthMdG
   d5ZDLjkHzpTdOMxjh6xpfTE0uCWKSan7UGCv2mnpK9mbLtFpCw5s3/7Nr
   k=;
X-IronPort-AV: E=Sophos;i="6.12,176,1728950400"; 
   d="scan'208";a="249288255"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:20:09 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.29.78:59908]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.12.16:2525] with esmtp (Farcaster)
 id e2a895a3-772f-4d81-8b2b-6c8bf49e4cad; Fri, 22 Nov 2024 15:20:09 +0000 (UTC)
X-Farcaster-Flow-ID: e2a895a3-772f-4d81-8b2b-6c8bf49e4cad
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 22 Nov 2024 15:20:08 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 22 Nov 2024 15:20:03 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.124.125.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 22 Nov 2024 15:20:03 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com [10.15.1.225])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id B661B40385;
	Fri, 22 Nov 2024 15:20:03 +0000 (UTC)
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 734B9204C; Fri, 22 Nov 2024 16:20:03 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH] cifs: Fix buffer overflow when parsing NFS reparse points
In-Reply-To: <20241122095529-423c0f305d9962cd@stable.kernel.org> (Sasha
	Levin's message of "Fri, 22 Nov 2024 09:56:00 -0500")
References: <20241122095529-423c0f305d9962cd@stable.kernel.org>
Date: Fri, 22 Nov 2024 16:20:03 +0100
Message-ID: <lrkyqserjxplo.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.12.y       |  Failed     |  N/A       |
> | stable/linux-6.11.y       |  Failed     |  N/A       |
> | stable/linux-6.6.y        |  Failed     |  N/A       |
> | stable/linux-6.1.y        |  Success    |  Success   |
> | stable/linux-5.15.y       |  Failed     |  N/A       |
> | stable/linux-5.10.y       |  Failed     |  N/A       |
> | stable/linux-5.4.y        |  Failed     |  N/A       |
> | stable/linux-4.19.y       |  Failed     |  N/A       |

Ah Yes, for 5.15 and less, it should be patched to fs/cifs/smb2ops.c
instead of fs/smb/client/smb2ops.c, I'll send a separate patch for them.

-MNAdam

