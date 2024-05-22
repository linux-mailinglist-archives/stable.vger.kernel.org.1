Return-Path: <stable+bounces-45582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EE8CC44B
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8751C20829
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480737D412;
	Wed, 22 May 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSyMjPN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C97D3EF
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392691; cv=none; b=L+UFQI8xncrUo+e8QHliYlXhjTAve6RpFYlRUlxqIXiOy6UGcPjWCmDgOh0T5Vt9CY/76Xz06/JPx0ExWj2m30smOc83hDS8Ql/UrSCcjmJRdEZ6sZ9tB8Ye/uzqbMRSKoVJyWNr+Oksc4AV0nsZcU7Ur7Av1hpcZ/cr0ZYZVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392691; c=relaxed/simple;
	bh=BEWdX4IwPUTj3yklt4ppjNSWJAwz64lzL/QHsRaHS+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dna3YsAdB7r8OUYy4WTfS5ZW0Jv4Kk4HSUuGWbpb9RmaakAsK/BKrhMF8o7QlUvPGyOuOdHATcjBn6KqTrR0TNIwFr85epy80gDowKMnC1JYNF6XH9gYZv/29LUKPk2CLdRElT80o5LoWp1D8Tkjt4Ml4u7Sw0hgFA2ZnWn7Quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSyMjPN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348D7C2BBFC;
	Wed, 22 May 2024 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716392690;
	bh=BEWdX4IwPUTj3yklt4ppjNSWJAwz64lzL/QHsRaHS+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSyMjPN1DlTBuX8fXFrjR2q/olFvFx8k1HhOpG7CMr30z+RFbQ+9ilGqWhQ9pIqbD
	 jsjcjzCEruJGvAX2HJvlpcbY++4bcqca2OQVsO4TN24TZDvHgcGT4Mt6IvTuL26qiv
	 NZxp/phO7WAb2IbIGRb5BPN4FOjpT9/asKqYERFA=
Date: Wed, 22 May 2024 17:44:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, stable@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Fix Intel's ice driver in stable
Message-ID: <2024052241-divided-atlantic-a75d@gregkh>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
 <2024051653-agility-dawn-0da9@gregkh>
 <0683ec3d-b0bb-4612-b64c-4808b7ec8d66@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0683ec3d-b0bb-4612-b64c-4808b7ec8d66@intel.com>

On Thu, May 16, 2024 at 10:10:07AM -0700, Jacob Keller wrote:
> 
> 
> On 5/15/2024 11:44 PM, Greg KH wrote:
> > On Wed, May 15, 2024 at 03:16:39PM -0600, Ahmed Zaki wrote:
> >> 2 - applying the following upstream commits (part of the series):
> >>  a) a21605993dd5dfd15edfa7f06705ede17b519026 ("ice: pass VSI pointer into
> >> ice_vc_isvalid_q_id")
> >>  b) 363f689600dd010703ce6391bcfc729a97d21840 ("ice: remove unnecessary
> >> duplicate checks for VF VSI ID")
> > 
> > We can take these too, it's your choice, which do you want us to do?
> > 
> > thanks,
> > 
> 
> Please pick these two up. That will solve the regression.

Now picked up, thanks.

greg k-h

