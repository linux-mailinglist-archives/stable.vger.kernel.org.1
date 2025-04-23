Return-Path: <stable+bounces-135291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A905A98CA2
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952D31B65465
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48726E162;
	Wed, 23 Apr 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGq0S3To"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D827C87C
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417904; cv=none; b=uYl94iEZ0dt70NKtqaYe7/w5ODR5Kts1qSJirPj0fTy3EoO8ulanJ7ZVw83T0jIO5PxDm36oZFZNHOiJggy8LDtvAXEFYYlTY+PTOHvHNXXyh1THvwikQGAkQ0sgH5MSKbHF4uMFCz7O9yDCPLCYPW+5T4DQehUV2A13NfGl6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417904; c=relaxed/simple;
	bh=QRK2mORtJHd7NU35kybuQE74jSeZzhqIFdY5vbRPyow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMwHDquMYi0hYBVN5Fsqsc8ERqDYhrxyyjaBuOR1EqBFvkx5ZuySZEnnRmwBFymmyfliAVDJOsIsjviKTBCDCChyuiDJE+5DUSYjz6uS+Pl0RVcUPEKSCsNZvsxbc7eP09/DNQBsCxU8eReT0WQrnmceuifKYpo5tDuJHglT2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGq0S3To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B2EC4CEE2;
	Wed, 23 Apr 2025 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745417903;
	bh=QRK2mORtJHd7NU35kybuQE74jSeZzhqIFdY5vbRPyow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGq0S3Toj6YX/oQzmo0nq2Wy9EmP60ssPJML7Llg8IQOFjmALgS/9NmHEgobwoRQk
	 tFAQ4W/kLbapSNC7WqYtittmKATkOw8PasojnnlNePc1cnLw5fDQp622XRSt2bFDeA
	 OulQb82uYkUNhVEarEOQ96lDcsV6ImSckpiMI/Nc=
Date: Wed, 23 Apr 2025 16:18:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4.y] usb: dwc3: core: Do core softreset when switch
 mode
Message-ID: <2025042355-cardboard-vacant-666f@gregkh>
References: <20250415113952.1847695-1-hgohil@mvista.com>
 <20250415105106-49407bc4f96ef856@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415105106-49407bc4f96ef856@stable.kernel.org>

On Tue, Apr 15, 2025 at 05:43:59PM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found follow-up fixes in mainline

Yes, those follow-up fixes are needed, I don't know how this was tested
:(

Now dropped.

greg k-h

