Return-Path: <stable+bounces-28266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430A87D38A
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B831C215C6
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B01B810;
	Fri, 15 Mar 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1yIfrUWJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A064AEF1
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527245; cv=none; b=C5J3vTBGBkdGCiJUGj1WP0j92jUK50PUyfgjb2QUnaXc1hqtUNwxG8S2KGnoDAJ9MQCesPRox2/XLsF5odAAdSZGPg+9lUZFNQneK473rUtTZm1PPdmjjiiMZjCqzDoU07rX7hGfGyUAg4Usf6vH8DKT8GyZnIANW+dWRzrQPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527245; c=relaxed/simple;
	bh=t0cnsU92bVST0HS1kr9jGSnJ42JyKhxU/UObpVhpt38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiIwx/LrQ1BE3oWFddugYYO1qu+AVSAhR4aBkuLMqGclYtcc12uQ6BZjvpaz5D1M+Oh0NKWXrJCJiaupRFWW74kGr3RZb+eKELaOzzmxCnx71C2EkOfx4M099hersIPLzmZPgXkyPR6gocPE6/40ZDuMTZK+UNq+9wbrDpZBn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1yIfrUWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F94C433F1;
	Fri, 15 Mar 2024 18:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710527245;
	bh=t0cnsU92bVST0HS1kr9jGSnJ42JyKhxU/UObpVhpt38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1yIfrUWJktFJzVMDORcqk0uME9AdDwzdO6cCLdnRKiB5QdgPxcjYRknZsTXqcnFFv
	 IxlQqr1l6jVbT26F9bHn6DVhGYfoatGcco5LOzB0XXiuLd+kOxRatx2IZVtF24/bul
	 zgXsnBEIKzXK9IBQQtFZsk+M5raUbWk+sK+hJAys=
Date: Fri, 15 Mar 2024 19:27:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, Helge Deller <deller@kernel.org>,
	stable@vger.kernel.org
Subject: Re: dddd
Message-ID: <2024031516-chip-circulate-ff78@gregkh>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ZfN8WxMrgQBUfjGo@sashalap>
 <7g5wb7rf3xxn5gz4dnqevbee7ba6zd4kllzb5lbj2i6capxppv@blm5renpmaiz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7g5wb7rf3xxn5gz4dnqevbee7ba6zd4kllzb5lbj2i6capxppv@blm5renpmaiz>

On Thu, Mar 14, 2024 at 07:02:46PM -0400, Kent Overstreet wrote:
> On Thu, Mar 14, 2024 at 06:38:19PM -0400, Sasha Levin wrote:
> > On Thu, Mar 14, 2024 at 05:46:35AM -0400, Kent Overstreet wrote:
> > > On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> > > > Dear Greg & stable team,
> > > > 
> > > > could you please queue up the patch below for the stable-6.7 kernel?
> > > > This is upstream commit:
> > > > 	eba38cc7578bef94865341c73608bdf49193a51d
> > > > 
> > > > Thanks,
> > > > Helge
> > > 
> > > I've already sent Greg a pull request with this patch - _twice_.
> > 
> > I'll point out, again, that if you read the docs it clearly points out
> > that pull requests aren't a way to submit patches into stable.
> 
> Sasha, Greg and I already discussed and agreed that this would be the
> plan for fs/bcachefs/.

I agreed?  I said that I would turn a pull request into individual
patches, but that it's extra work for me to do so so that it usually
will end up at the end of my work queue.  I'll get to this when I get
back from vacation and catch up with other stuff in a few weeks, thanks.

greg k-h

