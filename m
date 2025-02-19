Return-Path: <stable+bounces-118321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC8A3C7A2
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6E31889338
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182621517A;
	Wed, 19 Feb 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCcUnNfz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DA21516F
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989851; cv=none; b=Wp1/t2QJDsU7HQ7+QZJNeL4zEpPiv5srHKcP/ttfuKXMV4oWCoFBMrrEjEwsDZXpMDtkB1SsgDS0ze4oqe2a7Fka2M3eI+ExICaNNPsaZ/w+UWF8XFwbPQVCPgD1elS8Vov5rMIXaORHMeAl7HAhVZVmNL3UWV7xn2GXcteqXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989851; c=relaxed/simple;
	bh=zIdb+5/OEHxZu3cJeZYUI1T86WUd/xpFSH3h2Fks4pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOFE9oTvOzHty4s75/6LFeddwyTdZQaVNTwhwDagk9HCJcN2/hNNUT6EAXqLwJ8qXG1ugx5i/7cOs0C2jWffzjL671B+lLI7G/tfzIaJR0/jKEdbFBmHCwuIBJ/oEGV2F6JeMhDq/u7nvU3CTtlVxo0zAdf89HHxMW6DW4I5krA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCcUnNfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9593C4CED1;
	Wed, 19 Feb 2025 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739989851;
	bh=zIdb+5/OEHxZu3cJeZYUI1T86WUd/xpFSH3h2Fks4pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCcUnNfzCWKlasHXvxhbiQFsfxU3vDeiGOVLodxzuk5wKTtH1ol3nvf9hugLopGhm
	 ujybJFEovWWXrdKQQ38yjh+uTe000ZAP+y1HROFCLL9DLSH7/c5kZqyu573sRb8FV+
	 oSwNFAgUiz1dX0Dg1HovFP8MPq6ewFhUHMiW26xs=
Date: Wed, 19 Feb 2025 19:30:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y] WIP
Message-ID: <2025021935-driven-disaster-3542@gregkh>
References: <2023061111-tracing-shakiness-9054@gregkh>
 <20250219161049.119877-1-hoeppner@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219161049.119877-1-hoeppner@linux.ibm.com>

On Wed, Feb 19, 2025 at 05:10:49PM +0100, Jan Höppner wrote:
> ---
>  arch/s390/include/asm/idals.h  |  51 ++++
>  drivers/s390/char/tape.h       |   9 +-
>  drivers/s390/char/tape_34xx.c  |  10 +
>  drivers/s390/char/tape_char.c  | 436 +++++++++++++++++++++++++++++----
>  drivers/s390/char/tape_class.c |   2 +-
>  drivers/s390/char/tape_core.c  |   5 +-
>  drivers/s390/char/tape_std.c   | 146 +++++------
>  drivers/s390/char/tape_std.h   |   1 +
>  8 files changed, 512 insertions(+), 148 deletions(-)

I'm confused, is this a patch submission of a backport?


