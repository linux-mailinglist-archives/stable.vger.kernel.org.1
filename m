Return-Path: <stable+bounces-23466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97235861236
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580BF285F10
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59E7D413;
	Fri, 23 Feb 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EPFWB1XH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C96FBF
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693436; cv=none; b=Ks2wk/TI/WgxLV6VSO51IGUMMSoXpDYA/vley67yfiPvuaP83p/bljwHVY7XnqpbPTNH/0Eiw+G1nDnMhnIPJAInskelf3jhQFe2U9P0cW46ANbfWkIkSlnmIiF8+fs+Hog0nw+YD6t5O3cNp0UFOqn23FNTPB5RlV/Gq4Y7h2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693436; c=relaxed/simple;
	bh=9sBsslBZlStAox7vCImyp1Zx43FQ8puH/KUGko18yWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx9eqUB+qtrAcix9fZAlN6y2WWk/8XcSCBc/gaNY6L3Qc8ABKXamrerNE/JIuSc141zYjzvXL++/ofp2ItB9lv3bhLLXY9XoOMKcTb5yklal95jxInUOLyvphUc52npL23vwneVoQLmnfwOc40sADee7k+3Q69YaP5rAwbwBGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EPFWB1XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98783C433F1;
	Fri, 23 Feb 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708693436;
	bh=9sBsslBZlStAox7vCImyp1Zx43FQ8puH/KUGko18yWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPFWB1XHjfWq09a7wKB2O6DmklU5YMrPeWuH69RZeRF8VvAaPXhyUiv/CnmAXoODV
	 z79AOhRBDA6iGslim1n021gaHYAplTFPD0tmuZzoYOOdR0Z9uyYYdnnqKf3XG+RlLd
	 tUoYXMYRh9YRGk5Y5dZQUR6lZ76klr/ajpE1djjE=
Date: Fri, 23 Feb 2024 14:03:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Roxana Nicolescu <roxana.nicolescu@canonical.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport commit be80e9cdbca8 ("libbpf: Rename
 DECLARE_LIBBPF_OPTS into LIBBPF_OPTS") to 5.15
Message-ID: <2024022318-greedless-unshaven-764a@gregkh>
References: <8a078070-19db-4ca7-8210-077818224f67@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a078070-19db-4ca7-8210-077818224f67@canonical.com>

On Thu, Feb 22, 2024 at 05:02:19PM +0100, Roxana Nicolescu wrote:
> Hi,
> 
> Please include commit  be80e9cdbca8 ("libbpf: Rename DECLARE_LIBBPF_OPTS
> into LIBBPF_OPTS")
> to the 5.15 stable branch.
> 
> Commit  3eefb2fbf4ec ("selftests/bpf: Test tail call counting with bpf2bpf
> and data on stack")
> introduced in v5.15.39 is dependent on it, and now building selftests fails
> with:

Does 5.15.149 still need this?  We fixed up something like this in that
release.

If not, let us know and I'll add this.

thanks,

greg k-h

