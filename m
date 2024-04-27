Return-Path: <stable+bounces-41555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0768B469A
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3341F22FB9
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502B4F8A0;
	Sat, 27 Apr 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX72Qtxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425784F889;
	Sat, 27 Apr 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714227402; cv=none; b=drDm1xxAw9oUCQeRkFC7R68Xz6rJTOJL4igG9ctLZd4Y9jqFXfholVpZSWaqdK8Vy/I29uJ4777h7N3fIxTypDFw51nuPh/FcAkFR8is+30Nu9d7ebK2wFommNIplYWaPdw9YghRGWiR1M2aBg0VUEw/fs187Z5cYyL2tuoKCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714227402; c=relaxed/simple;
	bh=s9YKAQy10BvdqFgbzq0HlhBSESg8PHKRRzpR+7pCxEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPja4QnitUtCb5ypCbxgri+b5in/t2qDFhHTpSzFAc/FihE4MSnzTpfBh1oX7vZhGVKyeMKDlsN4x8ePgkPZlQ8rgM5Y2/bwD1q8PhnjIEYm/VQ5fSLrDLftRjZzDfMZqioN/uwbYm+OlDzf+5sauJeu2DX1YsZ/Bq2O1diDNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX72Qtxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33720C113CE;
	Sat, 27 Apr 2024 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714227402;
	bh=s9YKAQy10BvdqFgbzq0HlhBSESg8PHKRRzpR+7pCxEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EX72Qtxzh5E5rEb5amGJJko79zSx2pMrS+SHEmGGU5PA3r9VURDkffPfaq9o86YXj
	 kXMcAACE6nowHup54Oc4RmVaOLdnya4tBgNfMKqL5QlhE65PMshLdmMsqNBZfiKtcl
	 mrF8y9tmLdq51AG42v4m36dPjuePKdZ2ILSkKOEpdYxX/HwdIV6eENG62ZPL1kfebv
	 hKbLQ43IyuYW7ktL1/kdC6dWlS/JS8cITpNyavynLbAarWM4EL+8t/ODMDy4CAaeuI
	 HS2Qn1QsADxRnGCDCmEkAw5s64Ex61c9o9N5EE5XKDdR2sk7mTMCQwypORvfpt6stF
	 q/jGYIkECir5Q==
Date: Sat, 27 Apr 2024 15:16:38 +0100
From: Simon Horman <horms@kernel.org>
To: Doug Berger <opendmb@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] net: bcmgenet: synchronize UMAC_CMD access
Message-ID: <20240427141638.GM516117@kernel.org>
References: <20240425221007.2140041-1-opendmb@gmail.com>
 <20240425221007.2140041-4-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425221007.2140041-4-opendmb@gmail.com>

On Thu, Apr 25, 2024 at 03:10:07PM -0700, Doug Berger wrote:
> The UMAC_CMD register is written from different execution
> contexts and has insufficient synchronization protections to
> prevent possible corruption. Of particular concern are the
> acceses from the phy_device delayed work context used by the
> adjust_link call and the BH context that may be used by the
> ndo_set_rx_mode call.
> 
> A spinlock is added to the driver to protect contended register
> accesses (i.e. reg_lock) and it is used to synchronize accesses
> to UMAC_CMD.
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


