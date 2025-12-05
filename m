Return-Path: <stable+bounces-200201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17145CA950B
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 21:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 843FF3081811
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C562DF128;
	Fri,  5 Dec 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PjzsSdtq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642D227B8E;
	Fri,  5 Dec 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968232; cv=none; b=alk7EJdhkuEUtE4JWr/MPjfbcF5q4DK1/fFkTipCwX7b2Buh8NCFBCs6oCtczgBpZzMp0jRENddINnxE6moR3MUY2nNF2Qt0lhZiR1Dlh5D3hBk5vUiyIzTUZrhf+RAzj8c+1es70/LVYGyaExMBxWMLFlVGZEBdyq74TC419jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968232; c=relaxed/simple;
	bh=q62v9+SE3ud4yC02TCCUnwXe58LvFZ9q8Ei57GAee7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXKCR+aThM0CAoZ3Gt2sVF1KqCj1k1RAhhpskHzWKr2lcMPFd9IK9cTQy3gOGYlpwKXDDmKOcqY0U+UbfJnIWLw15hMl9yU05PCPVCrOj5C3aRL8zuLG8T2qOM7DvzatoN1Oacqfp9jTyp4EoX+C7Xo5csL483SsJpEG/V4/jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PjzsSdtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8C6C4CEF1;
	Fri,  5 Dec 2025 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764968231;
	bh=q62v9+SE3ud4yC02TCCUnwXe58LvFZ9q8Ei57GAee7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjzsSdtqHM3mR6zWFIoKlW58tX3BdGuLbubrDsGl+bpAOTTI9SQx9eEBMG0gZx/aH
	 vujO5uDnXVdYBTBRXHd2WDhCNqwXUQJinlIQ82QcKo1yACU+NY1kACTcnCQgFaZBym
	 fi0TAK1y+nRdpjEZBvDzICHXlluN/z18lHxBNf0w=
Date: Fri, 5 Dec 2025 15:57:08 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] platform/x86: alienware-wmi-wmax: Add support for
 some newly released models
Message-ID: <20251205-masked-classy-ferret-9bb445@lemur>
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
 <49c9bab4-520f-42ca-5041-8a008b55f188@linux.intel.com>
 <DEQIPUKHDQYB.2LLGMK25N40VN@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DEQIPUKHDQYB.2LLGMK25N40VN@gmail.com>

On Fri, Dec 05, 2025 at 02:08:52PM -0500, Kurt Borja wrote:
> >> Thanks for all your latest reviews!
> >> 
> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> >
> > You don't need to signoff the coverletter. :-) (Hopefully it won't 
> > confuse any tools but I guess they should handle duplicate tags sensibly 
> > so likely no problem in this case).
> 
> Actually, unless I messed up something, this is b4's default settings
> :-). I'll take a look.

This is intentional, because some subsystems use the cover letter as the
content of the merge commit.

-K

