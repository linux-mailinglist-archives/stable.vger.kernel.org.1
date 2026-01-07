Return-Path: <stable+bounces-206076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9285CFBA67
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 03:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E2930181AB
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914411FBEA8;
	Wed,  7 Jan 2026 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZnbzbqs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EB1A704B;
	Wed,  7 Jan 2026 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751393; cv=none; b=GvuaMBPW08R6NWutSMPZwOoJa7/MEe+edj9y2/TCqtlaE2PoxU0V9MFXKubLxIzV7KyX7LL+5i3KKrP0YQ047XZU9XET6ZcdwcfcZQtDyQNtaiH0cqK8SiaPNzKsqW0FocX2b+Jn7PnJHDlfManjDLTnfMm4/5oblFm5AlT8JB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751393; c=relaxed/simple;
	bh=PZ5X1ceCFh4+Dfgg1CrHE9Fac7nZep9LZ35B2lMweOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOdusHBFBVhvUlHRHwQva4dzn7oJD1+NeWyqEdHoe4dBatD5wgEiPk0D7LUiE5GwqsXpADO2RN5wu3XMmb+YM5vaI1TuxacrntgG8UlqHWJ582Jex8pKVEEArDXRMFqTE3QSjCsiVBiMjYkeUdDDC/qX5xWE2WOm/wTf/TYUesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZnbzbqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FB8C116C6;
	Wed,  7 Jan 2026 02:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767751390;
	bh=PZ5X1ceCFh4+Dfgg1CrHE9Fac7nZep9LZ35B2lMweOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZnbzbqs6Repmz1+juJR/xZCHHnDt5Jhlxg1ifw4EkDZOj7gojmf/PugqFSWWOpDO
	 sgFjXnywVofGXrqtN08IWCn1mSlB46OwQne5UiYHYh5YRwA3mKZ5ZyYVpDqTr7KQCg
	 u6FvLZbYK4bmuEOw96uAUndhrnavHci5Ny/jO+j8WVnvQKBK5//D5R/9Qpe/8S/Th0
	 lf6uWVH79+IU39lK+5Fe7gKpvslaD7CZAv1WdYtMsUllb+XBHxeuI4Dd863PsuAMAv
	 +Kpp0M2P4wZDbJjkiSiEssQNUIsSkoBslydRlJL01qq1mbpGbdbzYmNL8azl8OfNFs
	 aqevKEtSZ0ZtA==
Date: Tue, 6 Jan 2026 18:03:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Chas Williams <3chas3@gmail.com>, chas williams
 - CONTRACTOR <chas@cmf.nrl.navy.mil>, "David S. Miller"
 <davem@davemloft.net>, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: Fix dma_free_coherent() size
Message-ID: <20260106180309.07e0262f@kernel.org>
In-Reply-To: <20260105211913.24049-2-fourier.thomas@gmail.com>
References: <20260105211913.24049-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 22:19:11 +0100 Thomas Fourier wrote:
> The size of the buffer is not the same when alloc'd with
> dma_alloc_coherent() in he_init_tpdrq() and freed.
> 
> Fixes: ede58ef28e10 ("atm: remove deprecated use of pci api")

Fixes tag looks wrong, the size was incorrect before, too.

