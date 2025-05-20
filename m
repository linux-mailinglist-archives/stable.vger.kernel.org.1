Return-Path: <stable+bounces-145050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD84ABD473
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D35A7B044C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E70A268683;
	Tue, 20 May 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eOlXRnAZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728326772C
	for <stable@vger.kernel.org>; Tue, 20 May 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736570; cv=none; b=MQ4UCTkogvbCEJsTobNbitUVYdTenJjbmoX+ehg2/dNy6TZEZnOq6lhEuCRkBRWNHMpqcw8BZGTIeeSnFlryj5m9xUROFDhtnNveUwzfIeeDwKfmJjPiAL+yzgKPmKQ3Q+MSHSxVJmqTfq+NxBnttjxknDMXz5rs2ran0eOD0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736570; c=relaxed/simple;
	bh=pY0pKNr68GUVN2DyKXvNbRdfvRDVNQJnEE7QZYFPEZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ5n/nOrXSNMEDveG8iEGJYlsWn+1vY9nj2MISfECxIMgwekx9kKGEJaOScAzMevx5q/FCUzOuNPVuYv/tHvzqRC9oh3G1snvAae9RcDTbyvj2Ea5Fl9Ff2x8L1eI4iQjpk+5Pr4bKzNMEItjTHLpRnGSYnKCw0o7m10HGydqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eOlXRnAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F96C4CEE9;
	Tue, 20 May 2025 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747736569;
	bh=pY0pKNr68GUVN2DyKXvNbRdfvRDVNQJnEE7QZYFPEZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOlXRnAZwWCzNhh49oKoOiq45ixjw1eAwbQN8/KC2qsfp3KnOaUF7NwGi2vJloyXn
	 VcYR00hFDITQRf0MmoVXFZb5ldmV3lQpKBv1qtEDNJj9D14Rb5EJQpZzaPHaae0DbN
	 Oj/Eq6ctnrRy4hlFE3r5qD74i68sywFWDSEgiigE=
Date: Tue, 20 May 2025 12:22:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: Request for backporting accel/ivpu FW log patches to 6.12
Message-ID: <2025052040-struck-status-997a@gregkh>
References: <a0f38bde-d782-4170-9736-f1ad14a13ba6@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f38bde-d782-4170-9736-f1ad14a13ba6@linux.intel.com>

On Tue, May 13, 2025 at 06:26:28PM +0200, Jacek Lawrynowicz wrote:
> Hi,
> 
> Please cherry-pick following 4 patches to 6.12:
> 3a3fb8110c65d361cd9d750c9e16520f740c93f2 accel/ivpu: Rename ivpu_log_level to fw_log_level
> 4b4d9e394b6f45ac26ac6144b31604c76b7e3705 accel/ivpu: Reset fw log on cold boot
> 1fc1251149a76d3b75d7f4c94d9c4e081b7df6b4 accel/ivpu: Refactor functions in ivpu_fw_log.c
> 4bc988b47019536b3b1f7d9c5b83893c712d94d6 accel/ivpu: Fix fw log printing
> 
> These are fixing some firmware log corner cases that allow us to get reliable output in case of a failure.
> They should apply without conflicts.

All now queued up, thanks.

greg k-h

