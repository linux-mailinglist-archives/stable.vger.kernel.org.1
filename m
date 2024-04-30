Return-Path: <stable+bounces-42821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB288B7E96
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC4B21709
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29671802A5;
	Tue, 30 Apr 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAkT/R0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0D1369AC;
	Tue, 30 Apr 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498297; cv=none; b=mUT3BW9XHIDtGrr8MocJTr65VYuhOdrv662CK44RtIP75mX71JfOmVUyZgCx1IrB21yDyQ5lg0RSU7KnuyDsYAlfW6QA1yHvem3Vs2Y6i25xI7LjyL6VEokDwulgam8BqflqtFEt6B24jUmzekIgvx82ryL4n6dbv8PUIsh+1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498297; c=relaxed/simple;
	bh=/Ip7J5K8s7x43YQAeSS+jyAToZG38/oXcAkZGfkh/wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZWSswqr8vbxVvxnE7RuMcjXHDO9SQ5ov93hjbwA1SrwIcGj8TPi5n5SQNYGNu0Bf604U9I7U659pDy2EUIXhBev5V6ZhyL6guHdXJtbCNX3GLa+Kah2jRFXlPHtOZ+gYt94Y2rQWvrFhCMvXmTv9c2snpeetjYIw4F4WZB9zzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAkT/R0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F02C2BBFC;
	Tue, 30 Apr 2024 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714498297;
	bh=/Ip7J5K8s7x43YQAeSS+jyAToZG38/oXcAkZGfkh/wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAkT/R0bRnrRHy7aprSQ4w+lsAaNSf6+/Bg1aIiNleAzGvoeZp1cuqJPHZvAMPZpq
	 ty8bCPy7E04znxnUlZq/h9IAtphal9Aw3CPWs3pdy1rw8WgE7/bE49Xn3BiGQMlK8n
	 WKOWiunjdu5uhB7Y616CpnzPKFlXElercxi82RLDxjd3brpp5XR0dPkkWSiNXpqsG+
	 Awm2RMeoiSMgOOR6eSMtWQ5i3ORv26PYMt7m5taQe+x2xsFr0NCEe2FOMiPo8xDwEr
	 BaG3An5IlPodudMsZ/gCV2f7WMzC6iBWldoWA5A8YDyaeIvDChH+HcPRohpk3uNlGl
	 e5+W4IDvbGN1A==
Date: Tue, 30 Apr 2024 18:31:31 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	regressions@leemhuis.info, stable@vger.kernel.org,
	=?utf-8?B?SsOpcsO0bWU=?= Carretero <cJ@zougloub.eu>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: Re: [PATCH net] e1000e: change usleep_range to udelay in PHY mdic
 access
Message-ID: <20240430173131.GA2575892@kernel.org>
References: <20240429171040.1152516-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429171040.1152516-1-anthony.l.nguyen@intel.com>

On Mon, Apr 29, 2024 at 10:10:40AM -0700, Tony Nguyen wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> This is a partial revert of commit 6dbdd4de0362 ("e1000e: Workaround
> for sporadic MDI error on Meteor Lake systems"). The referenced commit
> used usleep_range inside the PHY access routines, which are sometimes
> called from an atomic context. This can lead to a kernel panic in some
> scenarios, such as cable disconnection and reconnection on vPro systems.
> 
> Solve this by changing the usleep_range calls back to udelay.
> 
> Fixes: 6dbdd4de0362 ("e1000e: Workaround for sporadic MDI error on Meteor Lake systems")
> Cc: stable@vger.kernel.org
> Reported-by: Jérôme Carretero <cJ@zougloub.eu>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218740
> Closes: https://lore.kernel.org/lkml/a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu/
> Co-developed-by: Sasha Neftin <sasha.neftin@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


