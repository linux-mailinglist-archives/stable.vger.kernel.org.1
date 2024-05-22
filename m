Return-Path: <stable+bounces-45576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9748CC3DE
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E61F246BB
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE8249FE;
	Wed, 22 May 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="elGEaXjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAC23768
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390658; cv=none; b=crPA58ylQufkOGVxByuuh9tRJjVoHksBpgOlwzS6czy56B8eiCLhAeOUgL/hxWBFRWIKmOGpweWqcxgdyDxloTruOb9ut91tsZA/nFMYBh1ehmrpuR+aqgACiskyNilERlnwXEpics44KGATNnM8ul6hbgVtycvP0V80bK6H6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390658; c=relaxed/simple;
	bh=V50RVpTMEA6R8wQXe7cM54DxYJM7ZKClyEM63HaOUqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq40GYzbVVsZ6sXhoALq7SM5Wq4wsBKx3PuFRICfbyQVDcgtdvqtJP8wUM8ZkYxd+YFT8EIUVDVDjgknAQBviqlAtHA7q4uGHTh1BTadZdpSElI28UiqB0rkFSDah7PePBbwY5TTS5y1Leu1ere+SEFHei49/DvPRftDro1A54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=elGEaXjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBBCC2BD11;
	Wed, 22 May 2024 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716390657;
	bh=V50RVpTMEA6R8wQXe7cM54DxYJM7ZKClyEM63HaOUqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elGEaXjD3gi4vILz7H/6YPoaMrvxoFns61aBKpwE2LqrqbYi5kHZNeOgsKIBttFh4
	 CIhz6azfLuqlMDidzCR6kgHl4KDek33h6JgxEwtG5sX5QEcoae8Inz5cJYNKqHLXdB
	 go7kNTIcdWs43qXGvbjm9uTvonbShpddpSCmkrdA=
Date: Wed, 22 May 2024 17:10:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: DSC divide by zero solution
Message-ID: <2024052249-washer-superman-3d7f@gregkh>
References: <e1937591-708b-4fe9-a43c-2027ddc1c657@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1937591-708b-4fe9-a43c-2027ddc1c657@amd.com>

On Sat, May 18, 2024 at 02:31:24PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> In some monitors with DSC a divide by zero has been reported and fixed in
> 6.10 by this commit.
> 
> 130afc8a8861 ("drm/amd/display: Fix division by zero in setup_dsc_config")
> 
> Can you please bring it back to 5.15.y+?

Now queued up, thanks.

greg k-h

