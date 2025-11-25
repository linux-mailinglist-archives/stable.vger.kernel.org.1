Return-Path: <stable+bounces-196840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09743C83268
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5D9D4E3ABC
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256871DFE09;
	Tue, 25 Nov 2025 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcFT5bPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1901BBBE5;
	Tue, 25 Nov 2025 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039385; cv=none; b=Zvw6SVQwMdjc13pHNV8iWAbLSrUxKc4xJ0ztXL2IjdZsvbz76Kle88nxKX+Nn4jMIkm4uybc98ePTlafM06+l+WC6EmuY6ZK9tPXvg+7A0Huem2hFaHEj8rHk2wBSlCvqlYj6e6GNEdQzPWxrPyF/oYTIPO/w9wIhCBZvStxHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039385; c=relaxed/simple;
	bh=GRYmmlgw4hUR9b2A4dJve/1qnOgW+42fvngFbQev4xE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjXXm2awwrJVQYeSqKkvKq12ttDL9jCZQoJV7OoTxWspyPGf4s8g7ip1S3GcxpmvOvLJ4yuk52LeQcPr5mTGl8uefNedd4OvfS9eOmpFGqra+mJDNwO1tg1UikTWqByEMKFX17OB1Er+YH9bTwPbe7wL9DelQKQ3y/uBuMgGSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcFT5bPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066FCC4CEF1;
	Tue, 25 Nov 2025 02:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764039385;
	bh=GRYmmlgw4hUR9b2A4dJve/1qnOgW+42fvngFbQev4xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CcFT5bPHfzrvpkmYZvmNOf1zPUjYBYrIyCvaQyErJE2X/X/UzYwmAqFOzvoRjjO8E
	 rPjotleoAN+tnKpDN2BIomaP2BHZeWWqurthJXC5EXXh8FoTLaO7h5CA7veMdik+DR
	 3+RNA28HGfbPLhfWJM8J+iSIIE+/3vAa0ajx4Ioew2eNVi0LlIMcO6w2GBlcNUD49J
	 P0FBilp4Ps/D/wRbjbipN28OxhMNHLkU5YNQhuhZm2MDanFXRxbWyvNelWDN/ZqXfz
	 OeiUIZR7zS0F7ZuI6IFy9JfQnHZnV+vM9XMIHUubkobldbM+omwFA+btjyL2k01Fe4
	 2KccVqSuEh3Cw==
Date: Mon, 24 Nov 2025 18:56:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: yongxin.liu@windriver.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com, andrew@lunn.ch,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
 memory leak
Message-ID: <20251124185624.682de84f@kernel.org>
In-Reply-To: <20251125022952.1748173-2-yongxin.liu@windriver.com>
References: <20251125022952.1748173-2-yongxin.liu@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 10:29:53 +0800 yongxin.liu@windriver.com wrote:
> Subject: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak

Presumably typo in the subject? Why would this go via netdev/net.. ?
-- 
pw-bot: nap

