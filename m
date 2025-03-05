Return-Path: <stable+bounces-120428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38EA4FF33
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B23174542
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78D0245011;
	Wed,  5 Mar 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWuHpQbD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B324502D
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179467; cv=none; b=QQyazj6yQ/I/aJaHbF+GHF+TxTzG8zfy1nvt2YE9IGr2orN7zZ1MmJrNDSZMG11C7RGpqtlTOKOVCwZvF6QAnINnyIvhaYeOI6HA5GSP7ClREnvoRWYI3Zvdt1+2m3euGgTCkpDjfqR4PZ07bV39Mhevg4i+Lc5uzkoaVPBNAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179467; c=relaxed/simple;
	bh=I90F2KM+kl0lj6yAzbhXZIw1PctmmxvvnjkuHYqjHYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llTnYVA7mUqAa8FK95bl3UbZnyuEC9wBe8B5X6Xiwkqh4Pjlefv3Ej/BfyVKSCeUsw/uPITfx+CV82ebxGlGJBLSjKFoMGDMde7lFzUsTPkm9ZUHzceBROg8KJMobXTJmQ99X2Pm3/IxYSVicxEXETc5f3C+NENdJEOgwaZLbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cWuHpQbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9314BC4CEE2;
	Wed,  5 Mar 2025 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741179467;
	bh=I90F2KM+kl0lj6yAzbhXZIw1PctmmxvvnjkuHYqjHYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWuHpQbDTBlnk2w+i+vAItlrwc5ZObIaMxFsG5B6/4M+YM/IjWhgXkABA5R3fZzlC
	 U04n3ZA0JDAs1zSI+Irk9gx9Nnmxq9ahYNybeFOzC2ErS8y48eLbmZjyge9zKPq6/x
	 Ho4iJ4F+CuE2u0+pHBSK1jkEKQ3J/luDNLuGeIDE=
Date: Wed, 5 Mar 2025 13:57:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Imre Deak <imre.deak@intel.com>
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 6.6.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port
 width macro
Message-ID: <2025030538-diabetic-shifter-0c1b@gregkh>
References: <2025022418-frostlike-congrats-bf0d@gregkh>
 <20250224153112.1959486-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224153112.1959486-1-imre.deak@intel.com>

On Mon, Feb 24, 2025 at 05:31:11PM +0200, Imre Deak wrote:
> commit 76120b3a304aec28fef4910204b81a12db8974da upstream.

Not an upstream commit id.


