Return-Path: <stable+bounces-188889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF68BFA0E9
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA79A3524AF
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AC2EB863;
	Wed, 22 Oct 2025 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qaDVl2oe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE872EB84F
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111040; cv=none; b=Dze+/IihJ4Y0GlazCieTRnQq/tZAx3eS/fLqOmTA2sIpDnC7xIyrsHThcmqkR56bfSzfzvtDg4UnaxKLafceFIZif6q0hdvAXuotrK7iXuiRc1ZiVtXlImNHaLAjIX7O0It283aCb+ROUI54dYMpwIT7p0nzE05k+Rt1aH9BdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111040; c=relaxed/simple;
	bh=eD4pVTGVovSRMp2dKTtn5e3EMm1Exq0wGdNlPgP7BV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd05lN7uH0lYhwMmrD/kmIPAtcuqIjnWM5EbyE2xfiZzeSpXBvgH08cNeNzJ3WvV+X0mECIhjEPYRom+s3EiAaCN/ZngBuHchD8yr2BxSdY5nJPkpqyT0gZ9iC+Lz+TKHAgBmOFARqj9gc5sLy7Y86AB0GUgleXqY2fuKRABBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qaDVl2oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACFFC4CEE7;
	Wed, 22 Oct 2025 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761111039;
	bh=eD4pVTGVovSRMp2dKTtn5e3EMm1Exq0wGdNlPgP7BV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaDVl2oedWDNKwAttQWwXcH/U4xtfaPiNlDeBFq84AVm6aPztf3agwqQo21if0lxZ
	 kQoq9QlJOswnvZkxz++sc0LkUK12yMyWXNnFDYPgzqhrcvUdwo5DIEi19OXZqFreu4
	 8YZx+UxRtDcKARGy42+bZDJyRjTnSwiEsrY5ubgI=
Date: Wed, 22 Oct 2025 07:30:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
Message-ID: <2025102224-auction-monastery-2a74@gregkh>
References: <2025102032-crescent-acuteness-5060gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
 <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
 <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
 <1f15260b-684e-4b8c-807f-244bbfd31f1c@kernel.org>
 <edffeaca-e52a-4ecc-b788-3120e11bbef2@kernel.org>
 <c5038e5a-ebb1-464f-9b79-905168ac7e44@hardfalcon.net>
 <49b53fad-586e-4b6d-bb66-a35faea2afd9@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b53fad-586e-4b6d-bb66-a35faea2afd9@hardfalcon.net>

On Wed, Oct 22, 2025 at 05:52:17AM +0200, Pascal Ernster wrote:
> [2025-10-21 23:34] Mario Limonciello (AMD) (kernel.org):
> > Alternatively does picking https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbfe987c5a2854705393ad79813074e5eadcbde6 help your issue?
> 
> Thanks again, this patch does indeed fix the build issue for me :)

My fault, I should have noticed that this was required, now picked up,
thanks!

greg k-h

