Return-Path: <stable+bounces-120427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A8A4FF2A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA9F3AE440
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83848248860;
	Wed,  5 Mar 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ER4sUJ6r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F072459C5
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179452; cv=none; b=gvNH1dl94vQ3iPYSN6q6EyoUxIzqALky53L6zJEc6pz68+d04RdKe8X3gSI1O314sy28HM8+iLTIPLs6jX7+egBeCnLaXyfWRzFCING2tC2t2/umetuO7fkMhay3Vtfm2Xq6lfN183aAvww4FWW+UFpQE7h0DgqXCHacmYvrBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179452; c=relaxed/simple;
	bh=TJXeMuLusxgK2NbxvXfw6ZeR7EerNexkOqs2/RO4WvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZYRnBzhdUI0HgqnBfHjgFcgMSNeMvMk9dj0xcpes0JPOaHs/A/RMxiUNUrcsO5RponYVBt7Rt20slY0w5GqBDbVaE1U/23LkiThO3QlEIhl/IhXwKhxka5Y2rgc+DzWOeAeHFeBhiUm+cPpfDUuLahppms9xLS0O5AiI9UxyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ER4sUJ6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E20C4CEE2;
	Wed,  5 Mar 2025 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741179451;
	bh=TJXeMuLusxgK2NbxvXfw6ZeR7EerNexkOqs2/RO4WvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ER4sUJ6rk596EY4mfGMkMOF3oTglWQGYYnQyCouOeM/e0BbRkDwcxeKI+Ax3+UAd9
	 xxa9LOrPoLJhtVPpZXSYiPrnl2e3/ciVt1kq4HS5g7TpcBrcLFbTnAdTuCyiFWW/fd
	 OwLCMbiP6nXg4eYUr6ut/Ohh9b2rcZhNT3ttRfwE=
Date: Wed, 5 Mar 2025 13:57:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Imre Deak <imre.deak@intel.com>
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 6.6.y] drm/i915/ddi: Fix HDMI port width programming in
 DDI_BUF_CTL
Message-ID: <2025030520-jinx-synopsis-4d7c@gregkh>
References: <2025022418-frostlike-congrats-bf0d@gregkh>
 <20250224153112.1959486-2-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224153112.1959486-2-imre.deak@intel.com>

On Mon, Feb 24, 2025 at 05:31:12PM +0200, Imre Deak wrote:
> commit b2ecdabe46d23db275f94cd7c46ca414a144818b upstream.

Again, this is not an upstream commit id.

