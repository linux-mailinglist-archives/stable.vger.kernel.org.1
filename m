Return-Path: <stable+bounces-23465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8767861221
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D082863BD
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B597E103;
	Fri, 23 Feb 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nuk4Ox3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED687BAE3;
	Fri, 23 Feb 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693192; cv=none; b=tg+kpuvhvlOCijB1H8XTHYHPltXnXYmFU4NdG8pELvyzLlNkdd44uL1bJ+oCmF+4upQ+8b2QMil1vIA77XzjZN2i01Uf9IY7szOepQvU48xixblFRJdVXAOcEaXT2MW/7OzxRhHYF4yxHBNkMPoTecGoE2PpbkN9S1qS4SwUZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693192; c=relaxed/simple;
	bh=e3AB1jM0eDGAg/c6YR/8B/AbSQNwUgxeBnXIZTcmOl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbOVmSdrNIeTH6+9nDELT30jmNs6EC15jnuoY9rTGAX/6qgYpe9/7qohF0jgpT2C7AAegafiy7UaivnAvYiv+b+SBGhYo+yg/HkVQZ7mzL+6WYUMjWruMhXZVaqnq39DHLS1dASrEbDJ3fxORYqFjAX8264Foy04YHqQT0oXhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nuk4Ox3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFBDC433C7;
	Fri, 23 Feb 2024 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708693191;
	bh=e3AB1jM0eDGAg/c6YR/8B/AbSQNwUgxeBnXIZTcmOl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nuk4Ox3bpskDob64TgbwGh046xGJ3UdbwLa5kgYaOxgr0lfjp0e0RLQPjBnI1gsTi
	 yVn03CdLKexMBIDjvDQq4ZCeI4XKkRAJ4+eni7EbyWo+6tHNIVngiYXza6asTn8cNO
	 B4UlPCyXmipPxSS/bf+hOeQOwFRZd0zRfSGDwWJk=
Date: Fri, 23 Feb 2024 13:59:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: Luna Jernberg <droidbittin@gmail.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Message-ID: <2024022326-wheat-heat-e4ba@gregkh>
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
 <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
 <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de>

On Wed, Feb 21, 2024 at 03:47:23PM +0100, Ronald Warsow wrote:
> On 21.02.24 15:25, Luna Jernberg wrote:
> > Works fine on my desktop with model name    : AMD Ryzen 5 5600 6-Core
> > Processor and Arch Linux
> > 
> > Tested-by: Luna Jernberg <droidbittin@gmail.com>
> > 
> 
> du meine deinem Scheiss Top Posting immer !!!
> :-(
> 
> get the fuck out of it !

Ik kan ook vloeken, maar dat is niet oké!


