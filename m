Return-Path: <stable+bounces-118291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF9A3C28E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0C178BF6
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFE91F3BAE;
	Wed, 19 Feb 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="kIADZjnu"
X-Original-To: stable@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78E40849
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976505; cv=none; b=o+eIHZkqNjH4zlN8TxI6cBAV9ckP+ffbIxqF1/vjpY5rKg7yz3qD52FRnTL3MOi6r/IHBT+xjJk9KgaV5G4v86378Evq/GIlD2O9Vb7bn5uvqMNP4RsNz4z4G0RDIKts4zgTlF0sFFdJhmT5hQUbRfGyPam1hEDasqKHDvW4GNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976505; c=relaxed/simple;
	bh=fGWCvZQC7h2jumv6caxWlc9a0bwEnQr+IERAGOmLlf0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UHoYG708ASo5eTO4fMPJ2+wDTAFxTc9BhbjgEh7Ws7hRoOZeJVEAR2UJDUejyGxywWhyFPJLMFse6pojkjq+WWNChTGgQi6Vi/0kTChTeL5Herb5IySObUgEJ75jXvp9hNOYMSOlHEVsVh5YsDu3DoE63oaU4G0K+WuVPErRjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=kIADZjnu; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 23BAC835102
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 15:40:49 +0100 (CET)
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 7C4DC2003C6;
	Wed, 19 Feb 2025 15:40:36 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=kIADZjnu;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VdaCZZVd7R9PybQ/FPn635RF21USoL3m3ZBdGSIKuN4=; b=kIADZjnu7ZBv1QrezUPodknS4g
	L7uTtEB2HO4hKK2RCFUpgMO+A1NDi95DOnaDiFyTiV4YyblHXHvFvQEr6xvGyxFFJFpYP19XEEfnD
	GZnWFxvZFFyE2pfVAOlgbS+reuI1lydzIo/wt9/5cLFXhU4WU7BKHgxXu4tg+XgvBMsM=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tklFb-004kCn-2x;
	Wed, 19 Feb 2025 15:40:35 +0100
Date: Wed, 19 Feb 2025 15:40:35 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: gregkh@linuxfoundation.org, tglozar@redhat.com, stable@vger.kernel.org,
	bristot@kernel.org, lgoncalv@redhat.com
Subject: 6.6.78: timerlat_{hist,top} fail to build
Message-ID: <Z7XtY3GRlRcKCAzs@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

The following patches prevent Linux 6.6.78+ rtla to build:

- "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads" (stable
commit 41955b6c268154f81e34f9b61cf8156eec0730c0)
- "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads" (stable
commit 83b74901bdc9b58739193b8ee6989254391b6ba7)

Both were added to Linux 6.6.78 based on the Fixes tag in the upstream
commits.

These patches prevent 6.6.78 rta to build with a similar error (missing
kernel_workload in the params struct)
src/timerlat_top.c:687:52: error: ‘struct timerlat_top_params’ has no member named ‘kernel_workload’

These patches appear to depend on "rtla/timerlat: Make user-space
threads the default" commit fb9e90a67ee9a42779a8ea296a4cf7734258b27d
which is not present in 6.6.

I am not sure if it's better to revert them or pick up
fb9e90a67ee9a42779a8ea296a4cf7734258b27d in 6.6. Tomas, what do you
think?

HTH,

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>

