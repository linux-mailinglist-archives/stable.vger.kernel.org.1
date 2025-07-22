Return-Path: <stable+bounces-163681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805EB0D647
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553CB1AA7677
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D672D97A2;
	Tue, 22 Jul 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSYQ/k9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111A2CCC1
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177873; cv=none; b=YfnHcijwvS1qCakmgVaMAWwmhBScH4ItSuAIA1RTMNfIYCb7VKoJ5d60iR2DNF4VPnNBcEOTa9kdpqMRu4eUfZheVxPR71ZBkYKg2H+bwXjrl59hYKuS4/RoGONA1mIheVS2eC+7uwGgSHeseIZVqlAM2pfP15hA+yVrTmMDhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177873; c=relaxed/simple;
	bh=HzpFjaoozbW8q9r3jL2tf6aCmPsIzOa7CYCZoCPPw+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOppTDE+7HHFbi2D6uq/bUThOiCznZUATcd/+5MFJ6AWFiD1LtY3l0+mYuLQ9UNXN+tQXLelk+QM/KFBY03mbIBmWSnNLv5UoL1rm4uS8JtbvUloId0zx1FPztxdnsP/0plLe5R2u/CC24pYo8toOWCCVB1CUEyTUFqrraJWZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSYQ/k9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B69C4CEF4;
	Tue, 22 Jul 2025 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753177872;
	bh=HzpFjaoozbW8q9r3jL2tf6aCmPsIzOa7CYCZoCPPw+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSYQ/k9IdV2AN7Wn2jdDTk+uorRZAyUbgnJNMMfH9CIt4mwObQiMQpCNIFhMd04oI
	 KsLxkSD4fpegl/eaZTU0R1U5cpYesJEWLXp6Jmf1gLNfxGHk4bq8Ne6K+QKWWfiZBT
	 a+1naXPinG1PVbf5C0VknfCkylXfN3ooNuRYHROc=
Date: Tue, 22 Jul 2025 11:51:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddhi Katage <siddhi.katage@oracle.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 0/4] Fix blank WHCAN value in 'ps' output
Message-ID: <2025072252-urban-triage-41c9@gregkh>
References: <20250722062642.309842-1-siddhi.katage@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722062642.309842-1-siddhi.katage@oracle.com>

On Tue, Jul 22, 2025 at 06:26:38AM +0000, Siddhi Katage wrote:
> The 'ps' output prints blank(hyphen) WHCAN value for all the tasks.
> This patchset will help print the correct WCHAN value.

Did you forget to also backport commit b88f55389ad2 ("profiling: remove
profile=sleep support") for this series?

thanks,

greg k-h

