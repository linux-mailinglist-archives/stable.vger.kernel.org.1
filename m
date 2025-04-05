Return-Path: <stable+bounces-128369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887DAA7C7EC
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D2B3B32D7
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 07:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893111A7044;
	Sat,  5 Apr 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQ6zuUVu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293634430
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743837801; cv=none; b=rNh2/cxnAp/IXekiJcMq92caZ0GxKTxHEStY3GeXf8jzCk0gcSkIMmusb3vWHbGGm2DPZXlx/B+2H2AEotK8wyxx3EmJ0Dlu2w03MGVuyR4ODQ2ZwcbiWInlin8D9OGoZDtv+vEgjEw4xWB/DtdG3DWJrCWqB4Chn9suAh1Yl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743837801; c=relaxed/simple;
	bh=1vW7klfoFC+2KYkRGw4jtDPEa2Z4SD1MSH37uTfgRbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6zGf9HVlVAQsP2fVtaB8ZTwGudzGQy33PtYzcwKgTpg3plbRzR2vXTIacf0nfKtQ+uV0fGa+EWXvIJnCEtxvNaQ+qrWx97dsJmzmzIgZe/Q9uQVAOADv6FKsLWnfeDcw08ylwXQDvrA404d/9uttta7XcqFsFs6din++q5+22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQ6zuUVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1204DC4CEE4;
	Sat,  5 Apr 2025 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743837800;
	bh=1vW7klfoFC+2KYkRGw4jtDPEa2Z4SD1MSH37uTfgRbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQ6zuUVuI7NIpyoFI+Euge4E+3lyLTFRvFKOpYAbxcDTuOr/1HTl+HQGBDwzQBbvA
	 ZbDRE8PoHyTfXmjUMFDLimJ615g1cY/hH8c7HWMBap2K7ij7xG9SzDExsCzWuR/+eF
	 HuzIYlfvAIa76Dn/abWb94Q/t2v004QqNxtVn7s0=
Date: Sat, 5 Apr 2025 08:21:52 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <2025040514-clobber-pretended-fa42@gregkh>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
 <2025040348-living-blurred-eb56@gregkh>
 <2025040348-grant-unstylish-a78b@gregkh>
 <2025040311-overstate-satin-1a8f@gregkh>
 <a830cc37fd56d7e7d145342472ede2c924d86837.camel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a830cc37fd56d7e7d145342472ede2c924d86837.camel@amazon.de>

On Fri, Apr 04, 2025 at 12:28:06PM +0000, Manthey, Norbert wrote:

<snip>

You sent this in html format, which is rejected by the kernel community
mailing lists.  Please fix you email client if you wish to work with the
kernel community properly.

thanks,

greg k-h

