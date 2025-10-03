Return-Path: <stable+bounces-183160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC9BB5F83
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 08:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6353C8A04
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CC17332C;
	Fri,  3 Oct 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uq+cju/2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D491547C9;
	Fri,  3 Oct 2025 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759471751; cv=none; b=eHEgdENDLSpggTj6On9NSeGSqeP6kPMLcih1OQXl99N0uwTrJW01vnQ23TQ7MFMa2N0bxIMRHyXCQlIBCL1pycDb61Hbv+13lv5z685zIcZgSUXCN9UinziqGKBk7T3CrP/EwOAtQ9jHo4EVnAFQbD/TOQ5jMq49kwtX0u/7UFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759471751; c=relaxed/simple;
	bh=YfSzYhQZ2eWIrwBq4KF6vpObZ0SyURA87QIx7up8W+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIjPi0IikzkykEW9qU8mLJ83mrgSMeJcaVnGNTYdYzZ7DtWsImpPZGHJEsDflBfv8NyfJNCLqKdux9WxiFPVfDt1bW9JSJt2P4uQoN6zC5HZoYdHE/iSDzc0+hmpFNKwurcSBhC7prkkdKHS1xy31lCyY+I8TiPAI75RypTko7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uq+cju/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2361DC4CEF5;
	Fri,  3 Oct 2025 06:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759471750;
	bh=YfSzYhQZ2eWIrwBq4KF6vpObZ0SyURA87QIx7up8W+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uq+cju/2CO5Ku7xG5CdfQERqzsx0FGTsyY9IjXtrN042miGmojtRNye7Y2z96dK3n
	 rPf/eNygGGFc/6A5k3855GMQD0RD28hb6hTVTBMACORFxZAde8jNv7N1zJhFxqFyIN
	 ty0d7FLxHP31baxc/FzFIsR2uRX45C9IyY61Rhag=
Date: Fri, 3 Oct 2025 08:09:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de, broonie@kernel.org,
	andriy.shevchenko@linux.intel.com, 13564923607@139.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, baojun.xu@ti.com, Baojun.Xu@fpt.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix a potential race condition
 that causes a NULL pointer in case no efi.get_variable exsits
Message-ID: <2025100301-resent-unsure-1c84@gregkh>
References: <20250911071131.1886-1-shenghao-ding@ti.com>
 <9a684e939409ed298c69782581fda7f838d61545.camel@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a684e939409ed298c69782581fda7f838d61545.camel@irl.hu>

On Thu, Oct 02, 2025 at 09:27:46PM +0200, Gergo Koteles wrote:
> Cc: <stable@vger.kernel.org>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

