Return-Path: <stable+bounces-100546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC149EC6AB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF5F1673D2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5BF1D2B0E;
	Wed, 11 Dec 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cKoJfITD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD361C5CD6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904740; cv=none; b=Oo+CvqU3+knh7jFsGsvSMLMlWM46lCSUGs427/hPEskqN/qQqYMXcf+7p3+zB+0n9nASLqvLW6G130TucapOzEsaeiqxHEmF5jiLShyY5ccXOBdUjKNWT+nbiPv05/uSBGDF7AUjSP03+D4DqFWYU51ZwUWfRgqG/lYccdJ5y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904740; c=relaxed/simple;
	bh=vAHpO2cIM9vBEcMrehMw5xPNzvu9ZKohUseoWGjOefQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEyHIMyonSWGMKQGS/3CPWLsuZgsIU2Ex2D/VpPfon6PF7LcslzmNxodO4BWgrzz2FpJcXv3XlBTA6pdIQF4zjJcgUvrBNI/OxGAM68PgPbICmh3F5X3VAIDe5LyCV4a3cvX3DqL3N9bxsEjWlTTzJylBP9UpwIIVhXfxfZU4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cKoJfITD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E7C4CED2;
	Wed, 11 Dec 2024 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904740;
	bh=vAHpO2cIM9vBEcMrehMw5xPNzvu9ZKohUseoWGjOefQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKoJfITDdxzJagROQewxUp7NsM0qjLp+cW+3fLM5XWC+f4DfG573BqCJkbhxxOyuE
	 h2CTSCRITTz/CbxiRD+nYMKEXwYfrgafJJS2Uefk6JqQd6IDxC0BHQWW4nI5cwRVth
	 OcYFzJqf8q3s0GVtEgdbvq8zZ57c5mPTN35KQiEM=
Date: Wed, 11 Dec 2024 09:11:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] net: stmmac: move the EST lock to struct stmmac_priv
Message-ID: <2024121130-unengaged-squall-cf25@gregkh>
References: <20241210020043.2545261-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210020043.2545261-1-bin.lan.cn@eng.windriver.com>

On Tue, Dec 10, 2024 at 10:00:43AM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: Xiaolei Wang <xiaolei.wang@windriver.com>
> 
> [ Upstream commit 36ac9e7f2e5786bd37c5cd91132e1f39c29b8197 ]

Please cc: all relevant people on backports.

