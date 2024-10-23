Return-Path: <stable+bounces-87825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFA9AC97F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F48280CFF
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D91AAE06;
	Wed, 23 Oct 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQdyuCBd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA851A7270;
	Wed, 23 Oct 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684575; cv=none; b=jEJ/wKjeQMpc/Shqc9m70cR/bhAdWS8NCCbTOtbg1OIWc3K5cM05XCoHU8/mdA7GXpVI05sICqs17fZpoEDX6AoB8++jmheGQHA4Wbw69KkH3avskYJYKaXnl5Y4vUuNvI0wuD89YAQbDo16Bibgbwgd7o4Jr1PgcqUCJxcvO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684575; c=relaxed/simple;
	bh=js+VsgORYgCrkl1IOoOS4gTzkIPmHgKMyBbMDgeHxEE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WKAmiOiEkqB4OzMEVE4c9d/Vm4gizwZuDpBS2kDCOUyBMkNDC1P73f9LLMew+qt9itEMYmeqb0gMlJO/yuWY6JUlVfv3cOSXF5A3iyEIMYohxNsUPgCWpD9kGmnzYQQ0z6VaoqXUwhM5wC22R5kLnAzqCi/CEDn03HSUFukpmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQdyuCBd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729684573; x=1761220573;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=js+VsgORYgCrkl1IOoOS4gTzkIPmHgKMyBbMDgeHxEE=;
  b=OQdyuCBdkK9gNQxQMQe9Ms/gX9Rd9ACnIuw74pheXgP6MMcqq9ltBfxE
   FCG3xrIQgifuSu9rcyrieIwu90dLUrnd+t3UD8/4TOvec/srXSJ+yI+a/
   MUZG4of7RvC5iZzEoDOtbV4sykOVQUtFLFa9u2w4PnmWTM71DXlmqQ/U0
   xjX7oNAnTh2No0Oeu/6axQrbXA6kNBib+4Za+UTZs7sQo+x/yL+kapHgv
   5gSBiI+ncmjXqF4cneOVMq31qyLlga2lxSwT1MX3xvbmh6zr3bjq0HoAt
   i3FC6UtweYiIk0PZOzduabVQOlES93jjflJAnz5uV8x9m8qd6Q+ihP5Oi
   A==;
X-CSE-ConnectionGUID: XcGZp9R9S8e3TMeTWrA4CQ==
X-CSE-MsgGUID: KJ7EgghATnOug3LeHbuOKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="32123791"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="32123791"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 04:56:13 -0700
X-CSE-ConnectionGUID: ofn1s8cxSaSVbjLpZtJLyw==
X-CSE-MsgGUID: /lAIBpQsSk+2W/09gS/vxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80509613"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 04:56:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Oct 2024 14:56:06 +0300 (EEST)
To: Sasha Levin <sashal@kernel.org>
cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org, 
    stable-commits@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "tty/serial: Make ->dcd_change()+uart_handle_dcd_change()
 status bool active" has been added to the 6.1-stable tree
In-Reply-To: <ZxjidR9PG2vfB_De@sashalap>
Message-ID: <28b8da74-02ff-8b2d-4eca-74062dc84946@linux.intel.com>
References: <20241022175403.2844928-1-sashal@kernel.org> <a07de63f-1723-440d-802c-6bedefec7f24@kernel.org> <ZxjidR9PG2vfB_De@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Oct 2024, Sasha Levin wrote:

> On Wed, Oct 23, 2024 at 08:25:12AM +0200, Jiri Slaby wrote:
> > On 22. 10. 24, 19:54, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool
> > > active
> > 
> > This is a cleanup, not needed in stable. (Unless something context-depends
> > on it.)
> 
> The 3 commits you've pointed out are a pre-req for 30c9ae5ece8e ("xhci:
> dbc: honor usb transfer size boundaries.").

Hi Sasha,

I wonder if that information could be added automatically into the 
notification email as it feels useful to know?

I assume there's some tool which figures these pre-reqs out, if it's based 
on manual work, please disregard my suggestion.

-- 
 i.


