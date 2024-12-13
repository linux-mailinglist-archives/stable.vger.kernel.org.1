Return-Path: <stable+bounces-104000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B39F0A6F
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527AA16A5B3
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FFC1CEEA8;
	Fri, 13 Dec 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oR1rBGye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E11CDA09
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088141; cv=none; b=IefqZm0ktOuuhnyA6BrPhk54S6BDq6bY7S/SoLtxgr33srtESWoqauzD4RzcB4QGZSG8sGr5KMqr61DkktcMDL/RtqD0AccEQBlvlSkj9S5a6q6Q+u2q3/4RyFVfsorfdk9dG7E09goSggRbg59vrQuJ1i17pbfZFyLnPY6LVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088141; c=relaxed/simple;
	bh=R2Bw7ERXPOV28gNYKkpCdWcGBA8GlAboUf2XwRXTMik=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqrWap2lKO+LBBB9R/jCcYl41AnHdhajAJ9UVhXl9tNntUlKjQYMqYp9j3dDE69DUM7rYJnOiX3+bCNbBTt3nxoS6Ia2YSZTM7h5HPpyBQvCVmi9BTK/y/2lTPh427KpVppyYmwj07mwvIo3FYQjJ2FVV4ftCt8WYg1xT1ym7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oR1rBGye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62325C4CED0;
	Fri, 13 Dec 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088139;
	bh=R2Bw7ERXPOV28gNYKkpCdWcGBA8GlAboUf2XwRXTMik=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=oR1rBGyebiGQeRW5ZE3jt4RGgC50nFWtkLalNZ8dzZuXbqstIrNiB4geZU8dnV70d
	 44rM9L7TNMU6dJAyGqTmDS2HyiBJCvWWDNIJFjb3fMrNu08LzlXO4ovSBjOkyVZRqa
	 xswlfRR7Z5QvIgP2MuJ9JW4wUApZMmImuc6/J03s=
Date: Fri, 13 Dec 2024 12:08:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	guocai.he.cn@windriver.com, stable@vger.kernel.org,
	ian.ray@gehealthcare.com, bartosz.golaszewski@linaro.org
Subject: Re: [PATCH][5.15.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock
 race
Message-ID: <2024121322-conjuror-gap-b542@gregkh>
References: <20241213103122.3593674-1-guocai.he.cn@windriver.com>
 <cead071a-f60c-42ac-80dd-f3fb1d937e48@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cead071a-f60c-42ac-80dd-f3fb1d937e48@oracle.com>

On Fri, Dec 13, 2024 at 04:15:09PM +0530, Harshit Mogalapalli wrote:
> Hi Guocai,
> 
> On 13/12/24 16:01, guocai.he.cn@windriver.com wrote:
> > From: Ian Ray <ian.ray@gehealthcare.com>
> > 
> > [ Upstream commit bfc6444b57dc7186b6acc964705d7516cbaf3904 ]
> > 
> > Ensure that `i2c_lock' is held when setting interrupt latch and mask in
> > pca953x_irq_bus_sync_unlock() in order to avoid races.
> > 
> > The other (non-probe) call site pca953x_gpio_set_multiple() ensures the
> > lock is held before calling pca953x_write_regs().
> > 
> > The problem occurred when a request raced against irq_bus_sync_unlock()
> > approximately once per thousand reboots on an i.MX8MP based system.
> > 
> >   * Normal case
> > 
> >     0-0022: write register AI|3a {03,02,00,00,01} Input latch P0
> >     0-0022: write register AI|49 {fc,fd,ff,ff,fe} Interrupt mask P0
> >     0-0022: write register AI|08 {ff,00,00,00,00} Output P3
> >     0-0022: write register AI|12 {fc,00,00,00,00} Config P3
> > 
> >   * Race case
> > 
> >     0-0022: write register AI|08 {ff,00,00,00,00} Output P3
> >     0-0022: write register AI|08 {03,02,00,00,01} *** Wrong register ***
> >     0-0022: write register AI|12 {fc,00,00,00,00} Config P3
> >     0-0022: write register AI|49 {fc,fd,ff,ff,fe} Interrupt mask P0
> > 
> > Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> > Link: https://lore.kernel.org/r/20240620042915.2173-1-ian.ray@gehealthcare.com
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
> > ---
> > This commit is to solve the CVE-2024-42253. Please merge this commit to linux-5.15.y.
> > 
> >   drivers/gpio/gpio-pca953x.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> > index 4860bf3b7e00..4e97b6ae4f72 100644
> > --- a/drivers/gpio/gpio-pca953x.c
> > +++ b/drivers/gpio/gpio-pca953x.c
> > @@ -672,6 +672,8 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
> >   	int level;
> >   	if (chip->driver_data & PCA_PCAL) {
> > +		guard(mutex)(&chip->i2c_lock);
> 
> This wouldn't compile on 5.15.y

Which means that no one is actually testing these backports.

Ok, I'm frustrated enough.  No more windriver backports for stable trees
will now be accepted until you all get your act together and figure out
how to do this properly.

As to "how" you prove that you all know what you are doing, I will
leave that up to you to come up with a proper proposal and proof.

ugh.

greg k-h

