Return-Path: <stable+bounces-106633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBF9FF4E3
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 21:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98061882081
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C081E32A3;
	Wed,  1 Jan 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbUTOZ5H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33B1E25F8;
	Wed,  1 Jan 2025 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735764943; cv=none; b=GuRgcDaq/HLe+NUXR8NmPEnTWg1/E4cL+BKK2Wg7lEXVIXFfmFG8yglR+cstLutrai63dmqT0/5x8Zm0Pj/hl1w5aoFrzPF1DCpHqHKyZR6uUyzHpAHXRBhNaq0R/O1AaFloJxVG7WCnKIbY+HKwdg/Za9KuvDgy9A4cM4aeBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735764943; c=relaxed/simple;
	bh=wJxE0VhI4245QsBRaUlZMHe9srJx5wH1Gs8qUjCkXj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AmCVkyEg9IgAlMXs7uDBXpiIYgZem/s9mAxLGVJgM6ZMq7QOMKnYRljHipvFGaOgYugqZy4GOVAYwjF7+7bcJFxTyZwzZr/15wQFjpwbhdLnAGh2ufRNA1dD0Uj2rUTepcftFnQUsjBUif45EvM2B6xDSEdDn09pLhPTnlSZ00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbUTOZ5H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735764942; x=1767300942;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wJxE0VhI4245QsBRaUlZMHe9srJx5wH1Gs8qUjCkXj8=;
  b=CbUTOZ5HBVWRrF8tWs2F8FGoM+QNL/qT5ya7dsFDigKXsd5I5s2p5dFh
   8ZvQuCTCyox2RTJH+pQUq5cGCYG5U/SEkp8F6puveKbiauBTd8a/sO6bR
   Gg+SxGQb1ruOWr8Jr6tNykEpGmwQP43yMxbkSPjnBBWPIaEORgNHxEIKh
   ZHwFu8EKPzMIKEWedUgRSHXz7hUY6LYM3+mbMuoDdhcyBlzK5NrbpTFj5
   VB5hPpEg73c6BUQc4BDgbLoM0DCPMZVBDrVOYWG5yRIqnVPOk8cdd/quZ
   BXxlFGYhU2tWMqcfW3d314s3cBJ3JkAwR3n2/sSukiRG5rl/O7PyiR0uh
   A==;
X-CSE-ConnectionGUID: UPHup7CFRaOKHJ+y9p61CA==
X-CSE-MsgGUID: rJvTHkq3SzayT58uL0NkNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53405767"
X-IronPort-AV: E=Sophos;i="6.12,283,1728975600"; 
   d="scan'208";a="53405767"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 12:55:41 -0800
X-CSE-ConnectionGUID: 3qFIqEp2QQ6I44z0qmp8mw==
X-CSE-MsgGUID: Zjq9/VaAT+y6TKOAdzZ7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="106377707"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.202]) ([10.245.246.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 12:55:39 -0800
Message-ID: <5ca1c5b64c313108ea2aa005ae273f1ba8051e7f.camel@linux.intel.com>
Subject: Re: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event
 xe_bo_move has unsafe dereference of argument 4
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Genes Lists <lists@sapience.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, lucas.demarchi@intel.com,
 stable@vger.kernel.org, 	regressions@lists.linux.dev, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Wed, 01 Jan 2025 21:55:26 +0100
In-Reply-To: <0ef755e06b8f0bf1ee4dfd7e743d6222fd795b70.camel@sapience.com>
References: <2e9332ab19c44918dbaacecd8c039fb0bbe6e1db.camel@sapience.com>
			<9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
			<20241230141329.5f698715@batman.local.home>
			<20241230145002.3cc11717@gandalf.local.home>
			<5f756542aaaf241d512458f306707bda3b249671.camel@sapience.com>
		 <20241230160311.4eec04da@gandalf.local.home>
	 <0ef755e06b8f0bf1ee4dfd7e743d6222fd795b70.camel@sapience.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Mon, 2024-12-30 at 16:07 -0500, Genes Lists wrote:
> On Mon, 2024-12-30 at 16:03 -0500, Steven Rostedt wrote:
> > >=20
> >=20
> > I'll start making it into an official patch. Can I add your
> > "Tested-
> > by" to it?
> >=20
> > -- Steve
> Terrific thank you and sure:
> =C2=A0Tested-by: Gene C <arch@sapience.com>
>=20
>=20

FWIW, we actually worked around this during the holiday in the drm-xe-
next branch in the xe driver since it was breaking our CI. Was planning
to include it for drm-xe-fixes for tomorrow. Since xe appeared to be
the only driver hitting this, our assumption was that it'd be better
fixed in the driver.

Thanks,
Thomas


