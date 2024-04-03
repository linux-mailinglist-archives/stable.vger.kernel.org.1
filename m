Return-Path: <stable+bounces-35864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F89897808
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 20:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20391C2195A
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8441534F2;
	Wed,  3 Apr 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSj7+4gu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE2152DF0
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168315; cv=none; b=jnYXk6q9BoG7O2q6Roa7CU4gwnB84D5+dKROYhB8f57pyvwvOGZ2UVsu8bsl9vd2Xyh57fj/a6r3LaLSHaPzG9nPCa44pM4DlmzKSZmp1eaJJBYaU0RdW4XsILIddMJ4qE0jDRCR4dhkj5dLKIr+kTDReDAtumbDXc4qwyNrGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168315; c=relaxed/simple;
	bh=P9yWqBtlsaeFnaAZmbCkgpReXKzLQLMYUfBreeUNjr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSjhYBM0RwwVwrBnjXm0siC0WwqbQ3LDV52KsncrH2xvABZOghF4gQIwmmhPhN/f1BJ+4p5Eiywf8eJ3IL/SQyTc87HGxZu9ZAOzL3zGARI9MgTWYF/S7iXHj+Zybq4mVkINb4aszbJQSUZet4qVXW1t+RCQWFqNWb/k3/BD2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSj7+4gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AC9C433F1;
	Wed,  3 Apr 2024 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712168315;
	bh=P9yWqBtlsaeFnaAZmbCkgpReXKzLQLMYUfBreeUNjr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSj7+4gu1ie54nAa9tpG/7XYqz6LKMWtzj7Zo9MOgrnnr8DptCtNNmJE+ejzrDqHH
	 YoCFJyHRpdAAiDU+unF9K2GqrCZRGkGB3RmZaxsqJLcHUV7rhf8YaWcTxdZwHqX50r
	 VouPXAkYnbwPm9RD4OewmUCjvBinGy1mOedPl//UrTjIynADlD/dTerXr/Ddtvqste
	 N4LX736jN+RL9z6PoQgAp6PllalT6rAWdArWFLgPdh5ECJjOTfbAqdhVKQRDXVgnqL
	 JPAKSjS4yjeZU3tZQL5mW+vyFboaE1oE3OfMLiuxyaWQPd4qjSRfRvh8ZoHtuvLjG6
	 on6ttJ04ypFkQ==
Date: Wed, 3 Apr 2024 11:18:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Leah Rumancik <lrumancik@google.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by
 xfs/179/270/557/606
Message-ID: <20240403181834.GA6414@frogsfrogsfrogs>
References: <20240403125949.33676-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125949.33676-1-mngyadam@amazon.com>

On Wed, Apr 03, 2024 at 02:59:44PM +0200, Mahmoud Adam wrote:
> Hi,
> 
>  These patches fix and reported by xfstests tests xfs/179 xfs/270
> xfs/557 xfs/606, the patchset were tested to confirm they fix those
> tests. all are clean picks.

Hi!  Thanks for the backports!

Normally I'd pass these on to the 6.1 XFS maintainer, but I'm not sure
who's actually taking care of that at the moment.  To find out, I've
cc'd all the people who have either sent 6.1 backports or made noises
about doing so.

To the group: Who's the appropriate person to handle these?

Mahmoud: If the answer to the above is "???" or silence, would you be
willing to take on stable testing and maintenance?

Also FYI the normal practice (I think) is to cc linux-xfs, pick up some
acks, and then resend with the acks and cc'd to stable.

The six patches you sent along look ok to me, so
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> thanks,
> MNAdam

