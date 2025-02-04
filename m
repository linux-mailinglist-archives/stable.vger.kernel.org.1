Return-Path: <stable+bounces-112200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA9A27850
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1CF165CB3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E9B2163A2;
	Tue,  4 Feb 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ua1n5HHg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A021638E
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689963; cv=none; b=Cs6yQhFHfSfPc3hW7BvUi48KPVoXN4MLHysdd3PPF2V8Jjx9W79AUkDKl6O/N0Ayd75AZPR+2oJ0wp6gTKLvRz/GzaI/f4WfidxoD5oFO5ndYl2ks+yTFL9WOpiUC68LQsojOAdIwkSj/DZczfiiI1zGaugp7XXfemd0tZw4KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689963; c=relaxed/simple;
	bh=ZYvOyibfipNHT3s+QlBt8aiFl9GzxiZgbO/tuONZA3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeiKvKO/+H96z1odbSdOcHOJVkFftBdo7872Miy2pHXT8NA+afCTRoRXoMz/USaGmImYrL/hsxP8/Bec+Y2VufqANmTO+UzmpjglzAJNZk1FCaSfvGcDJm9s34xFou5WVBD5QvOLCXLba/gZVaSFcysQCTLWLXPPzJyi4B65AOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ua1n5HHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072D8C4CEDF;
	Tue,  4 Feb 2025 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738689962;
	bh=ZYvOyibfipNHT3s+QlBt8aiFl9GzxiZgbO/tuONZA3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua1n5HHgGkc1cunRm11DMpNX8ZxOr6zRenm7RHYEwx5Fm29qtLMmSHF1/VUfzfHqX
	 R1XGWqJcntH4sUaz+C2wPqLa9Run1bEh/97SOgN6eYWjn0Cm50KK+PzNre/8R5tD1f
	 kdNjmj7cOIOh8cFfc8wFtcezGp9EYJILRKFkvFzA=
Date: Tue, 4 Feb 2025 18:25:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Kramme <kramme@digitalmanufaktur.com>
Cc: stable@vger.kernel.org, chengming.zhou@linux.dev,
	Bendix Bartsch <bartsch@digitalmanufaktur.com>
Subject: Re: v6.12 backport for psi: Fix race when task wakes up before
 psi_sched_switch() adjusts flags
Message-ID: <2025020447-coziness-pedigree-3e5b@gregkh>
References: <CAHcPAXT=6GhKo4CnkveSm_X+EQXSz-GCRtigi5aFRscASSTFXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHcPAXT=6GhKo4CnkveSm_X+EQXSz-GCRtigi5aFRscASSTFXw@mail.gmail.com>

On Tue, Feb 04, 2025 at 04:31:44PM +0100, Paul Kramme wrote:
> Hello,
> 
> we are seeing broken CPU PSI metrics across our infrastructure running
> 6.12, with messages like "psi: inconsistent task state!
> task=1831:hackbench cpu=8 psi_flags=14 clear=0 set=4" in dmesg. I
> believe commit 7d9da040575b343085287686fa902a5b2d43c7ca might fix this
> issue.
> 
> psi: Fix race when task wakes up before psi_sched_switch() adjusts flags

It is already queued up for the next 6.12.y release.

thanks,

greg k-h

