Return-Path: <stable+bounces-53631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156F90D35F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C5286783
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430018132A;
	Tue, 18 Jun 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmzOwNGP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9D17E476;
	Tue, 18 Jun 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717899; cv=none; b=CMtc/wrd0gBYgW5eklTScquxyPueItjblUB1Y6f0aPha89aLYGcVyDkgL5NdbNzKkQ2aEmF2gKq5C6t1CMzD26dnLaGAXUxH2lUQpCcUqBsyvf8QZLTSuXg210d3rO7cNqxugXrkRQQPNYkXVeqd/jR4hvTsFDH4JJXd/8tBV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717899; c=relaxed/simple;
	bh=6faXDGSZijxkWpxmkup1dsDNKUawVzWBi0cOzGQkyWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPE9CIRG4ToVRXefusYeR2gHSlaJ9/ops/jJSm8vX8lrFayEvluruSoN2uyMeJ48A7iQREfFz1FCzcTtHpFcnCqgCljMmubNwujt6X88SWcKtZWSRsyPOTSg3bDdJeMKZJ9JNigdAUiVEyrGcmi/L6eh0c9C90g2quoSXh3OGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmzOwNGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D041AC3277B;
	Tue, 18 Jun 2024 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717899;
	bh=6faXDGSZijxkWpxmkup1dsDNKUawVzWBi0cOzGQkyWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmzOwNGPEZB1TQbxDWSTkdNEBB0bf6ldfAPMlLDndlSTX9tRURV+C6tNkNsfdVEkz
	 20Uhrg5G4CcxWxQVASx5z30qZZqkygPa/CDIcPG6kXq5SR6Z7DIOpuXfNmf1ffLOEB
	 p9Di7lBkMLOtG0794J4h1cxUsU+ZpQM59uWeJ8ow=
Date: Tue, 18 Jun 2024 15:38:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061831-oyster-stoppage-8b1f@gregkh>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240612153922.2531-1-joswang1221@gmail.com>
 <2024061203-good-sneeze-f118@gregkh>
 <CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
 <20240618000502.n3elxua2is3u7bq2@synopsys.com>
 <CAMtoTm1ZkT6NoBj9N-wKkzxASQ2AboYNdd-L7DHUEt8m8hootg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtoTm1ZkT6NoBj9N-wKkzxASQ2AboYNdd-L7DHUEt8m8hootg@mail.gmail.com>

On Tue, Jun 18, 2024 at 08:47:38PM +0800, joswang wrote:
> On Tue, Jun 18, 2024 at 8:05 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> >
> > On Thu, Jun 13, 2024, joswang wrote:
> > > On Thu, Jun 13, 2024 at 1:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 11:39:22PM +0800, joswang wrote:
> > > > > From: Jos Wang <joswang@lenovo.com>
> > > > >
> > > > > This is a workaround for STAR 4846132, which only affects
> > > > > DWC_usb31 version2.00a operating in host mode.
> > > > >
> > > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > > in host mode that would cause a CSR read timeout When CSR
> > > > > read coincides with RAM Clock Gating Entry. By disable
> > > > > Clock Gating, sacrificing power consumption for normal
> > > > > operation.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > > ---
> > > > > v1 -> v2:
> > > > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
> > > > >   this patch does not make any changes
> > > > > v2 -> v3:
> > > > > - code refactor
> > > > > - modify comment, add STAR number, workaround applied in host mode
> > > > > - modify commit message, add STAR number, workaround applied in host mode
> > > > > - modify Author Jos Wang
> > > > > v3 -> v4:
> > > > > - modify commit message, add Cc: stable@vger.kernel.org
> > > >
> > > > This thread is crazy, look at:
> > > >         https://urldefense.com/v3/__https://lore.kernel.org/all/20240612153922.2531-1-joswang1221@gmail.com/__;!!A4F2R9G_pg!a29V9NsG_rMKPnub-JtIe5I_lAoJmzK8dgo3UK-qD_xpT_TOgyPb6LkEMkIsijsDKIgdxB_QVLW_MwtdQLnyvOujOA$
> > > > for how it looks.  How do I pick out the proper patches to review/apply
> > > > there at all?  What would you do if you were in my position except just
> > > > delete the whole thing?
> > > >
> > > > Just properly submit new versions of patches (hint, without the ','), as
> > > > the documentation file says to, as new threads each time, with all
> > > > commits, and all should be fine.
> > > >
> > > > We even have tools that can do this for you semi-automatically, why not
> > > > use them?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > We apologize for any inconvenience this may cause.
> > > The following incorrect operation caused the problem you mentioned:
> > > git send-email --in-reply-to command sends the new version patch
> > > git format-patch --subject-prefix='PATCH v3
> > >
> > > Should I resend the v5 patch now?
> >
> > Please send this as a stand-alone patch outside of the series as v5. (ie.
> > remove the "3/3"). I still need to review the other issue of the series.
> >
> > Thanks,
> > Thinh
> 
> This patch has been sent separately, please help review it.

You too can help review other commits on the list to reduce the
maintainer load here.  Please do so in order to insure that there is
time to review your changes as well.

thanks,

greg k-h

