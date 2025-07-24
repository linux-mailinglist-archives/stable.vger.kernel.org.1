Return-Path: <stable+bounces-164595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4BB108AC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A3B1CC2786
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F626B96A;
	Thu, 24 Jul 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="m24rYpw0"
X-Original-To: stable@vger.kernel.org
Received: from smtp124.ord1d.emailsrvr.com (smtp124.ord1d.emailsrvr.com [184.106.54.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF426C38E
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355480; cv=none; b=EtDDP9ANCXX0ZmJUTIuWb+23MOsP8xI1gX3Hb7pS/LfQGWdY8L3sk59dVROdRrvq61+oJD/4h9pgZIFmKQnn837oe1uEv/leRJ8umU3/hR49SC+aojxWhXgsMBXkh5/x00GqoPplRos5T9CJ0zFo+rvSHIKVpbdzelmGDi7XbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355480; c=relaxed/simple;
	bh=l1hhrAv+zcbtM8WhB81XgFPZP4CulIQB5EGj0F+Ig2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eguKdrEpouVSqH9se5GHzo8/az/cfoLvy/pCFI8V/rb+FDN9kq2WCCyq7YpYitw3lzQ+JOTcQhn6o8+NIcmqk+HCWglQZ0Wdzu2bWgqqHsISgHOIHsxHQIhCvi5Q/XpmUwMwDO0W3zZPt9ottWKoOLybs+R/kLmILYEqJVv8bFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=m24rYpw0; arc=none smtp.client-ip=184.106.54.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753355472;
	bh=l1hhrAv+zcbtM8WhB81XgFPZP4CulIQB5EGj0F+Ig2w=;
	h=Date:Subject:To:From:From;
	b=m24rYpw0qZ/xRErrpQzbx05YHH6zKogzOZecuTs+g0y7gJytdID6Tes7l9PU5M3YJ
	 i+domTznD+K1donCW4a75MyIIOUvekNRPNdOvfx6rB+0myeje2Fn2uzaEthwEDzCGj
	 IyDLK1Un5N4hmquu1ghQoBH/W1CUh6jSHm5m/sHM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 63CEDA00BB;
	Thu, 24 Jul 2025 07:11:11 -0400 (EDT)
Message-ID: <0dc7497f-0f90-4667-85e3-822ec5e98417@mev.co.uk>
Date: Thu, 24 Jul 2025 12:11:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 REPOST] comedi: pcl726: Prevent invalid irq number
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Edward Adam Davis <eadavis@qq.com>, syzkaller-bugs@googlegroups.com,
 stable@vger.kernel.org, syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
References: <tencent_3C66983CC1369E962436264A50759176BF09@qq.com>
 <20250724110754.8708-1-abbotti@mev.co.uk>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250724110754.8708-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 07c8dfe5-5051-41bb-a700-a30324994bf5-1-1

On 24/07/2025 12:07, Ian Abbott wrote:
> From: Edward Adam Davis <eadavis@qq.com>
> 
> The reproducer passed in an irq number(0x80008000) that was too large,
> which triggered the oob.
> 
> Added an interrupt number check to prevent users from passing in an irq
> number that was too large.
> 
> If `it->options[1]` is 31, then `1 << it->options[1]` is still invalid
> because it shifts a 1-bit into the sign bit (which is UB in C).
> Possible solutions include reducing the upper bound on the
> `it->options[1]` value to 30 or lower, or using `1U << it->options[1]`.
> 
> The old code would just not attempt to request the IRQ if the
> `options[1]` value were invalid.  And it would still configure the
> device without interrupts even if the call to `request_irq` returned an
> error.  So it would be better to combine this test with the test below.
> 
> Fixes: fff46207245c ("staging: comedi: pcl726: enable the interrupt support code")
> Cc: <stable@vger.kernel.org> # 5.13+
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5cd373521edd68bebcb3
> Tested-by: syzbot+5cd373521edd68bebcb3@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

I forgot to append the changelog from the original email:

V1 -> V2: combine test with old test
V2 -> V3: fix misspelled

Ian

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

