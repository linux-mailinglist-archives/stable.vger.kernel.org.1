Return-Path: <stable+bounces-135105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8478A968AA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4385189C57C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7127CB10;
	Tue, 22 Apr 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mApABv+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F127C174
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324038; cv=none; b=BRq1S3m8Wu9e5J5vI5a8VIi3JKzv11VIkEE24EjhjnmywYd+h+Qglh4XeXjLi1Mc5baYuUNMGrIx8IVPRn1XwztV9JZC5pTBoBpcdBXJp7tcW1pcqwQpqgzeYHs+GcS+otGSAH4X3koqG9oZ6gQ96AfcI49y2LQ79MMGPQUyNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324038; c=relaxed/simple;
	bh=SCV89DY2Ip8hqt0F0oJVxUrIOh5KMe6SOABPbTRjECI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF56MLqHHXkGQvrFsVdmTDBBtkasJbzfNkPJJ7wa5+IG/FDc7ps9tLu4ITiGglPeFfTFx9OAzvjg7WwtgLJs4AbpaeOPFXgaBrE51DS44sWY5L8X65AFcg+J4BHpGIBBGOWw7AkeJ3cQFMJfveyPSJgRa/Xqp3y008Yh735ep5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mApABv+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADBBC4CEE9;
	Tue, 22 Apr 2025 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745324038;
	bh=SCV89DY2Ip8hqt0F0oJVxUrIOh5KMe6SOABPbTRjECI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mApABv+kr+uEtyAnyIV4hjxadnNfw7mIwSw6p+rBdXxPjLDGMG65mcRgVNvlUU+xc
	 vKfKiyk2ysuh3hM3kWxe9zjFM1zNwyLGoG4cjxRYwxwsVY3eKgADRgQm1OXFvy8EcZ
	 3yI0yqa4tSn4eR/tXlC4iBwsmAelEoNMZf2LnZXo=
Date: Tue, 22 Apr 2025 14:13:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume
 to PM ops
Message-ID: <2025042242-wildfowl-late-9470@gregkh>
References: <2025032414-unsheathe-greedily-1d17@gregkh>
 <20250324204639.17505-1-kamal.dasu@broadcom.com>
 <20250324204639.17505-4-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324204639.17505-4-kamal.dasu@broadcom.com>

On Mon, Mar 24, 2025 at 04:46:39PM -0400, Kamal Dasu wrote:
> commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream

Not a valid commit id :(


