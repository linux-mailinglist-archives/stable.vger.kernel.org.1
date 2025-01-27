Return-Path: <stable+bounces-110869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0DA1D70B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D571882D88
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC61FFC44;
	Mon, 27 Jan 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ht2DBVDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55361FDA84;
	Mon, 27 Jan 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985375; cv=none; b=i2yxAbMtpsy9CWsqCNGDBIeC2mO3lz3PfxHVDwCFLSKbfb28oQ5i2rI2SbkydZlyOtzIyxRZIT4Hgi+3yZFmJvjjg7laLu5yvSTK41t4XEx+m6J3a6+m4IB/tv0bLAzIzxrvgOnvNH3NOMDVUR/CQESAb/5ldMJuMmbntZo/MxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985375; c=relaxed/simple;
	bh=r8nOZnwWJznAEvZqaDk6dtmwOuac49XSASCIzrvdYcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQj8uC4RKBTPYn8ql3uRNm8k9e+O2jwqn7hVuS3woNtKr2lM4Jf86l+gX2Pxfx+qneVHK9VlYJLfk/2wPX/HIMilp6RP3pRdyciKDys+jin8MPJls3dWWotupqqBrFfpemQCRQkWYcZvNnHU8QTy3y1Py+sQ6Fu0Cs9xxuLIZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ht2DBVDB; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737985373; x=1769521373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pyuw/0tPRJaK1+pxJr3dwbn54vn26qcJgaoO+O9fMg=;
  b=ht2DBVDBfGtLZKQAcrwBthoVVmntpVzyuw25OaEfr3uObtQ6HyofDIOU
   4PeDGOCBcQkYAUsxHkAxcMCJpyS5ON13AbXFWspMB4J80nR085MSzIgds
   0PaxAzg8KbLLmstvMYKPItAg8kohywqS6TOCHiT4IvwLlZvJDCGrjtzm0
   o=;
X-IronPort-AV: E=Sophos;i="6.13,238,1732579200"; 
   d="scan'208";a="164549720"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 13:42:51 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:17706]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.70:2525] with esmtp (Farcaster)
 id 9874343d-576a-4d68-a30a-93b568787c06; Mon, 27 Jan 2025 13:42:50 +0000 (UTC)
X-Farcaster-Flow-ID: 9874343d-576a-4d68-a30a-93b568787c06
Received: from EX19D004ANA004.ant.amazon.com (10.37.240.146) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 13:42:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D004ANA004.ant.amazon.com (10.37.240.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 13:42:49 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 27 Jan 2025 13:42:48 +0000
Received: from dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com (dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com [10.13.244.41])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id B020C40637;
	Mon, 27 Jan 2025 13:42:48 +0000 (UTC)
Received: by dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com (Postfix, from userid 5005603)
	id 466C45ADF; Mon, 27 Jan 2025 13:42:48 +0000 (UTC)
From: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
To: <kovalev@altlinux.org>
CC: <edumazet@google.com>, <i.maximets@ovn.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lvc-project@linuxtesting.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 5.10] net: defer final 'struct net' free in netns dismantle
Date: Mon, 27 Jan 2025 13:42:48 +0000
Message-ID: <20250127134248.25731-1-abuehaze@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121192730.155559-1-kovalev@altlinux.org>
References: <20250121192730.155559-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

I think a better approach will be to backport 41467d2ff4df 
("net: net_namespace: Optimize the code") as a prerequisite for
0f6ede9fbc74 ("net: defer final 'struct net' free in netns 
dismantle") otherwise we may endup with refcount underflow whenever
"net_free" & "net_drop_ns" called sequentially as with the current 
version of the backport both of them apparently call 
refcount_dec_and_test(&ns->passive). In 41467d2ff4df
("net: net_namespace: Optimize the code") there are two
hunks that aren't directly related to this backport however 
these are removing duplicate code into a separate function 
which will likely help with future backports. I have backported
both commits cleanly on 5.10.y and didn't see any issues and I 
am currently testing the same on 5.4 as it's also missing both 
commits.

