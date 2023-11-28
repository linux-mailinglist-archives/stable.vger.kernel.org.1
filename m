Return-Path: <stable+bounces-2866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FE7FB3A0
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EA61C20C26
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D3156C2;
	Tue, 28 Nov 2023 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wZg5YV72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D515E80;
	Tue, 28 Nov 2023 08:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC038C433C7;
	Tue, 28 Nov 2023 08:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701158860;
	bh=0t+O+30Xv5t/NqO26Aolg8thAtJ3OrzSz6sxE+kDq18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wZg5YV72F+D/Yaov5ZJtMMfrCI70bcfZPYtVG97UzrnZqGNDp5215cHjUEsns6TfA
	 wMFUIMh5+jZs87WA8JtzUItRNXkkAY9HaVB0jMgK/0s+35aFzkfUfK4jFeyAfmMwH9
	 P4vmeKXZpOSljde8EvefzsR4IzXBlEwRlKwCVjs8=
Date: Tue, 28 Nov 2023 08:07:37 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, badhri@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <2023112847-verdict-percent-71b3@gregkh>
References: <20231127210951.730114-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127210951.730114-2-rdbabiera@google.com>

On Mon, Nov 27, 2023 at 09:09:52PM +0000, RD Babiera wrote:
> When typec_altmode_put_partner is called by a plug altmode upon release,
> the port altmode the plug belongs to will not remove its reference to the
> plug. The check to see if the altmode being released evaluates against the
> released altmode's partner instead of the calling altmode itself, so change
> adev in typec_altmode_put_partner to properly refer to the altmode being
> released.
> 
> typec_altmode_set_partner is not run for port altmodes, so also add a check
> in typec_altmode_release to prevent typec_altmode_put_partner() calls on
> port altmode release.
> 
> ---
> Changes since v1:
> * Changed commit message for clarity
> * Added check to typec_altmode_release to only call put_partner if altmode
> belongs to port partner or plug
> ---

This info all goes below the following lines:

> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---

Down here, otherwise if you try to apply this patch, your signed-off-by
lines are removed from the patch, right?

As-is, this can not be applied at all :(

Please fix up, thanks.

greg k-h

