Return-Path: <stable+bounces-73915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF39707ED
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 16:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB4F28242E
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C76329CF7;
	Sun,  8 Sep 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aGGHxh3I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE716FF3B;
	Sun,  8 Sep 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804219; cv=none; b=LToBoXz66GdVrpUWHwZzCHN8a+qVPlOu1ZMOcWBWTOx9ukqIz6K4JpGJrU5MX8/nIb333onB4qwznpvUPQbRLxEC5FDmGnwaGMln97C3E1iO/7IIOsuzAmHfQrP5iPo7tzsQa2UolsDeshKFmeirFDlrt6FgsL0UF24apDNpsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804219; c=relaxed/simple;
	bh=PWGEba5F2l3NtkxLC5EHZ/MpSElA4SrElsh5plPn9nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+MkLHyqYpIVKK6Ie1yJI92FweP3XpNB+kKlJ4WLfngBnH2pdDcnEpwdutPJ+yeo1SNsatuGVxxAdcEDTtXWeq1vz/4inEW5jkkj9f1lJi24gdetdPeOVcI4/uP8CLJU3XvtPuru13/YQd9XntDo4LHGVUEw0NGfThJZklnflTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aGGHxh3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC666C4CEC3;
	Sun,  8 Sep 2024 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725804219;
	bh=PWGEba5F2l3NtkxLC5EHZ/MpSElA4SrElsh5plPn9nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGGHxh3IqCGUvZa3ejYBZN67vlxG5f17V5brWNNhJ4Ic555iQyQBDVLyIPrJ/Ul1N
	 nGoshUuY3hTfpMS+x7bY/Jp470kT8NF2DgseFCvlUt15rGHVHTdG+XdLdXXppSa58b
	 +qfRoQKyhtPIhDwCxS4ZLTIwDRV5vLxkct1BbMb4=
Date: Sun, 8 Sep 2024 16:03:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/3] selftests: mptcp: fix backport issues
Message-ID: <2024090824-latter-phonebook-aaf7@gregkh>
References: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
 <20240905144306.1192409-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905144306.1192409-5-matttbe@kernel.org>

On Thu, Sep 05, 2024 at 04:43:07PM +0200, Matthieu Baerts (NGI0) wrote:
> Greg recently reported that two of the backport patches I sent for v6.1
> could not be applied [1][2]. It looks like it was because some other
> patches have been applied twice, using different versions [3].
> 
> After having dropped the duplicated patches, the backport patches that 
> couldn't be applied were still causing issues. It looks like it is due 
> to quilt/patch having applied some code at the wrong place. This is 
> fixed in patch 1/3. After that, the same two patches can be applied 
> without any issue. They have been added in this series to help just in 
> case.
> 
> Link: https://lore.kernel.org/2024090455-precook-unplanned-52b3@gregkh [1]
> Link: https://lore.kernel.org/2024090420-passivism-garage-f753@gregkh [2]
> Link: https://lore.kernel.org/fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org [3]

All now queued up, thanks.

greg k-h

