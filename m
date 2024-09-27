Return-Path: <stable+bounces-77874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D61987F95
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071471F22BD8
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176417BB33;
	Fri, 27 Sep 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jQbGqaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005A15699E
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422821; cv=none; b=nKC7wiYQ7eLCm8X0Wkm+Qv+ENqP7ZCNTS+MW0Q3kMUJoHzlMfxEv2XMJqGgjpwJNAuuK1NtUAfGkX9pDqp6L/6HnC+jwvACtulY7TjGUPfHoEnODWLP6xK5P3izdKSyUkacnaXaFAa1Nf0oWBAkim/9DihmtwiZYE+H28c3xgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422821; c=relaxed/simple;
	bh=y/Rd7Wgxgoz0fB20KMb10HW1iNeX1X+/06ej16hIyZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyuNiZKO7oa8LUI5uLmtdGcXj6LaBDj8pus1lc9J26+L3ZDWW/yluqDaK2p3dQpgglvL8Iu1ha2G0FkTkzOlEAkh6fVnVFBIqGZ6iQ2q0hnKxoGwQJ0Drr4Jid6+fJaewy3Qz7wDD0zzx/2SRQ40t6CVcktNGwK9aXCB41ogCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jQbGqaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7EAC4CEC4;
	Fri, 27 Sep 2024 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727422821;
	bh=y/Rd7Wgxgoz0fB20KMb10HW1iNeX1X+/06ej16hIyZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0jQbGqaHhRxBd+qGJ9Wvbmn8BgGCUbR3Yp786rx/ehk3wsFA7GfmYF3khr9QfevS2
	 0bVxVvCyzz2YugKWBqiEOecwUgrC7yoRKbm5dSc2c0toIdIx0IlzUzuycWiyBVeLu6
	 sAWxFUVTtFJ5ARuKV4Tc6Hl7quLdVotjRduqfcBU=
Date: Fri, 27 Sep 2024 09:40:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Power consumption fix for ACP 7 devices
Message-ID: <2024092702-recoup-bonding-fe0c@gregkh>
References: <ec0891d9-ac9a-48f5-ab96-4cdb428897c2@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0891d9-ac9a-48f5-ab96-4cdb428897c2@amd.com>

On Tue, Sep 24, 2024 at 08:18:00PM -0500, Mario Limonciello wrote:
> Hi,
> 
> Can you please bring this commit into linux-6.11.y?
> 
> commit c35fad6f7e0d ("ASoC: amd: acp: add ZSC control register programming
> sequence")
> 
> This helps with power consumption on the affected platforms.

Now queued up, thanks.

greg k-h

