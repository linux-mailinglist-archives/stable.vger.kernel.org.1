Return-Path: <stable+bounces-154697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F3ADF569
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CEA1885B0E
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DFF2F49E5;
	Wed, 18 Jun 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iDcLV6/O"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90A2BF013;
	Wed, 18 Jun 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269738; cv=none; b=PeX/jbavFj9Xcp7cNKFVuw3+HBCFRd8Dc/Vus0cDHTd9k7orDARyE0m5wommf0liXwDBTrMfucirq8H7Kx5miej3sVZ5cW99D0b22C75d9+DvXMiVIHmBcgwp+7mkMhsQqEjCNIDTw+T49JiNtZNG+Upv/ya467IEpV5UMynrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269738; c=relaxed/simple;
	bh=J8qm0KIxvDABeFAbOTa/JmNQ+sdVdGPfkXdpFFrTCSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z1pcF7eLbrump+dZ63YmXhQyB9JdLDk19mrkoaiWPc+izS8mW6qVYP+/tYWi8kBNuakwluX5yVG3RdnI9M3G21JmA8lKP++z5vS9MZuUk6bWjR2E20x0MspnfgPPmfI2/bzeEmwI1unBXqoh0G939bBGB0aG0V2XmqBHJkpz6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iDcLV6/O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 0610121176FA; Wed, 18 Jun 2025 11:02:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0610121176FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750269737;
	bh=rDfd80+cYWJKoaG2bdjZmVVVUOstotsIHopxHl0Sj7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDcLV6/OXfTwiOotVSGp4N8AG/KR/W1MlD4d0ojyOJtcT5YW2ZlDBt4CZvAfQ1te5
	 SvnkJQH7xrQM8ZWY21norqL+edXNp8+EoDhBjleG6WnmgPksektoCWB2RSepWAg6bW
	 ESG4U/kLrM2Iip8FXtH0/HL2lftQZshU9gAtpkS4=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
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
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
Date: Wed, 18 Jun 2025 11:02:16 -0700
Message-Id: <1750269736-29190-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.12.34-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29860466  17729102  6385664  53975232  33798c0  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36428814  15006645  1052880  52488339  320e893  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

