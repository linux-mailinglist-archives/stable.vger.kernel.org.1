Return-Path: <stable+bounces-67517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAAA9509F7
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADE5281BC6
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382B51A08C2;
	Tue, 13 Aug 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="hiOIXUWO"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95B19AD90;
	Tue, 13 Aug 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565813; cv=none; b=P7VsW6vswocgOp+I8xHtpmiMJ40af/mhCTtULeccBKlXZOymYMNAEVjxS2e96H6a219brNt9xZiPoV7U4LyzPXR9AOLeGn8f9JSYXR5OUmlj0SwL+8PGwpgS575D6peLXiXJedW3JB7PgCDPVY52a6Axd/kzk+TfiPfb0XlbPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565813; c=relaxed/simple;
	bh=4zB4ZNfV+x+fD1m8knCnZqL65akwque1xKl+Wyxy/Ro=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suFH8sHJ0N/YjWKkwG3joZytMzYVXMl4HpfCYiQw7K1Z6PhyHKR4ZSDnolZh3zerAVpmFJOPD089RU4gwJyivoVMwT3ZXPEQLGFpwdiNDwfDJIqG50pa4diSRRj9/zAqE7oa12eRNR1jB1wsft67C+Y+wb7TAR6odo1DpfyvuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=hiOIXUWO; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 13 Aug 2024 18:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1723565803;
	bh=4zB4ZNfV+x+fD1m8knCnZqL65akwque1xKl+Wyxy/Ro=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=hiOIXUWORNGL+5ufZcHVChPjz6kxcKTFOZCtoAWG8egdE3owuOnxl7DIzJJTNG6mg
	 UHUcCBP1sY8QihNCL1VxiZk+w26sbHLCe3zTqY2lfvCtTWX9eAZFVfSXaJ3XesacI/
	 OY+BFPeN5dXxittZ+V9da26sDpZJstyMXMKepssOikm2y0o1u/QWDz/f4V/ZbNRYfW
	 LWcrCkcrpuReDLH+E6M/cf+ZOlxp4DK09gCR+qysxThZveGu5+MjVzF6YW/qALipji
	 aTqkqocc9c5v3Mi4bS1+WzCvut1UtHVBYmFSKzJ11uvi53QSgfjPaF1nkfQVhle3nE
	 RFlIVMnlyh09g==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
Message-ID: <20240813161642.GA5407@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812160146.517184156@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.10.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.

Hi Greg

6.10.5-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

