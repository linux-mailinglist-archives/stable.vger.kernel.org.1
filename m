Return-Path: <stable+bounces-72762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EDE969487
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401EB1F23EA7
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F01D6DB6;
	Tue,  3 Sep 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzM/z1mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE671D6194;
	Tue,  3 Sep 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346971; cv=none; b=eSqPeGHn8eDvIW707N3MVVQCg8Rwy2E+nuLZyUNrYyGYex0cMsS/4ULkdu1wfN8bABrXUV6b4Ud/wrMdpUsV0jteCLGOVa130XKAT1z+e2loyH9KMsV6ZWujt0bIWheSIjWfL8Q3wL/vJCmgYEJ2vIozqumRT4VY9phUENSuXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346971; c=relaxed/simple;
	bh=3qidJfQt+X4a5kMK7cfyTY7OkqPL4BDhOdGy6okPpKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPWpWMJGC0cnSTe09COhtgLzHi8QJBT2J8YGuXzwVJaxy2/Fo4wf9TKAVs9SymLndCfZ13O3UBRyQMTM1icusUelOOXzEOq3+FkTj3cTkk2fhyyJJubmAwahSts7O/QYgweeoNLn3yMPJdMWfbB7tZnsmVHX8bCfe+O+JEdcUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzM/z1mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B82C4CEC5;
	Tue,  3 Sep 2024 07:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725346970;
	bh=3qidJfQt+X4a5kMK7cfyTY7OkqPL4BDhOdGy6okPpKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzM/z1mPycuq4e2yNt8f7GA15sih3ir21E8Talxo4MlWCSmmpSmTueSUhufJ/kTq/
	 n+7dvsgFyKe1KYXdSL/FJVfg9Szkry1FA46kTuCvhTdTDOs5uipkLfz53z/DQgoQ08
	 LyVDpiIkc5hCdxJEAHOh0Nc1jEjY8ksZQOl3xIqc=
Date: Tue, 3 Sep 2024 09:02:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable@vger.kernel.org, linux-usb@vger.kernel.org,
	Charles Yo <charlesyo@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>, Ondrej Jirman <megi@xff.cz>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6.6] usb: typec: fix up incorrectly backported "usb:
 typec: tcpm: unregister existing source caps before re-registration"
Message-ID: <2024090336-spider-skirmish-2ac9@gregkh>
References: <2024083008-granddad-unmoving-828c@gregkh>
 <ZtVaaFD5wbmYlLCa@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtVaaFD5wbmYlLCa@kuha.fi.intel.com>

On Mon, Sep 02, 2024 at 09:25:44AM +0300, Heikki Krogerus wrote:
> On Fri, Aug 30, 2024 at 04:00:09PM +0200, Greg Kroah-Hartman wrote:
> > In commit b16abab1fb64 ("usb: typec: tcpm: unregister existing source
> > caps before re-registration"), quilt, and git, applied the diff to the
> > incorrect function, which would cause bad problems if exercised in a
> > device with these capabilities.
> > 
> > Fix this all up (including the follow-up fix in commit 04c05d50fa79
> > ("usb: typec: tcpm: fix use-after-free case in
> > tcpm_register_source_caps") to be in the correct function.
> > 
> > Fixes: 04c05d50fa79 ("usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps")
> > Fixes: b16abab1fb64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
> > Reported-by: Charles Yo <charlesyo@google.com>
> > Cc: Kyle Tso <kyletso@google.com>
> > Cc: Amit Sunil Dhamne <amitsd@google.com>
> > Cc: Ondrej Jirman <megi@xff.cz>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks for the review!

