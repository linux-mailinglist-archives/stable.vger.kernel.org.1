Return-Path: <stable+bounces-66390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118394E2B1
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 20:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532A91C208F4
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 18:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F41537DF;
	Sun, 11 Aug 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="rf2hWM2q"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270410979
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723401343; cv=none; b=C7F381+EVoVjDXUHAUU2phWla/mBowugB9NZCPypTtmk+WgUc83NyQLtIZkYM5yOnwBjN4MVYqIJlMR+Dlz4d0RVNzyvrIsn/UDSlxIzAcfeaW6BQpecTkW2N/4GXK4AaVNV8f/Dd92bmtv+4iMRvic8po68ttHuZVR1OWKleco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723401343; c=relaxed/simple;
	bh=Tj7UhdKPxbaKD5mghZ+z/L6N7sjwQOo4VeU0WzFBdGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/AVXlElKBHDg3pNJdytMpszEL5ovk0I82coNm8DUOld9ccJdkpnBX4mJpbpKlT5JRVVPDopsO6a9RfXygbjhjX9rRjQv2w1QvutwuWzQLyzUPTWpUVv308MlBgknjvRjLlF8OdoBGDV1qPWuwSJJFw3cet8kj+M8ax4PWPipZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=rf2hWM2q; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sun, 11 Aug 2024 20:32:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1723401334;
	bh=Tj7UhdKPxbaKD5mghZ+z/L6N7sjwQOo4VeU0WzFBdGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=rf2hWM2qZxeiu9e4mvvkuUlBILl+9RQK1rUY6RukcZ7hgAo+qFLysvpKYsMYIqmaV
	 NK12ZSPKO0gYjoEmlWE10Cg0ET2KrZCzlKwQrlr1/0Fr/WKMsJKJQZS7g1D+cbBIJ3
	 wLSFEJkEdrTpLruZEU6g0ybYM/nqW8gz2Tj8bJFQpEH24GPBpllLvStBXgg/H4GHSV
	 xaE1jG8S2aYmD/p8A0Ly55ztqswr3BPG5h3a7HyOvkETulfkuuJZft1igMBjEnBUs4
	 M0hSxyhSsJ5isXY15D/ZebdZXy3111/dj3VuUwHw5i9LDqrmHBcqSt3v7h3vfGt+l6
	 Nf7d3VVrTyOig==
From: Markus Reichelt <ml@mareichelt.com>
To: Wolfgang Klein <klein.wolfg@web.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Longterm 6.6.x series: hdd temperature not accessible any more
Message-ID: <20240811183201.GA2487@pc21.mareichelt.com>
Mail-Followup-To: Wolfgang Klein <klein.wolfg@web.de>,
	stable@vger.kernel.org, regressions@lists.linux.dev
References: <e620f887-a674-f007-c17b-dc16f9a0a588@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e620f887-a674-f007-c17b-dc16f9a0a588@web.de>

* Wolfgang Klein <klein.wolfg@web.de> wrote:

> Is this a bug or has a new parameter or configuration option been added
> to the kernel code that has to be activated in order to retrieve the
> temperature?

The problem is known, have a look here:

https://lore.kernel.org/regressions/e206181e-d9d7-421b-af14-2a70a7f83006@heusel.eu/T/#mc60ff08e7c20d45faf9588e42048b5f01acaa0a3



