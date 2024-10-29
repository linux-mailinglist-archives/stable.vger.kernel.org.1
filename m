Return-Path: <stable+bounces-89153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6059B4021
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3041C210A6
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78592126C01;
	Tue, 29 Oct 2024 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hdsga5QD"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311582876;
	Tue, 29 Oct 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167681; cv=none; b=hSysXwKXR7JNxDFc0NSlXS8Wfbv26hQ3RQIxl8Y0+rMwg4zDBI98LWd/llO5qd65grEC9Hdj/2Gxor7GSTqronJmkpZ/RNg7//SDCjTWY85wmPuFZp2hqa8+us2nozcaysQgz39OeLzWE48i63hb/oaaxWAkcT1VGl3b1dP0LF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167681; c=relaxed/simple;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eVgxbEtUhvryL4u7UePYh7JCh35ax7JN0MUurA7dvzTHvdS7cJx2j6zWm75ErfOm4RmnJIlYds9T4QMdAkHvUJ3yoef1q48rymk+DXfdC6Fv3x0IBmkk6KjiiQNYzU3OGt7wvsGoxihulZYiM7S5PFFlTNMHt4LUU1VS9CjaYoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hdsga5QD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 213CA211F60E; Mon, 28 Oct 2024 19:07:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 213CA211F60E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730167678;
	bh=H5yKHa85K/kN38MCbIEu0HaXLqb/id9+omWJt6O4sx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hdsga5QD/uRuO3D5CRdPstgEaMsK0bwpGuB24HynRkNsta5znSpYxXTueWz8ZAqbu
	 tV4RgwYraTEAWLNCjdYHQsOUT2Rsm36AkbLyIFzTVWyhFMJ0AheGOU+c196/Qg6/3w
	 mpq1kOJI29K0AmIKjXHXTTlTckMThlCMCR8C02Bw=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 5.15] 5.15.170-rc1 review
Date: Mon, 28 Oct 2024 19:07:58 -0700
Message-Id: <1730167678-10669-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

