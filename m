Return-Path: <stable+bounces-90071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBF9BDF4D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25841C22D86
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0392D1C3302;
	Wed,  6 Nov 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMvi+EIg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA871BDAA8
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877809; cv=none; b=oZW3cae6x9GdNzUPK67ZsosCVRzv3ljU36TaNk51NbnNxKFrPv1pRKbihheIeR0bJo/b4GDZ3BmT5+BhczWqJkcwofgJIpbqB4cwHdetrLi0O1I7p70JaZ1lpGLK0TFAC4/MlTyt83BtcRAyotrsyJDLci/sJyC2j3edyIPgJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877809; c=relaxed/simple;
	bh=v/Mn2x8i+5AmQnwtED4G9gz+5W6C0BkLBYfv1IUDbdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPkPuOlj9yQ89/GAXOEhG1MprEe9Gay3HXT7SfKNmQb6BKYGLf+uhwLBCjEkjBMbVxbTTYD8XOZZzDSY1D1UqvPmm2xqsR3TdIEBTE48c5MIJZtRrLNiMFxMdI3vdYfO/TWB/mM74YR3TwaKsW5t48L+BHRZXoiKs6yB5h2juf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMvi+EIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA615C4CECD;
	Wed,  6 Nov 2024 07:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730877809;
	bh=v/Mn2x8i+5AmQnwtED4G9gz+5W6C0BkLBYfv1IUDbdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yMvi+EIgxJZAdtT4S5Q5irM6vC8jxZo0Y+dEBh3TJDy6VCVdUcLN49lKwesuhGNPs
	 X0L6+o+zotaH1h+3cOPhVuMjqLedympMNR/9+bEMxERe9uy/fBBGG5Z23nslyIOF2U
	 Mgi4saQ8q05LoZGYaHygCoEcYYPo8YLi5JJ9tSVo=
Date: Wed, 6 Nov 2024 08:23:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org, Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Subject: Re: [PATCH 6.6.y 0/2] mm: don't install PMD mappings when THPs are
 disabled by the hw/process/vma
Message-ID: <2024110601-handstand-ambulance-d66a@gregkh>
References: <2024101842-empty-espresso-c8a3@gregkh>
 <20241105172550.969951-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105172550.969951-1-david@redhat.com>

On Tue, Nov 05, 2024 at 06:25:48PM +0100, David Hildenbrand wrote:
> Resending both patches in one series now, easier for everybody that way.
> 

Much better, now queued up, thanks!

greg k-h

