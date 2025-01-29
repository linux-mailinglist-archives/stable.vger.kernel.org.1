Return-Path: <stable+bounces-111095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD95A219AE
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C50161AE4
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D40194147;
	Wed, 29 Jan 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fC+wfd/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4F179BC
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141693; cv=none; b=nYmceqzZiP5p+/fFz5byCMB2bTjEq5SW917l4QlWS4chuHUcqsC1sfy5UAc3xz12Rslb91TRx5+5nMBPY5KfApsTDKliExDoJmLSH4rHH5aqeZjz65lQMGWQWVQ6fpDRaF/xpOdiTjt+7dEGkIRz0YYwVn8sPBvwTbUqpFkgFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141693; c=relaxed/simple;
	bh=KUNLI64DkS/2Kry3Zd19jYM7epfDBucYONCA2hHK73c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjUdoaGRWUw/Cjy+dAoxGxCl6j5i/mDz46jvaaKTzwF6b05kuS5SPWvF+EYeJvFA6nogD7D0v6Bj04HNGuXcjDqSMJRI6okAx+3bJaa/rUs2hEFRkLbiWAyW0nAmQPo9NvRVu+zcp6cXOKzS3N5UGsnleTf+NK5Rv97dCdKMI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fC+wfd/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48B5C4CED3;
	Wed, 29 Jan 2025 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738141692;
	bh=KUNLI64DkS/2Kry3Zd19jYM7epfDBucYONCA2hHK73c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fC+wfd/INI2GaUPs3jKJFsCxWiPkEYSk4nZvnu0VadKvd40Mf4rsjqtEZmzoMBU5G
	 zYbMuCHYuvrY1pMc2JD0OZjgl9oNGOxOpa/B2cNG1kcYiRyiblG/28XTRgqQSB7lyN
	 YOgHRAg+61/K3DXCunKv34JvTdFu5sKHdUkVV7S8=
Date: Wed, 29 Jan 2025 10:06:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian =?iso-8859-1?Q?K=FChnke?= <christian@kuehnke.de>
Cc: stable@vger.kernel.org, dlemoal@kernel.org
Subject: Re: Request inclusion of 18676c6aab0863618eb35443e7b8615eea3535a9
 into stable 6.6
Message-ID: <2025012949-agnostic-padlock-e746@gregkh>
References: <64f08e31-dff8-4e86-ac5a-95ddc756031e@kuehnke.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64f08e31-dff8-4e86-ac5a-95ddc756031e@kuehnke.de>

On Wed, Jan 29, 2025 at 09:39:42AM +0100, Christian Kühnke wrote:
> Hi all,
> 
> I have been sent here from the linux-ide mailing list. Over there, I have
> reported an issue with the 6.6 stable series of the kernel, starting with
> 6.6.51. The root cause is as follows:
> 
> On 12.09.2024, commit 872f86e1757bbb0a334ee739b824e47c448f5ebc ("ata:
> libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf") was
> applied to 6.6, adding checks of ATA_QCFLAG_RTF_FILLED to libata_scsi. The
> patch seen in baseline commit 18676c6aab0863618eb35443e7b8615eea3535a9
> ("ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()") should
> have gone together with this.
> 
> Without it, I receive errors retrieving SMART data from SATA disks via a
> C602 SAS controller, apparently because in this situation
> ATA_QCFLAG_RTF_FILLED is not set.
> 
> I applied 18676c6aab0863618eb35443e7b8615eea3535a9 from baseline to 6.6.74
> and the problem went away.
> 
> If you need any further information, do not hesitate to contact me (linux
> user since 0.99.x, but only debugging it once every few years or so...).
> 

Now queued up, thanks.

greg k-h

