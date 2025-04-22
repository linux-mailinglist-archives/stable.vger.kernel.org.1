Return-Path: <stable+bounces-135043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D816A95F22
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EAD18984D2
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5950238C0E;
	Tue, 22 Apr 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw5ldGrX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334310A3E
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306453; cv=none; b=Fj8/6FeMFIJ9GgVjdDaOv8KQCf3vyC+WWRlQsqR7/8EfYtBS6eLEh43a/SAnI3gDCvpBInkmlH/sAMgO4L1FoNtyg/E3rVabdAo9Aw0oHqQN7lvMVoMLPAsoQHPuZBWUDYT6Ig4hcRE/fr9CdyNbp5h100ScAua66Y2VdVxxcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306453; c=relaxed/simple;
	bh=lVDeZvbyosVTp+1wr+tH/scBqOy8eSwK76t0F/nkjh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmwuIbVCPxqPQLTiHqXNyx8Krvx9nyx1mqIlbjPKCgy+AanJ3Urev/WUxL5es3S21kxUjh2HYXyL3b3SPicd90LvfBDzydZ3QCgOluvKYi/i8Q2enuxZd98eO/DyuVOo4o0snsJKE4oUcDV6SOb0tbF1HdJKnGMaBQ72ew4J0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iw5ldGrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD71C4CEEA;
	Tue, 22 Apr 2025 07:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745306453;
	bh=lVDeZvbyosVTp+1wr+tH/scBqOy8eSwK76t0F/nkjh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iw5ldGrXvRrnxo34nZSCBEtZqSqDvZyAhFqyv4cO2kAGPhuKAaq27LNrdPTCDozpE
	 prbVljXEFv/jbmN20lMXHVIul9xPdvJ5UTeAT6kIymukP6nlxufVrkAUEHBz1trJp0
	 wyvz+VDic1J7pqhfiGycvBQIO5855fNYwCHgubKI=
Date: Tue, 22 Apr 2025 09:20:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, kees@kernel.org
Subject: Re: [PATCH 6.12] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Message-ID: <2025042243-cadillac-turbulent-1e8b@gregkh>
References: <2025042120-backward-waged-41cf@gregkh>
 <20250421153918.3248505-2-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421153918.3248505-2-nathan@kernel.org>

On Mon, Apr 21, 2025 at 08:39:19AM -0700, Nathan Chancellor wrote:
> commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.

Wrong git id :(

