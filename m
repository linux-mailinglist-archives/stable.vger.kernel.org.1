Return-Path: <stable+bounces-114275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2BA2C8E3
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3125A165C8B
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927A18C00B;
	Fri,  7 Feb 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LV/Z/QZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB31891A9
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945851; cv=none; b=sF3EeBVxk9CKgMHhLC+fHs4Coy5LKE8vamE+LdYrR4l7HnGB1SoTY0mPyzuygNxp7JWyF9CrUiFBT5PDV8QYq3JUPSsqQW76+iHoQ6BGwgy5A0o1uxgZZXSRDjK7V1MlB31JDV+oaMT9y23WsK31TY2VajxWDF20CyRS82MO8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945851; c=relaxed/simple;
	bh=9ZqTJup3Dy9Exa4ildl8WnrPbX5sk6tM0tvVhc57CYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPpB/a/V1pUu0DBYpdR+PC7208M74Fy/QyzSRyqPs68OmyoxHz5YJcyi+T1MgToIAmrd8pNtgT7wxHcmR/np75rC787RuV7KshaBQWyA4q5DDmWAjR98T0CA5qv7Gllot8KsipZSkTJxjNtSi5cVO7/hXMJj9DjX18F7Oju3Aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LV/Z/QZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91779C4CEDF;
	Fri,  7 Feb 2025 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738945851;
	bh=9ZqTJup3Dy9Exa4ildl8WnrPbX5sk6tM0tvVhc57CYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LV/Z/QZo9ZTzCqXR7JSQ1PhErYZkvrV9+zSQccMJVmXdcymJ5N6NujgGs3sRxdDX3
	 g+M+X3WeroIzH4Hqb3UFRJcbRTCuRE50w4jx50O7qaZnUHCydKtiFDRqiyp4EVUMKi
	 I3K7QmKumOgFxYvm5CEuqLa+zt2OQ956I10tUalA=
Date: Fri, 7 Feb 2025 17:30:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vgiraud.opensource@witekio.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6 0/1] Fix CVE-2024-56647
Message-ID: <2025020740-fleshed-stiffen-9457@gregkh>
References: <20250207145532.2503951-1-vgiraud.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207145532.2503951-1-vgiraud.opensource@witekio.com>

On Fri, Feb 07, 2025 at 03:55:31PM +0100, vgiraud.opensource@witekio.com wrote:
> In-Reply-To: 
> 
> 
> 

Something went wrong here :(

