Return-Path: <stable+bounces-37879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2118489DD52
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E73A1C21303
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C85374D9;
	Tue,  9 Apr 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/9hX05K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15DAD4E
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674393; cv=none; b=eMV2mMxIq/kzBPL+RcqiuAeuv0yy1SB2ihqpAVnE6V+kwNw/jWqxfA8cKi3dDKUcuABukClZ9eWsTV9jp6lVVyFj3vS6Hyzs3uwYKtBI9RkmYwEOm6aSiimT64O1TUrYb96H26wEUepG9ohcp4Pkle/f+TK1dWV8mZYPtL6FwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674393; c=relaxed/simple;
	bh=CwEWGWQTxnFJ+aAKeqBE7+9ASA2pNjYyJvTCSXPYlOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMhXVfHdQxVOtc4ReFXFnZkKlWtlt5YTKRy3mY1NFZUwN4n1yBx2nc6kS5dZlf3HsYKnUQgbpf7Qh8h4fXhW8FWxCQzVw6Xt1OQYhSB5QGRC90YoLRTpJAwHvYl01PDqZ+K1hUUQ9amMhUKf3nj18Fdd6IV6R1TTDGtxfAcGaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/9hX05K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CBDC433F1;
	Tue,  9 Apr 2024 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712674392;
	bh=CwEWGWQTxnFJ+aAKeqBE7+9ASA2pNjYyJvTCSXPYlOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/9hX05KWfb94/YE6Rw6RKXtCMvXWD+Ii9ET8v/jRkgt8+a+d2H1i43Vhg1P1me5u
	 P+Iwv7y532Rs6odO6c1Us/4E4zjZcua2HHyKmHR2TvPsiDz3Nl6SRfoGhYcOfWGvvU
	 Lp/LpZpRfvY9CjCURHQ1iksGRJ2//I9HRJ6wCUws=
Date: Tue, 9 Apr 2024 16:53:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Backport commit ed4adc07207d ("net: ravb: Count packets instead
 of descriptors in GbEth RX path")
Message-ID: <2024040959-freckles-bling-36b6@gregkh>
References: <TYCPR01MB64780A9ED53818F6A9D062ED9F072@TYCPR01MB6478.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB64780A9ED53818F6A9D062ED9F072@TYCPR01MB6478.jpnprd01.prod.outlook.com>

On Tue, Apr 09, 2024 at 02:47:02PM +0000, Claudiu Beznea wrote:
> Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.
> 

Now deleted.

