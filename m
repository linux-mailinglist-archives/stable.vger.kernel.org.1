Return-Path: <stable+bounces-81177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34E991B89
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5ACD1F224E1
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6B23C3C;
	Sun,  6 Oct 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBJS+n3I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7219A
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174099; cv=none; b=tyo8CkbtRnsRs5wZIEozv7gNTAFlBv7csP2OY4p4q6S61Y4iRRw5wKOvz6sSK4WNeisX2ProQWO57OWJcFLVcLFsDkQklL1Ridhr/8/132YLEzbooA+nDRQdbxDQKiL/ic0MjEgcgSNgA+ivK5g8fGy9Ee0JHxDsT2FjP6nuS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174099; c=relaxed/simple;
	bh=rWALCP05kjKkN2vRQXz28iuO//Xyk6hRYmfjrAAI3b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFtoP8xZNQBG+8yBR0QDgq980mQRQuxjsKZwac2GQkNqCgKHARx429mWkl07bHDUcVl+1SZ43yZ+qZXoitpw1IOOCZghH2w/iXZP+fhn/q2GaP/AmG8DuFNotPRi5A7dbks0mPOj6z4i9sJGpwePt9UckSaNvClgMO2m4ZMFi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBJS+n3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5373BC4CEC2;
	Sun,  6 Oct 2024 00:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174098;
	bh=rWALCP05kjKkN2vRQXz28iuO//Xyk6hRYmfjrAAI3b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBJS+n3InTG0frJpG7zohPRrpjs/3vXtiQB7iHomleEvDZuxHet27NozrOPv+BWEh
	 b6aZd4DXKkb57+hK8vRi7Ogkl2kFcK05dU0vA/Btrie5sG5h4JEXr94Q01IJ4kE6T0
	 BVVlyf60mAq1xpCW30M7mhrDb/Mjb74vZL9QEpQtuEfxzvLAvlVrogwT2RpZDyFZeL
	 l0Ah2zdCIjFbz7p/ddBKwidhKr0GTmi3JbXTlD/6w1++ikzX23zOv4qIeBYf6TzWdi
	 ise7OBnKtSFu2xumF9g5dnUX6/AXJYrbv+Jr7Uc9fosjlYXeFON7s+Egog8g8ET1Cf
	 Mb3M2j+9Wvs8w==
Date: Sat, 5 Oct 2024 20:21:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Bar-Gabay <morx.bar.gabay@intel.com>,
	Andreas Beckmann <anbe@debian.org>
Subject: Re: Please apply 0a6ad4d9e169 ("e1000e: avoid failing the system
 during pm_suspend") to 6.11.y
Message-ID: <ZwHYENvFyZwMuhy3@sashalap>
References: <ZwEqV7J97fQz-nMx@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZwEqV7J97fQz-nMx@eldamar.lan>

On Sat, Oct 05, 2024 at 02:00:23PM +0200, Salvatore Bonaccorso wrote:
>Hi,
>
>Andreas Beckmann reported in Debian in https://bugs.debian.org/1082795
>that the commit 0a6ad4d9e169 ("e1000e: avoid failing the system during
>pm_suspend") indeed fixed his with suspending with his Lenovo Thinkpad
>T16 Gen 3,
>
>https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1082795#21 confirms
>the fix.

Queued up, thanks!

-- 
Thanks,
Sasha

