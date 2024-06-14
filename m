Return-Path: <stable+bounces-52153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AB908561
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BAB1C21A2B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5F14C5AA;
	Fri, 14 Jun 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HjrG/3Fy"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DE13B5B2
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351694; cv=none; b=ZgtOd8mStU4lUWF+fA9nw8x9f3orBrl83cJjavVGOKaZ8E2IB3Kn53Lsz2DPiRpN6ut0m1MCf1FaXZqw/sVPko9nXi2WXmuiESBxHgoCxvoF2z3roZ9AgkuMnli9u+UjeTHXIy7znVarWmPoCsEbkXodqDMYcQI9o+V5QYxDjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351694; c=relaxed/simple;
	bh=9+zcL08VUjLdLZ5zpSD6OLxOtZ56MCdmy+ylInPWAJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tTiPeJrerhStnBUl1tnanJUIm/ZAxySthKGTYIWCNB6EPShpAwHhPkweuyR/43/xbMrMJGLTQJPyYM3AHOSHE8WYE2DPDdXSGCTO3D3+uixRC3GflU/7YfFsNRIN9zhUY6KypbH176G+TvocvlLs+S3TPWLpKZe8nfRPgd3cJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=HjrG/3Fy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718351690;
	bh=/EbTuSwaLt88VY4aLtR+tIbwCPpZ9zrwjvem1QZrNA0=;
	h=From:To:Cc:Subject:Date:From;
	b=HjrG/3FyCx7gfMb5+XF0jFIjPIgJGuZ4oA0/WL2PwoNBd70bgMUKNXMoFTVANnPyh
	 sRubgNHfK0dzwu67EA+dCGO2Zxkr1PGmPwRfP97sxi7VV8BtM9fp0RaclFk331N6MZ
	 0QeAAR8JYvvXjKSQbMB2i4Hdla53GhomjuadfLAkeq4G4TbSwjkMuLhgTS4DOPac6H
	 sSMNdpwcuPhL/WQPfaunQQSeqBGDcaic9PoItptQIktwpTCpcMyVhaqoxQRVIxpPOh
	 Gc7E9vGtBYK60rbkAKuItrXYsxr5UwbeVvcRByKJmh7Za+AcmkrT6CxAOVBdA85azt
	 NjUo+zk8m1vDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0s4p3bP5z4wcq;
	Fri, 14 Jun 2024 17:54:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Please backport 2d43cc701b96 to v6.9 and v6.6
Date: Fri, 14 Jun 2024 17:54:50 +1000
Message-ID: <87wmmsnelx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi stable team,

Can you please backport:
  2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with GCC 13/14")

To v6.9 and v6.6.

It was marked for backporting, but hasn't been picked up AFAICS. I'm not
sure if it clashed with the asm_goto_output changes or something. But it
backports cleanly to the current stable branches.

It needs a custom backport for earlier kernels, I'll send those.

cheers

