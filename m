Return-Path: <stable+bounces-111258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01BCA229C3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 09:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661511887B53
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D871B21AC;
	Thu, 30 Jan 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZZMI/eJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542F1AF0CA;
	Thu, 30 Jan 2025 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226526; cv=none; b=sRALqCl0HIfufh3bowEkEjoiy66uTcVLYF1OsZqNsCaHqo3D65/IEEp1bTWC9AHg7Or4yeR3oSO0Szs9LCjlpo3jYByI9k1jnghPD8Z90Be/ySAtAtorQis0YygUJqLUbNNcbbPaomedsqC2+4x43MF23Fom9LYcO9Wk8sALTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226526; c=relaxed/simple;
	bh=5zNFrQ5ep7SJ4ETu6BE8Y+0ZTQiAAcEGAlDmGPcn/4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTN3qco2C5JbW533Z30q7JEyGEZ9AtHlGhVN3W9ub/T4/4ta7kUvapJHn1YL/0h3AEGLeIFILKAnpb45mbOKONDkMB8DWAGRGPkwlZrwGunInle0PGTmygo2zzU9x/hlEMfcTySX5H6Qou0iEklpSxowO129l8SS62MQe2wgneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZZMI/eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B18CC4CED2;
	Thu, 30 Jan 2025 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738226525;
	bh=5zNFrQ5ep7SJ4ETu6BE8Y+0ZTQiAAcEGAlDmGPcn/4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZZMI/eJMmLEDyYyIcvJnkA5AUBbGrOMJcZctC12/PMM0E5rcsSJgnHBjdgJZxNEk
	 cQ7hTqhlOKDzUzMsdFaNmFZk8/6DkJWYccHqHUc8f/VQbBCr5LjJKHE8BHnNzQvcwG
	 eAxYVseWrCJhgJeGZW3V/zTfnE17KCsHmoUDLDLE=
Date: Thu, 30 Jan 2025 09:41:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, amir73il@gmail.com,
	chandan.babu@oracle.com, catherine.hoang@oracle.com
Subject: Re: [PATCH 6.1 00/19] xfs 6.1.y fixes from 6.7
Message-ID: <2025013003-scaling-factsheet-b0c6@gregkh>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>

On Wed, Jan 29, 2025 at 10:46:58AM -0800, Leah Rumancik wrote:
> Returning to focus on 6.1, here is the 6.1 set from the corresponding
> 6.6 set:
> 
> https://lore.kernel.org/all/20240208232054.15778-1-catherine.hoang@oracle.com/

All now queued up, thanks!

greg k-h

