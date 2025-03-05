Return-Path: <stable+bounces-120454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A264A506C0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805FC18868BD
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F0250C0A;
	Wed,  5 Mar 2025 17:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D1539A
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196926; cv=none; b=qo9Q9qrL/t+yFgBzN00g2I8T4UW8Wz1aCqsxlBma95R9aNV3UfxG2emFf4nB3H+IVg3ntqAdefBleas9BSZZ37L5wp0BwezkjG4mpMTO26UJljlJ7chVZXWxYFT8XXJw4Cwv7ZhE/cN5QQ3bRzTjI5Me4jbmU14HWB3nO2h65Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196926; c=relaxed/simple;
	bh=2tLdMJRHGCxRuxP8xqKM0lKQU131eAZZNl441U/+e2U=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ODSvXiXbrZThzDSinbC4FZAZOtAks/0AAsv7atcwuI8a0rWmMk1Lk5ovbQcNLcIK9cGR8HRVyFJA4qysF1h3QTQntrasl644VTy23eHBB6H0JVBYtKtto0vyagcHqsuF+W5G+mEMdUAobTuwJhOnxUotmIAERmrltofhnoecArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id F3E3DEC0064;
	Wed,  5 Mar 2025 18:39:40 +0100 (CET)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id D9C76EC0062;
	Wed,  5 Mar 2025 18:39:40 +0100 (CET)
Date: Wed, 5 Mar 2025 18:39:39 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: stable <stable@vger.kernel.org>
cc: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>, 
    Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Please apply f24f669d03f8 ("x86/mm: Don't disable PCID when INVLPG
 has been fixed by microcode")
Message-ID: <8ce15881-3a46-fc08-72e1-95047b844ec0@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 1.4.2/27568/Wed Mar  5 10:48:48 2025


Hi,

please apply f24f669d03f8 for 6.12.y.
It is already in 6.13.y.

Backports of that patch would be needed for 6.6.y down to 5.4.y as it 
doesn't apply.

But I don't know how to backport that fix but I can test anything.


     Thomas


