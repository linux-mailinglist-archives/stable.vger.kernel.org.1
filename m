Return-Path: <stable+bounces-94589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDF9D5DBC
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E2280F37
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633918FDB4;
	Fri, 22 Nov 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vAKpp2vw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240F14A84
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273515; cv=none; b=U55y4+TeGeZ0CWV5CKHU5+KPLfeSi/3YGmc78zlCYBG8ppGerp4CobPqHvJC+xcOvxrS7Nyp/vkX8GwF7gytIdLI3DrFV7eiMtPpZYGcM4v/Xq9VAV+kSWX3ShgDePnHQTn7arJ+I3o5vqTqfC5XrZGd8d4056mesw/4xOZbwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273515; c=relaxed/simple;
	bh=eKcPX5k5KMd8cKm1kJgH9AW1jEDlPac7QGt2llxagj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdmWoZgiEDDbm4SKITWIW7kBwNyuFqEIr2tkewRFjVz2/JfjiT8nExz3wnL3ICBTCAQnGBaAVBG5L9brS251t1gyzINSeWoZCK+Cc6v3vE3yclCylp1w1sTOhxNL0Er1+zZL50Fzphs8uhq9mQazvJ8pveIq107sKdAUxnDBDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vAKpp2vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6161BC4CECE;
	Fri, 22 Nov 2024 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732273514;
	bh=eKcPX5k5KMd8cKm1kJgH9AW1jEDlPac7QGt2llxagj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAKpp2vwt+r2VZMnImwcRS+xp4Iy1O6qaNeJketx0KAEfS+guACv0E/I24KqcDu+E
	 8xQtEW4JzRXM+iUNL/VxsqgSJFiywQjs9r7FIkANae18c3wNRbCJZoByh1d0lwqjvL
	 cmtrGwd26d1Gc1qnUzdWwMJ/neZ/iNMLDmrGyGnI=
Date: Fri, 22 Nov 2024 12:04:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: fec: refactor PPS channel configuration
Message-ID: <2024112235-upscale-mardi-7fe7@gregkh>
References: <e437a6ba-292d-4a0e-8e81-074c84045b26@prolan.hu>
 <20241016080156.265251-3-csokas.bence@prolan.hu>
 <2024101822-calamari-litigate-8d87@gregkh>
 <ae0a81ca-01d5-46c2-8ab5-5ba16fdc7190@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae0a81ca-01d5-46c2-8ab5-5ba16fdc7190@prolan.hu>

On Fri, Nov 22, 2024 at 10:10:38AM +0100, Csókás Bence wrote:
> Hi,
> 
> On 2024. 10. 18. 12:37, Greg Kroah-Hartman wrote:
> > On Wed, Oct 16, 2024 at 10:01:57AM +0200, Csókás, Bence wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Preparation patch to allow for PPS channel configuration, no functional
> > > change intended.
> > > 
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > 
> > > (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
> > 
> > Not a valid commit id in Linus's tree :(
> 
> It is now merged by Linus, please pick it when you can.
> 

Please resend it, it is long-gone from my review queue.

thanks,

greg k-h

