Return-Path: <stable+bounces-262583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hu63B2b2KWq1gAMAu9opvQ
	(envelope-from <stable+bounces-262583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 01:42:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8466D67A
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 01:42:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kAOPjs3L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262583-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262583-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83AF330144FE
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67B3932FC;
	Wed, 10 Jun 2026 23:41:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8939150D
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134869; cv=none; b=sIopPLZ1KK0iGNZ4Cyp8k+0iKGxAlfE2Rjg4pyhECDFMD8/0thGRyC/zj8PYsGV5GFD1swJv70vp650grAtgUHL+G/PxdpPY2PEspVOGGCUxZJJj/S/yGzXpm/OacN+Zall4TPP5oUZWokndyg1dKFUyaNNllQf2kTe5ML0ktMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134869; c=relaxed/simple;
	bh=9rozZdgv7t8p8ynviikc0qoAvrM/IC3PX/LUZKZPytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im+RbsgSzDqPOz+op7a+JBKycxE9k58GJBt71h9k+/LwaJ9pF6f7RjRXgDJUonzAXDum4PtcVss1KWo/DQ4o+0QMSLTL3EvVH8qROk2av8H/0B8ciKyP/7rbSZhDf/iOmR5Hu447Tk5mpKxWOJRqnnnA2YIjceq8YTCuoQsKrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAOPjs3L; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304cf518c9dso9205655eec.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134867; x=1781739667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EpTMNZ1obqYILWzMgsVeOkGLftyPXzrtSogbriqTbI=;
        b=kAOPjs3LPEts8EtP1R4zJaUGOxk4483n1o3bcroQS3wxpt9naWIXhCud7S9evm5Yxx
         0obAPzDD6uPh2xI7ylf0UlcyIDCix99A5KbwoyRn6FxItVGO9DYZnXvPRf9sK/qvrjA3
         1T6W+6LyCJ96MAOtp49gucQGlfs3sNKchvyJCXkSzN8BKP163sWhurVRKou5K05j7FDC
         r8wy+j4K1baGl5HJmf/nLxiTlWHlC38MsnoPKkH01nRkXYZuob1xDVrlpDgBtUvfx1XD
         rFIBNTpwkI/SuJLGxpyseRlijoe8Rpd4o+0l/spZa8sbFoWmF5t0+4IDBhjJsgxc1yIw
         HH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134867; x=1781739667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EpTMNZ1obqYILWzMgsVeOkGLftyPXzrtSogbriqTbI=;
        b=dytC9AWwif+S66PovMlWvWroDAjFiOCamHQF1wU6FnH2+tzh5oAHX0B5jiE1dq3OSW
         +q4M7jtRbOHwFVkUicrQqRueSD4WJvGmR3PbV4/PbBvCRGjuF+nCdFLf24LAS5qqOZOK
         m1JPnh6JdkYvy8j/jLqqQCtdYEo8SfXmMIlCeyrssKz+FK5y7FZvT/1aIgeyxLBYRy1n
         2W4fIoT0uatNv5/H0kdJZ2EafzWqXzEVpTkPWIG2Qqh4HYmk9K8Ks7GSDUnAzNzialFx
         CaSnoBjZo1eXrZRHVEqGmg+O2Fokm2XQliVN8HI5dxTa874ZTdSTL+OJz2LG3irdIiES
         2xmg==
X-Forwarded-Encrypted: i=1; AFNElJ8XFhFhvpOL0hTQMcw3aZ2wu3DYToayGnTDIJNg4Ov+bX2GblhFjHYD2Rxxn8RnsgSpuytiitE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/7r4RIylwSAp5hQNQ9tsfXzk+ecS9Fw3IrzIIiIm2tF8kwAr
	EC92+mRu7HxUaOdVaJ7x+bSDp1aOZX5rZmcxw0T8Bw6Y7jELjEbzj2mu
X-Gm-Gg: Acq92OGFX4+YCEe06gBXReNofBAluhfYNDOif6T4tLrOGiErxhiiUP1ALZaM6fXCXpz
	ddqhlWFAp7CI3EUD909SJtrkK8u0S8pE4FQYWxosHi73Tv6O3uKHnC4YfphRpl12nBdew6s4Kbz
	L9bLhGFW9gtEY3ZrZYodKPyLLwwdX776GtLJkByyZK8rnIunPRYCkGKHsmkf3cJXLq4h2oeIKwg
	7luO9mnQ2mjyr67wqcbLFTF1ZTM3ARR9/Xxs0YinzaQjjzIj4Uc1LIYueF5i7px/xKpcTSWHrzn
	EA+A6Tm2GoF3PzQ1pdQU7p1FAdnYbUlY8hpw74VfidMpoLKhTUX/XG2UuPAZDbbDPWRFnlsneO5
	hS8wPIsnP6LaOnpl88D9i6m6klMVDqDDweFPiRiC4eY/iMarfjP0C9+OB/uHN42RfdZRwrrm5hz
	y6WMeavvQYAgckQpiqKsp0GmWWQ7tU6KFF3etnYfU01kECLtarJ74wr3K0IPT/LWWJGYlHIOqZt
	tc=
X-Received: by 2002:a05:7300:6c25:b0:307:934e:da79 with SMTP id 5a478bee46e88-30804b769b7mr347241eec.34.1781134867104;
        Wed, 10 Jun 2026 16:41:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm29449322eec.27.2026.06.10.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:41:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:41:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: git@apitzsch.eu, Marge.Yang@tw.synaptics.com, kees@kernel.org, 
	jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - unregister function handlers on
 physical driver registration failure
Message-ID: <ain1g0QAE2sr32Pj@google.com>
References: <20260610064633.2837084-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610064633.2837084-1-haoxiang_li2024@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262583-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:git@apitzsch.eu,m:Marge.Yang@tw.synaptics.com,m:kees@kernel.org,m:jiapeng.chong@linux.alibaba.com,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABC8466D67A

Hi Haoxiang,

On Wed, Jun 10, 2026 at 02:46:33PM +0800, Haoxiang Li wrote:
> If rmi_register_physical_driver() fails, the current error path
> unregisters only the RMI bus. The function handlers registered
> earlier remain registered with the driver core.
> 
> Add a separate error path to unregister the function handlers
> before unregistering the bus in this failure case.
> 
> Fixes: d6e680837ec5 ("Input: synaptics-rmi4 - fix function name in kerneldoc")

This is not correct commit for fixes. I changed this to 

2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")

and applied, thank you.

Thanks.

-- 
Dmitry

