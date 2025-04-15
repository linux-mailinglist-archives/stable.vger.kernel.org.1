Return-Path: <stable+bounces-132780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A680A8AA2B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A881902905
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63D24C09A;
	Tue, 15 Apr 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IL53Nvjc"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48414F9D9
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752839; cv=none; b=J0W1njGANN2/+9v5AtV2e2yU27gWq7VI0bjnLevpsWGLPAJQlN3JcNqKSrDUhSaASlEgfaBV6I9OXKhLQRKHUVtGm0d8CMCLhdwziZxSPnD79JVuzsN7jGzGSisBOatjIjn3S3Drx0GdKl6HlU1unofb/InxIMZC3t0juuu4Jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752839; c=relaxed/simple;
	bh=hAn9QzxCUsrzCgxFc+vF/dJC7pCyFnQ/R70xtoNQwiw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OWZBF7bXq0Brah2cYbEMf1Wj1w4zZdfVOF+qcVdVLaGC/gluvphmzslYyaJx6JRnRiviQwL4idc7dROKESKgO4e0Veq3lT0XPaOukEQFXhPG47OWPmCiZkxlLX5ktIZiqq+y2mrOfmHj4MA/iWdeE0xNxEEoueC2bl2c6GN0A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IL53Nvjc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 523D8210C44D; Tue, 15 Apr 2025 14:33:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 523D8210C44D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744752837;
	bh=hAn9QzxCUsrzCgxFc+vF/dJC7pCyFnQ/R70xtoNQwiw=;
	h=Date:From:To:Cc:Subject:From;
	b=IL53NvjcMOSO4rACyu2o0ZzttK6upNkCBbPoUAf5GQpOnjuRfJKsDMmO78BlBhT3/
	 bgr2fQbCddPTUhSfIAUToGE6szgThY0eNuMVYrQKR6FyyAqJvrxXkZMaSAu3eluE7V
	 KvyvOzRneomMJyHU5dFc09v718olYZB2yOxkPFoA=
Date: Tue, 15 Apr 2025 14:33:57 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [REQUEST] efi backport for 6.6+
Message-ID: <20250415213357.GA26569@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

Please include commit ec4696925da6 ("efi/libstub: Bump up
EFI_MMAP_NR_SLACK_SLOTS to 32") in kernel 6.6+, it allows
us to be able to boot some arm64 efi machines without
any workarounds.

Thanks,
Hamza

