Return-Path: <stable+bounces-114501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B9A2E859
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137631673C2
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6261C3C10;
	Mon, 10 Feb 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVzgDb69"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF11C3C01
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181337; cv=none; b=U/ohN3//ukK5LqEsic19NdHPLnUEOTGJVoQCwVYbxReZauLwVSpTg7jTHR3wjIAKL4uQEicG2PkyK7ZjwJzZ6bpxAh8zhBQj6wssI4w1PmP+DFmU57tYIvWbbiLC1SWgppNxhF8mCtES/URm8SqoFzE89lum8TCNYMR43+TOWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181337; c=relaxed/simple;
	bh=noLKjX+tiagrq8KLYljIlHZfCLLHiCyrOmYtSmImgjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVg2iiTJBB2Ca470CoS3jObjW+v+nFQmjuV2Pkh2xBOkKZahEMK0nuSCQwJIaTWQP4vFTb3BMXs9GPS8Z83Cs4Lz204ADw3tYks0HZgWatkYKwQCSIPq/fGz8oY7Mjisqk/GNmImw7K12sdDbKO16ysmJWAwdxiBVw8ZkfJYzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVzgDb69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696CEC4CED1;
	Mon, 10 Feb 2025 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739181337;
	bh=noLKjX+tiagrq8KLYljIlHZfCLLHiCyrOmYtSmImgjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVzgDb69tOWwEJwxGAKOjrYHeMxX7ypyX/1sNgWn1H0oaNi/gxJH7nZKgVsLSeuD8
	 CikSvPh57p/Ca1bpm2n/ZQj+1QdWyjoAF+iwxzirsBrrPtWWIxfuJ3id+slzcXGeoF
	 r/NGG21LHwGnfT6NGz+iIgOh3umalcuPpy/NFGZg=
Date: Mon, 10 Feb 2025 10:55:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: bruno.vernay@se.com, kent.overstreet@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v5.15-v5.4] lib/generic-radix-tree.c: Don't overflow in
 peek()
Message-ID: <2025021020-tavern-regroup-785b@gregkh>
References: <2025021059-waking-parlor-c55d@gregkh>
 <20250210093913.209407-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210093913.209407-1-hsimeliere.opensource@witekio.com>

On Mon, Feb 10, 2025 at 10:39:13AM +0100, hsimeliere.opensource@witekio.com wrote:
> This patch is needed to correct CVE-2021-47432
> https://nvd.nist.gov/vuln/detail/cve-2021-47432

Same comments here, this is not a valid answer, sorry.

greg k-h

