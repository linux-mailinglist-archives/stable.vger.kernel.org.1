Return-Path: <stable+bounces-171667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F3B2B43E
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCDD4E5DE8
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5845BAF0;
	Mon, 18 Aug 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KoqOwhwH"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CED220F34;
	Mon, 18 Aug 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557662; cv=none; b=XpPXoVJI9c9yNWFVQ6PUtELUGCEupb6YnruyHomAD0+M4apkoHW0AiR6okAabEdc2xa/PuFqHI7K3RD2D1cPSJfLN3lh092lyMLs+KeeCygnWkGqdNjGOeUgYB1RNMbz6+Y4e1RUrnInRUL2eVcj+oqyEzHAMT/i2e3O7KEbZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557662; c=relaxed/simple;
	bh=BU7N2xefuNipAwY40FF37e0WQnsyxyGMTWEyr6kFZpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tsf5SEYO4WNQT+zsiToJVgpLa5SEKKRxXSXUR/AETslDN/Ke4oF35Mjp8s3JfMHhn7IZRGFhW/jzh1i+tTuNNsPjUT1bq9Cu8dnKCZsfDi5i9Yiu6okHPJmw6SGW/v3ZByYEA7TcOGcm14pGD4IFnGdgHAJR/3R0v9DAGu5btpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KoqOwhwH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id BE9C92015E53; Mon, 18 Aug 2025 15:54:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE9C92015E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755557660;
	bh=BU7N2xefuNipAwY40FF37e0WQnsyxyGMTWEyr6kFZpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoqOwhwHVeWqiwVQ07o0KOGU8TS918Q2XIKlFCR2tal8HPDWuWHKWCIcNzcWQR7ec
	 oNHEY+o4VMsLG7gcYcycuLj06Mm8a8S1ah+jDZuFq9Ooy5q5PwxFQzKhqanjGWjPWy
	 d/QdtMsjHDruADQG5Xgxl7ke8W8QUj153WMVki6c=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
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
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
Date: Mon, 18 Aug 2025 15:54:20 -0700
Message-Id: <1755557660-15518-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.43-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

