Return-Path: <stable+bounces-183591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F49BC3D0C
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 10:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AE1403088
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20E2EC0AC;
	Wed,  8 Oct 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JmWlZSDt"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461913D521
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911828; cv=none; b=UFSoDQMkyIw5F/nMz3LpQwTrZlRR2UyGAAFGhtIoEDb0+Y8DCEV3z/8a+QoOQKeqZhyoAyYxRne2bVHrAVv5cOJ2xDdaHC15ZPhOpKamxAmn+ekCBQJA8EgU77JLidEDQLLPBOBTgn0IPuztRse6GNbp/8MT5cl8kHo5v+Lmums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911828; c=relaxed/simple;
	bh=+dxyJRGiUUIK22wq5cd29dbMXuEsFp2Z9BhfqxkRbqA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=E3xIPFGiLjtUf+J2+op4pJD4o5QDGx2B+HWCe0Ibn1IERRD2Sr003UEjYnlsNNbqWeyUGRAFKhMl1gl5D6EauO7AXh+LbaYwZGmm+Hq+2CBSfTH6aMG5Wup5jzObRH9qBXTj/F0BnI2LvHmxWoBCSvFlMpx18Y3x63NamxL4j6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JmWlZSDt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759911827; x=1791447827;
  h=message-id:date:mime-version:from:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=+dxyJRGiUUIK22wq5cd29dbMXuEsFp2Z9BhfqxkRbqA=;
  b=JmWlZSDtaBTRP6x4c1efXf/7GLF2iTLiT/9p1IdeHPNV0CNGZqbkEIfU
   HVeg8ZurHMQG9+SGkKXTHbFsVB7lb8vWWNOI6lJ37e+LdAXDSpoTY9rCo
   MhBU152bHDzP9vNX+0kECasZ26aSfjkVTLPzXAO7QYwnfNYXrvvxNxmev
   NZzAq3+qtPFmVJrtOHQLD4zwA6RN8E1hn5ILvoYuLSf6s3oFk1QmeKNKg
   rP/Y+gFDMPJ2oxDqnak2lB5zmpCdNITZvtaGVVEWdQ1y0zMmxLeOQoIbX
   Lh4bYiJTHAFpccu0SMr8XxngD1m8U+dsAjN2WK+H23NYzFTrWk+E9pQkk
   Q==;
X-CSE-ConnectionGUID: m7/J0LYfR1umnxvlY8MedQ==
X-CSE-MsgGUID: sZa0B6soQHmd6f74Ski5Fw==
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="47980652"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2025 01:23:46 -0700
Received: from chn-vm-ex2.mchp-main.com (10.10.87.31) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 8 Oct 2025 01:23:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 8 Oct 2025 01:23:20 -0700
Received: from [10.159.245.206] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 8 Oct 2025 01:23:18 -0700
Message-ID: <6f27f897-8d09-4e8b-9265-79bf7df2b15e@microchip.com>
Date: Wed, 8 Oct 2025 10:22:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: <romain.sioen@microchip.com>
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>, Greg KH
	<gregkh@linuxfoundation.org>, Romain Sioen - M70749
	<Romain.Sioen@microchip.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>,
	"syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com"
	<syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] hid: fix I2C read buffer overflow in raw_event() for
 mcp2221
References: <20251007130811.1001125-1-romain.sioen@microchip.com>
 <20251007130811.1001125-2-romain.sioen@microchip.com>
 <2025100751-ambiance-resubmit-c65e@gregkh>
 <3a44a61b-bd60-4dec-a5e6-8ad064203f2b@arnaud-lcm.com>
 <2025100716-rockfish-panda-9c4b@gregkh>
 <1eea8c34-8c96-4e0b-a255-8679f6d4ae00@arnaud-lcm.com>
In-Reply-To: <1eea8c34-8c96-4e0b-a255-8679f6d4ae00@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 10/8/25 8:50 AM, "Lecomte, Arnaud" <contact@arnaud-lcm.com> wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
> the content is safe
> 
> On 07/10/2025 17:26, Greg KH wrote:
> > On Tue, Oct 07, 2025 at 05:23:17PM +0200, Lecomte, Arnaud wrote:
> >> On 07/10/2025 15:16, Greg KH wrote:
> >>> On Tue, Oct 07, 2025 at 03:08:11PM +0200, Romain Sioen wrote:
> >>>> From: Arnaud Lecomte <contact@arnaud-lcm.com>
> >>>>
> >>>> [ Upstream commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 ]
> >>>>
> >>>> As reported by syzbot, mcp2221_raw_event lacked
> >>>> validation of incoming I2C read data sizes, risking buffer
> >>>> overflows in mcp->rxbuf during multi-part transfers.
> >>>> As highlighted in the DS20005565B spec, p44, we have:
> >>>> "The number of read-back data bytes to follow in this packet:
> >>>> from 0 to a maximum of 60 bytes of read-back bytes."
> >>>> This patch enforces we don't exceed this limit.
> >>>>
> >>>> Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
> >>>> Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
> >>>> Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
> >>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> >>>> Link: https://patch.msgid.link/20250726220931.7126-1- 
> >>>> contact@arnaud-lcm.com
> >>>> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >>>> [romain.sioen@microchip.com: backport to stable, up to 6.12. Add 
> >>>> "Fixes" tag]
> >>> I don't see a fixes tag :(
> >> Hey, I am the author of the patch. I can find the fixes tag if this 
> >> looks
> >> good to you.
> > There's no need for a fixes tag, just let us know where you want this
> > backported to.
> The ones, you already did the back-port to, seems good enough for me,
> Thanks Greg :)
> > thanks,
> >
> > greg k-h
> Arnaud
> 

Sorry for the confusion, I didn't put a tag indeed. I just wanted to backport this
patch to previous LTS versions 5.10, 5.15, 6.1, 6.6 and 6.12 as we need it to solve 
a bug. I tested it in all these stable versions and can confirm that it compiles correctly.
This is in the continuity of a backport request I made 1 month ago which has been accepted
and merged.

Thank you for your help,

Romain

